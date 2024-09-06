$ProgressPreference = 'SilentlyContinue'
cd C:\Users\WDAGUtilityAccount\Desktop

# Download files
invoke-webrequest https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe -outfile python_install.exe
invoke-webrequest https://github.com/DidierStevens/DidierStevensSuite/archive/refs/heads/master.zip -outfile didier_master.zip
invoke-webrequest https://github.com/danielbohannon/Invoke-Obfuscation/archive/refs/heads/master.zip -OutFile obfuscate_master.zip
Invoke-WebRequest https://github.com/danielbohannon/Revoke-Obfuscation/archive/refs/heads/master.zip -OutFile revoke_master.zip
invoke-webrequest https://download.mikestammer.com/bstrings.zip -OutFile bstrings.zip
invoke-webrequest https://download.mikestammer.com/net6/EZViewer.zip -OutFile EZViewer.zip
invoke-webrequest https://download.sysinternals.com/files/Sysmon.zip -Outfile Sysmon.zip
invoke-webrequest https://raw.githubusercontent.com/Neo23x0/sysmon-config/master/sysmonconfig-export.xml -OutFile sysmonconfig-export.xml

sleep 5

# Unzip files
expand-archive .\didier_master.zip .\Dider_tools
expand-archive .\obfuscate_master.zip .\Obfuscate_tool
expand-archive .\revoke_master.zip .\Revoke-Obfuscation_tool
expand-archive .\bstrings.zip .\Zimmerman_tools
expand-archive .\EZViewer.zip .\Zimmerman_tools
expand-archive .\Sysmon.zip .\Sysmon

# Install Python 3
.\python_install.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

sleep 60

# Set Python paths
$Env:Path += ";c:\program files\python39;c:\program files\python39\scripts"
py --version

# Upgrade PIP
py -m pip install --upgrade pip

# Install Olefile
py -m pip install olefile

sleep 30

# Install Sysmon
move-item -path .\sysmonconfig-export.xml -destination .\sysmon
.\sysmon\sysmon.exe -accepteula -i .\sysmon\sysmonconfig-export.xml

# Clean up unneeded files.
remove-item .\python_install.exe
remove-item .\didier_master.zip
remove-item .\obfuscate_master.zip
remove-item .\revoke_master.zip
remove-item .\bstrings.zip
remove-item .\EZViewer.zip
remove-item .\Sysmon.zip
remove-item .\sysmon -recurse -force

cd C:\Users\WDAGUtilityAccount\Desktop\Dider_tools\DidierStevensSuite-master
write-host ""
write-host -foregroundcolor green "Didier Stevens Tools List: https://blog.didierstevens.com/my-software/"
write-host -foregroundcolor green "Didier Stevens Tools Example Below:"
write-host -foregroundcolor yellow "python .\oledump.py C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host -foregroundcolor yellow "python .\pdfid.py C:\Users\WDAGUtilityAccount\Desktop\Document.pdf"
write-host -foregroundcolor yellow " Hint: Look for a count greater than 0 in /JS, /JavaScript, and /Launch"
write-host -foregroundcolor yellow "python .\pdf-parser.py C:\Users\WDAGUtilityAccount\Desktop\Document.pdf"
write-host -foregroundcolor yellow " Hint: Look for code in the output"
write-host ""
start-process powershell

cd C:\Users\WDAGUtilityAccount\Desktop\Zimmerman_Tools
write-host -foregroundcolor green "BStrings.exe Example Below:"
write-host -foregroundcolor yellow ".\bstrings.exe -f C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host -foregroundcolor yellow ".\bstrings.exe --lr url3986 -f C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host -foregroundcolor yellow ".\bstrings.exe --lr ipv4 -f C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host -foregroundcolor yellow ".\bstrings.exe --lr email -f C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host -foregroundcolor yellow ".\bstrings.exe --lr reg_path -f C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host ""
start-process powershell

cd C:\Users\WDAGUtilityAccount\Desktop
invoke-webrequest "https://download.mozilla.org/?product=thunderbird-128.1.1esr-SSL&os=win64&lang=en-US" -outfile thunderbird.exe
.\thunderbird.exe /S

<#
cd C:\Users\WDAGUtilityAccount\Desktop\Obfuscate_tool\Invoke-Obfuscation-master
Set-ExecutionPolicy bypass
Import-Module ./Invoke-Obfuscation.psd1
Invoke-Obfuscation
#>

<#
cd C:\Users\WDAGUtilityAccount\Desktop\Revoke-Obfuscation_tool\Revoke-Obfuscation-master
Set-ExecutionPolicy bypass
Import-Module .\Revoke-Obfuscation.psd1
Revoke-Obfuscation
#>

