*** Settings ***
Documentation            Ações e elementos da página de listagem de tarefas

Library        Browser

*** Keywords ***
Task should be registered
    [Arguments]        ${task_name}

    Wait For Elements State     css=.task-todo >> text=${task_name}
    ...        visible        5

Task should be complete
    [Arguments]        ${task_name}

    ${element}        Set Variable        css=.task-done >> text=${task_name}

    Wait For Elements State      ${element}
    ...        visible        5
    
    Get Style    ${element}    text-decoration-line    equal    line-through

Mark task as completed
    [Arguments]        ${task_name}

    ${element}        Set Variable
    ...    xpath=//strong[text()="${task_name}"]/..//button[@class="item-toggle"]
    
    Wait For Elements State      ${element}        visible    5

    Click        ${element}

Request removal
    [Arguments]        ${task_name}

    ${element}      Set Variable
    ...        xpath=//strong[text()="${task_name}"]/..//button[@class="task-remove"] 
    
    Wait For Elements State      ${element}        visible    5

    Click        ${element}

Task should not exist
    [Arguments]        ${task_name}

    Wait For Elements State     css=.task-todo >> text=${task_name}
    ...        detached        5