*** Settings ***
Resource    ../../../testData/variables/imports.resource
Resource    ../../../keywords/imports.resource
Library     RequestsLibrary


*** Variables ***
&{suiteWrongTokenHeader}    Authorization=Bearer wr0ngT0k3n
&{suiteEmptyTokenHeader}    Authorization=${EMPTY}
${suiteGetMethod}           GET
${suitePostMethod}          POST
${suiteDeleteMethod}        DELETE


*** Test Cases ***    METHOD    ENDPOINT    AUTHHEADER
Verify Get All Users With Wrong Autorization    [Template]    Custom Test Template
    ${suiteGetMethod}    ${globalEndpointUsers}    ${suiteWrongTokenHeader}

Verify Get All Users With Empty Autorization    [Template]    Custom Test Template
    ${suiteGetMethod}    ${globalEndpointUsers}    ${suiteWrongTokenHeader}

Verify Get Users Id With Wrong Autorization    [Template]    Custom Test Template
    ${suiteGetMethod}    ${globalEndpointUsers}/1    ${suiteWrongTokenHeader}

Verify Get Users Id With Empty Autorization    [Template]    Custom Test Template
    ${suiteGetMethod}    ${globalEndpointUsers}/1    ${suiteEmptyTokenHeader}

Verify Post Users With Wrong Autorization    [Template]    Custom Test Template
    ${suitePostMethod}    ${globalEndpointUsers}    ${suiteWrongTokenHeader}

Verify Post Users With Empty Autorization    [Template]    Custom Test Template
    ${suitePostMethod}    ${globalEndpointUsers}    ${suiteEmptyTokenHeader}

Verify Delete Users With Wrong Autorization    [Template]    Custom Test Template
    ${suiteDeleteMethod}    ${globalEndpointUsers}/1    ${suiteWrongTokenHeader}

Verify Delete Users With Empty Autorization    [Template]    Custom Test Template
    ${suiteDeleteMethod}    ${globalEndpointUsers}/1    ${suiteEmptyTokenHeader}


*** Keywords ***
Custom Test Template
    [Arguments]    ${METHOD}    ${endpoint}    ${authHeader}
    Log To Console    \nSending Request To ${globalEndpointUsers}\n
    ${globalStartTime}    Get Current Date
    ${response}    Run Keyword
    ...    ${METHOD}
    ...    url=${endpoint}
    ...    expected_status=${globalUnauthorizedStatusCode}
    ...    headers=${authHeader}
    ${globalEndTime}    Get Current Date
    Validate Response Time    ${globalStartTime}    ${globalEndTime}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${globalSchemaLoginError}
