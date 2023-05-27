*** Settings ***
Documentation       Test cases for checking JsonQuery library

Library             JsonQuery    ${JSON_QUERY_MODULE_NAME}
Library             Collections

Suite Setup         Load Sample Json File


*** Variables ***
${TEST_PATH}                    ${CURDIR}/../data
${SAMPLE_FILE}                  ${TEST_PATH}/sample.json
${JSON_QUERY_MODULE_NAME}       jsonpath_ng.ext


*** Test Cases ***
Verify That Library Correctly Imported Query Module
    ${loaded_module}    Get Query Module
    Should Be Equal As Strings    ${loaded_module}    ${JSON_QUERY_MODULE_NAME}

Verify That Can Get All friends Name
    ${expected}    Create List    Lea Fernandez    Goodwin Dorsey    Claudia Price
    ${result}    Query Json    ${JSON_FILE}    friends[*].name
    Lists Should Be Equal    ${result}    ${expected}

Verify That Can Get Only Ids Greater Than 1
    ${expected}    Create Dictionary    id=2    name=Claudia Price
    ${result}    Query Json    ${JSON_FILE}    friends[?(@.id>1)]
    Lists Should Be Equal    ${expected}    ${result}[0]


*** Keywords ***
Load Sample Json File
    ${JSON_FILE}    Read Json File    ${SAMPLE_FILE}
    Set Suite Variable    ${JSON_FILE}
    Log    ${JSON_FILE}
