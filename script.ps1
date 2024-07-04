### Install Azure CLI
 
# Download the Azure CLI installer
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
 
# Install Azure CLI silently
Start-Process msiexec.exe -Wait -ArgumentList '/i AzureCLI.msi /quiet'
 
# Clean up the downloaded installer
Remove-Item .\AzureCLI.msi
 
# Add Azure CLI installation directory to PATH
$env:Path += ";C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin"
 
Write-Output "Azure CLI installation complete."

### Install GIT
 
# get latest download url for git-for-windows 64-bit exe
$git_url = "https://api.github.com/repos/git-for-windows/git/releases/latest"
$asset = Invoke-RestMethod -Method Get -Uri $git_url | % assets | where name -like "*64-bit.exe"

# download installer
$installer = "$env:temp\$($asset.name)"
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $installer

# run installer
$git_install_inf = "<install inf file>"
$install_args = "/SP- /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL /NORESTART /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /LOADINF=""$git_install_inf"""
Start-Process -FilePath $installer -ArgumentList $install_args -Wait


### docker 

Install-Module -Name DockerMsftProvider -Repository PSGallery -Force

Install-Package -Name docker -ProviderName DockerMsftProvider -Force

Start-Service docker 
