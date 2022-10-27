*** Variables ***
${globalAuthHeader}                 ${EMPTY}
${globalAuthSet}                    ${False}
${globalStartTime}                  ${EMPTY}
${globalEndTime}                    ${EMPTY}
${globalExpectedResponseTime}       0.007

# List of API response codes
${globalOkStatusCode}               200
${globalUnauthorizedStatusCode}     401
${globalBadRequestStatusCode}       400
${globalCreatedStatusCode}          201

# List of used accounts
${globalAccountAdmin}               admin
