# Define the directory where the base64 parts are stored
$directory = "C:\path\to\your\files"

# Define the pattern for the base64 part files (e.g., xaa, xab, etc.)
$pattern = "xa*"

# Define the output file for the combined base64
$combinedBase64File = "$directory\combined_base64.txt"

# Define the output file for the decoded binary data
$outputFile = "$directory\outputfile.bin"

# Combine all the base64 parts into one file
Get-ChildItem -Path $directory -Filter $pattern | Sort-Object Name | ForEach-Object {
    Get-Content $_.FullName | Out-File -FilePath $combinedBase64File -Append -Encoding ASCII
}

# Decode the combined base64 file into the original binary file
$base64Content = Get-Content -Path $combinedBase64File -Raw
[System.IO.File]::WriteAllBytes($outputFile, [System.Convert]::FromBase64String($base64Content))

Write-Host "Base64 decoding complete. The output file is located at $outputFile"
