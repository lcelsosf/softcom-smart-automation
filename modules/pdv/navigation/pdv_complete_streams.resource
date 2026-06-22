*** Settings ***
Documentation    Fluxos completos do módulo Pdv — composição de navigation keywords.
...
...    Nomenclatura: PDV - Complete Flow - <Fluxo>
...    Dependências: navigation abaixo + locators carregados via base_pdv.resource
Resource    pdv_navigation.resource


*** Keywords ***
PDV - Complete Flow - Order Common
    [Documentation]    Executa o fluxo comum de pedido e pagamento.
    [Arguments]    ${product_name}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Filter Name Reference And Barcode
    [Documentation]    Pesquisa produtos por nome, referência e código de barras, depois finaliza o pedido.
    [Arguments]    ${product_name}    ${product_reference}    ${product_barcode}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Search Product    ${product_reference}    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Search Product    ${product_barcode}    ${product_name}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Alter Quantity And Remove Item
    [Documentation]    Altera a quantidade de um item, remove outro item e finaliza a venda.
    [Arguments]    ${product_primary}    ${product_secondary}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_primary}
    Pdv - Navigate To Long Press Product    ${product_primary}
    Pdv - Navigate To Add Quantity    3
    Pdv - Navigate To Remove Quantity    2
    Pdv - Navigate To Confirm Quantity
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Select Product    ${product_secondary}
    Pdv - Navigate To Long Press Product    ${product_secondary}
    Pdv - Navigate To Remove Product From Order
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Cancel Order After Select Product
    [Documentation]    Seleciona um produto, limpa a pesquisa e cancela o pedido retornando para a tela inicial.
    [Arguments]    ${product_name}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Cancel Order
    Pdv - Home - Verify Visible


PDV - Complete Flow - Alter Client And Add Itens From Cart
    [Documentation]    Altera o cliente no carrinho, adiciona outro item e finaliza a venda.
    [Arguments]    ${product_primary}    ${client_name}    ${product_secondary}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_primary}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Check Order
    Pdv - Navigate To Select Client    ${client_name}
    Pdv - Navigate To Add Items From Cart
    Pdv - Navigate To Select Product    ${product_secondary}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Discount Integer
    [Documentation]    Aplica desconto em valor fixo no carrinho e finaliza a venda.
    [Arguments]    ${product_name}    ${discount_value}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Check Order
    Pdv - Navigate To Apply Discount Integer    ${discount_value}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Discount Percent
    [Documentation]    Aplica desconto percentual no carrinho e finaliza a venda.
    [Arguments]    ${product_name}    ${discount_value}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Check Order
    Pdv - Navigate To Apply Discount Percent    ${discount_value}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Discount Item
    [Documentation]    Aplica desconto em valor fixo no item com promoção e percentual no item de desconto antes de finalizar a venda.
    [Arguments]    ${product_discount}    ${product_promotion}    ${payment_method}=money
    Pdv - Home - Verify Visible
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_discount}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Select Product    ${product_promotion}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Apply Cart Item Discount Integer By Name    ${product_promotion}    1,00
    Pdv - Navigate To Apply Cart Item Discount Percent By Name    ${product_discount}    10,00
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Additional Percent
    [Documentation]    Aplica acréscimo percentual no carrinho e finaliza a venda.
    [Arguments]    ${product_name}    ${additional_value}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Check Order
    Pdv - Navigate To Apply Additional Percent    ${additional_value}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Additional Integer
    [Documentation]    Aplica acréscimo em valor fixo no carrinho e finaliza a venda.
    [Arguments]    ${product_name}    ${additional_value}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Check Order
    Pdv - Navigate To Apply Additional Integer    ${additional_value}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Item Edition
    [Documentation]    Edita quantidades e remove item no carrinho antes de finalizar a venda.
    [Arguments]    ${product_primary}    ${product_secondary}    ${product_discount}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_primary}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Select Product    ${product_secondary}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Select Product    ${product_discount}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Add Cart Item Quantity    ${product_discount}    3
    Pdv - Navigate To Remove Cart Item Quantity    ${product_discount}    2
    Pdv - Navigate To Remove Cart Item By Icon    ${product_secondary}
    Pdv - Navigate To Remove Cart Item By Name    ${product_primary}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Bankslip
    [Documentation]    Realiza pedido com cliente alterado e pagamento por boleto bancário.
    [Arguments]    ${product_name}    ${client_name}    ${calendar_day}    ${term_days}=7    ${parcels_add_times}=4   ${payment_method}=bankslip
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Select Client    ${client_name}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Configure Bank Slip Payment    ${parcels_add_times}    ${term_days}    ${calendar_day}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Item Variations
    [Documentation]    Realiza pedido com variações de item, badge de promoção e pagamento Pix Off.
    [Arguments]    ${product_fractional}    ${product_composition}    ${barcode_variation_1}    ${barcode_variation_2}    ${product_promotion}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_fractional}
    Pdv - Navigate To Long Press Product    ${product_fractional}
    Pdv - Navigate To Edit Quantity    500
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Select Product    ${product_composition}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Search And Select First Product Card    ${barcode_variation_1}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Search And Select First Product Card    ${barcode_variation_2}
    Pdv - Navigate To Clear Product Search
    Pdv - Navigate To Select Product With Promotion Badge    ${product_promotion}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Express Mode
    [Documentation]    Adiciona itens pelo modo expresso e finaliza a venda.
    [Arguments]    ${product_primary}    ${product_secondary}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_primary}
    Pdv - Orders - Click Cart Button
    Pdv - Navigate To Add Items From Cart
    Pdv - Navigate To Select Product    ${product_secondary}
    Pdv - Orders - Click Finalize Order New Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Mini PDV Mode
    [Documentation]    Adiciona item via seleção e outro via código de barras ADB, depois finaliza a venda.
    [Arguments]    ${product_name}    ${barcode}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Input Barcode By Adb    ${barcode}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Smart PDV Functions
    [Documentation]    Seleciona cliente, valida estoque, altera preço unitário e finaliza a venda.
    [Arguments]    ${client_name}    ${product_name}    ${unit_price}   ${payment_method}
    Pdv - Navigate To New Order
