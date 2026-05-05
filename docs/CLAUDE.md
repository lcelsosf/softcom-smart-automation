# CLAUDE.md — Shield Smart Test Automation

Documento de referência arquitetural para uso direto na IDE com IA (Cursor, Windsurf, Claude Code).
Descreve todas as decisões técnicas, padrões e estrutura alvo do projeto.
Em caso de dúvida, este arquivo prevalece sobre qualquer convenção genérica.

---

## 1. Stack e ferramentas

| Ferramenta | Versão mínima | Função |
|---|---|---|
| Python | 3.11 | Runtime |
| uv | latest | Gerenciador de pacotes (substitui pip) |
| Robot Framework | 7.4.2 | Framework de automação |
| AppiumLibrary | 3.2.1 | Keywords mobile Android |
| Pabot | 5.2.2 | Execução paralela por device |
| Allure Robot Framework | 2.13.5 | Relatórios |
| Robocop | 8.2.2 | Linter (dev dependency) |
| RobotFramework Faker | 6.0.0 | Geração de dados de teste |
| python-dotenv | 1.2.2 | Leitura de variáveis de ambiente |
| PyYAML | 6.0.3 | Leitura de arquivos YAML |

Gerenciamento de dependências exclusivamente via `uv`. Nunca usar `pip install` diretamente.

```bash
uv add <pacote>           # adicionar dependência
uv add --dev <pacote>     # dependência de desenvolvimento
uv run robot ...          # executar robot dentro do venv gerenciado pelo uv
uv run pabot ...          # executar pabot dentro do venv gerenciado pelo uv
```

---

## 2. Estrutura de pastas

```
projeto/
│
├── resources/                          # Camada global — compartilhada entre todos os módulos
│   ├── base/
│   │   ├── base.resource               # Importa libs, variables globais e helpers
│   │   ├── open_app.resource           # Resolve UDID + abre sessão Appium
│   │   └── setup.resource             # Suite/Test Setup e Teardown
│   │
│   ├── helpers/
│   │   ├── common_keywords.resource    # Keywords utilitárias de interação com UI
│   │   ├── error_handling.resource     # Screenshot em falha, Fatal Error
│   │   ├── structured_logging.resource # Log Action com timestamp
│   │   └── validation.resource        # Validação via logcat (renomeado de .robot)
│   │
│   ├── libraries/
│   │   ├── DevicesConfig.py            # Lê devices.yaml, expande env vars, fallback por UDID
│   │   ├── LogcatLibrary.py            # Captura e validação de logcat Android
│   │   └── locators_loader.py          # Resolve APP_PACKAGE e faz merge dos YAMLs de locators
│   │
│   ├── locators/                       # YAMLs de locators globais/compartilhados
│   │   ├── common.yml
│   │   ├── default.yml
│   │   ├── pdv.yml
│   │   └── commands.yml
│   │
│   ├── data/
│   │   ├── devices.yaml                # FONTE ÚNICA: tag → udid, app_package, keyboard_close,
│   │   │                               # system_port, appium_server
│   │   ├── user_data.yaml
│   │   └── endpoints.yaml
│   │
│   ├── fixtures/                       # Massa de dados por módulo
│   │   ├── commands/
│   │   ├── default/
│   │   └── common/
│   │
│   └── variables/
│       └── env_variables.py            # Leitura de variáveis de ambiente via python-dotenv
│
├── modules/                            # Camada modular — cada módulo é auto-contido
│   ├── default/
│   │   ├── base_default.resource       # ÚNICO ponto de entrada do módulo
│   │   ├── locators/
│   │   ├── pages/
│   │   └── navigation/
│   │
│   ├── pdv/
│   │   ├── base_pdv.resource
│   │   ├── locators/
│   │   ├── pages/
│   │   └── navigation/
│   │
│   ├── commands/
│   │   ├── base_commands.resource
│   │   ├── locators/
│   │   ├── pages/
│   │   └── navigation/
│   │
│   ├── prevenda/
│   │   ├── base_prevenda.resource
│   │   ├── locators/
│   │   ├── pages/
│   │   └── navigation/
│   │
│   ├── mini_mercado/
│   │   ├── base_mini_mercado.resource
│   │   ├── locators/
│   │   ├── pages/
│   │   └── navigation/
│   │
│   └── common/                         # Pages e locators compartilhados entre módulos
│       ├── pages/
│       │   ├── login_page.resource
│       │   └── verifications.resource
│       └── locators/
│
├── tests/                              # Suites de teste — uma pasta por módulo
│   ├── regression/
│   │   ├── default/
│   │   │   └── default.robot
│   │   ├── pdv/
│   │   │   └── pdv.robot
│   │   ├── commands/
│   │   │   └── commands.robot
│   │   ├── prevenda/
│   │   │   └── prevenda.robot
│   │   └── mini_mercado/
│   │       └── mini_mercado.robot
│   ├── smoke/
│   │   └── smoke.robot
│   └── unit/
│       └── test_logcat_library.py
│
├── pabot_configs/                      # Um .args por adquirente
│   ├── cielo.args
│   ├── rede.args
│   ├── rede_n960k.args
│   ├── getnet_dx8000.args
│   ├── getnet_p2.args
│   ├── getnet_p3.args
│   ├── stone.args
│   ├── pagbank.args
│   ├── pagbank_a11.args
│   ├── fiserv.args
│   ├── sipag_p2.args
│   ├── sipag_x990.args
│   ├── sipag_dx8000.args
│   ├── safra.args
│   ├── mercadopago.args
│   ├── quickpay_a910.args
│   ├── clover.args
│   └── README.md
│
├── pabot_results/                      # Gerado automaticamente — gitignore
├── allure-report/                      # Gerado automaticamente — gitignore
├── documentation/                      # Documentação do projeto
│   └── PROJECT_ANALYSIS.md
├── run_tests.sh                        # Detecção de devices via ADB + menu interativo
├── .env                                # UDIDs reais — gitignore
├── .env.example                        # Template de variáveis de ambiente
├── .gitignore
├── pyproject.toml                      # Dependências gerenciadas pelo uv
├── uv.lock                             # Commitar no git
└── README.md
```

