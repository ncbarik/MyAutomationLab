*** Settings ***
Library    RequestsLibrary
Library     DataDriver  ../TestData/TestData.csv
Library     Collections
Library     OperatingSystem

Test Template   CSV Upload

*** Variables ***
${BASE_URL}     https://conduit.productionready.io/

*** Test Cases ***

Cvs upload of Articles  #${title}

*** Keywords ***
CSV Upload
    #   bulk upload of articles from cvs file
    #[Arguments]     ${title}
    Create Session  cvsuploadrticle  ${BASE_URL}
    #${body}=    get file   C:/Users/ncbar/PycharmProjects/Automation/TestData/Article_body.json
    ${bearer_token}  get file  C:/Users/ncbar/PycharmProjects/Automation/TestData/Token.json
    ${header2}=  create dictionary   token=${bearer_token}  Content-Type=application/json
    ${response}=    post request     cvsuploadrticle    /api/articles   headers=${header2}


    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    #Should Be Equal As Strings  ${response.status_code}  201
    ${res_body}=    convert to string   ${response.content}
    #   here validating the articles just updated in response
    #should contain  ${res_body}     title   body
