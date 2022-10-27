*** Settings ***
Resource            ../../../../testData/variables/imports.resource
Resource            ../../../../keywords/imports.resource
Library             RequestsLibrary

Test Template       Custom Test Template


*** Test Cases ***    USERNAME    PASSWORD
Verify Login With Wrong Password Returns 401    admin    wrongPass
Verify Login With Wrong User Returns 401    guest    masterPass
Verify Login With Empty Data Returns 401    ${EMPTY}    ${EMPTY}
Verify Login With Wrong User And Password Returns 401    guest    wrongPass


*** Keywords ***
Custom Test Template
    [Arguments]    ${username}    ${password}
    Log To Console    \nSending Request To ${globalEndpointLogin}\n
    &{jsonBody}    Create Dictionary    username=${username}    password=${password}
    ${globalStartTime}    Get Current Date
    ${response}    POST    url=${globalEndpointLogin}    json=${jsonBody}    expected_status=${globalUnauthorizedStatusCode}
    ${globalEndTime}    Get Current Date
    Validate Response Time    ${globalStartTime}    ${globalEndTime}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${globalSchemaLoginError}
