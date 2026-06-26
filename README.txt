Copy and paste these lines in to a Powershell terminal in the following order:

1: For this script to work, your CurrentUser environment must allow Powershell scripts to execute.

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

2: To verify, run the following command

Get-ExecutionPolicy -List

# Running this module on Powershell will provide a list of the rules for each environment in Windows, and "CurrentUser" should have "Unrestricted" next to in the table that appears.

3: AFTER you run the script, it is highly advised for optimal security on your workstation to run the following command

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Restricted 
# Running this module with these options will ensure that no Powershell scripts will run on your active user environment (currently logged in as) which will help in cases of breaches.

4 (OPTIONAL): To test unresolved DNS queries in the application, copy and paste the following line in a Powershell terminal

RESOLVE-DNSNAME THISISATESTDOMAINQUERYFORTHESCRIPT.com

# Immediately run DNSLogger.exe afterwards and observe a query with the "Public Name" as "Unresolved Query"