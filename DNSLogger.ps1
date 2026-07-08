Get-Date | Out-File "C:\temp\DNSDump.txt" -Append
Write-Host "Dumping client DNS cache..."
Get-DNSClientCache | Select-Object -Property @{Name="Public Name"; Expression={if ([string]::IsNullOrEmpty($_.Name)) { "Unresolved Query" } else { $_.Name }}}, @{Name="Status"; Expression={switch($_.Status){0{"Success"} 9003{ "NameError (NXDOMAIN)" } 1460{ "Timeout" } default{ "Other Error Code: $_" }}}}, TTL, @{Name="Domain Address"; Expression={if ([string]::IsNullOrEmpty($_.Data)) { "Unrecognized Domain/Address" } else { $_.Data }}} | Format-Table -Autosize
# In the powershell module, DNSClientCache, the Status property is outputted as a numeric value, or an enumeration, which represents the status of the DNS query. For e.g.
# 0 = Success
# 9003 = NameError (NXDOMAIN)
# 1460 = Timeout
# This line below will rerun the command to log the findings immediately after the first execution for consistency between the two executions
Get-DNSClientCache | Select-Object -Property @{Name="Public Name"; Expression={if ([string]::IsNullOrEmpty($_.Name)) { "Unresolved Query" } else { $_.Name }}}, @{Name="Status"; Expression={switch($_.Status){0{"Success"} 9003{ "NameError (NXDOMAIN)" } 1460{ "Timeout" } default{ "Other Error Code: $_" }}}}, TTL, @{Name="Domain Address"; Expression={if ([string]::IsNullOrEmpty($_.Data)) { "Unrecognized Domain/Address" } else { $_.Data }}} | Format-Table -Autosize | Out-File "C:\temp\DNSDump.txt" -Append
Write-Host "DNS cache dump completed"
Write-Host "Logging current findings to a text file..."
Invoke-Item "C:\temp\DNSDump.txt"
Write-Host "Terminating script..."
START-SLEEP -Seconds 5