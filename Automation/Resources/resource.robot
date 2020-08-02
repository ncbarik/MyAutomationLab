*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${URL}   https://demo.realworld.io/

*** Keywords ***
Open My Browser
    #   Opening URL under Test
    Open Browser    ${URL}   Chrome
    Maximize Browser Window
Close Browsers
    Close All Browsers