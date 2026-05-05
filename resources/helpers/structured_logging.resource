*** Keywords ***

Log Action
    [Arguments]    ${action}    ${message}    ${level}=INFO    &{kwargs}
    ${timestamp}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    ${extras}=    Evaluate    ' | '.join(f'{k}={v}' for k, v in $kwargs.items())
    ${formatted}=    Set Variable If    '${extras}' != ''
    ...    [${action.upper()}] ${message} | ${extras} | timestamp=${timestamp}
    ...    [${action.upper()}] ${message} | timestamp=${timestamp}
    Log    ${formatted}    level=${level}