*** Settings ***
Resource            ../../../../testData/variables/imports.resource
Resource            ../../../../keywords/imports.resource
Library             RequestsLibrary

Suite Setup         Authorize
Suite Teardown      Delete User    ${suiteUserId}


*** Test Cases ***
Verify Create New Users
    Log To Console    \nSending Resquest To ${globalEndpointUsers}\n
    ${id}    ${response}    Create New User
    Set Suite Variable    ${suiteUserId}    ${id}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${globalSchemaUsersPost}
