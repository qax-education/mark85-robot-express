*** Settings ***
Documentation            Cenários de cadastro de tarefas

Resource        ../../resources/base.resource

Test Setup          Start Session
Test Teardown       Take Screenshot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    [Tags]    critical
    
    ${data}    Get fixture    tasks    create

    Reset user from database    ${data}[user]

    Do login   ${data}[user]

    Go to task form
    Submit task form             ${data}[task]
    Task should be registered    ${data}[task][name]

Não deve cadastrar tarefa com nome duplicado
    [Tags]    dup
    
    ${data}    Get fixture    tasks    duplicate
    
    Reset user from database    ${data}[user]
    Create a new task from API  ${data}

    Do login   ${data}[user]

    Go to task form
    Submit task form             ${data}[task]

    Notice should be        Oops! Tarefa duplicada.

Não deve cadastrar uma nova tarefa quando atinge o limite de tags
    [Tags]    tags_limit

    ${data}    Get fixture    tasks    tags_limit
    
    Reset user from database    ${data}[user]

    Do login   ${data}[user]

    Go to task form
    Submit task form             ${data}[task]

    Notice should be        Oops! Limite de tags atingido.