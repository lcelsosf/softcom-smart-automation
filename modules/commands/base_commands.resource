*** Settings ***
Documentation    Base do módulo Commands — único import necessário nas suites.
...
...    Importa: base global + locators (1 YAML por tela) + navigation do módulo.
...    Navigation importa os pages transitivamente.
...
...    Hierarquia de imports:
...    commands.robot
...      └── base_commands.resource  ← você está aqui
...            ├── base.resource (libs, helpers, open_app, setup)
...            ├── locators/*.yaml (1 arquivo por tela)
...            └── navigation/commands_navigation.resource
...                  └── pages/*.resource (1 arquivo por tela)

# --- Base global ---
Resource    ../../resources/base/base.resource

# --- Locators do módulo (1 YAML por tela) ---
Variables    locators/table_panel_locators.yaml
Variables    locators/open_table_locators.yaml
Variables    locators/client_locators.yaml
Variables    locators/table_locators.yaml
Variables    locators/products_locators.yaml
Variables    locators/menu_table_locators.yaml
Variables    locators/advance_locators.yaml
Variables    locators/invoice_locators.yaml
Variables    locators/split_account_locators.yaml
Variables    locators/join_table_locators.yaml
Variables    locators/change_client_locators.yaml
Variables    locators/cancel_table_locators.yaml
Variables    locators/manage_service_charge_locators.yaml

# --- Navigation do módulo (importa pages transitivamente) ---
Resource    navigation/commands_navigation.resource
