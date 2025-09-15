#Parameter for the folder path to output the data file.
param(
	[Parameter(Mandatory = $true, HelpMessage = "Enter the full path where the output files will be created.")]
	[string]$OutputFolder
)

# Make sure the output folder exists. If not then create it.

if (-not (Test-Path $OutputFolder)) {
    Write-Host "Creating Output folder."
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
}

# Create a folder for the log file in the output folder.

if (-not (Test-Path $OutputFolder\Logs)) {
    Write-Host "Creating Log folder."
    New-Item -ItemType Directory -Path $OutputFolder\Logs | Out-Null
}

$key="602264bd8ddae447b06a856f7c491b78"
$SeriesID = "TXNGSP"
$URI = "https://api.stlouisfed.org/fred/series/observations?api_key=$key&series_id=$SeriesID&file_type=json"
$maxRetries = 5
$retryDelaySeconds = 5

Start-Transcript -Path "$OutputFolder\Logs\FRED-API.log"

#Make the API call and retry if there is a rate limit error. Stop execution and dislay the status code on all other errors.
for ($i = 0; $i -lt $maxRetries; $i++) {

    try{
        $response = Invoke-RestMethod -Method Get -Uri $URI
	    Write-Host "Connection successful."
        break
        }
    
        catch [System.Net.WebException] {
            $statusCode = $_.Exception.Response.StatusCode.Value__
            #This is the error for a rate limit.
            if ($statusCode -eq 429) {
                Write-Warning "Rate limit exceeded. Retrying in $retryDelaySeconds seconds."
                Start-Sleep -Seconds $retryDelaySeconds
            } else {
                Write-Error "API call failed with status code: $statusCode"
                break # Exit loop on other errors
            }
    }
}


#Create the json data file.
$response.observations | Out-file $OutputFolder\Data.json
Stop-Transcript