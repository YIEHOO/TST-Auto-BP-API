*** Settings ***
Library     ../lib/vaultAccess.py


*** Keywords ***
Read Secret From Vault
    [Arguments]    ${accountToRetrieve}
    Log To Console    Retrieving password for the account!
    ${password}    Read Secret    ${accountToRetrieve}
    RETURN    ${password}
