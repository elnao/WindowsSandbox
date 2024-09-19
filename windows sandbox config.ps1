$internet_access = tnc -InformationLevel Quiet

$ProgressPreference = 'SilentlyContinue'
cd C:\Users\WDAGUtilityAccount\Desktop

if ($internet_access)
{
    # Download files
    invoke-webrequest https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe -outfile python_install.exe
    invoke-webrequest https://github.com/DidierStevens/DidierStevensSuite/archive/refs/heads/master.zip -outfile didier_master.zip
    # invoke-webrequest https://github.com/danielbohannon/Invoke-Obfuscation/archive/refs/heads/master.zip -OutFile obfuscate_master.zip
    # invoke-WebRequest https://github.com/danielbohannon/Revoke-Obfuscation/archive/refs/heads/master.zip -OutFile revoke_master.zip
    invoke-webrequest https://download.mikestammer.com/bstrings.zip -OutFile bstrings.zip
    invoke-webrequest https://download.mikestammer.com/net6/EZViewer.zip -OutFile EZViewer.zip
    invoke-webrequest https://download.sysinternals.com/files/Sysmon.zip -Outfile Sysmon.zip
    invoke-webrequest https://raw.githubusercontent.com/Neo23x0/sysmon-config/master/sysmonconfig-export.xml -OutFile sysmonconfig-export.xml

    sleep 5
}
else
{
    cd C:\Users\WDAGUtilityAccount\Desktop\WindowsSandbox
    Copy-Item *.zip,*.exe,*.xml C:\Users\WDAGUtilityAccount\Desktop\
}

# Unzip files
cd C:\Users\WDAGUtilityAccount\Desktop
expand-archive olefile-master.zip .\olefile
expand-archive .\didier_master.zip .\Dider_tools
# expand-archive .\obfuscate_master.zip .\Obfuscate_tool
# expand-archive .\revoke_master.zip .\Revoke-Obfuscation_tool
expand-archive .\bstrings.zip .\Zimmerman_tools
expand-archive .\EZViewer.zip .\Zimmerman_tools
expand-archive .\Sysmon.zip .\Sysmon

# Install Python 3
.\python_install.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

sleep 60

# Set Python paths
$Env:Path += ";c:\program files\python39;c:\program files\python39\scripts"
py --version

if ($internet_access)
{
    # Upgrade PIP
    py -m pip install --upgrade pip

    # Install Olefile
    py -m pip install olefile

    sleep 30
}
else
{
    # Install Olefile
    cd C:\Users\WDAGUtilityAccount\Desktop\olefile\olefile-master
    python setup.py install
}

cd C:\Users\WDAGUtilityAccount\Desktop

# Install Sysmon
move-item -path .\sysmonconfig-export.xml -destination .\sysmon
.\sysmon\sysmon.exe -accepteula -i .\sysmon\sysmonconfig-export.xml

# Clean up unneeded files.
remove-item .\python_install.exe
remove-item .\didier_master.zip
# remove-item .\obfuscate_master.zip
# remove-item .\revoke_master.zip
remove-item .\bstrings.zip
remove-item .\EZViewer.zip
remove-item .\Sysmon.zip
remove-item .\sysmon -recurse -force
remove-item .\olefile-master.zip
remove-item .\olefile -recurse -force

cd C:\Users\WDAGUtilityAccount\Desktop\Dider_tools\DidierStevensSuite-master
write-host ""
write-host -foregroundcolor green "Didier Stevens Tools List: https://blog.didierstevens.com/my-software/"
write-host -foregroundcolor green "Didier Stevens Tools Examples Below:"
write-host -foregroundcolor green "--OFFICE DOCUMENT--"
write-host -foregroundcolor yellow "python .\oledump.py C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host -foregroundcolor darkyellow " Hint: if any of the streams have M next to them, that indicates a VBA macro"
write-host -foregroundcolor yellow "python .\oledump.py -M C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host -foregroundcolor darkyellow " Hint: above command displays file metadata"
write-host -foregroundcolor green "--EMAIL MSG FILE--"
write-host -foregroundcolor yellow "python .\oledump.py -q -p plugin_msg_summary.py C:\Users\WDAGUtilityAccount\Desktop\email.msg"
write-host -foregroundcolor darkyellow " Hint: above command parses email files"
write-host -foregroundcolor green "--PDF DOCUMENT--"
write-host -foregroundcolor yellow "python .\pdfid.py C:\Users\WDAGUtilityAccount\Desktop\Document.pdf"
write-host -foregroundcolor darkyellow " Hint: Look for a count greater than 0 in /JS, /JavaScript, /Launch, or /OpenAction"
write-host -foregroundcolor red " Hint: If a number apprears in parenthesis, that item is probably obfuscated"
write-host -foregroundcolor yellow "python .\pdf-parser.py -s javascript C:\Users\WDAGUtilityAccount\Desktop\Document.pdf"
write-host -foregroundcolor darkyellow " Hint: above command searches for javascript"
write-host -foregroundcolor yellow "python .\pdf-parser.py -o <object number> -f C:\Users\WDAGUtilityAccount\Desktop\Document.pdf"
write-host -foregroundcolor darkyellow " Hint: above line applies filter to the object you found that contains javascript"
write-host -foregroundcolor yellow "python .\pdf-parser.py -s uri C:\Users\WDAGUtilityAccount\Desktop\Document.pdf"
write-host -foregroundcolor darkyellow " Hint: above command searches URLs or email addresses"
write-host ""
start-process powershell -ArgumentList '-noexit -noprofile -command $host.ui.rawui.windowtitle=\"Didier Tools\"'

cd C:\Users\WDAGUtilityAccount\Desktop\Zimmerman_Tools
write-host -foregroundcolor green "BStrings.exe Example Below:"
write-host -foregroundcolor yellow ".\bstrings.exe -f C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host -foregroundcolor yellow ".\bstrings.exe --lr url3986 -f C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host -foregroundcolor yellow ".\bstrings.exe --lr ipv4 -f C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host -foregroundcolor yellow ".\bstrings.exe --lr email -f C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host -foregroundcolor yellow ".\bstrings.exe --lr reg_path -f C:\Users\WDAGUtilityAccount\Desktop\Document.docx"
write-host ""
start-process powershell -ArgumentList '-noexit -noprofile -command $host.ui.rawui.windowtitle=\"Zimmerman Tools\"'

if ($internet_access)
{
    # Download Thunderbird
    cd C:\Users\WDAGUtilityAccount\Desktop
    invoke-webrequest "https://download.mozilla.org/?product=thunderbird-128.1.1esr-SSL&os=win64&lang=en-US" -outfile thunderbird.exe
    
    # Download .Net 6
    Invoke-webrequest "https://download.visualstudio.microsoft.com/download/pr/61881ecd-a425-4053-a420-7f76586d2f60/6daf1af8c05df332eb1c53261fafc07f/dotnet-sdk-6.0.425-win-x64.exe" -outfile dotnet6.exe
    
}

cd C:\Users\WDAGUtilityAccount\Desktop

# Install Thunderbird
.\thunderbird.exe /S

# Install Dot Net 6
.\dotnet6.exe /install /quiet /norestart



# Remove Thunderbird and dot net 6 install files
sleep 120
remove-item .\thunderbird.exe
remove-item .\dotnet6.exe

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