---

## 3. Regras de ouro — nunca violar

1. **Locators ficam APENAS em arquivos YAML** — nunca hardcoded em `.resource` ou `.robot`
2. **Pages têm APENAS keywords atômicas** — uma ação por keyword, sem fluxos compostos
3. **Fluxos compostos ficam em `navigation/`** — nunca em `pages/`
4. **Cada suite importa APENAS o `base_<modulo>.resource`** do seu módulo
5. **`base_<modulo>.resource` é o único ponto de entrada do módulo** — centraliza todos os imports
6. **`devices.yaml` é a fonte única de verdade dos devices** — nunca duplicar em `.args` ou `.resource`
7. **Novos adquirentes: editar apenas `devices.yaml`** e criar o `.args` correspondente
8. **Nunca usar `pip install`** — sempre `uv add`

---

## 4. `devices.yaml` — estrutura obrigatória

Cada entrada deve conter todos os campos abaixo. O `locators_loader.py` e o
`DevicesConfig.py` dependem dessa estrutura.

```yaml
default_app_package: "softcom.mobile.smart2"

devices:
  <tag>:
    udid: "${NOME_DA_VAR_ENV}"        # lido via os.getenv() com python-dotenv
    app_package: "com.pacote.app"     # opcional — usa default_app_package se omitido
    keyboard_close: "hide"            # "hide" ou "back"
    system_port: 8200                 # porta única por device — evitar colisões no pabot
    appium_server: "http://localhost:4723"
```

**Adquirentes cadastrados:**

| Tag | UDID env var | system_port |
|---|---|---|
| cielo | CIELO_DX8000_UDID | 8200 |
| rede | REDE_L400_UDID | 8202 |
| rede_n960k | REDE_N960K_UDID | 8204 |
| getnet | GETNET_DX8000_UDID | 8206 |
| getnet_dx8000 | GETNET_DX8000_UDID | 8206 |
| getnet_p2 | GETNET_P2_UDID | 8208 |
| getnet_p3 | GETNET_P3_UDID | 8210 |
| stone | STONE_UDID | 8212 |
| pagbank | PAGBANK_A7_1_UDID | 8214 |
| pagbank_a11 | PAGBANK_A11_UDID | 8216 |
| fiserv | FISERV_UDID | 8218 |
| sipag_p2 | SIPAG_P2_UDID | 8220 |
| sipag_x990 | SIPAG_X990_UDID | 8222 |
| sipag_dx8000 | SIPAG_DX8000_UDID | 8224 |
| safra | SAFRA_UDID | 8226 |
| mercadopago | MERCADOPAGO_UDID | 8228 |
| quickpay | QUICKPAY_A910_UDID | 8230 |
| quickpay_a910 | QUICKPAY_A910_UDID | 8230 |
| clover | CLOVER_UDID | 8232 |

