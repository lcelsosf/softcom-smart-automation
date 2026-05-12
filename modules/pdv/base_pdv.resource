*** Settings ***
Documentation    Base do módulo Pdv — único import necessário nas suites.
...
...    Importa: base global + locators (1 YAML por tela) + navigation do módulo.
...    Navigation importa os pages transitivamente.
...
...    Hierarquia de imports:
...    pdv.robot
...      └── base_pdv.resource  ← você está aqui
...            ├── base.resource (libs, helpers, open_app, setup)
...            ├── locators/*.yaml (1 arquivo por tela)
...            └── navigation/pdv_navigation.resource
...                  └── pages/*.resource (1 arquivo por tela)

# --- Base global ---
Resource    ../../resources/base/base.resource

# --- Locators do módulo (1 YAML por tela) ---
Variables    locators/home_locators.yaml
Variables    locators/settings_locators.yaml
Variables    locators/orders_locators.yaml
Variables    locators/clients_locators.yaml
Variables    locators/list_orders_locators.yaml
Variables    locators/sync_locators.yaml

# --- Navigation do módulo (importa pages transitivamente) ---
Resource    navigation/pdv_navigation.resource
