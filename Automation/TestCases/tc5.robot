*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}     https://conduit.productionready.io/

*** Test Cases ***

Log in
    Create Session  LogIn  ${BASE_URL}
    ${response}=    get request     LogIn    /api/users/login
    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  200

Create an Article
    Create Session  createarticle  ${BASE_URL}
    ${body}=    create dictionary  title=this is my article
    ${header2}=   create dictionary  Content-Type=application/json
    ${response}=    put request    createarticle    /api/articles   data=${body}    headers=${header2}


    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  201

Delete Comment
    Create Session  deletearticle  ${BASE_URL}
    ${response}=    post request     deletearticle    /api/articles/1

    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  200

*** Keywords ***
