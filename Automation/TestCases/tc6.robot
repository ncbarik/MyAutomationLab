*** Settings ***
Library    RequestsLibrary
Library     DataDriver  ../TestData/TestData.csv

Test Template   CSV Upload

*** Variables ***
${BASE_URL}     https://conduit.productionready.io/

*** Test Cases ***

Cvs upload of Articles  #${title}

*** Keywords ***
CSV Upload
    #[Arguments]     ${title}
    Create Session  cvsuploadrticle  ${BASE_URL}
    ${body}=    create dictionary  title=this is my article
    ${header2}=   create dictionary  Content-Type=application/json
    ${response}=    put request    cvsuploadrticle    /api/articles   data=${body}    headers=${header2}


    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  201
