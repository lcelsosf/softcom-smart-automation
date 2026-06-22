# Shield Smart Test Automation

Framework de automação mobile para testes de regressão em terminais de pagamento Android.
Construído com Robot Framework + Appium, suporta execução paralela em múltiplos adquirentes via Pabot.

---

## Sumário

- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Configuração](#configuração)
- [Estrutura de Pastas](#estrutura-de-pastas)
- [Arquitetura em Camadas](#arquitetura-em-camadas)
- [Executando os Testes](#executando-os-testes)
- [Relatório Allure](#relatório-allure)
- [Linting e Qualidade de Código](#linting-e-qualidade-de-código)
- [Implementando Novas Keywords](#implementando-novas-keywords)
- [Adicionando um Novo Adquirente](#adicionando-um-novo-adquirente)
- [Adicionando um Novo Módulo](#adicionando-um-novo-módulo)

---

## Pré-requisitos

| Dependência         | Versão mínima | Instalação                           |
| ------------------- | ------------- | ------------------------------------ |
| Python              | 3.12+         | [python.org](https://python.org)     |
| uv                  | latest        | `pip install uv`                     |
| Node.js             | 18+           | [nodejs.org](https://nodejs.org)     |
| Android SDK (adb)   | —             | Android Studio → SDK Platform Tools  |
| Appium Server       | 2.x           | `npm install -g appium`              |
| Appium UIAutomator2 | —             | `appium driver install uiautomator2` |
| Allure CLI          | latest        | `npm install -g allure-commandline`  |

Verificar instalação:

```powershell
adb devices              # lista devices conectados
appium --version         # verifica Appium Server
uv --version             # verifica uv
allure --version         # verifica Allure CLI
```

---

## Instalação

```powershell
# Clonar o repositório
git clone <url>
cd softcom-smart-automation

# Instalar todas as dependências Python (Robot Framework, Appium, Pabot, Allure, Robocop...)
uv sync

# Criar arquivo de variáveis de ambiente a partir do template
copy .env.example .env
# Edite .env preenchendo os UDIDs reais dos devices (obtidos com: adb devices)
```

---

## Configuração

### Devices (`resources/data/devices.yaml`)

Cada adquirente tem uma entrada com UDID (lido do `.env`), método de fechar teclado, porta do sistema Appium e URL do servidor:

```yaml
cielo:
  udid: "${CIELO_DX8000_UDID}"
  keyboard_close: "back" # "back" = keycode 4 | "hide" = Hide Keyboard
  system_port: 8200
  appium_server: "${APPIUM_SERVER_URL}"

rede:
  udid: "${REDE_L400_UDID}"
  keyboard_close: "back"
  system_port: 8202
  appium_server: "${APPIUM_SERVER_URL}"
```

> `keyboard_close: "back"` envia o keycode do botão Voltar Android. Use `"hide"` para devices que não respondem ao Voltar.

### Variáveis de Ambiente (`.env`)

Copie `.env.example` para `.env` e preencha com os UDIDs reais dos devices conectados:

```
CIELO_DX8000_UDID=ABC123
REDE_L400_UDID=DEF456
APPIUM_SERVER_URL=http://localhost:4723
...
```

Os UDIDs são lidos em `resources/variables/env_variables.py` via `python-dotenv` e injetados nos devices via `resources/libraries/devicesconfig.py`.

### Pabot configs (`pabot_configs/`)

Um arquivo `.args` por adquirente. Contém apenas a variável de tag do device:

```
--variable DEVICE_TAG:cielo
```

O `run_tests.ps1` usa esses arquivos automaticamente para montar a execução paralela.

---

## Estrutura de Pastas

```
softcom-smart-automation/
│
├── resources/                          # Camada global — compartilhada entre módulos
│   ├── base/
│   │   ├── base.resource               # Ponto de entrada global: libs + helpers + variáveis
│   │   ├── open_app.resource           # Abertura de sessão Appium (capabilities + start)
│   │   └── setup.resource              # Suite/Test Setup e Teardown com skip automático
│   ├── helpers/
│   │   ├── common_keywords.resource    # Utilitários: click, input, swipe, long press, etc.
│   │   ├── error_handling.resource     # Tratamento padronizado de erros
│   │   ├── structured_logging.resource # Log Action — logs estruturados em JSON
│   │   └── validation.resource         # Assertions reutilizáveis
│   ├── libraries/
│   │   ├── devicesconfig.py            # Lê devices.yaml e expande env vars (fonte única de config)
│   │   ├── logcatlibrary.py            # Captura e validação de logcat Android
│   │   └── locators_loader.py          # Resolve locators por app_package e DEVICE_TAG
│   ├── data/
│   │   ├── devices.yaml                # Configuração de todos os adquirentes
│   │   └── endpoints.yaml              # URLs de API
│   └── variables/
│       └── env_variables.py            # UDIDs via python-dotenv
│
├── modules/                            # Camada modular — cada módulo auto-contido
│   ├── pdv/
│   │   ├── base_pdv.resource           # Único import necessário nas suites PDV
│   │   ├── locators/                   # Um YAML por tela (homeLocators.yml, etc.)
│   │   ├── pages/                      # Ações atômicas por tela (home_page.resource, etc.)
│   │   ├── navigation/
│   │   │   ├── pdv_navigation.resource         # Navegações compostas entre telas
│   │   │   ├── pdv_complete_streams.resource   # Fluxos end-to-end completos
│   │   │   └── pdv_settings_setup.resource     # Configurações de setup de ambiente
│   │   ├── data/
│   │   │   └── pdv_data.yml            # Dados de teste (produtos, clientes, etc.)
│   │   └── pdv_guide.md                # Documentação detalhada do módulo PDV
│   │
│   └── commands/
│       ├── base_commands.resource      # Único import necessário nas suites Commands
│       ├── locators/                   # Um YAML por tela
│       ├── pages/                      # Ações atômicas por tela
│       └── navigation/                 # Navegações e fluxos do módulo
│
├── tests/
│   └── regression/
│       ├── pdv/pdv.robot               # Suite de regressão — módulo PDV
│       └── commands/commands.robot     # Suite de regressão — módulo Commands
│
├── pabot_configs/                      # Um .args por adquirente
│   ├── cielo.args
│   ├── rede.args
│   ├── getnet.args
│   ├── quickpay.args
│   └── ...
│
├── docs/
│   └── CLAUDE.md                       # Referência arquitetural completa (para devs)
│
├── allure-results/                     # Gerado durante execução — gitignore
├── allure-report/                      # Gerado pelo allure generate — gitignore
├── pabot_results/                      # Resultados pabot — gitignore
│
├── run_tests.ps1                       # Script interativo de execução (PowerShell)
├── pyproject.toml                      # Dependências Python
├── .env                                # UDIDs reais — gitignore
└── .env.example                        # Template de variáveis
```

---

## Arquitetura em Camadas

O projeto segue 3 camadas com fluxo de imports unidirecional — cada camada importa apenas da imediatamente abaixo:

```
tests/regression/<modulo>/<modulo>.robot
  │
  └── modules/<modulo>/base_<modulo>.resource   ← único import da suite
        │
        ├── resources/base/base.resource         ← globals: libs, helpers, variáveis
        │     ├── AppiumLibrary
        │     ├── FakerLibrary
        │     ├── devicesconfig.py
        │     ├── logcatlibrary.py
        │     ├── locators_loader.py
        │     ├── common_keywords.resource
        │     ├── structured_logging.resource
        │     ├── error_handling.resource
        │     └── open_app.resource
        │
        ├── modules/<modulo>/locators/*.yaml      ← locators da tela (via locators_loader.py)
        │
        └── modules/<modulo>/navigation/
              ├── <modulo>_navigation.resource    ← navegações compostas
              │     └── pages/*.resource          ← ações atômicas por tela
              ├── <modulo>_complete_streams.resource  ← fluxos end-to-end
              └── <modulo>_settings_setup.resource    ← setup de ambiente de testes
```

**Regra de ouro:** a suite só importa o `base_<modulo>.resource`. Nunca importe `base.resource` diretamente numa suite, nem chame keywords de `pages/` diretamente nos casos de teste.

### Setup e Teardown

As suites usam keywords wrapper de `resources/base/setup.resource`:

| Keyword                  | Comportamento                                                              |
| ------------------------ | -------------------------------------------------------------------------- |
| `Suite Setup Default`    | Abre o app; registra início de suite no log                                |
| `Suite Teardown Default` | Fecha o app; consolida screenshots                                         |
| `Test Setup Default`     | Pula o teste se o anterior falhou por erro de UI (evita cascata de falhas) |
| `Test Teardown Default`  | Captura screenshot em falha; fecha teclado se necessário                   |

---

## Executando os Testes

### Execução interativa (recomendado)

```powershell
.\run_tests.ps1
```

O script:

1. Lê o `.env` automaticamente
2. Detecta devices Android conectados via ADB
3. Exibe menu de seleção de devices (individual ou todos)
4. Exibe menu de seleção de suite
5. Monta e executa o comando `pabot` com os `.args` corretos
6. Gera e abre o relatório Allure automaticamente

### Execução manual — device único, suite completa

```powershell
uv run robot `
  --variable DEVICE_TAG:cielo `
  --listener allure_robotframework:allure-results `
  tests/regression/pdv/pdv.robot
```

### Execução manual — caso de teste específico

```powershell
uv run robot `
  --variable DEVICE_TAG:cielo `
  --test "PDV - Setup" `
  tests/regression/pdv/pdv.robot
```

### Execução manual — por tag

```powershell
# Executa apenas testes marcados com a tag "setup"
uv run robot `
  --variable DEVICE_TAG:cielo `
  --include setup `
  tests/regression/pdv/pdv.robot
```

### Execução paralela — múltiplos devices (Pabot)

```powershell
uv run pabot `
  --processes 2 `
  --argumentfile1 pabot_configs/cielo.args `
  --argumentfile2 pabot_configs/rede.args `
  --outputdir . `
  --listener allure_robotframework:allure-results `
  tests/regression/pdv/pdv.robot
```

### Validar sintaxe sem executar (dry-run)

```powershell
uv run robot --dryrun `
  --variable DEVICE_TAG:cielo `
  tests/regression/pdv/pdv.robot
```

---

## Relatório Allure

O listener `allure_robotframework` grava resultados JSON em `allure-results/` durante a execução.
Após os testes, gere e abra o relatório HTML:

```powershell
# Gerar relatório
allure generate allure-results -o allure-report --clean

# Abrir no browser
allure open allure-report
```

> O Allure CLI é instalado via npm: `npm install -g allure-commandline`
> Não use `uv run allure` — o allure é uma ferramenta Node, não Python.

---

## Linting e Qualidade de Código

### Validar com Robocop (linter)

```powershell
# Lint em todos os arquivos
uv run robocop check

# Corrige violações de regras que têm fix
uv run robocop check --fix

# Formatar todos os arquivos
uv run robocop format
```

---

## Implementando Novas Keywords

O fluxo completo de implementação segue sempre a mesma ordem:
**Locator → Page → Navigation → Fluxo Completo → Caso de Teste**

### 1. Locator (YAML)

Cada tela tem um arquivo YAML em `modules/<modulo>/locators/`.
Os locators são agrupados por namespace (um namespace por contexto de UI):

```yaml
# modules/pdv/locators/homeLocators.yml

home:
  btn_new_order: xpath=//*[@resource-id='NovoPedidoCard_0']
  btn_orders_list: xpath=//*[@resource-id='HomeActionWideCard_0']

logoff:
  btn_yes: xpath=//android.view.View[.//android.widget.TextView[@text='Sim']]
  btn_no: xpath=//android.view.View[.//android.widget.TextView[@text='Não']]
```

Acesso no Robot: `${home.btn_new_order}`, `${logoff.btn_yes}`.

O `locators_loader.py` resolve o `app_package` do device automaticamente — você não precisa se preocupar com isso.

### 2. Page (ação atômica)

Keywords de page fazem **uma única ação** em **uma única tela**. Não navegam entre telas.

```robotframework
# modules/pdv/pages/home_page.resource

*** Settings ***
Resource    ../../../resources/helpers/common_keywords.resource

*** Keywords ***
Pdv - Home - Click New Order
    [Documentation]    Card "Novo Pedido" — inicia um pedido.
    Wait Visible And Click Element    ${home.btn_new_order}

Pdv - Home - Click Settings
    [Documentation]    Card "Configurações".
    Wait Visible And Click Element    ${home.btn_settings}
```

**Nomenclatura:** `<Modulo> - <Tela> - <Ação> <Complemento>`

Use sempre as keywords de `common_keywords.resource` — elas têm tratamento de erro e screenshot automático:

| Keyword                                     | Uso                                            |
| ------------------------------------------- | ---------------------------------------------- |
| `Wait Visible And Click Element`            | Aguarda visível e clica                        |
| `Wait Visible And Click Element With Retry` | Clica com retry em caso de stale element       |
| `Wait Visible And Input Text`               | Aguarda visível e digita (paste)               |
| `Wait Visible And Input Text Pause`         | Digita caractere a caractere (campos de busca) |
| `Wait Visible And Long Press Element`       | Long press com duração configurável            |
| `Swipe Until Visible And Click Element`     | Scroll + clique para elementos fora da tela    |
| `Wait For Element To Disappear`             | Aguarda elemento sumir                         |
| `Assert Element Not Visible`                | Valida que elemento não está visível           |
| `Close Keyboard`                            | Fecha o teclado (método lido do devices.yaml)  |
| `Normalize Digits`                          | Remove caracteres não numéricos de uma string  |

### 3. Navigation (fluxo composto)

Keywords de navigation **combinam ações de pages** para realizar uma navegação com múltiplas etapas:

```robotframework
# modules/pdv/navigation/pdv_navigation.resource

*** Settings ***
Resource    ../pages/home_page.resource
Resource    ../pages/orders_page.resource
Resource    ../pages/checkout_page.resource

*** Keywords ***
Pdv - Navigate To Checkout
    [Arguments]    ${product}
    Pdv - Home - Click New Order
    Pdv - Orders - Search Product    ${product}
    Pdv - Orders - Click Add To Cart
    Pdv - Orders - Click Checkout
```

### 4. Fluxo Completo (end-to-end)

Fluxos completos ficam em `<modulo>_complete_streams.resource` e representam um cenário inteiro de uso:

```robotframework
# modules/pdv/navigation/pdv_complete_streams.resource

*** Keywords ***
PDV - Complete Flow - Order Common
    [Arguments]    ${product}    ${payment_method}
    Pdv - Navigate To Checkout    ${product}
    Pdv - Checkout - Select Payment Method    ${payment_method}
    Pdv - Checkout - Confirm Payment
    Pdv - Orders Status - Verify Success
```

### 5. Caso de Teste

A suite `.robot` só chama keywords de navigation ou fluxos completos, nunca de pages diretamente:

```robotframework
# tests/regression/pdv/pdv.robot

*** Settings ***
Resource    ../../../modules/pdv/base_pdv.resource
Suite Setup      Suite Setup Default
Suite Teardown   Suite Teardown Default
Test Setup       Test Setup Default
Test Teardown    Test Teardown Default

*** Test Cases ***
PDV - Order Common
    [Documentation]    Realiza pedido simples com pagamento em dinheiro.
    [Tags]    regression    pdv    orders
    PDV - Complete Flow - Order Common
    ...    ${products.product_1}
    ...    money
```

### Registrar novo YAML de locators em `base_<modulo>.resource`

Ao criar um novo arquivo de locators, adicione-o na linha `Variables` do `locators_loader.py` dentro do `base_<modulo>.resource`:

```robotframework
# Adicionar o novo YAML antes de ${DEVICE_TAG}:
Variables    ../../resources/libraries/locators_loader.py \
    modules/pdv/locators/homeLocators.yml \
    modules/pdv/locators/novaTelaLocators.yml \
    ${DEVICE_TAG}
```

---

## Adicionando um Novo Adquirente

1. **`resources/data/devices.yaml`** — adicionar a entrada:

   ```yaml
   novo_adquirente:
     udid: "${NOVO_ADQUIRENTE_UDID}"
     keyboard_close: "back"
     system_port: 8236
     appium_server: "${APPIUM_SERVER_URL}"
   ```

   > Escolha uma `system_port` única (par, sequencial ao último usado).

2. **`.env` e `.env.example`** — adicionar a variável:

   ```
   NOVO_ADQUIRENTE_UDID=
   ```

3. **`resources/variables/env_variables.py`** — adicionar:

   ```python
   NOVO_ADQUIRENTE_UDID = os.getenv("NOVO_ADQUIRENTE_UDID", "")
   ```

4. **`pabot_configs/novo_adquirente.args`** — criar o arquivo:
   ```
   --variable DEVICE_TAG:novo_adquirente
   ```

Após isso, o `run_tests.ps1` detecta o device automaticamente pelo UDID e carrega o `.args` correspondente.

---

## Adicionando um Novo Módulo

1. **Criar a estrutura de pastas:**

   ```powershell
   mkdir modules\novo_modulo\locators
   mkdir modules\novo_modulo\pages
   mkdir modules\novo_modulo\navigation
   ```

2. **Criar `modules/novo_modulo/base_novo_modulo.resource`** seguindo o padrão dos módulos existentes:

   ```robotframework
   *** Settings ***
   Documentation    Base do módulo Novo Modulo.

   Resource    ../../resources/base/base.resource
   Variables    ../../resources/libraries/locators_loader.py    modules/novo_modulo/locators/telaLocators.yml    ${DEVICE_TAG}
   Resource    navigation/novo_modulo_navigation.resource
   ```

3. **Criar os locators, pages e navigation** seguindo a convenção de nomenclatura documentada acima.

4. **Criar a suite `tests/regression/novo_modulo/novo_modulo.robot`:**

   ```robotframework
   *** Settings ***
   Resource    ../../../modules/novo_modulo/base_novo_modulo.resource
   Suite Setup      Suite Setup Default
   Suite Teardown   Suite Teardown Default
   Test Setup       Test Setup Default
   Test Teardown    Test Teardown Default
   ```

5. Consulte `modules/pdv/pdv_guide.md` como referência detalhada de um módulo completo implementado.

---

## Referência Adicional

- `modules/pdv/pdv_guide.md` — documentação detalhada do módulo PDV: todos os locators, keywords, fluxos e casos de teste mapeados
- `docs/CLAUDE.md` — referência arquitetural completa: convenções de nomenclatura, regras de camadas, histórico de decisões técnicas