---

## 5. `DevicesConfig.py` — métodos obrigatórios

O arquivo deve expor os seguintes métodos públicos para o Robot Framework:

```python
class DevicesConfig:
    def get_device_udid(self, tag: str, default: str = "emulator-5554") -> str:
        """Retorna o UDID do device para a tag informada."""

    def get_device_config(self, tag: str) -> DeviceConfig:
        """Retorna objeto com system_port, appium_server, app_package para a tag."""

    def get_keyboard_close_method(self, tag: str) -> str:
        """Retorna 'back' ou 'hide' conforme devices.yaml."""

    def get_tag_from_udid(self, udid: str) -> str:
        """Busca a tag no devices.yaml pelo UDID. Retorna 'default' se não encontrar.
        Elimina a necessidade de comparar variáveis ${*_UDID} no .resource."""
```

Regras de implementação:
- Usar `python-dotenv` para expandir variáveis de ambiente (`${VAR}` no YAML)
- Nunca usar a sintaxe customizada `%{VAR=default}` — usar `os.getenv("VAR", default)` padrão
- Carregar o `.env` automaticamente via `load_dotenv()` no `__init__`

---

## 6. `pabot_configs/*.args` — estrutura obrigatória

Cada arquivo contém **apenas a tag do device**. Todas as outras configurações
vêm do `devices.yaml` via `DevicesConfig.py`.

```
# cielo.args
--variable DEVICE_TAG:cielo
```

Nunca adicionar `SYSTEM_PORT`, `APPIUM_SERVER_URL` ou outros nos `.args` —
essas informações vivem exclusivamente no `devices.yaml`.

---

## 7. `base.resource` — estrutura obrigatória

```robot
*** Settings ***
Library     AppiumLibrary
Library     resources/libraries/DevicesConfig.py
Library     resources/libraries/LogcatLibrary.py
Resource    resources/helpers/structured_logging.resource
Resource    resources/helpers/common_keywords.resource
Resource    resources/helpers/error_handling.resource
Resource    resources/base/open_app.resource
Resource    resources/base/setup.resource

*** Variables ***
${SCREENSHOT_DIR}     results/screenshots
${TIMEOUT}            30s
${SHORT_TIMEOUT}      10s
${ELEMENT_TIMEOUT}    15s
${DEFAULT_TIMEOUT}    30s
${DEVICE_TAG}         ${EMPTY}
${DEVICE_UDID}        emulator-5554
${DEFAULT_UDID}       emulator-5554
```

---

## 8. `base_<modulo>.resource` — estrutura obrigatória

Cada módulo tem um arquivo base que é o **único import das suites**.
Ele deve importar: base global + locators + pages + navigation do módulo.

```robot
*** Settings ***
Documentation    Base do módulo <modulo> — importa tudo necessário para as suites deste módulo.
Resource    ../../resources/base/base.resource
Resource    ./locators/<modulo>_locators.yaml      # via locators_loader.py
Resource    ./pages/<tela>_page.resource
Resource    ./navigation/<modulo>_navigation.resource
```

---

## 9. Suites de teste — estrutura obrigatória

```robot
*** Settings ***
Documentation    Suite de regressão — módulo <modulo>
Resource         ../../modules/<modulo>/base_<modulo>.resource
Suite Setup      Open App
Suite Teardown   Close App
Test Setup       <keyword de setup do módulo se necessário>

*** Test Cases ***
<Nome do cenário em português>
    [Tags]    @allure.label.severity:critical    regression    <modulo>
    <Keyword de navigation ou page>
    <Keyword de validação>
```

Regras:
- Importar **apenas** o `base_<modulo>.resource` — nunca importar resources diretamente
- Usar `Open App` e `Close App` de `open_app.resource` no Setup/Teardown
- Tags Allure em todos os casos de teste

---

## 10. Padrão de nomenclatura

