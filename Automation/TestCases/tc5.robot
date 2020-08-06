*** Settings ***
Library    RequestsLibrary
Library     Collections
Library     OperatingSystem


*** Variables ***
${BASE_URL}     https://conduit.productionready.io/


*** Test Cases ***

Log in
    #   Login with Token created at previous login
    Create Session  LogIn  ${BASE_URL}
    ${body}=    get file   C:/Users/ncbar/PycharmProjects/Automation/TestData/request_body.json
    ${bearer_token}  get file  C:/Users/ncbar/PycharmProjects/Automation/TestData/Token.json
    ${header}=  create dictionary   token=${bearer_token}  Content-Type=application/json
    ${response}=    post request     LogIn    /api/users/login   data=${body}   headers=${header}
    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    # validation
    Should Be Equal As Strings  ${response.status_code}  200
    ${res_body}=    convert to string   ${response.content}
    #   here validating token login response contains same user and email
    should contain  ${res_body}     nara    nara@gmail.com

Create an Article
    Create Session  createarticle  ${BASE_URL}
    Create Session  LogIn  ${BASE_URL}
    ${body}=    get file   C:/Users/ncbar/PycharmProjects/Automation/TestData/Article_body.json
    ${bearer_token}  get file  C:/Users/ncbar/PycharmProjects/Automation/TestData/Token.json
    ${header2}=  create dictionary   token=${bearer_token}  Content-Type=application/json
    ${response}=    post request     createarticle    /api/articles     data=${body}    headers=${header2}


    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    #Should Be Equal As Strings  ${response.status_code}  201
    ${res_body}=    convert to string   ${response.content}
    #   here validating the article just created in response
    #should contain  ${res_body}     title   How to train your dragon

Delete Article
    #   Deleting a cooment from article id and comment id
    Create Session  deletearticle  ${BASE_URL}
    ${bearer_token}  get file  C:/Users/ncbar/PycharmProjects/Automation/TestData/Token.json
    ${header2}=  create dictionary   token=${bearer_token}      Content-Type=application/json
    ${response}=    delete request     deletearticle    /api/articles/1    headers=${header2}

    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    #Should Be Equal As Strings  ${response.status_code}  200
    ${res_body}=    convert to string   ${response.content}
    #   Validating the comment posted and and response no loger contains the comment
    #should not contain  ${res_body}     deleted   Successfully

*** Keywords ***
