*** Settings ***
Resource    baseAPI.robot
Library     RequestsLibrary
Library     Collections
Library     FakerLibrary    locale=pt_BR


*** Test Cases ***
Cadastrar um livro(POST)
    cadastrar um novo livro
    validacao do response de ID "1"
    validar o campo de Excerpt se contem a msg "teste"
    validar o HEADERS


***Keywords***
cadastrar um novo livro
    Criando Sessão
    ${NOMEFAKE}           FakerLibrary.Name
    ${HEADERS}            Create Dictionary       Content-Type=application/json
    ${RESPOSTA}           Post Request            fakeAPI           /api/Books
    ...                   data={"ID": 1,"Title": "O menino","Description": "Era uma vez","PageCount": 200,"Excerpt": "teste","PublishDate": "2020-04-28T22:22:59.149Z"}
    ...                   headers=${HEADERS}

    ##Validações
    Log To Console            ${RESPOSTA}
    Set Suite Variable        ${RESPOSTA}
    ${STATUSCODE}             Convert To String             ${RESPOSTA.status_code}
    Should Be Equal           ${STATUSCODE}                 200
    Log To Console            ${RESPOSTA.content}

validacao do response de ID "${VALORID}"
    Dictionary Should Contain Item    ${RESPOSTA.json()}    ID    ${VALORID}

validar o campo de Excerpt se contem a msg "${valEXCERPT}"
    Dictionary Should Contain Item    ${RESPOSTA.json()}    Excerpt    ${valEXCERPT}

validar o HEADERS
    ${HEADERS}                        Set Variable    ${RESPOSTA.headers}
    Log To Console    ${HEADERS}
    Dictionary Should Contain Item    ${HEADERS}    content-type    application/json; charset=utf-8
