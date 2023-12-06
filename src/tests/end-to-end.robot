*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Test Program Output
    ${output}=    Run    python ./src/interact_with_index.py
    Should Contain    ${output}    Input a to add a new reference
    Should Contain    ${output}    Input l to list all references
    Should Contain    ${output}    Input e to export references as a .bib file
    Should Contain    ${output}    Input q to exit

Test Program Output with bad text
    ${output}=    Run    python ./src/interact_with_index.py
    Should Not Contain    ${output}    Some other text that should not be here

Test Program Output on Add Reference
    ${output}=    Run    python ./src/interact_with_index.py a
    Should Contain    ${output}    Choose the entry type (Enter empty to abort):

Test Program Output on Add Reference and bad entry type
    ${output}=    Run    python ./src/interact_with_index.py a asd
    Should Contain    ${output}    Invalid entry type!

Test Create New Article With Non-Numeric Year
    ${output}=    Run    python ./src/interact_with_index.py a article title year
    Should Contain    ${output}    Choose the entry type (Enter empty to abort):
    Should Contain    ${output}    Enter value for title (Enter empty to abort):
    Should Contain    ${output}    Enter value for year (Enter empty to abort):
    Should Contain    ${output}    Value was not a number!
    Should Contain    ${output}    Enter value for year (Enter empty to abort):

Test Create New Article With Non-Numeric Year And Then Numeric
    ${output}=    Run    python ./src/interact_with_index.py a article title year 2023 author journal "" ckey
    Should Contain    ${output}    Choose the entry type (Enter empty to abort):
    Should Contain    ${output}    Enter value for title (Enter empty to abort):
    Should Contain    ${output}    Enter value for year (Enter empty to abort):
    Should Contain    ${output}    Value was not a number!
    Should Contain    ${output}    Enter value for year (Enter empty to abort):
    Should Contain    ${output}    Enter value for author (Enter empty to abort):
    Should Contain    ${output}    Enter value for journal (Enter empty to abort):
    Should Contain    ${output}    Enter optional field name (Leave empty to finish):
    Should Contain    ${output}    Enter the citation key, or press Enter to use the suggestion:
