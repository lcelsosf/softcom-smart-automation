*** Settings ***
Documentation       Base do módulo Commands — único import necessário nas suites.
...
...                 Importa: base global + locators (1 YAML por tela) + navigation do módulo.
...                 Navigation importa os pages transitivamente.
...
...                 Hierarquia de imports:
...                 commands.robot
...                 └── base_commands.resource    ← você está aqui
...                 ├── base.resource (libs, helpers, open_app, setup)
...                 ├── locators/*.yaml (1 arquivo por tela)
...                 └── navigation/commands_navigation.resource
...                 └── pages/*.resource (1 arquivo por tela)

# --- Base global ---
Resource            ../../resources/base/base.resource