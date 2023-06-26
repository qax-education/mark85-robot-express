*** Settings ***
Documentation        Ações e elementos do componente de notificações

Library        Browser

*** Keywords ***
Notice should be
    [Arguments]    ${expected_text}

    ${element}        Set Variable        css=.notice p
    
    Wait For Elements State      ${element}        visible        5
    Get Text                     ${element}        equal          ${expected_text}
