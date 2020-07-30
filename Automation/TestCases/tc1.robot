*** Settings ***
Library     SeleniumLibrary
Library    Collections

*** Variables ***
${URL}   https://demo.realworld.io/
${INVALID_USERID1}  $%$%$123-
${INVALID_EMAIL1}  $%$%$123-
${INVALID_PASSWORD1}    password@rd123
${ERROR_MESSAGE1}    username can't be blank
${ERROR_MESSAGE2}    email can't be blank
${ERROR_MESSAGE3}    password can't be blank
${ERROR_MESSAGE4}    username is too short (minimum is 1 character)
${ERROR_MESSAGE5}    username is too long (maximum is 20 characters)
${ERROR_MESSAGE6}    email has already been taken
${ERROR_MESSAGE7}    username has already been taken

*** Test Cases ***
Landing OnLogIn Page
    #   Opening URL under Test
    Open Browser    ${URL}   Chrome
    #   Clicking on Sign in link
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
    Element Should Be Enabled   xpath://button[contains(text(),'Sign up')]

    #   Validating all links on the page
    Wait Until Element is Visible     xpath://a
    # Count number of links on page
    ${AllLinksCount}=    Get Element Count   xpath://a

    #   Log the count of links
    Log    ${AllLinksCount}

    #   Create a list to store the link texts
    @{LinkItems}    Create List

    #   Loop through all links and store links value that has length more than 1 character
    FOR    ${INDEX}    IN RANGE    1    ${AllLinksCount}
    Log    ${INDEX}
    ${lintext}=    Get Text    xpath=(//a)[${INDEX}]
    Log    ${lintext}
    ${linklength}    Get Length    ${lintext}
    Run Keyword If    ${linklength}>1   Append To List    ${LinkItems}    ${lintext}
    ${LinkSize}=    Get Length    ${LinkItems}
    Log    ${LinkSize}
    END

    Comment    Print all links
    FOR    ${ELEMENT}    IN    @{LinkItems}
    Log    ${ELEMENT}
    END

Validation of Error messages for all blank values
    #   Validation of Error messages for all blank values
    Wait Until Element Is Enabled   xpath://input[contains(@placeholder, 'Username')]
    Element Should Be Enabled   xpath://button[contains(text(),'Sign up')]
    Click Element   xpath://button[contains(text(),'Sign up')]
    #   Validating All 5 error messages on page
    #   Username field validation
    #   Scrolling to view
    Maximize Browser Window
    Sleep    5s
    Scroll Page To View    0    2000
    Wait Until Page Contains Element    xpath://list-errors//div//li[text()[contains(., "username can't be blank")]]
    Element Text Should Be  xpath://list-errors//div//li[text()[contains(., "username can't be blank")]]   ${ERROR_MESSAGE1}
    #  Email field  validation
    Wait Until Page Contains Element    xpath://list-errors//div//li[text()[contains(.,"email can't be blank")]]
    Element Text Should Be  xpath://list-errors//div//li[text()[contains(.,"email can't be blank")]]   ${ERROR_MESSAGE2}
    #   Password field validation
    Wait Until Page Contains Element    xpath://list-errors//div//li[text()[contains(.,"password can't be blank")]]
    Element Text Should Be  xpath://list-errors//div//li[text()[contains(.,"password can't be blank")]]  ${ERROR_MESSAGE3}
    #   UserName length validation
    Wait Until Page Contains Element    xpath://list-errors//div//li[text()[contains(.,"username is too short (minimum is 1 character)")]]
    Element Text Should Be  xpath://list-errors//div//li[text()[contains(.,"username is too short (minimum is 1 character)")]]  ${ERROR_MESSAGE4}
    Wait Until Page Contains Element    xpath://list-errors//div//li[text()[contains(.,"username is too long (maximum is 20 characters)")]]
    Element Text Should Be  xpath://list-errors//div//li[text()[contains(.,"username is too long (maximum is 20 characters)")]]  ${ERROR_MESSAGE5}

Validation of Error messages for blank Username
    #   Validation of Error messages for blank Username
    Wait Until Element Is Enabled   xpath://input[contains(@placeholder, 'Username')]
    Clear Element Text  xpath://input[contains(@placeholder, 'Username')]
    Click Element   xpath://input[contains(@placeholder, 'Email')]
    Input Text    xpath://input[contains(@placeholder, 'Email')]   ${INVALID_EMAIL1}@gmail.com  clear=True
    Wait Until Element Is Enabled   xpath://input[contains(@placeholder, 'Password')]
    Click Element   xpath://input[contains(@placeholder, 'Password')]
    Input Password  xpath://input[contains(@placeholder, 'Password')]  ${INVALID_PASSWORD1}    clear=True
    Element Should Be Enabled   xpath://button[contains(text(),'Sign up')]
    Click Element   xpath://button[contains(text(),'Sign up')]
    Wait Until Page Contains Element    xpath://list-errors//div//li[text()[contains(., "username can't be blank")]]
    Element Text Should Be  xpath://list-errors//div//li[text()[contains(., "username can't be blank")]]   ${ERROR_MESSAGE1}

Validation of Error messages for blank Email
    #   Validation of Error messages for blank Email
    Wait Until Element Is Enabled   xpath://input[contains(@placeholder, 'Username')]
    Click Element   xpath://input[contains(@placeholder, 'Username')]
    Input Text  xpath://input[contains(@placeholder, 'Username')]   ${INVALID_USERID1}  clear=True
    Clear Element Text   xpath://input[contains(@placeholder, 'Email')]
    Click Element   xpath://input[contains(@placeholder, 'Password')]
    Input Text  xpath://input[contains(@placeholder, 'Password')]   ${INVALID_PASSWORD1}    clear=True
    Element Should Be Enabled   xpath://button[contains(text(),'Sign up')]
    Click Element   xpath://button[contains(text(),'Sign up')]
    Wait Until Page Contains Element    xpath://list-errors//div//li[text()[contains(.,"email can't be blank")]]
    Element Text Should Be  xpath://list-errors//div//li[text()[contains(.,"email can't be blank")]]   ${ERROR_MESSAGE2}

Validation of Error messages for blank Password
    #   Validation of Error messages for blank Email
    Wait Until Element Is Enabled   xpath://input[contains(@placeholder, 'Username')]
    Click Element   xpath://input[contains(@placeholder, 'Username')]
    Input Text  xpath://input[contains(@placeholder, 'Username')]   ${INVALID_USERID1}  clear=True
    Click Element   xpath://input[contains(@placeholder, 'Email')]
    Input Text    xpath://input[contains(@placeholder, 'Email')]   ${INVALID_EMAIL1}@gmail.com  clear=True
    Clear Element Text   xpath://input[contains(@placeholder, 'Password')]
    Element Should Be Enabled   xpath://button[contains(text(),'Sign up')]
    Click Element   xpath://button[contains(text(),'Sign up')]
    Wait Until Page Contains Element    xpath://list-errors//div//li[text()[contains(.,"password can't be blank")]]
    Element Text Should Be  xpath://list-errors//div//li[text()[contains(.,"password can't be blank")]]   ${ERROR_MESSAGE3}

Validation of Error messages for already existing UserName EmailId
    #   Validation of Error messages for already existing UserName EmailId
    Wait Until Element Is Enabled   xpath://input[contains(@placeholder, 'Username')]
    Click Element   xpath://input[contains(@placeholder, 'Username')]
    Input Text  xpath://input[contains(@placeholder, 'Username')]   ${INVALID_USERID1}  clear=True
    Click Element   xpath://input[contains(@placeholder, 'Email')]
    Input Text  xpath://input[contains(@placeholder, 'Email')]  ${INVALID_EMAIL1}@gmail.com  clear=True
    Click Element   xpath://input[contains(@placeholder, 'Password')]
    Input Text  xpath://input[contains(@placeholder, 'Password')]   ${INVALID_PASSWORD1}    clear=True
    Element Should Be Enabled   xpath://button[contains(text(),'Sign up')]
    Click Element   xpath://button[contains(text(),'Sign up')]
    Wait Until Page Contains Element    xpath://list-errors//div//li[text()[contains(.,"email has already been taken")]]
    Element Text Should Be  xpath://list-errors//div//li[text()[contains(.,"email has already been taken")]]  ${ERROR_MESSAGE6}
    Wait Until Page Contains Element    xpath://list-errors//div//li[text()[contains(.,"username has already been taken")]]
    Element Text Should Be  xpath://list-errors//div//li[text()[contains(.,"username has already been taken")]]  ${ERROR_MESSAGE7}

*** Keywords ***
Scroll Page To View
    [Arguments]    ${x_location}    ${y_location}
    Execute JavaScript    window.scrollTo(${x_location},${y_location})

