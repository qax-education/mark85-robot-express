*** Settings ***
Documentation        Cenários de autenticação do usuário

Library         Collections
Resource        ../resources/base.resource

Test Setup      Start Session
Test Teardown   Take Screenshot

*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado

    ${user}    Create Dictionary
    ...    name=Fernando Papito
    ...    email=papito@msn.com
    ...    password=123456
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    
    Submit login form           ${user}
    User should be logged in    ${user}[name]

Não deve logar com senha inválida

    ${user}    Create Dictionary
    ...    name=Steve Woz
    ...    email=woz@apple.com
    ...    password=123456
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Set To Dictionary    ${user}        password=abc123
    
    Submit login form       ${user}
    Notice should be        Ocorreu um erro ao fazer login, verifique suas credenciais.