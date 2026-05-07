*** Settings ***
Documentation    Ações atômicas — Tela Mesa Aberta (ComandaMesaScreen)
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Table - Click Menu
    Wait Visible And Click Element    ${table.menu}

Commands - Table - Click Conference Print
    Wait Visible And Click Element    ${table.conference_print}

Commands - Table - Click Tab Products
    Wait Visible And Click Element    ${table.products}

Commands - Table - Click Tab Conference
    Wait Visible And Click Element    ${table.conference}

Commands - Table - Click Tab Released
    Wait Visible And Click Element    ${table.released}

Commands - Table - Click Advance
    Wait Visible And Click Element    ${table.advance}

Commands - Table - Click Cancel
    Wait Visible And Click Element    ${table.cancel}

Commands - Table - Click Filter
    Wait Visible And Click Element    ${table.filter}

Commands - Table - Click Clean Search
    Wait Visible And Click Element    ${table.clean_search}
