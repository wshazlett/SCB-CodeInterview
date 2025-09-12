# Because we may not always have the exact same file name or path to the txt file we'll setup an input parameter. Also we'll create an output folder where the new files will be created.

param(
	[Parameter(Mandatory = $true)]
	[string]$InputFile,
	
	[string]$OutputFolder = "C:\Output"
)

# Make sure the output folder exists. If not then create it.

if (-not (Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
}

# Get all two-letter ISO country codes
$countryCodes = [System.Globalization.CultureInfo]::GetCultures([System.Globalization.CultureTypes]::SpecificCultures) |
    ForEach-Object { (New-Object System.Globalization.RegionInfo $_.Name).TwoLetterISORegionName } |
    Sort-Object -Unique |
    Where-Object { $_ -match "^[A-Z]{2}$" }
	
	
# Setup our patterns to look for and store each pattern in a variable.
$Email = '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b'
$CountryCode = '(?:\b\.(' + ($countryCodes -join '|') + ')\b)'
$IPv4 = '\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b'
$IPv6 = '([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|:([0-9a-fA-F]{1,4}:){1,7}|fe80::([0-9a-fA-F]{0,4}:){0,4}%[0-9a-zA-Z]{1,}|::ffff:((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'
$tldPattern = '\.([a-z]{2,})(?:\/|$)'



#Read the txt file
$BlockList = Get-Content -Path $InputFile


#Process each search and create seperate files for each cattegory.
$EmailAddresses = (Select-String -InputObject $BlockList -Pattern $Email -AllMatches).Matches | ForEach-Object { $_.Value }
$UniqueEmailAddresses = $EmailAddresses | Select-Object -Unique | Out-File -FilePath "$OutputFolder\EmailAddresses.txt" -Encoding UTF8

$CountryCodes = (Select-String -InputObject $BlockList -pattern $CountryCode -AllMatches).Matches | ForEach-Object {$_.Value} | Out-File -FilePath "$OutputFolder\CountryCodes.txt" -Encoding UTF8

$IPv4Addresses = (Select-String -InputObject $BlockList -pattern $IPv4 -AllMatches).Matches | ForEach-Object {$_.Value} | Out-File -FilePath "$OutputFolder\IPv4Addresses.txt" -Encoding UTF8

$IPv6Addresses = (Select-String -InputObject $BlockList -pattern $IPv6 -AllMatches).Matches | ForEach-Object {$_.Value} | Out-File -FilePath "$OutputFolder\IPv6Addresses.txt" -Encoding UTF8