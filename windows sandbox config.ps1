$ProgressPreference = 'SilentlyContinue'
cd C:\Users\WDAGUtilityAccount\Desktop

# Download files
invoke-webrequest https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe -outfile python_install.exe
invoke-webrequest https://github.com/DidierStevens/DidierStevensSuite/archive/refs/heads/master.zip -outfile didier_master.zip
invoke-webrequest https://github.com/danielbohannon/Invoke-Obfuscation/archive/refs/heads/master.zip -OutFile obfuscate_master.zip
Invoke-WebRequest https://github.com/danielbohannon/Revoke-Obfuscation/archive/refs/heads/master.zip -OutFile revoke_master.zip
invoke-webrequest https://download.mikestammer.com/bstrings.zip -OutFile bstrings.zip
invoke-webrequest https://download.mikestammer.com/net6/EZViewer.zip -OutFile EZViewer.zip

sleep 5

# Unzip files
expand-archive .\didier_master.zip .\Dider_tools
expand-archive .\obfuscate_master.zip .\Obfuscate_tool
expand-archive .\revoke_master.zip .\Revoke-Obfuscation_tool
expand-archive .\bstrings.zip .\Zimmerman_tools
expand-archive .\EZViewer.zip .\Zimmerman_tools

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

# Clean up unneeded files.
remove-item .\python_install.exe
remove-item .\didier_master.zip
remove-item .\obfuscate_master.zip
remove-item .\revoke_master.zip
remove-item .\bstrings.zip
remove-item .\EZViewer.zip

cd C:\Users\WDAGUtilityAccount\Desktop\Dider_tools\DidierStevensSuite-master
write-host -forgroundcolor green "Didier Stevens Tools: https://blog.didierstevens.com/my-software/"
write-host -foregroundcolor green "OLEDump.py Example Below:"
write-host -foregroundcolor yellow "python .\oledump.py C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
start-process powershell

cd C:\Users\WDAGUtilityAccount\Desktop\Zimmerman_Tools
write-host -foregroundcolor green "BStrings.exe Example Below:"
write-host -foregroundcolor yellow ".\bstrings.exe -f C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
start-process powershell

cd C:\Users\WDAGUtilityAccount\Desktop
invoke-webrequest "https://download.mozilla.org/?product=thunderbird-128.1.1esr-SSL&os=win64&lang=en-US" -outfile thunderbird.exe
.\thunderbird.exe /q

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

