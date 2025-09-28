#!/bin/bash

# Function to display help menu
show_help() {
    echo "Usage: $0 <folder_name>"
    echo "Creates a penetration test folder structure with empty .md files."
    echo "Example: $0 Inlanefreight_Penetration_Test"
    exit 1
}

# Check if no arguments or help is requested
if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
fi

# Assign top-level folder name from argument
TOP_FOLDER="$1"

# Create folder structure
mkdir -p "$TOP_FOLDER"/{Admin,Deliverables,Evidence/{Findings,Logging_output,Misc_files,Notes,OSINT,Scans/{AD_Enumeration,Service,Vuln,Web},Wireless},Retest}

# Create empty .md files in Findings
touch "$TOP_FOLDER/Evidence/Findings"/{H1_-_Kerberoasting,H2_-_ASREPRoasting,H3_-_LLMNR\&NBT-NS_Response_Spoofing,H4_-_Tomcat_Manager_Weak_Credentials}.md

# Create empty .md files in Notes
touch "$TOP_FOLDER/Evidence/Notes"/{10._AD_Enumeration_Research,11._Attack_Path,12._Findings,1._Administrative_Information,2._Scoping_Information,3._Activity_Log,4._Payload_Log,5._OSINT_Data,6._Credentials,7._Web_Application_Research,8._Vulnerability_Scan_Research,9._Service_Enumeration_Research}.md

echo "Folder structure and .md files created under $TOP_FOLDER/"