#    Pdv - Navigate To Select Client    ${client_name}
    Pdv - Navigate To Select Product With Stock    ${product_name}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Edit Cart Item Unit Price By Name    ${product_name}    ${unit_price}
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Price Table
    [Documentation]    Seleciona tabela de preço A, adiciona item da tabela e finaliza a venda.
    [Arguments]    ${product_name}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Price Table A
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible


PDV - Complete Flow - Pix Off
    [Documentation]    Realiza pedido com pagamento via Pix Off.
    [Arguments]    ${product_name}    ${payment_method}=pixoff
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible

PDV - Complete Flow - NFCe Disable
    [Documentation]    Realiza pedido com fiscal desativado.
    [Arguments]    ${product_name}    ${payment_method}
    PDV - Complete Flow - Order Common    ${product_name}    ${payment_method}

PDV - Complete FLow - No Payment Method
    [Documentation]    Realiza pedido sem método de pagamento.
    [Arguments]    ${product_name}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible

PDV - Complete Flow - Ticket Order
    [Documentation]    Realiza pedido com emissão de ticket de retirada.
    [Arguments]    ${product_name}    ${payment_method}
    Pdv - Navigate To New Order
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Add Cart Item Quantity    ${product_name}    10
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible

PDV - Complete Flow - Register Client
    [Documentation]    Cadastra um cliente com dados gerados pelo Faker e verifica o registro na lista.
    ...    Física → gera CPF e Nome, pesquisa e verifica pelo nome.
    ...    Jurídica → gera CNPJ, Nome Fantasia e Razão Social, pesquisa pelo CNPJ e verifica pela Razão Social.
    [Arguments]    ${person_type}    ${cep}
    ${phone}=    FakerLibrary.Phone Number
    ${email}=    FakerLibrary.Email
    ${number}=   FakerLibrary.Building Number
    Pdv - Home - Verify Visible
    Pdv - Home - Click Clients
    Pdv - Navigate To New Client
    IF    '${person_type}' == 'Física'
        ${cpf}=     FakerLibrary.Cpf
        ${name}=    FakerLibrary.Name
        Pdv - Navigate To Fill Client Details    ${person_type}    ${cpf}    ${name}    ${phone}    ${email}    teste cadastro de cliente
        Pdv - Navigate To Fill Client Address    ${cep}    ${number}    teste cadastro de cliente
        Pdv - Navigate To Save And Verify Client    ${name}
    ELSE IF    '${person_type}' == 'Jurídica'
        ${cnpj}=            FakerLibrary.Cnpj
        ${cnpj_search}=     Evaluate    '${cnpj}'.replace('.', '').replace('/', '').replace('-', '')
        ${fantasy_name}=    FakerLibrary.Company
        ${social_reason}=   FakerLibrary.Company
        Pdv - Navigate To Fill Client Details Juridic    ${person_type}    ${cnpj}    ${fantasy_name}    ${social_reason}    ${phone}    ${email}    teste cadastro de cliente
        Pdv - Navigate To Fill Client Address    ${cep}    ${number}    teste cadastro de cliente
        Pdv - Navigate To Save And Verify Client By Cnpj    ${cnpj_search}    ${social_reason}
    END
    Pdv - Home - Verify Visible

PDV - Complete Flow - List Orders Functions
    [Documentation]    Navega pela Lista de Pedidos: visualiza, reimprimi, acessa nota fiscal, cancela pedido e imprime relatórios.
    Pdv - Home - Verify Visible
    Pdv - Home - Click List Orders
    Orders List - Should Be Visible
    Pdv - Navigate To View Order
    Pdv - Navigate To Reprint First Order Receipt
#    Pdv - Navigate To Fiscal Details First Order
    Pdv - Navigate To Cancel First Order
    Pdv - Navigate To Print Receipts
    Pdv - Navigate To Print Sales Summary
    Orders List - Click Back
    Pdv - Home - Verify Visible

PDV - Complete Flow - Sync Search Client And Init Order
    [Documentation]    Sincroniza a lista de clientes, seleciona o cliente e inicia um pedido.
    [Arguments]    ${client_name}    ${product_name}    ${payment_method}
    Pdv - Home - Verify Visible
    Pdv - Navigate To Clients
    Pdv - Navigate To Sync Client List
    Pdv - Navigate To Search And Select Client    ${client_name}
    Pdv - Navigate To Init Order From Client
    Pdv - Navigate To Select Product    ${product_name}
    Pdv - Navigate To Check Order
    Pdv - Navigate To Finish Order
    Pdv - Navigate To Select Payment Method    ${payment_method}
    Pdv - Navigate To Confirm Payment Value
    Pdv - Navigate To Finish Sale
    Pdv - Navigate To Initial Screen
    Pdv - Home - Verify Visible