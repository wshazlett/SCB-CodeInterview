# Because we may not always have the exact same file name or path to the txt file we'll setup an input parameter for the file. Also we'll prompt for an output folder where the new files will be created.

param(
	[Parameter(Mandatory = $true, HelpMessage = "Enter the full path to the input txt file.")]
	[string]$InputFile,
	[Parameter(Mandatory = $true, HelpMessage = "Enter the full path where the output files will be created.")]
	[string]$OutputFolder
)

# Make sure the output folder exists. If not then create it.

if (-not (Test-Path $OutputFolder)) {
    Write-Host "Creating Output folder."
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
}
	
	
# Setup our patterns to look for and store each pattern in a variable.
$Email = '^[a-zA-Z0-9-_%&+-]{1,}\@'
$CountryCode = '\*\.[a-zA-Z]{2}$'
$IPv4 = '^[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}$'
$IPv6 = '^[0-9a-fA-F]{1,}\:[0-9a-fA-F]{1,}\:[0-9a-fA-F]{1,}'
$subDomain = '^[a-zA-Z-]{1,}\.[a-zA-Z]{2,}|^\*\.[a-zA-Z-]{3,}|^\*\@'
$tld = '\*\.[a-zA-Z0-9]{3,}$'


#Process each search and create seperate files for each category.

$TotalLines = (Select-String '.*' -Path $InputFile).Count

Write-Host "Reading $TotalLines entries from $InputFile."

Select-String -Path $InputFile -pattern $Email | Select -ExpandProperty line | Out-File -FilePath "$OutputFolder\EmailAddresses.txt" -Encoding UTF8

Select-String -Path $InputFile -pattern $CountryCode | Select -ExpandProperty line | Out-File -FilePath "$OutputFolder\CountryCodes.txt" -Encoding UTF8

Select-String -Path $InputFile -pattern $IPv4 | Select -ExpandProperty line | Out-File -FilePath "$OutputFolder\IPv4Addresses.txt" -Encoding UTF8

Select-String -Path $InputFile -pattern $IPv6 | Select -ExpandProperty line | Out-File -FilePath "$OutputFolder\IPv6Addresses.txt" -Encoding UTF8

Select-String -Path $InputFile -pattern $subDomain | Select -ExpandProperty line | Out-File -FilePath "$OutputFolder\SubDomains.txt" -Encoding UTF8

Select-String -Path $InputFile -pattern $tld | Select -ExpandProperty line | Out-File -FilePath "$OutputFolder\TopLevelDomains.txt" -Encoding UTF8

$EmailMatch = (Get-Content -Path $OutputFolder\EmailAddresses.txt | Measure-Object -Line).Lines
Write-Host "Wrote $EmailMatch lines to EmailAddresses.txt."

$CountryCodeMatch = (Get-Content -Path $OutputFolder\CountryCodes.txt | Measure-Object -Line).Lines
Write-Host "Wrote $CountryCodeMatch lines to CountryCodes.txt."

$IPv4Match = (Get-Content -Path $OutputFolder\IPv4Addresses.txt | Measure-Object -Line).Lines
Write-Host "Wrote $IPv4Match lines to IPv4Addresses.txt."

$IPv6Match = (Get-Content -Path $OutputFolder\IPv6Addresses.txt | Measure-Object -Line).Lines
Write-Host "Wrote $IPv6Match lines to IPv6Addresses.txt."

$subDomainMatch = (Get-Content -Path $OutputFolder\SubDomains.txt | Measure-Object -Line).Lines
Write-Host "Wrote $subDomainMatch lines to SubDomains.txt."

$tldMatch = (Get-Content -Path $OutputFolder\TopLevelDomains.txt | Measure-Object -Line).Lines
Write-Host "Wrote $tldMatch lines to TopLevelDomains.txt."