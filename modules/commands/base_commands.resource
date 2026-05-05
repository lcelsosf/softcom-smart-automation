*** Settings ***
Documentation    Base do módulo commanda — único import necessário nas suites.
...
...    Importa: base global + locators + pages + navigation do módulo.
...
...    Hierarquia de imports:
...    commands.robot
...      └── base_commands.resource  ← você está aqui
...            ├── base.resource (libs, helpers, open_app, setup)
...            ├── locators/commands_locators.yaml
...            └── navigation/commands_navigation.resource

# --- Base global ---
Resource    ../../resources/base/base.resource

# --- Locators do módulo ---
Variables    ../../resources/locators/commands.yml

# --- Pages do módulo ---
Resource    ../../resources/pages/commands_page.resource

# --- Navigation do módulo ---
Resource    navigation/commands_navigation.resource
