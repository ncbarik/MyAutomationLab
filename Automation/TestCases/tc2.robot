*** Settings ***
Library     SeleniumLibrary
Library    Collections
Library  String

*** Variables ***
${URL}   https://demo.realworld.io/

*** Test Cases ***
Landing OnLogIn Page
    #   Opening URL under Test
    Open Browser    ${URL}   Chrome
    #   Clicking on Sign in link
    Click Element   xpath://*[contains(text(), "Sign in")]
    #  Vvalidating the user landed on Login page successfully
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
    Element Should Be Enabled   xpath://button[contains(text(),'Sign up')]

New Account Creation with valid values
    ${RAN_USER}=   Generate Random String  length=6  chars=[LETTERS]
    ${RAN_EMAIL}    Generate Random String  6  [LETTERS]
    ${RAM_PASSWORD}     Generate Random String  8  [LETTERS]

    #   Input all valid data to create an account
    Click Element   xpath://input[contains(@placeholder, 'Username')]
    Input Text    xpath://input[contains(@placeholder, 'Username')]   ${RAN_USER}  clear=True
    Click Element   xpath://input[contains(@placeholder, 'Email')]
    Input Text    xpath://input[contains(@placeholder, 'Email')]   ${RAN_EMAIL}@gmail.com  clear=True
    Click Element   xpath://input[contains(@placeholder, 'Password')]
    Input Password  xpath://input[contains(@placeholder, 'Password')]  ${RAM_PASSWORD}    clear=True
    Element Should Be Enabled   xpath://button[contains(text(),'Sign up')]
    Click Element   xpath://button[contains(text(),'Sign up')]
    Close Browser

*** Keywords ***