### Keywords
- **Pages:** `<Modulo> - <Tela> - <Ação>`
  - Exemplo: `Default - Orders - Select Product`
- **Navigation:** `<Modulo> - Navigate To <Destino>`
  - Exemplo: `Default - Navigate To Settings`
- **Helpers públicos:** verbo + substantivo descritivo
  - Exemplo: `Wait Visible And Click Element`, `Close Keyboard`
- **Helpers internos:** prefixo `_Do` + nome da keyword pública
  - Exemplo: `_Do Wait Visible And Click Element`
- **Setup/Teardown:** `Open App`, `Close App`

### Arquivos
- Pages: `<tela>_page.resource`
- Locators: `<tela>_locators.yaml`
- Navigation: `<modulo>_navigation.resource`
- Base de módulo: `base_<modulo>.resource`
- Suites: `<modulo>.robot` ou `<funcionalidade>_suite.robot`

### Variáveis Robot Framework
- Globais: `${UPPER_CASE}`
- Locators carregados: `${nome_tela.nome_elemento}` (notação de ponto via locators_loader)

---

## 11. Padrão `_Do` — keywords internas

Keywords prefixadas com `_Do` são internas e nunca devem ser chamadas diretamente
fora do arquivo onde estão definidas. Elas existem para permitir que `Run With
Screenshot On Failure` receba a lógica real como argumento.

```robot
# Pública — chamada por pages, navigation e testes
Wait Visible And Click Element
    [Arguments]    ${locator}    ${timeout}=${ELEMENT_TIMEOUT}
    Run With Screenshot On Failure    _Do Wait Visible And Click Element    click_error
    ...    Erro ao clicar em '${locator}'    ${locator}    ${timeout}

# Interna — nunca chamar diretamente
_Do Wait Visible And Click Element
    [Arguments]    ${locator}    ${timeout}=${ELEMENT_TIMEOUT}
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Click Element    ${locator}
```

---

## 12. `variables.resource` — ELIMINADO

O arquivo `variables/variables.resource` foi eliminado na refatoração.
Suas responsabilidades foram redistribuídas:

| Variável | Destino |
|---|---|
| `${APPIUM_SERVER_URL}` | `devices.yaml` por tag → lido pelo `DevicesConfig.py` |
| `${SYSTEM_PORT}` | `devices.yaml` por tag → lido pelo `DevicesConfig.py` |
| `${DEVICE_TAG}` | Seção `*** Variables ***` do `base.resource` |
| `${DEVICE_UDID}` | Seção `*** Variables ***` do `base.resource` |
| `${DEFAULT_UDID}` | Seção `*** Variables ***` do `base.resource` |
| `${SCREENSHOT_DIR}` | Seção `*** Variables ***` do `base.resource` |
| `${*_UDID}` por adquirente | Eliminadas — `get_tag_from_udid()` no `DevicesConfig.py` |
| Credenciais de teste | `.env` → `env_variables.py` via `python-dotenv` |

---

## 13. `device.resource` — ELIMINADO

O arquivo `common/device.resource` foi eliminado na refatoração.
A keyword `Get Device Type` foi absorvida:

- `Close Keyboard` em `common_keywords.resource` resolve o device diretamente
  via `${DEVICE_TAG}` + `Get Tag From Udid` do `DevicesConfig.py`
- Qualquer page que precise da tag usa `${DEVICE_TAG}` diretamente

---

## 14. `common/` — DISSOLVIDA

A pasta `common/` foi dissolvida. Mapeamento dos arquivos:

| Arquivo original | Destino |
|---|---|
| `common/open_app.resource` | `resources/base/open_app.resource` |
| `common/common_keywords.resource` | `resources/helpers/common_keywords.resource` |
| `common/error_handling.resource` | `resources/helpers/error_handling.resource` |
| `common/structured_logging.resource` | `resources/helpers/structured_logging.resource` |
| `common/validation.robot` | `resources/helpers/validation.resource` (renomear extensão) |
| `common/device.resource` | **Eliminado** |

---

## 15. Keywords renomeadas

Renomeações aplicadas para evitar colisão com AppiumLibrary:

