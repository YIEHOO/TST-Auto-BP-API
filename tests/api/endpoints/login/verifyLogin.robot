*** Settings ***
Resource    ../../../../testData/variables/imports.resource
Resource    ../../../../keywords/imports.resource
Library     RequestsLibrary
Library     DateTime
Library     Telnet


*** Test Cases ***
Verify Login Returns 200
    # Declare the endpoint tested on console
    Log To Console    \nSending Request To ${globalEndpointLogin}\n

    # Setup the endpoint jsonBody, Headers and Parameters
    ${password}    Read Secret From Vault    ${globalAccountAdmin}
    &{jsonBody}    Create Dictionary    username=${globalAccountAdmin}    password=${password}

    # Set the endpoint starting time
    ${globalStartTime}    Get Current Date

    # Send the request
    ${response}    POST    url=${globalEndpointLogin}    json=${jsonBody}    expected_status=${globalOkStatusCode}

    # Set the endpoint end time
    ${globalEndTime}    Get Current Date

    # Validate the test results
    Validate Response Time    ${globalStartTime}    ${globalEndTime}
    Validate Json Schema    inputJson=${response.json()}    referenceSchemaPath=${globalSchemaLogin}
