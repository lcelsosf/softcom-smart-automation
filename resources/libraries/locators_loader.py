"""Carrega locators YAML e substitui ${APP_PACKAGE} pelo pacote do app.

O Robot não resolve variáveis dentro de YAML; este loader lê os arquivos,
aplica a substituição em Python e devolve um dict acessível por ponto
(ex: ${login.email}).

Uso nas bases:
    Variables  resources/libraries/locators_loader.py  common  default  ${DEVICE_TAG}
    Variables  resources/libraries/locators_loader.py  common  commands  ${DEVICE_TAG}

Argumentos:
    - Um ou mais prefixos de arquivo YAML (common, default, commands, pdv, ...)
    - Opcionalmente DEVICE_TAG como último argumento (define APP_PACKAGE via devices.yaml)

Busca de arquivos YAML (em ordem de prioridade):
    1. resources/locators/<prefix>.yml|yaml
    2. modules/<prefix>/locators/<prefix>.yml|yaml
    3. modules/*/locators/<prefix>.yml|yaml  (busca ampla)
"""
import os
import warnings
from pathlib import Path
from typing import Any

import yaml

# --- Paths base ---
_LIB_DIR = Path(__file__).resolve().parent          # resources/libraries/
BASE_DIR = _LIB_DIR.parent                          # resources/
LOCATORS_DIR = BASE_DIR / "locators"                # resources/locators/
DEVICES_FILE = BASE_DIR / "data" / "devices.yaml"   # resources/data/devices.yaml
MODULES_DIR = BASE_DIR.parent / "modules"           # modules/

# --- Cache de configuração ---
_DEVICES_CONFIG: dict | None = None


# =============================================================================
# DEVICES CONFIG
# =============================================================================

def _load_devices_config() -> dict:
    """Carrega resources/data/devices.yaml."""
    if not DEVICES_FILE.exists():
        warnings.warn(f"devices.yaml não encontrado em: {DEVICES_FILE}", stacklevel=2)
        return {}
    with open(DEVICES_FILE, encoding="utf-8") as f:
        return yaml.safe_load(f) or {}


def _get_devices_config() -> dict:
    """Retorna devices.yaml com cache lazy — carrega apenas na primeira chamada."""
    global _DEVICES_CONFIG
    if _DEVICES_CONFIG is None:
        _DEVICES_CONFIG = _load_devices_config()
    return _DEVICES_CONFIG


def _app_package_for(device_tag: str) -> str:
    """Retorna o APP_PACKAGE para a device_tag lido de devices.yaml.

    Fallback: default_app_package → 'softcom.mobile.smart2'
    """
    config = _get_devices_config()
    tag = (device_tag or "").strip().lower()
    default_pkg = config.get("default_app_package", "softcom.mobile.smart2")
    device_cfg = config.get("devices", {}).get(tag, {})
    return device_cfg.get("app_package", default_pkg)


# =============================================================================
# RESOLUÇÃO DE PREFIXOS
# =============================================================================

def _known_prefixes() -> frozenset:
    """Descobre prefixos válidos lendo YAMLs existentes em resources/locators/
    e em modules/*/locators/ — sem hardcode de nomes de módulos.
    """
    prefixes: set[str] = set()

    if LOCATORS_DIR.exists():
        prefixes |= {p.stem for ext in ("*.yml", "*.yaml") for p in LOCATORS_DIR.glob(ext)}

    if MODULES_DIR.exists():
        prefixes |= {
            p.stem
            for ext in ("*/locators/*.yml", "*/locators/*.yaml")
            for p in MODULES_DIR.glob(ext)
        }

    return frozenset(prefixes)


def _is_locator_source(arg: str, known_prefixes: frozenset[str]) -> bool:
    value = (arg or "").strip()
    if not value:
        return False

    normalized = value.replace("\\", "/").lower()
    if normalized in known_prefixes:
        return True

    if "/" in normalized or normalized.endswith((".yml", ".yaml")):
        return True

    return False


def _parse_args(args: tuple) -> tuple[list[str], str]:
    """Separa lista de prefixos de arquivo e device_tag.

    Regra: se o último argumento não parecer uma origem de locator,
    ele é tratado como device_tag. Caso contrário, device_tag vem do ambiente.

    Exemplos:
        ("common", "default")           -> (["common", "default"], os.getenv(...))
        ("common", "commands", "cielo") -> (["common", "commands"], "cielo")
        ("modules/pdv/locators/settings_locators.yaml",) -> ([...], os.getenv(...))
        ()                                -> ValueError
    """
    raw = [str(a).strip() for a in args if a and str(a).strip()]

    if not raw:
        raise ValueError(
            "locators_loader requer ao menos um prefixo de arquivo YAML.\n"
            "Exemplo: Variables  resources/libraries/locators_loader.py"
            "  common  commands  ${DEVICE_TAG}"
        )

    known = _known_prefixes()
    last = raw[-1]

    if _is_locator_source(last, known):
        return raw, os.getenv("DEVICE_TAG", "")

    device_tag = last
    file_prefixes = raw[:-1] if len(raw) > 1 else raw
    return file_prefixes, device_tag


