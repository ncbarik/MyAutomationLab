*** Settings ***
Library    RequestsLibrary
Library     Collections
Library     OperatingSystem

*** Variables ***
${BASE_URL}     https://conduit.productionready.io
${bearer_token}     eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTA4MTM0LCJ1c2VybmFtZSI6Im5hcmEiLCJleHAiOjE2MDE3NDUwNjB9.ToyhAmCLX3j8_IMEv9Bt_Jq3doqlJ6eGB1gJcjUwNFs

*** Test Cases ***
Validations check for wrong credential
    ${AUTH}     create list     mnop@gmail.com  password123
    Create Session  wrongcredential  ${BASE_URL}    auth=${AUTH}
    ${response}=    get request     wrongcredential    /api/users/login

    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  401

Register User
    Create Session  regist    ${BASE_URL}
    ${body}=    get file   C:/Users/ncbar/PycharmProjects/Automation/TestData/request_body.json
    ${header1}=   create dictionary  Content-Type=application/json
    ${response}=    post request    regist    /api/users/login  data=${body}    headers=${header1}

    log to console  ${response.status_code}
    log to console  ${response.content}

    #   Validation
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal As Strings  ${status_code}  200
    ${res_body}=    convert to string   ${response.content}
    should contain  ${res_body}     nara    nara@gmail.com

Log in
    Create Session  LogIn  ${BASE_URL}
    ${header}=  create dictionary   Authentication=${bearer_token}  Content-Type=application/json
    ${response}=    get request     LogIn    /api/users/login   ${header}
    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  200

Get Article
    Create Session  getarticle  ${BASE_URL}
    ${header}=  create dictionary   Authentication=${bearer_token}  Content-Type=application/json
    ${response}=    get request     getarticle    /api/articles?limit=10&offset=0&tag=testing   ${header}
    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  200

Post Comment
    Create Session  postcomment  ${BASE_URL}
    ${body}=    create dictionary  Comment=This is My First Comment
    ${header2}=   create dictionary  Authentication=${bearer_token} Content-Type=application/json
    ${response}=    put request    postcomment    /api/articles/1/comments   data=${body}    headers=${header2}


    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  200

Delete Comment
    Create Session  deletearticle  ${BASE_URL}
    ${response}=    post request     deletearticle    /api/articles/1/comments/1

    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  200



*** Keywords ***
