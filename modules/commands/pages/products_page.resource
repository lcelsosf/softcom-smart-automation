*** Settings ***
Documentation    Ações atômicas — Aba Produtos + Dialog Adicionar Produto
Resource    ../../../resources/helpers/common_keywords.resource


*** Keywords ***
Commands - Products - Search Item
    [Arguments]    ${text}
    Wait Visible And Input Text    ${products.search_item}    ${text}
    Close Keyboard

Commands - Products - Click Product
    Wait Visible And Click Element    ${products.product}

Commands - Products - Click Add Item
    Wait Visible And Click Element    ${products.add_item}

Commands - Products - Click Item Obs
    Wait Visible And Click Element    ${products.item_obs}

Commands - Products - Input Item Obs Text
    [Arguments]    ${text}
    Wait Visible And Input Text    ${products.item_obs_text}    ${text}
    Close Keyboard

Commands - Products - Click Additional Add
    Wait Visible And Click Element    ${products.item_adc_add}

Commands - Products - Click Additional Add 2
    Wait Visible And Click Element    ${products.item_adc_add_2}

Commands - Products - Click Additional Sub
    Wait Visible And Click Element    ${products.item_adc_sub}

Commands - Products - Click Additional Obs
    Wait Visible And Click Element    ${products.item_adc_obs}

Commands - Products - Input Additional Obs Text
    [Arguments]    ${text}
    Wait Visible And Input Text    ${products.item_adc_obs_text}    ${text}
    Close Keyboard

Commands - Products - Click Additional Obs Confirm
    Wait Visible And Click Element    ${products.item_adc_obs_confirm}

Commands - Products - Click Additional Obs Cancel
    Wait Visible And Click Element    ${products.item_adc_obs_cancel}
