*** Settings ***
Documentation    Base do módulo default — único import necessário nas suites.
...
...    Importa: base global + locators + pages + navigation do módulo.
...
...    Hierarquia de imports:
...    suite.robot
...      └── base_default.resource  ← você está aqui
...            ├── base.resource (libs, helpers, open_app, setup)
...            ├── locators/default_locators.yaml
...            ├── pages/orders_page.resource
...            ├── pages/payment_page.resource
...            ├── pages/login_page.resource
...            └── navigation/default_navigation.resource

# --- Base global ---
Resource    ../../resources/base/base.resource

# --- Locators do módulo ---
Variables    ./locators/default_locators.yaml

# --- Pages do módulo ---
Resource    ./pages/orders_page.resource
Resource    ./pages/payment_page.resource
Resource    ./pages/login_page.resource

# --- Navigation do módulo ---
Resource    ./navigation/default_navigation.resource