| Nome antigo | Nome novo | Motivo |
|---|---|---|
| `Wait Until Element Is Not Visible` | `Wait For Element To Disappear` | Colisão com AppiumLibrary |
| `Element Should Not Be Visible` | `Assert Element Not Visible` | Colisão com AppiumLibrary |
| `Limpar Logcat` | `Clear Logcat` (direto da LogcatLibrary) | Wrapper desnecessário |
| `Wait And Click Element` | `Wait Visible And Click Element` com `timeout` opcional | Duplicação |

---

## 16. Execução de testes

### Execução interativa (recomendado)
```bash
chmod +x run_tests.sh
./run_tests.sh
# → detecta devices via ADB
# → exibe menu de seleção de devices e suites
# → monta e executa o comando pabot
# → gera allure report
```

### Execução manual — device único
```bash
uv run robot -v DEVICE_TAG:cielo tests/regression/default/default.robot
```

### Execução manual — paralela
```bash
uv run pabot --processes 2 \
      --argumentfile1 pabot_configs/cielo.args \
      --argumentfile2 pabot_configs/clover.args \
      --outputdir pabot_results/ \
      --listener allure_robotframework:allure-report/ \
      tests/
```

### Gerar relatório Allure
```bash
uv run allure generate allure-report/ -o allure-report/html --clean
uv run allure open allure-report/html
```

---

## 17. `.gitignore` obrigatório

```
# Ambiente virtual
.venv/

# Resultados de execução
pabot_results/
allure-report/
results/

# Variáveis de ambiente com dados sensíveis
.env

# Python
__pycache__/
*.pyc
*.log

# uv — NÃO ignorar uv.lock (deve ser commitado)
```

---

## 18. Plano de migração — ordem de execução

Execute nesta ordem para migrar do estado atual para a arquitetura alvo:

| # | Ação | Arquivos afetados | Risco |
|---|---|---|---|
| 1 | Remover import `.venv` de `commands/main_navigation.resource` | 1 arquivo | Baixo |
| 2 | Renomear `common/validation.robot` → `resources/helpers/validation.resource` | 1 arquivo | Baixo |
| 3 | Refatorar `DevicesConfig.py` — adicionar `get_tag_from_udid()` e `get_device_config()`, migrar para `python-dotenv` | 1 arquivo | Médio |
| 4 | Adicionar `system_port` e `appium_server` ao `devices.yaml` para todos os adquirentes | 1 arquivo | Baixo |
| 5 | Simplificar todos os `.args` — remover tudo exceto `--variable DEVICE_TAG:<tag>` | 19 arquivos | Baixo |
| 6 | Criar `resources/base/base.resource` com variáveis globais (substitui `variables.resource`) | 1 arquivo novo | Médio |
| 7 | Mover e adaptar arquivos de `common/` para `resources/base/` e `resources/helpers/` | 6 arquivos | Médio |
| 8 | Eliminar `common/device.resource` — adaptar `Close Keyboard` e `comboPage.resource` | 2 arquivos | Médio |
| 9 | Criar `base_<modulo>.resource` para cada módulo centralizando todos os imports | 5 arquivos | Médio |
| 10 | Adaptar suites para importar apenas o `base_<modulo>.resource` do módulo | 5 suites | Médio |
| 11 | Mover `pages/` e `navigation/` para dentro de `modules/<modulo>/` | ~40 arquivos | Alto |
| 12 | Resolver `base_minimarket.resource` — implementar ou remover | 1-5 arquivos | Baixo |
| 13 | Limpar `orders_navigation.resource` (shim) e código morto em `commands/` | 2 arquivos | Médio |

---

## 19. Arquivos já refatorados

Os arquivos abaixo já foram refatorados e estão prontos para uso:

- ✅ `resources/helpers/common_keywords.resource`
- ✅ `resources/base/open_app.resource`
- ✅ `run_tests.sh`

Próximos a refatorar (sugerido):
- `resources/libraries/DevicesConfig.py` — adicionar `get_tag_from_udid()` e `get_device_config()`
- `resources/data/devices.yaml` — adicionar `system_port` e `appium_server`
- `resources/base/base.resource` — criar com variáveis globais
- `resources/helpers/structured_logging.resource` — corrigir formatação de `&{kwargs}`
- `resources/helpers/error_handling.resource` — mover sem mudanças estruturais
- `resources/helpers/validation.resource` — extrair helpers internos, renomear extensão
