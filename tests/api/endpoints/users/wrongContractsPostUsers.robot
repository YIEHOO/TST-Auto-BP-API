*** Settings ***
Resource            ../../../../testData/variables/imports.resource
Resource            ../../../../keywords/imports.resource
Library             RequestsLibrary

Suite Setup         Authorize
Test Template       Custom Test Template


*** Test Cases ***    CONTRACTS
Verify Create New Users With 0 Contracts    ${0}
Verify Create New Users With 4 Contracts    ${4}


*** Keywords ***
Custom Test Template
    [Arguments]    ${contractsNumber}
    Log To Console    \nSending Request To ${globalEndpointUsers}\n
    ${id}    ${response}    Create New User    contractsNumber=${contractsNumber}    expectedStatus=${globalBadRequestStatusCode}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${globalSchemaUsersPostError}
