*** Settings ***
Library    RequestsLibrary
Library     Collections
Library     OperatingSystem

*** Variables ***
${BASE_URL}     https://conduit.productionready.io


*** Test Cases ***
Validations check for wrong credential
    #   invalid useremail and password used in basic authentication
    ${AUTH}     create list     mnop@gmail.com  password123
    Create Session  wrongcredential  ${BASE_URL}    auth=${AUTH}
    ${response}=    get request     wrongcredential    /api/users/login

    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  401

Register An User
    #   user is registered and gives token for further authorization
    Create Session  regist    ${BASE_URL}
    ${body}=    get file   C:/Users/ncbar/PycharmProjects/Automation/TestData/request_body.json
    ${header1}=   create dictionary  Content-Type=application/json
    ${response}=    post request    regist    /api/users/login  data=${body}    headers=${header1}

    log to console  ${response.status_code}
    log to console  ${response.content}

    #   Validation of response
    ${status_code}=     convert to string   ${response.status_code}
    Should Be Equal As Strings  ${status_code}  200
    ${res_body}=    convert to string   ${response.content}
    #   here validating the respone with user name and email present or not
    should contain  ${res_body}     nara    nara@gmail.com

Log in with created User
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

Get An Article
    #   Getting an Article with token log in
    Create Session  getarticle  ${BASE_URL}
    ${bearer_token}  get file  C:/Users/ncbar/PycharmProjects/Automation/TestData/Token.json
    ${header}=  create dictionary   token=${bearer_token}  limit=10 offset=0    tag=test Content-Type=application/json
    ${response}=    get request     getarticle    /api/articles     headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    Should Be Equal As Strings  ${response.status_code}  200
    ${res_body}=    convert to string   ${response.content}
    #   validating the article in response and tag name present
    should contain  ${res_body}     test    article


Post A Comment
    #   Posting a Comment with article id in comments section
    Create Session  postcomment  ${BASE_URL}
    ${bearer_token}  get file  C:/Users/ncbar/PycharmProjects/Automation/TestData/Token.json
    ${header1}=  create dictionary  token=${bearer_token}   Content-Type=application/json
    ${comment_body}=    get file   C:/Users/ncbar/PycharmProjects/Automation/TestData/Comment_body.json
    ${response}=    post request     postcomment    /articles/1/comments    data=${comment_body}    headers=${header1}


    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    #Should Be Equal As Strings  ${response.status_code}  200
    ${res_body}=    convert to string   ${response.content}
    #   Validating the comment posted and and response contains the comment
    #should contain  ${res_body}     body    Thank you so much!


Delete Comment
    #   Deleting a cooment from article id and comment id
    Create Session  deletearticle  ${BASE_URL}
    ${bearer_token}  get file  C:/Users/ncbar/PycharmProjects/Automation/TestData/Token.json
    ${header2}=  create dictionary   token=${bearer_token}      Content-Type=application/json
    ${response}=    delete request     getarticle    /api/articles/1/comments/1    headers=${header2}

    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}
    #Should Be Equal As Strings  ${response.status_code}  200
    ${res_body}=    convert to string   ${response.content}
    #   Validating the comment posted and and response no loger contains the comment
    #should not contain  ${res_body}     deleted   Successfully




*** Keywords ***
