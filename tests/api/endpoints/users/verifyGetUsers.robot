*** Settings ***
Resource        ../../../../testData/variables/imports.resource
Resource        ../../../../keywords/imports.resource

Suite Setup     Authorize


*** Test Cases ***
Verify All Users 200
    Log To Console    \nSending Request To ${globalEndpointUsers}\n
    ${params}    Create Dictionary    filter=all
    ${globalStartTime}    Get Current Date
    ${response}    GET
    ...    url=${globalEndpointUsers}
    ...    expected_status=${globalOkStatusCode}
    ...    headers=${globalAuthHeader}
    ...    params=${params}
    ${globalEndTime}    Get Current Date
    Validate Response Time    ${globalStartTime}    ${globalEndTime}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${globalSchemaUsers}
