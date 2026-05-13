*** Settings ***
Documentation    Ações atômicas — Tela de Configurações
Resource         ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Default - Settings - Click Printers
    Wait Visible And Click Element    ${settings.printers}

Default - Settings - Click Printer List
    Wait Visible And Click Element    ${settings.printer_list}

Default - Settings - Select Printer
    Wait Visible And Click Element    ${settings.select_printer}

Default - Settings - Close Printer List
    Wait Visible And Click Element    ${settings.select_close}

Default - Settings - Click Back
    Wait Visible And Click Element    ${settings.back}

Default - Settings - Exit Settings
    Wait Visible And Click Element    ${settings.exit_settings}

Default - Settings - Click Payment Forms
    Wait Visible And Click Element    ${settings.payments_forms}

Default - Settings - Click Pix Off
    Wait Visible And Click Element    ${settings.pix_off}

Default - Settings - Click Bankslip
    Wait Visible And Click Element    ${settings.bankslip}

Default - Settings - Toggle Enable Payment
    Wait Visible And Click Element    ${settings.enable_payment}

Default - Settings - Save Payment
    Wait Visible And Click Element    ${settings.save_button}

Default - Settings - Click Ticket
    Wait Visible And Click Element    ${settings.ticket}

Default - Settings - Toggle Enable Ticket
    Wait Visible And Click Element    ${settings.enable_ticket}

Default - Settings - Toggle Enable Ticket Reprint
    Wait Visible And Click Element    ${settings.enable_ticket_reprint}

Default - Settings - Exit Ticket
    Wait Visible And Click Element    ${settings.exit_ticket}

Default - Settings - Click Orders Section
    Wait Visible And Click Element    ${settings.orders}

Default - Settings - Toggle Sales Change Price
    Wait Visible And Click Element    ${settings.sales_change_price}

Default - Settings - Toggle Block Stock
    Wait Visible And Click Element    ${settings.block_stock}

Default - Settings - Toggle Fractional Quantity
    Wait Visible And Click Element    ${settings.fractional_quantity}

Default - Settings - Toggle Price Table
    Wait Visible And Click Element    ${settings.price_table}
