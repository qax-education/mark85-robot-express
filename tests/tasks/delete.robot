*** Settings ***
Documentation            Cenários de testes de remoção de tarefas

Resource        ../../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder apagar uma tarefa indesejada

    ${data}        Get fixture    tasks    delete
    
    Reset user from database    ${data}[user]

    Create a new task from API  ${data}

    Do login   ${data}[user]

    Request removal          ${data}[task][name]
    Task should not exist    ${data}[task][name]
