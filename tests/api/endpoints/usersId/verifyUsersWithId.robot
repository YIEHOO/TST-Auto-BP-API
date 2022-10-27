*** Settings ***
Resource        ../../../../testData/variables/imports.resource
Resource        ../../../../keywords/imports.resource
Library         RequestsLibrary

Suite Setup     Authorize


*** Test Cases ***
Verify Existing User 200
    Log To Console    \nSending Request To ${globalEndpointUsers}/1\n
    ${globalStartTime}    Get Current Date
    ${response}    GET    url=${globalEndpointUsers}/1    headers=${globalAuthHeader}    expected_status=${globalOkStatusCode}
    ${globalEndTime}    Get Current Date
    Validate Response Time    ${globalStartTime}    ${globalEndTime}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${globalSchemaUsersWithId}