# =============================================================================
# CARREGAMENTO DE YAML
# =============================================================================

def _find_yaml(prefix: str) -> Path | None:
    """Resolve um locator por nome ou caminho explícito.

    Ordem de prioridade:
    1. caminho explícito informado no argumento
    2. resources/locators/<prefix>.yml|yaml
    3. modules/<prefix>/locators/<prefix>.yml|yaml
    4. modules/*/locators/<prefix>.yml|yaml (busca ampla)
    """
    normalized = prefix.replace("\\", "/")

    explicit_candidates = []
    candidate_path = Path(normalized)
    if candidate_path.suffix.lower() in {".yml", ".yaml"}:
        explicit_candidates.append(candidate_path)
        explicit_candidates.append(BASE_DIR.parent / candidate_path)
    else:
        explicit_candidates.extend(
            [
                Path(f"{normalized}.yml"),
                Path(f"{normalized}.yaml"),
                BASE_DIR.parent / f"{normalized}.yml",
                BASE_DIR.parent / f"{normalized}.yaml",
            ]
        )

    for candidate in explicit_candidates:
        if candidate.exists():
            return candidate.resolve()

    # 2. Locators globais
    for suffix in (".yml", ".yaml"):
        candidate = LOCATORS_DIR / f"{prefix}{suffix}"
        if candidate.exists():
            return candidate

    # 3. Locators do módulo com mesmo nome do prefixo
    if MODULES_DIR.exists():
        for suffix in (".yml", ".yaml"):
            candidate = MODULES_DIR / prefix / "locators" / f"{prefix}{suffix}"
            if candidate.exists():
                return candidate

        # 4. Busca ampla em qualquer módulo
        matches = [
            p
            for pattern in (f"*/locators/{prefix}.yml", f"*/locators/{prefix}.yaml")
            for p in MODULES_DIR.glob(pattern)
        ]
        if matches:
            return matches[0]

    return None


def _load_yaml(path: Path, prefix: str = "") -> dict:
    """Carrega YAML retornando dict. Emite warning se arquivo não encontrado."""
    if not path.exists():
        label = f" (prefixo: '{prefix}')" if prefix else ""
        warnings.warn(f"Arquivo de locators não encontrado: {path}{label}", stacklevel=3)
        return {}
    with open(path, encoding="utf-8") as f:
        return yaml.safe_load(f) or {}


def _replace_package(obj: Any, app_package: str) -> Any:
    """Substitui ${APP_PACKAGE} em todas as strings da estrutura."""
    if isinstance(obj, dict):
        return {k: _replace_package(v, app_package) for k, v in obj.items()}
    if isinstance(obj, str):
        return obj.replace("${APP_PACKAGE}", app_package)
    return obj


def _merge_locators(file_prefixes: list[str], app_package: str) -> dict:
    """Carrega os YAMLs na ordem informada e mescla — o último sobrescreve.

    Busca cada prefixo em resources/locators/ e modules/*/locators/.
    """
    merged: dict[str, Any] = {}
    for prefix in file_prefixes:
        path = _find_yaml(prefix)
        if path is None:
            warnings.warn(
                f"Nenhum arquivo YAML encontrado para o prefixo '{prefix}'. "
                f"Verifique se o arquivo existe em resources/locators/ "
                f"ou modules/{prefix}/locators/.",
                stacklevel=2,
            )
            continue
        data = _load_yaml(path, prefix)
        merged.update(_replace_package(data, app_package))
    return merged


# =============================================================================
# DOT DICT — acesso por atributo no Robot Framework
# =============================================================================

class _DotDict(dict):
    """Dict que permite acesso por atributo (ex: ${login.email} no Robot)."""

    __getattr__ = dict.__getitem__
    __setattr__ = dict.__setitem__

    def __init__(self, *args: Any, **kwargs: Any) -> None:
        super().__init__(*args, **kwargs)
        for k, v in list(self.items()):
            if isinstance(v, dict) and not isinstance(v, _DotDict):
                self[k] = _DotDict(v)


def _to_dotdict(obj: Any) -> Any:
    """Converte dicts aninhados em _DotDict para acesso por ponto no Robot."""
    if isinstance(obj, dict):
        return _DotDict({k: _to_dotdict(v) for k, v in obj.items()})
    return obj


# =============================================================================
# ENTRY POINT DO ROBOT FRAMEWORK
# =============================================================================

def get_variables(*args: Any) -> dict[str, Any]:
    """Entry point do Robot Framework — retorna variáveis de locators para a suite.

    Argumentos:
        *prefixos   Um ou mais nomes de arquivo YAML (sem extensão)
        device_tag  Opcional — último argumento se não for prefixo conhecido

    Exemplos:
        Variables  resources/libraries/locators_loader.py  common  default  ${DEVICE_TAG}
        Variables  resources/libraries/locators_loader.py  common  commands  cielo
        Variables  resources/libraries/locators_loader.py  common  pdv
    """
    file_prefixes, device_tag = _parse_args(args)
    app_package = _app_package_for(device_tag)
    data = _merge_locators(file_prefixes, app_package)
    return {k: _to_dotdict(v) for k, v in data.items()}