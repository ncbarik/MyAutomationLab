*** Settings ***
Library    RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}     https://conduit.productionready.io/

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
    ${body}=    create dictionary  FirstName=raj1234   LastName=raj1234   UserName=raj1234    Password=raj1234
    ${header1}=   create dictionary  Content-Type=application/json
    ${response}=    post request    regist    /register   data=${body}    headers=${header1}

    log to console  ${response.status_code}
    log to console  ${response.content}

    #   Validation
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal As Strings  ${status_code}  201
    ${res_body}=    convert to string   ${response.content}
    should contain  ${res_body} Operation completed successfully


Log in
    Create Session  LogIn  ${BASE_URL}
    ${response}=    get request     LogIn    /api/users/login
    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  200

Get Article
    Create Session  getarticle  ${BASE_URL}
    ${response}=    get request     getarticle    /api/articles?limit=10&offset=0&tag=testing

    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  200

Post Comment
    Create Session  postcomment  ${BASE_URL}
    ${body}=    create dictionary  Comment=This is My First Comment
    ${header2}=   create dictionary  Content-Type=application/json
    ${response}=    put request    postcomment    /api/articles/1/comments   data=${body}    headers=${header2}


    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  201

Delete Comment
    Create Session  deletearticle  ${BASE_URL}
    ${response}=    post request     deletearticle    /api/articles/1/comments/1

    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  200



*** Keywords ***
