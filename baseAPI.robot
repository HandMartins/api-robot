*** Settings ***
Library               Collections
Library               RequestsLibrary



***Variable***
${URL_API}              https://fakerestapi.azurewebsites.net
${QTD_LIVROS}           200
#para o get &{API_ID}               ID=15


***Keywords***
Criando Sessão
  Create Session    fakeAPI    ${URL_API}
