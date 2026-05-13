*** Settings ***
Documentation    Fluxos compostos — Módulo Default (Pedidos, Configurações, Sincronização, Clientes)
Library          AppiumLibrary
Library          FakerLibrary    locale=pt_BR
Resource         ../../../resources/helpers/common_keywords.resource
Resource         ../pages/menu_page.resource
Resource         ../pages/settings_page.resource
Resource         ../pages/sync_page.resource
Resource         ../pages/orders_page.resource
Resource         ../pages/clients_page.resource
Resource         ../pages/orders_list_page.resource


*** Keywords ***
# =============================================================================
# MENU / NAVEGAÇÃO PRINCIPAL
# =============================================================================

Default - Navigate To New Order
    Default - Menu - Open Menu
    Default - Menu - Click New Order

Default - Navigate To Settings
    Default - Menu - Open Menu
    Default - Menu - Click Settings

Default - Navigate To Orders List
    Default - Menu - Open Menu
    Default - Menu - Click Orders List

Default - Navigate To Register Client Screen
    Default - Menu - Open Menu
    Default - Menu - Click Register Client

# =============================================================================
# SELEÇÃO DE PRODUTO
# =============================================================================

Default - Navigate To Select Product
    [Arguments]    ${product}
    Default - Orders - Select Group All
    Default - Orders - Click Search
    Default - Orders - Type In Search    ${product}
    Default - Orders - Click Item
    Default - Orders - Close Search

# =============================================================================
# PAGAMENTO
# =============================================================================

Default - Navigate To Pay With Money
    [Arguments]    ${value}=${EMPTY}
    Default - Orders - Click Pay
    Default - Orders - Select Money
    IF    '${value}' != '${EMPTY}'
        Default - Orders - Set Payment Value    ${value}
    END
    Default - Orders - Confirm Payment
    Default - Orders - Click Finish
    Default - Orders - Click Print

Default - Navigate To Pay With Pix Off
    Default - Orders - Click Pay
    Default - Orders - Select Pix Off
    Default - Orders - Confirm Payment
    Default - Orders - Click Finish
    Default - Orders - Click Print

Default - Navigate To Pay With Bankslip
    [Arguments]    ${value}    ${term}    ${parcels}=1
    Default - Orders - Click Pay
    Default - Orders - Select Bankslip
    FOR    ${i}    IN RANGE    ${parcels}
        Default - Orders - Click Bankslip Add Parcel
    END
    Default - Orders - Set Bankslip Term    ${term}
    Default - Orders - Confirm Payment
    Default - Orders - Click Finish
    Default - Orders - Click Print

# =============================================================================
# FLUXOS DE PEDIDO
# =============================================================================

Default - Navigate To Create Order And Pay With Money
    [Arguments]    ${product}
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product}
    Default - Orders - Click Cart
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Money

Default - Navigate To Create Order And Pay With Pix Off
    [Arguments]    ${product}
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product}
    Default - Orders - Click Cart
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Pix Off

Default - Navigate To Create Order And Pay With Bankslip
    [Arguments]    ${product}    ${value}    ${term}    ${parcels}=1
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product}
    Default - Orders - Click Cart
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Bankslip    ${value}    ${term}    ${parcels}

Default - Navigate To Create Order With Add
    [Arguments]    ${product}    ${add_mode}    ${integer_value}=${EMPTY}    ${percent_value}=${EMPTY}
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product}
    Default - Orders - Click Cart
    Default - Orders - Click Add
    IF    '${add_mode}' == 'sum'
        Default - Orders - Select Sum Mode
    ELSE
        Default - Orders - Select Replace Mode
    END
    IF    '${integer_value}' != '${EMPTY}'
        Default - Orders - Set Integer Value    ${integer_value}
    END
    IF    '${percent_value}' != '${EMPTY}'
        Default - Orders - Set Percent Value    ${percent_value}
    END
    Default - Orders - Confirm Discount
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Money

