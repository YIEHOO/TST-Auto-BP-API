*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     DateTime
Resource    ../testData/variables/imports.resource
Resource    imports.resource


*** Keywords ***
Authorize
    IF    not ${globalAuthSet}
        &{jsonBody}    Create Dictionary    username=admin    password=masterPass
        ${globalStartTime}    Get Current Date
        ${response}    POST    url=${globalEndpointLogin}    json=${jsonBody}    expected_status=${globalOkStatusCode}
        ${globalEndTime}    Get Current Date
        Validate Response Time    ${globalStartTime}    ${globalEndTime}
        ${responseJson}    Set Variable    ${response.json()}
        ${token}    Get From Dictionary    ${responseJson}    token
        ${headers}    Create Dictionary    Authorization=Bearer ${token}
        Set Global Variable    ${globalAuthHeader}    ${headers}
        Set Global Variable    ${globalAuthSet}    ${True}
    END

Create New User
    [Arguments]    ${active}=${True}    ${city}=Paris    ${contractsCurrency}=EUR    ${contractsId}=33    ${contractsPrice}=${9.99}    ${contractsType}=basic    ${email}=yassine.ibnelhassan@outlook.com    ${name}=IBN EL HASSAN    ${street}=1st street    ${surname}=Yassine    ${zip}=95100    ${contractsNumber}=${1}    ${expectedStatus}=201
    @{contracts}    Create List
    IF    ${contractsNumber} > ${0}
        FOR    ${counter}    IN RANGE    ${contractsNumber}
            ${contract}    Create Dictionary
            ...    currency=${contractsCurrency}
            ...    id=${contractsId}
            ...    price=${contractsPrice}
            ...    type=${contractsType}
            Append To List    ${contracts}    ${contract}
        END
    END

    ${body}    Create Dictionary
    ...    active=${active}
    ...    city=${city}
    ...    contracts=${contracts}
    ...    email=${email}
    ...    name=${name}
    ...    street=${street}
    ...    surname=${surname}
    ...    zip=${zip}
    ${globalStartTime}    Get Current Date
    ${response}    POST
    ...    url=${globalEndpointUsers}
    ...    json=${body}
    ...    expected_status=${expectedStatus}
    ...    headers=${globalAuthHeader}
    ${globalEndTime}    Get Current Date
    Validate Response Time    ${globalStartTime}    ${globalEndTime}
    ${userId}    Set Variable    ${EMPTY}
    IF    "${expectedStatus}" == "${globalCreatedStatusCode}"
        ${userId}    Get From Dictionary    ${response.json()}    ID
    END
    RETURN    ${userId}    ${response}

Delete User
    [Arguments]    ${userId}
    ${globalStartTime}    Get Current Date
    ${response}    DELETE
    ...    url=${globalEndpointUsers}/${userId}
    ...    expected_status=${globalOkStatusCode}
    ...    headers=${globalAuthHeader}
    ${globalEndTime}    Get Current Date
    Validate Response Time    ${globalStartTime}    ${globalEndTime}
    RETURN    ${response}
