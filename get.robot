*** Settings ***
Resource              baseAPI.robot
Library               Collections
Library               RequestsLibrary



*** Test Cases ***
VALIDAÇÃO DE GETS
  Requisitar todos os itens
  Validar o Status Code         200
  Validar Reason                OK
  Validar a lista de "200" livros


Validação de um livro especifico
  Requisitar o livro de id "15"
  Validar o Status Code 200        200
  Validar Reason                   OK
  Validar a lista de "200" livros
  Conferir todos os campos do id "15"
    # Log To Console        ${RESPOSTA.headers}
    # Log To Console        ${RESPOSTA.content}




*** Keywords ***
Requisitar todos os itens
    Criando Sessão
    ${RESPOSTA}             Get Request     fakeAPI     /api/Books
    Set Suite Variable      ${RESPOSTA}
    Log                     ${RESPOSTA.text}
    


Validar o Status Code
    [Arguments]                             ${STATUSCODE_DESEJADO}
    #log to Console                          ${RESPOSTA}
    log                                     ${RESPOSTA}
    #Log To Console                          ${RESPOSTA.status_code}
    Log                                     ${RESPOSTA.status_code}
    #${atual_status}=                        Convert To String                  ${RESPOSTA.status_code}
    # ${novostatus}=                         Convert To Integer                 ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings              ${STATUSCODE_DESEJADO}              ${RESPOSTA.status_code}


Validar Reason
      [Arguments]                           ${REASON_DESEJADO}
      #Log To Console                        ${RESPOSTA.reason}
      Log                                   ${RESPOSTA.reason}
      Should Be Equal As Strings            ${REASON_DESEJADO}                  ${RESPOSTA.reason}


Validar a lista de "${QTD_LIVROS}" livros
      log                                   ${RESPOSTA.json()}
      #Log To Console                        ${RESPOSTA.json()}
      Length Should Be                      ${RESPOSTA.json()}                  ${QTD_LIVROS}


Requisitar o livro de id "${ID}"
      ${RESPOSTA}                           Get Request     fakeAPI     /api/Books/${ID}
      Set Suite Variable                    ${RESP_IDBOOK}             ${RESPOSTA}
      #Log To Console                       ${RESP_IDBOOK.text}


Validar o Status Code 200
      [Arguments]                             ${STATUSCODE_DESEJADO}
      #log to Console                          ${RESPOSTA}
      log                                     ${RESPOSTA}
      #Log To Console                          ${RESPOSTA.status_code}
      Should Be Equal As Strings              ${STATUSCODE_DESEJADO}              ${RESPOSTA.status_code}


Conferir todos os campos do id "${ID}"
    ${RESPOSTA}                               Get Request     fakeAPI     /api/Books/${ID}
    Log To Console                            ${RESPOSTA.json()}
    #Dictionary Should Contain Item            ${RESPOSTA.json()}    ID           ${API_ID.ID}
    Dictionary Should Contain Item            ${RESPOSTA.json()}    ID            15
    Dictionary Should Contain Item            ${RESPOSTA.json()}    Title         Book 15
    Dictionary Should Contain Item            ${RESPOSTA.json()}    PageCount     1500

    Should Not Be Empty                       ${RESPOSTA.json()["Description"]}
    Should Not Be Empty                       ${RESPOSTA.json()["Excerpt"]}
    Should Not Be Empty                       ${RESPOSTA.json()["PublishDate"]}

#Usando value como inteiro
    # ${var}=                        Convert To Integer        15
    # Dictionary Should Contain Value    ${RESPOSTA.json()}    ${var}