Default - Navigate To Create Order With Discount
    [Arguments]    ${product}    ${discount_mode}    ${integer_value}=${EMPTY}    ${percent_value}=${EMPTY}
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product}
    Default - Orders - Click Cart
    Default - Orders - Click Discount
    IF    '${discount_mode}' == 'sum'
        Default - Orders - Select Sum Mode
    ELSE
        Default - Orders - Select Replace Mode
    END
    IF    '${integer_value}' != '${EMPTY}'
        Default - Orders - Set Integer Value    ${integer_value}
    END
    IF    '${percent_value}' != '${EMPTY}'
        Default - Orders - Set Percent Value    ${percent_value}
    END
    Default - Orders - Confirm Discount
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Money

Default - Navigate To Change Item Quantity
    [Arguments]    ${product}
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product}
    Default - Orders - Click Cart
    Default - Orders - Click Cart Item
    Default - Orders - Add Cart Item Quantity
    Default - Orders - Confirm Item
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Money

Default - Navigate To Change Price
    [Arguments]    ${product}    ${new_price}
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product}
    Default - Orders - Click Cart
    Default - Orders - Click Cart Item
    Default - Orders - Set Cart Item Price    ${new_price}
    Default - Orders - Confirm Item
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Money

Default - Navigate To Remove Item
    [Arguments]    ${product_1}    ${product_2}
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product_1}
    Default - Navigate To Select Product    ${product_2}
    Default - Orders - Click Cart
    Default - Orders - Click Cart Item
    Default - Orders - Remove Cart Item
    Default - Orders - Confirm Remove Item
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Money

Default - Navigate To Item Combo
    [Arguments]    ${product}
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product}
    ${is_safra}=    Evaluate    'safra' in '${DEVICE_TAG}'.lower()
    IF    ${is_safra}
        Default - Orders - Click Safra Item Combo 1
        Default - Orders - Click Safra Item Combo 2
        Default - Orders - Add Safra Item Combo
    ELSE
        Default - Orders - Click Item Combo 1
        Default - Orders - Click Item Combo 2
        Default - Orders - Add Item Combo
    END
    Default - Orders - Click Cart
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Money

Default - Navigate To Create Order With Fractional Quantity
    [Arguments]    ${product}    ${quantity}
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product}
    Default - Orders - Set Item Quantity    ${quantity}
    Default - Orders - Confirm Item
    Default - Orders - Click Cart
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Money

Default - Navigate To Create Order With Grid
    [Arguments]    ${product_1}    ${product_2}
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product_1}
    Default - Navigate To Select Product    ${product_2}
    Default - Orders - Click Cart
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Money

Default - Navigate To Create Order With Price Table
    [Arguments]    ${product}
    Default - Navigate To New Order
    Default - Orders - Click Price Table
    Default - Orders - Select Price A
    Default - Orders - Save Price
    Default - Orders - Confirm Price
    Default - Navigate To Select Product    ${product}
    Default - Orders - Click Cart
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Money

Default - Navigate To Create Order With Ticket
    [Arguments]    ${product}    ${quantity}=10
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product}
    Default - Orders - Click Cart
    Default - Orders - Click Cart Item
    Default - Orders - Set Item Quantity    ${quantity}
    Default - Orders - Confirm Item
    Default - Orders - Confirm Cart
    Default - Navigate To Pay With Money

Default - Navigate To Select Client
    [Arguments]    ${client}
    Default - Orders - Click Client Button
    Default - Orders - Search Client    ${client}
    Default - Orders - Select Client

Default - Navigate To Block Stock Test
    [Arguments]    ${product}
    Default - Navigate To New Order
    Default - Navigate To Select Product    ${product}

# =============================================================================
# LISTA DE PEDIDOS
# =============================================================================

Default - Navigate To Reprint
    Default - Navigate To Orders List
    Default - Orders List - Click First Order
    Default - Orders List - Click Reprint

# =============================================================================
# SINCRONIZAÇÃO
# =============================================================================

