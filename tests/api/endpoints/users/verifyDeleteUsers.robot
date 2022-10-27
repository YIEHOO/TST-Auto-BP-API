*** Settings ***
Resource        ../../../../testData/variables/imports.resource
Resource        ../../../../keywords/imports.resource
Library         RequestsLibrary

Suite Setup     Custom Suite Setup


*** Variables ***
${suiteUserId}      ${EMPTY}


*** Test Cases ***
Verify Delete Users 200
    Log To Console    \Sending Resquest To ${globalEndpointUsers}\n
    ${globalStartTime}    Get Current Date
    ${response}    Delete User    ${suiteUserId}
    ${globalEndTime}    Get Current Date
    Validate Response Time    ${globalStartTime}    ${globalEndTime}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${globalSchemaUsersDelete}


*** Keywords ***
Custom Suite Setup
    Authorize
    ${id}    ${response}    Create New User
    Set Suite Variable    ${suiteUserId}    ${id}
