*** Settings ***
Library     SeleniumLibrary
Library    Collections
#Test Template     ERROR_MESSAGE_TEST


*** Variables ***
${URL}   https://demo.realworld.io/
${VALID_USERID}     mno@gmail.com
${VALID_PASSWORD}   password123
${MY_COMMENT}   This is My First Comment
${URL1}     https://demo.realworld.io/#/settings


*** Test Cases ***
LandingOnLogInPageTask
    #   Opening URL under Test
    Open Browser    ${URL}   Chrome
    #   Clicking on Sign in link
    Click Element   xpath://*[contains(text(), "Sign in")]
    #  Vvalidating the user landed on Login page successfully
    ${response}    Get Text    xpath://*[contains(text(), "Need an account?")]
    Should Be Equal As Strings    ${response}    Need an account?

SuccessfulLogInHomePageValidation
    #   Validation of Valid Login
    Wait Until Element Is Enabled   xpath://input[@placeholder="Email"]
    Click Element   xpath://input[@placeholder="Email"]
    Input Text    xpath://input[@placeholder="Email"]   ${VALID_USERID}  clear=True
    Click Element   xpath://input[@placeholder="Password"]
    Input Password  xpath://input[@placeholder="Password"]  ${VALID_PASSWORD}    clear=True
    Click Button    xpath://button[contains(text(),'Sign in')]
    #   Validation of successful login and user on home page
    Wait Until Page Contains Element    xpath://a[contains(text(), 'Home')]
    Wait Until Page Contains Element    xpath://a[contains(text(), 'Your Feed')]

GlobalArticleTest
    Wait Until Page Contains Element    xpath://a[contains(text(), 'Global Feed')]
    #   Clicking on Global Feed
    Click Element   xpath://a[contains(text(), 'Global Feed')]
    #   Clicking on first article
    Wait Until Page Contains Element    xpath://span[contains(text(), 'Read more')]
    Click Element   xpath://span[contains(text(), 'Read more')]
    #   Write a comment
    Maximize Browser Window
    Sleep    5s
    Scroll Page To Location    0    2000
    Wait Until Page Contains Element    xpath://textarea
    Click Element    xpath://textarea
    Input Text    xpath://textarea   ${MY_COMMENT}  clear=True
    Wait Until Element Is Enabled   xpath://button[contains(text(), 'Post Comment')]
    Click Element   xpath://button[contains(text(), 'Post Comment')]
    #   Validate comment on the same page posted successfully
    Wait Until Page Contains Element    xpath://p[contains(text(), 'This is My First Comment')]
    #   Logging Out
    Go To   https://demo.realworld.io/#/settings
    Wait Until Page Contains Element    //button[contains(text(), 'Or click here to logout.')]
    Click Element   //button[contains(text(), 'Or click here to logout.')]
    #   Validate Comment on logout view
    Wait Until Page Contains Element    xpath://span[contains(text(), 'Read more')]
    Click Element   xpath://span[contains(text(), 'Read more')]
    Scroll Page To Location    0    2000
    Wait Until Page Contains Element    xpath://p[contains(text(), 'This is My First Comment')]



*** Keywords ***
Scroll Page To Location
    [Arguments]    ${x_location}    ${y_location}
    Execute JavaScript    window.scrollTo(${x_location},${y_location})