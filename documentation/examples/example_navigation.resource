*** Settings ***
Documentation    Navigation do módulo default.
...
...    Regras:
...    - Contém APENAS keywords de fluxo composto (2+ ações encadeadas)
...    - NUNCA contém ações atômicas (click, input, wait isolados)
...    - NUNCA importa AppiumLibrary diretamente
...    - Nomenclatura: Default - Navigate To <Destino>


*** Keywords ***
Default - Navigate To Orders
    [Documentation]    Navega até a tela de pedidos a partir da tela inicial.
    ...    Fluxo: Home → Menu → Pedidos
    Default - Home - Open Menu
    Default - Menu - Select Orders Option

Default - Navigate To Payment
    [Documentation]    Navega do carrinho até a tela de pagamento.
    ...    Fluxo: Carrinho → Confirmar itens → Pagamento
    Default - Cart - Confirm Items
    Default - Cart - Proceed To Checkout

Default - Complete Payment Flow
    [Documentation]    Executa o fluxo completo de pagamento com cartão.
    ...    Fluxo: Selecionar método → Inserir cartão → Confirmar → Aguardar aprovação
    [Arguments]    ${metodo}    ${parcelas}=1
    Default - Payment - Select Method    ${metodo}
    Default - Payment - Select Installments    ${parcelas}
    Default - Payment - Confirm Transaction
    Default - Payment - Wait For Approval

Default - Navigate To Settings
    [Documentation]    Navega até as configurações do PDV a partir da tela inicial.
    ...    Fluxo: Home → Menu → Configurações
    Default - Home - Open Menu
    Default - Menu - Select Settings Option

Default - Verify Return To Orders Screen
    [Documentation]    Confirma que o fluxo retornou para a tela de pedidos após cancelamento.
    ...    Fluxo: Aguardar tela → Verificar elemento identificador
    Default - Payment - Wait For Cancellation Confirmation
    Default - Orders - Verify Screen Is Active