Default - Navigate To Sync
    [Arguments]    ${mode}=all
    Default - Menu - Open Menu
    Default - Menu - Click Sync
    IF    '${mode}' == 'products'
        Default - Sync - Toggle Clients
        Default - Sync - Toggle Orders
    ELSE IF    '${mode}' == 'clients'
        Default - Sync - Toggle Products
        Default - Sync - Toggle Orders
    ELSE IF    '${mode}' == 'orders'
        Default - Sync - Toggle Products
        Default - Sync - Toggle Clients
    ELSE IF    '${mode}' == 'cancel'
        Default - Sync - Click Cancel
        RETURN
    END
    Default - Sync - Click Sync Button
    Default - Sync - Click Ok

# =============================================================================
# LOGOFF
# =============================================================================

Default - Navigate To Logoff
    Default - Menu - Open Menu
    Default - Menu - Click Logoff
    Default - Menu - Confirm Logoff

# =============================================================================
# CADASTRO DE CLIENTES
# =============================================================================

Default - Navigate To Register Client
    Default - Navigate To Register Client Screen
    Default - Clients - Click Add Client
    ${cpf}=         FakerLibrary.Cpf
    ${name}=        FakerLibrary.Name
    ${email}=       FakerLibrary.Email
    ${zip_code}=    FakerLibrary.Postcode
    ${address}=     FakerLibrary.Street Name
    ${number}=      FakerLibrary.Building Number
    ${neighborhood}=    FakerLibrary.City Suffix
    ${complement}=  FakerLibrary.Secondary Address
    ${state}=       FakerLibrary.State Abbr
    ${city}=        FakerLibrary.City
    ${ddd}=         FakerLibrary.Numerify    ##
    ${telephone}=   FakerLibrary.Numerify    #####-####
    Default - Clients - Type CPF            ${cpf}
    Default - Clients - Type Name           ${name}
    Default - Clients - Type Email          ${email}
    Default - Clients - Type Zip Code       ${zip_code}
    Default - Clients - Type Address        ${address}
    Default - Clients - Type Number         ${number}
    Default - Clients - Type Neighborhood   ${neighborhood}
    Default - Clients - Type Complement     ${complement}
    Default - Clients - Type State          ${state}
    Default - Clients - Type City           ${city}
    Default - Clients - Type DDD            ${ddd}
    Default - Clients - Type Telephone      ${telephone}
    Default - Clients - Save Client
    Set Suite Variable    ${CLIENT_NAME}    ${name}

# =============================================================================
# CONFIGURAÇÕES
# =============================================================================

Default - Navigate To Change Sales Price Setting
    Default - Navigate To Settings
    Default - Settings - Click Orders Section
    Default - Settings - Toggle Sales Change Price
    Default - Settings - Exit Settings

Default - Navigate To Block Stock Setting
    Default - Navigate To Settings
    Default - Settings - Click Orders Section
    Default - Settings - Toggle Block Stock
    Default - Settings - Exit Settings

Default - Navigate To Fractional Quantity Setting
    Default - Navigate To Settings
    Default - Settings - Click Orders Section
    Default - Settings - Toggle Fractional Quantity
    Default - Settings - Exit Settings

Default - Navigate To Configure Printer
    Default - Navigate To Settings
    Default - Settings - Click Printers
    Default - Settings - Click Printer List
    Default - Settings - Select Printer
    Default - Settings - Close Printer List
    Default - Settings - Exit Settings

Default - Navigate To Enable Pix Off Payment
    Default - Navigate To Settings
    Default - Settings - Click Payment Forms
    Default - Settings - Click Pix Off
    Default - Settings - Toggle Enable Payment
    Default - Settings - Save Payment
    Default - Settings - Exit Settings

Default - Navigate To Enable Bankslip Payment
    Default - Navigate To Settings
    Default - Settings - Click Payment Forms
    Default - Settings - Click Bankslip
    Default - Settings - Toggle Enable Payment
    Default - Settings - Save Payment
    Default - Settings - Exit Settings

Default - Navigate To Configure Ticket
    Default - Navigate To Settings
    Default - Settings - Click Ticket
    Default - Settings - Toggle Enable Ticket
    Default - Settings - Toggle Enable Ticket Reprint
    Default - Settings - Exit Ticket

Default - Navigate To Configure Price Table
    Default - Navigate To Settings
    Default - Settings - Click Orders Section
    Default - Settings - Toggle Price Table
    Default - Settings - Exit Settings
