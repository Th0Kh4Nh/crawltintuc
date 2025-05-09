*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    DateTime
Library    String

Suite Setup    Mở Trang
Suite Teardown    Close Browser

*** Variables ***
${URL}             https://kenh14.vn/
${BROWSER}         Chrome
${CSV_FILE}        tintuc.csv
${HEADER_WRITTEN}  False

*** Test Cases ***
Chạy vào lúc 6h sáng
    WHILE    True
        ${current_time}=    Get Time
        ${hour}=    Convert Date    ${current_time}    result_format=%H
        ${minute}=    Convert Date    ${current_time}    result_format=%M
        
        # Kiểm tra nếu là 6:00 sáng
        IF    '${hour}:${minute}' == '06:00'
            Hàm chính
            Sleep    300    
        ELSE
            # Chờ 1 phút trước khi kiểm tra lại
            Sleep    60
        END
    END

*** Keywords ***
Mở Trang
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s

Hàm chính
    Wait Until Element Is Visible    xpath=//*[@id="k14-main-menu-wrapper"]/div/div/ul/li[6]    10s
    Click Element    xpath=//*[@id="k14-main-menu-wrapper"]/div/div/ul/li[6]
    Sleep    2
    ${all_data}=    Create List
    WHILE    True
        ${articles}=    Get WebElements    //article
        FOR    ${article}    IN    @{articles}
            ${tieude}=    Run Keyword And Ignore Error    Get Text    xpath=.//h3[contains(@class,"knswli-title")]
            ${mota}=     Run Keyword And Ignore Error    Get Text    xpath=.//p[contains(@class,"knswli-sapo")]
            ${time}=     Run Keyword And Ignore Error    Get Text    xpath=.//span[contains(@class,"knswli-time")]
            ${img}=      Run Keyword And Ignore Error    Get Element Attribute    xpath=.//img[contains(@class,"lozad")]    data-src

            ${tieude}=    Set Variable If    '${tieude}[0]' == 'PASS'    ${tieude}[1]    ''
            ${mota}=     Set Variable If    '${mota}[0]' == 'PASS'     ${mota}[1]     ''
            ${time}=     Set Variable If    '${time}[0]' == 'PASS'     ${time}[1]     ''
            ${img}=      Set Variable If    '${img}[0]' == 'PASS'      ${img}[1]      ''

            ${row}=    Create List    ${tieude}    ${mota}    ${img}    ${time}
            Append To List    ${all_data}    ${row}
        END

        ${next}=    Run Keyword And Ignore Error    Click Element    xpath=//a[contains(@class,"next")]
        Run Keyword If    '${next}[0]' == 'FAIL'    Exit For Loop
        Sleep    1
    END

    Lưu CSV    ${all_data}

Lưu CSV
    [Arguments]    ${data}
    IF    not ${HEADER_WRITTEN}
        Create File    ${CSV_FILE}    Tiêu đề,Mô tả,Hình ảnh,Thời gian\n
        Set Global Variable    ${HEADER_WRITTEN}    True
    END
    FOR    ${row}    IN    @{data}
        ${line}=    Catenate    SEPARATOR=,    @{row}
        Append To File    ${CSV_FILE}    ${line}\n
    END
