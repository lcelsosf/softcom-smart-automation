*** Settings ***
Documentation    Suite de regressão — módulo default
Resource         ../../modules/default/base_default.resource
Suite Setup      Open App
Suite Teardown   Close App
Test Setup       Test Setup Default
Test Teardown    Test Teardown Default


*** Test Cases ***
Realizar venda com cartão de débito
    [Tags]    @allure.label.severity:critical    regression    default
    Default - Navigate To Orders
    Default - Orders - Select Product    produto=Água 500ml    quantidade=1
    Default - Navigate To Payment
    Default - Payment - Select Method    metodo=Débito
    Default - Payment - Confirm Transaction

Realizar venda com cartão de crédito à vista
    [Tags]    @allure.label.severity:critical    regression    default
    Default - Navigate To Orders
    Default - Orders - Select Product    produto=Café Expresso    quantidade=2
    Default - Navigate To Payment
    Default - Payment - Select Method    metodo=Crédito
    Default - Payment - Select Installments    parcelas=1
    Default - Payment - Confirm Transaction

Cancelar venda em andamento
    [Tags]    @allure.label.severity:normal    regression    default
    Default - Navigate To Orders
    Default - Orders - Select Product    produto=Refrigerante Lata    quantidade=1
    Default - Navigate To Payment
    Default - Payment - Cancel Transaction
    Default - Verify Return To Orders Screen
