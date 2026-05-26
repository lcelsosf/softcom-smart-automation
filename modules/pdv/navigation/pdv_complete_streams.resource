*** Settings ***
Documentation    Fluxos completos do módulo Pdv — composição de page keywords.
...
...    Nomenclatura: Pdv - <fluxo>
...    Dependências: pages abaixo + locators carregados via base_pdv.resource
Library    FakerLibrary    locale=pt_BR    WITH NAME    faker
Resource    navigation/pdv_navigation.resource

*** Keywords ***

