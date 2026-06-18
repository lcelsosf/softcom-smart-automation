*** Settings ***
Documentation    Configuração global do projeto — importada por todos os base_<modulo>.resource.
...
...    Responsabilidades:
...    - Carregar todas as bibliotecas externas e customizadas
...    - Definir variáveis globais de ambiente e execução
...    - Importar helpers e base de sessão compartilhados
...
...    USO:
...    Nunca importe este arquivo diretamente nas suites de teste.
...    Cada módulo tem seu próprio base_<modulo>.resource que importa este arquivo.
...
...    HIERARQUIA DE IMPORTS:
...    suite.robot
...      └── base_<modulo>.resource
...            └── base.resource  ← você está aqui
...                  ├── AppiumLibrary
...                  ├── DevicesConfig.py
...                  ├── LogcatLibrary.py
...                  ├── structured_logging.resource
...                  ├── error_handling.resource
...                  ├── common_keywords.resource
...                  └── open_app.resource

# --- Bibliotecas externas ---
Library     AppiumLibrary

# --- Bibliotecas customizadas ---
Library     ../libraries/devicesconfig.py
Library     ../libraries/logcatlibrary.py
            
# --- Variáveis de ambiente via python-dotenv ---
Variables   ../variables/env_variables.py

# --- Helpers globais ---
Resource    ../helpers/structured_logging.resource
Resource    ../helpers/error_handling.resource
Resource    ../helpers/common_keywords.resource

# --- Sessão Appium ---
Resource    open_app.resource

# --- Setup e Teardown padrão ---
Resource    setup.resource


*** Variables ***
# --- Identificação do device ---
# Sobrescritos via linha de comando ou pabot_configs/*.args
${DEVICE_TAG}            ${EMPTY}
${DEVICE_UDID}           emulator-5554
${DEFAULT_UDID}          emulator-5554

# --- Timeouts ---
${TIMEOUT}               60s
${SHORT_TIMEOUT}         10s
${ELEMENT_TIMEOUT}       60s
${DEFAULT_TIMEOUT}       60s

# --- Diretórios de saída ---
${SCREENSHOT_DIR}        results/screenshots
