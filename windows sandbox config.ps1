
$ProgressPreference = 'SilentlyContinue'
invoke-webrequest https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe -outfile python_install.exe
invoke-webrequest https://github.com/DidierStevens/DidierStevensSuite/archive/refs/heads/master.zip -outfile didier_master.zip
invoke-webrequest https://github.com/danielbohannon/Invoke-Obfuscation/archive/refs/heads/master.zip -OutFile obfuscate_master.zip
sleep 5
expand-archive .\didier_master.zip
expand-archive .\obfuscate_master.zip
.\python_install.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
sleep 60
$Env:Path += ";c:\program files\python39;c:\program files\python39\scripts"
py --version
py -m pip install --upgrade pip
py -m pip install olefile


sleep 30
remove-item .\python_install.exe
remove-item .\didier_master.zip
remove-item .\obfuscate_master.zip
cd C:\Users\WDAGUtilityAccount\Desktop\didier_master\DidierStevensSuite-master
start powershell
cd C:\Users\WDAGUtilityAccount\Desktop\obfuscate_master\Invoke-Obfuscation-master
Set-ExecutionPolicy bypass

Import-Module ./Invoke-Obfuscation.psd1
Invoke-Obfuscation

