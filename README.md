# Shield Smart Test Automation

Framework de automação mobile para testes de regressão em terminais de pagamento Android.
Construído com Robot Framework + Appium, suporta execução paralela em múltiplos adquirentes via Pabot.

---

## Pré-requisitos

| Dependência | Versão mínima | Instalação |
| --- | --- | --- |
| Python | 3.11+ | [python.org](https://python.org) |
| uv | latest | `pip install uv` ou [docs.astral.sh/uv](https://docs.astral.sh/uv) |
| Node.js | 18+ | [nodejs.org](https://nodejs.org) |
| Android SDK (adb) | — | Android Studio → SDK Platform Tools |
| Appium Server | 2.x | `npm install -g appium` |
| Appium UIAutomator2 | — | `appium driver install uiautomator2` |

Verificar instalação:

```bash
adb devices          # lista devices conectados
appium --version     # verifica instalação do servidor
uv --version         # verifica instalação do uv
```

---

## Instalação

```bash
# Clonar o repositório
git clone <url>
cd softcom-smart-automation

# Instalar dependências com uv
uv sync

# Copiar e preencher variáveis de ambiente
cp .env.example .env
# Edite .env com os UDIDs reais dos devices (veja: adb devices)
```

---

## Configuração

### Devices

Todos os devices são configurados em `resources/data/devices.yaml`.
Cada adquirente tem: `udid`, `app_package`, `keyboard_close`, `system_port`, `appium_server`.

Adicionar um novo adquirente:
1. Inserir nova entrada no `devices.yaml`
2. Adicionar variável de UDID no `.env` e `.env.example`
3. Criar `pabot_configs/<tag>.args`

### Variáveis de ambiente (.env)

| Variável | Descrição |
| --- | --- |
| `CIELO_DX8000_UDID` | UDID do terminal Cielo DX8000 |
| `REDE_L400_UDID` | UDID do terminal Rede L400 |
| `REDE_N960K_UDID` | UDID do terminal Rede N960K |
| `GETNET_DX8000_UDID` | UDID do terminal Getnet DX8000 |
| `GETNET_P2_UDID` | UDID do terminal Getnet P2 |
| `GETNET_P3_UDID` | UDID do terminal Getnet P3 |
| `STONE_UDID` | UDID do terminal Stone |
| `PAGBANK_A7_1_UDID` | UDID do terminal PagBank A7.1 |
| `PAGBANK_A11_UDID` | UDID do terminal PagBank A11 |
| `FISERV_UDID` | UDID do terminal Fiserv |
| `SIPAG_P2_UDID` | UDID do terminal Sipag P2 |
| `SIPAG_X990_UDID` | UDID do terminal Sipag X990 |
| `SIPAG_DX8000_UDID` | UDID do terminal Sipag DX8000 |
| `SAFRA_UDID` | UDID do terminal Safra |
| `MERCADOPAGO_UDID` | UDID do terminal Mercado Pago |
| `QUICKPAY_A910_UDID` | UDID do terminal QuickPay A910 |
| `CLOVER_UDID` | UDID do terminal Clover |

---

## Executando os testes

### Execução interativa (recomendado)

```bash
chmod +x run_tests.sh
./run_tests.sh
```

O script:
1. Detecta devices conectados via ADB
2. Exibe menu de seleção de devices e suites
3. Monta e executa o comando pabot automaticamente
4. Gera relatório Allure ao final

### Execução manual — device único

```bash
uv run robot -v DEVICE_TAG:cielo tests/regression/default/default.robot
```

### Execução paralela — múltiplos devices

```bash
uv run pabot --processes 2 \
  --argumentfile1 pabot_configs/cielo.args \
  --argumentfile2 pabot_configs/clover.args \
  --outputdir pabot_results/ \
  --listener allure_robotframework:allure-report/ \
  tests/
```

### Relatório Allure

```bash
uv run allure generate allure-report/ -o allure-report/html --clean
uv run allure open allure-report/html
```

---

## Estrutura do projeto

```
softcom-smart-automation/
│
├── resources/                      # Camada global — compartilhada entre módulos
│   ├── base/
│   │   ├── base.resource           # Ponto de entrada global: libs + helpers
│   │   ├── open_app.resource       # Abertura de sessão Appium
│   │   └── setup.resource          # Suite/Test Setup e Teardown
│   ├── helpers/
│   │   ├── common_keywords.resource
│   │   ├── error_handling.resource
│   │   ├── structured_logging.resource
│   │   └── validation.resource
│   ├── libraries/
│   │   ├── DevicesConfig.py        # Lê devices.yaml, expande env vars
│   │   ├── LogcatLibrary.py        # Captura e validação de logcat
│   │   └── locators_loader.py      # Resolve locators por app_package
│   ├── data/
│   │   ├── devices.yaml            # Configuração de todos os adquirentes
│   │   └── endpoints.yaml
│   └── variables/
│       └── env_variables.py        # UDIDs via python-dotenv
│
├── modules/                        # Camada modular — auto-contida por módulo
│   ├── default/
│   │   ├── base_default.resource   # Único import das suites default
│   │   ├── locators/
│   │   ├── pages/
│   │   └── navigation/
│   ├── pdv/
│   ├── commands/
│   ├── prevenda/
│   ├── mini_mercado/
│   └── common/                     # Pages compartilhadas entre módulos
│
├── tests/                          # Suites de teste
│   ├── regression/
│   │   ├── default/default.robot
│   │   ├── pdv/pdv.robot
│   │   └── commands/commands.robot
│   └── smoke/smoke.robot
│
├── pabot_configs/                  # Um .args por adquirente
│   ├── cielo.args
│   ├── clover.args
│   └── ...
│
├── documentation/                  # Documentação e templates
│   ├── examples/
│   └── NAVIGATION_ANALYSIS.md
│
├── run_tests.sh                    # Menu interativo de execução
├── .env                            # UDIDs reais — gitignore
├── .env.example                    # Template
└── pyproject.toml
```

---

## Arquitetura em camadas

O projeto segue uma arquitetura de 3 camadas com imports unidirecionais:

```
suite.robot
  └── base_<modulo>.resource          # 1. Camada modular — único import da suite
        ├── base.resource             # 2. Camada global — libs e helpers
        │     ├── AppiumLibrary
        │     ├── DevicesConfig.py
        │     ├── LogcatLibrary.py
        │     ├── structured_logging.resource
        │     ├── error_handling.resource
        │     ├── common_keywords.resource
        │     └── open_app.resource
        ├── locators/<modulo>.yaml    # 3. Locators do módulo
        ├── pages/<tela>_page.resource
        └── navigation/<modulo>_navigation.resource
```

**Regra de ouro:** cada camada importa apenas da camada imediatamente abaixo.
Suites nunca importam `base.resource` diretamente — sempre via `base_<modulo>.resource`.

---

## Adicionando um novo adquirente

1. Inserir entrada em `resources/data/devices.yaml`:
   ```yaml
   novo_adquirente:
     udid: "${NOVO_ADQUIRENTE_UDID}"
     keyboard_close: "hide"
     system_port: 8234
     appium_server: "http://localhost:4723"
   ```
2. Adicionar variável no `.env` e `.env.example`:
   ```
   NOVO_ADQUIRENTE_UDID=
   ```
3. Adicionar ao `resources/variables/env_variables.py`:
   ```python
   NOVO_ADQUIRENTE_UDID = os.getenv("NOVO_ADQUIRENTE_UDID", "emulator-5554")
   ```
4. Criar `pabot_configs/novo_adquirente.args`:
   ```
   --variable DEVICE_TAG:novo_adquirente
   ```

---

## Adicionando um novo módulo

1. Criar estrutura de pastas:
   ```bash
   mkdir -p modules/<modulo>/{locators,pages,navigation}
   ```
2. Criar `modules/<modulo>/base_<modulo>.resource` importando base global + locators + pages + navigation
3. Criar `tests/regression/<modulo>/<modulo>.robot` importando apenas o `base_<modulo>.resource`
4. Seguir regras de nomenclatura do `docs/CLAUDE.md`

---

## Adicionando novos testes

- **Locators** → YAML em `modules/<modulo>/locators/`
- **Ações atômicas** → `modules/<modulo>/pages/<tela>_page.resource`
- **Fluxos compostos** → `modules/<modulo>/navigation/<modulo>_navigation.resource`
- **Caso de teste** → importa apenas keywords de navigation ou pages (via `base_<modulo>.resource`)

---

## Linting e qualidade

```bash
# Linter Robot Framework
uv run robocop resources/ modules/ tests/

# Formatação automática
uv run robotidy resources/ modules/ tests/
```

---

## Contribuindo

Consulte `docs/CLAUDE.md` para as regras arquiteturais completas, incluindo:
- Padrão `_Do` para keywords internas
- Regras de nomenclatura
- Lista de arquivos eliminados e renomeados
- Critérios de navigation vs pages
