*** Settings ***
Documentation    Entry point do módulo Default — importação única para suites de teste.
Resource         ../../resources/base/base.resource
Variables        locators/menu_locators.yaml
Variables        locators/settings_locators.yaml
Variables        locators/sync_locators.yaml
Variables        locators/orders_locators.yaml
Variables        locators/exclusive_locators.yaml
Variables        locators/clients_locators.yaml
Variables        locators/orders_list_locators.yaml
Resource         navigation/default_navigation.resource
