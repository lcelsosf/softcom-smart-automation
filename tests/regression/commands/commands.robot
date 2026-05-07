*** Settings ***
Documentation    Suite de regressão — módulo Commands (Comanda/Mesa)
...
...    Cobre os fluxos principais de abertura, operação e encerramento de mesas.
...    Pré-condição: app iniciado no Painel de Mesas.
Resource         ../../../modules/commands/base_commands.resource
Suite Setup      Suite Setup Default
Suite Teardown   Suite Teardown Default
Test Setup       Test Setup Default
Test Teardown    Test Teardown Default


*** Variables ***
${TABLE_NUMBER}          10
${TABLE_CLIENT}          Cliente Teste
${CANCEL_REASON}         Motivo de cancelamento automático


*** Test Cases ***
Abrir mesa e faturar com dinheiro
    [Tags]    @allure.label.severity:critical    regression    commands    invoice
    Commands - Navigate To Open Table    ${TABLE_NUMBER}    ${TABLE_CLIENT}
    Commands - Navigate To Search Table And Open    ${TABLE_NUMBER}
    Commands - Add Items To Table    Frango    Cerveja
    Commands - Navigate To Invoice And Pay    money

Abrir mesa e faturar com Pix Off
    [Tags]    @allure.label.severity:critical    regression    commands    invoice
    Commands - Navigate To Open Table    ${TABLE_NUMBER}    ${TABLE_CLIENT}
    Commands - Navigate To Search Table And Open    ${TABLE_NUMBER}
    Commands - Add Items To Table    Água 500ml
    Commands - Navigate To Invoice And Pay    pixoff

Abrir mesa e registrar adiantamento com dinheiro
    [Tags]    @allure.label.severity:normal    regression    commands    advance
    Commands - Navigate To Open Table    ${TABLE_NUMBER}    ${TABLE_CLIENT}
    Commands - Navigate To Search Table And Open    ${TABLE_NUMBER}
    Commands - Navigate To Advance    ${TABLE_CLIENT}    50,00    money

Abrir mesa e registrar adiantamento com Pix Off
    [Tags]    @allure.label.severity:normal    regression    commands    advance
    Commands - Navigate To Open Table    ${TABLE_NUMBER}    ${TABLE_CLIENT}
    Commands - Navigate To Search Table And Open    ${TABLE_NUMBER}
    Commands - Navigate To Advance    ${TABLE_CLIENT}    50,00    pixoff

Abrir mesa e dividir conta
    [Tags]    @allure.label.severity:normal    regression    commands    split_account
    Commands - Navigate To Open Table    ${TABLE_NUMBER}    ${TABLE_CLIENT}
    Commands - Navigate To Search Table And Open    ${TABLE_NUMBER}
    Commands - Navigate To Split Account
    Commands - Split Account - Click Add People
    Commands - Split Account - Click Back

Abrir mesa e alterar cliente
    [Tags]    @allure.label.severity:normal    regression    commands    change_client
    Commands - Navigate To Open Table    ${TABLE_NUMBER}    ${TABLE_CLIENT}
    Commands - Navigate To Search Table And Open    ${TABLE_NUMBER}
    Commands - Navigate To Change Client
    Commands - Change Client - Input Client Name    Novo Cliente
    Commands - Change Client - Click Search
    Commands - Client - Click Client Item
    Commands - Change Client - Click Confirm

Abrir mesa e cancelar
    [Tags]    @allure.label.severity:normal    regression    commands    cancel
    Commands - Navigate To Open Table    ${TABLE_NUMBER}    ${TABLE_CLIENT}
    Commands - Navigate To Search Table And Open    ${TABLE_NUMBER}
    Commands - Navigate To Cancel Table    ${CANCEL_REASON}
    Commands - Table Panel - Verify Panel Visible

Buscar mesa existente pelo número
    [Tags]    @allure.label.severity:minor    regression    commands    search
    Commands - Table Panel - Search Table    ${TABLE_NUMBER}
    Commands - Table Panel - Click Table Item
    Commands - Table Panel - Verify Panel Visible

Verificar painel de mesas acessível
    [Tags]    @allure.label.severity:minor    regression    commands    smoke
    Commands - Table Panel - Verify Panel Visible
