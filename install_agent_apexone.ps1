# Define the URL for the agent executable
$agentUrl = "https://api-us1.xbc.trendmicro.com/api/public/download_xbc_agent/v1.0/faa9a5bd-b3d8-4a3d-9184-78736ce35c22"

# Define the path where the executable will be saved
$downloadPath = "$env:TEMP\xbc_agent_installer.exe"

# Download the agent executable
Invoke-WebRequest -Uri $agentUrl -OutFile $downloadPath

# Check if the download was successful
if (Test-Path $downloadPath) {
    Write-Host "Download completed successfully. Installing the agent..."

    # Run the installer
    Start-Process -FilePath $downloadPath -ArgumentList '/quiet' -Wait

    # Check if the installation was successful
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Agent installed successfully."
    } else {
        Write-Host "Installation failed with exit code: $LASTEXITCODE."
    }
} else {
    Write-Host "Download failed. Please check the URL and try again."
}

# Optionally, you can remove the installer after installation
Remove-Item $downloadPath -Force
