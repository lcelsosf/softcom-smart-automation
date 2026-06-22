*** Settings ***
Documentation       Base do módulo Pdv — único import necessário nas suites.
...
...                 Importa: base global + locators (1 YAML por tela) + navigation do módulo.
...                 Navigation importa os pages transitivamente.
...
...                 Hierarquia de imports:
...                 pdv.robot
...                 └── base_pdv.resource    ← você está aqui
...                 ├── base.resource (libs, helpers, open_app, setup)
...                 ├── locators/*.yaml (1 arquivo por tela)
...                 └── navigation/pdv_navigation.resource
...                 └── pages/*.resource (1 arquivo por tela)

# --- Base global ---
Resource            ../../resources/base/base.resource
# --- Locators e dados do módulo ---
Variables           ../../resources/libraries/locators_loader.py    modules/pdv/locators/homeLocators.yml    modules/pdv/locators/ordersLocators.yml    modules/pdv/locators/checkoutLocators.yml    modules/pdv/locators/settingsLocators.yml    modules/pdv/locators/clientsLocators.yml    modules/pdv/locators/orderslistLocators.yml    modules/pdv/data/pdv_data.yml    ${DEVICE_TAG}
# --- Fluxos completos do módulo (importa navigation e pages transitivamente) ---
Resource            navigation/pdv_complete_streams.resource
Resource            navigation/pdv_settings_setup.resource
