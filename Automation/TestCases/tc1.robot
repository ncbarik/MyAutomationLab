*** Settings ***
Library     SeleniumLibrary
Library     DataDriver  ../TestData/invalidtestdata.csv
Library     SeleniumLibrary
Resource    ../Resources/resource.robot

Suite Setup     Open My Browser
Suite Teardown  Close Browsers
Test Template  InValid LogIn

*** Variables ***

*** Test Cases ***
Invalid Log In using    ${username} ${email}    ${password} ${errormessage}

*** Keywords ***
Scroll Page To View
    [Arguments]    ${x_location}    ${y_location}
    Execute JavaScript    window.scrollTo(${x_location},${y_location})


InValid LogIn
    [Arguments]     ${username}     ${email}    ${password}     ${errormessage}
    #   Clicking on Sign in link
    Wait Until Page Contains Element    xpath://*[contains(text(), "Sign in")]
    Click Element   xpath://*[contains(text(), "Sign in")]
    #  Validating the user landed on Login page successfully
    ${response}    Get Text    xpath://*[contains(text(), "Need an account?")]
    Should Be Equal As Strings    ${response}    Need an account?
    #   Clicking on need an account link
    Wait Until Page Contains Element    xpath://*[contains(text(), "Need an account?")]
    Click Element   xpath://*[contains(text(), "Need an account?")]
    #   Landing on Sign Up validation
    Wait Until Page Contains Element    xpath://div//h1[contains(text(), 'Sign up')]
    Wait Until Page Contains Element    xpath://a[contains(text(), 'Have an account?')]
    #   Validation of input filds
    Wait Until Page Contains Element    xpath://input[contains(@placeholder, 'Username')]
    Wait Until Page Contains Element    xpath://input[contains(@placeholder, 'Email')]
    Wait Until Page Contains Element    xpath://input[contains(@placeholder, 'Password')]

    Wait Until Element Is Enabled   xpath://input[contains(@placeholder, 'Username')]
    Element Should Be Enabled   xpath://button[contains(text(),'Sign up')]
    Click Element   xpath://button[contains(text(),'Sign up')]
    #   Validating All 5 error messages on page
    #   Username field validation
    #   Scrolling to view
    Maximize Browser Window
    Sleep    5s
    Scroll Page To View    0    2000
    Click Element   xpath://input[contains(@placeholder, 'Username')]
    Input Text  xpath://input[contains(@placeholder, 'Username')]   ${username}   clear=True
    Click Element   xpath://input[contains(@placeholder, 'Email')]
    Input Text  xpath://input[contains(@placeholder, 'Email')]  ${email}@gmail.com  clear=True
    Click Element   xpath://input[contains(@placeholder, 'Password')]
    Input Text  xpath://input[contains(@placeholder, 'Password')]   ${password} clear=True
    Element Should Be Enabled   xpath://button[contains(text(),'Sign up')]
    Click Element   xpath://button[contains(text(),'Sign up')]
    Element Text Should Be  xpath://list-errors//div//li[text()[contains(.,"${errormessage}")]]  ${errormessage}