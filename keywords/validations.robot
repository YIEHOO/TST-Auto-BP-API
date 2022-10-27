*** Settings ***
Library     ../lib/jsonValidateSchema.py
Library     DateTime
Resource    ../testData/variables/imports.resource


*** Keywords ***
Validate Schema
    [Arguments]    ${inputJson}    ${referenceSchemaPath}
    Log To Console    Validating the Json Schema!
    Validate Json Schema    ${inputJson}    ${referenceSchemaPath}

Validate Response Time
    [Arguments]    ${startTime}    ${endTime}    ${expectedResponseTime}=${globalExpectedResponseTime}
    Log To Console    Validating the response time!
    ${responseTime}    Subtract Date From Date    ${endTime}    ${startTime}
    Run Keyword And Warn On Failure    Should Be True    ${responseTime} < ${expectedResponseTime}
