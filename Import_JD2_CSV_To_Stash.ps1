
$StashGQL_URL = "http://localhost:9999/graphql"

 <#
---Import CSV to Stash PoSH script 0.2---

AUTHOR
    JuiceBox
URL 
    https://github.com/ALonelyJuicebox/JDownloader-Metadata-To-Stash

DESCRIPTION
    Imports CSV files made with my JD2 script into stash. 

REQUIREMENTS
    Powershell Core
 #>


Import-Module PSGraphQL

clear-host
write-host "Import CSV to Stash" -ForegroundColor Cyan
write-host "By JuiceBox`n-"
write-host "`nQuick Tips:"
write-host "    * The filename/filesize must match what's defined in your .csv files."
write-host "    * Make sure you are using this JDownloader2 script to generate .csv files."
write-host "      https://github.com/ALonelyJuicebox/JD2_WriteInfoCSV"


if($IsWindows){
    read-host "`n-`nPress [Enter] to select the folder that contains your .csv files"
    Add-Type -AssemblyName System.Windows.Forms
    $FileBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $null = $FileBrowser.ShowDialog()
    $pathtovideofiles  = $FileBrowser.SelectedPath
}
else{
    $pathtovideofiles = read-host "What folder are your CSV files in?"
}
if (!(Test-Path $pathtovideofiles)){
    write-host "Whoops, that folder does not seem to exist."
    read-host "Press [Enter] to exit. "
    exit
}
write-host "OK, we'll use the following path:"
write-host $pathtovideofiles
read-host "`nPress [Enter] to begin"

$successcounter = 0
$skipcounter = 0
$missingcounter = 0
$progressCounter = 1 #Used for the progress UI

$allcsvfiles = Get-ChildItem -Path $pathtovideofiles -recurse -Include '*.csv' -File 

#Let's iterate through all discovered CSV files
foreach ($currentcsvfile in $allcsvfiles){

    #Let's help the user see how we are progressing
    $currentProgress = [int]$(($progressCounter/$allcsvfiles.length)*100)
    Write-Progress -parentId 1 -Activity "CSV Import Progress" -Status "$currentProgress% Complete" -PercentComplete $currentProgress
    $progressCounter++


    #We'll use the import-csv cmdlet to parse the csv files. Since they don't come with headers, we'll define them ourselves
    $currentcsv = Import-Csv $currentcsvfile -header 'filepath','filesize','url'

    #Each csv file may contain more than one file. For that reason, we'll iterate through each row in the CSV file as well.
    foreach ($csv_row in $currentcsv){
        $currentfilepath = $csv_row.filepath 
        $currentfilesize = $csv_row.filesize
        $currenturlfromcsv = $csv_row.url

        $StashGQL_Query = 'mutation {
            querySQL(sql: "SELECT files.basename, files.size, files.id AS files_id, scenes.id AS scenes_id FROM files JOIN scenes_files ON files.id = scenes_files.file_id JOIN scenes ON scenes.id = scenes_files.scene_id WHERE files.basename ='''+$currentfilepath+''' AND size = '''+$currentfilesize+'''") {
            rows
        }
        }'

        try{ 
            $StashGQL_Result = Invoke-GraphQLQuery -Query $StashGQL_Query -Uri $StashGQL_URL -Headers $(if ($StashAPIKey){ @{ApiKey = "$StashAPIKey" }})
        }
        catch{
            write-host "(1) Error: There was an issue with the GraphQL query/mutation." -ForegroundColor red
            write-host "Additional Error Info: `n`n$StashGQL_Query `n$StashGQL_QueryVariables"
            read-host "Press [Enter] to exit" 
            exit
        }

        
        #If there is a match in Stash, let's check to see if this URL is already in Stash for this scene
        if($StashGQL_Result.data.querySQL.rows){
            $CurrentSceneID = $StashGQL_Result.data.querySQL.rows[0][3]

            $StashGQL_Query = 'query FindScene($id: ID!) {
                findScene(id: $id) {
                  urls
                }
              }'

            $StashGQL_QueryVariables = '{"id":"'+$CurrentSceneID+'"}'

            try{
                $existingURLs = Invoke-GraphQLQuery -Headers $(if ($StashAPIKey){ @{ApiKey = "$StashAPIKey" }}) -Query $StashGQL_Query -Uri $StashGQL_URL -Variables $StashGQL_QueryVariables -escapehandling EscapeNonAscii
                $existingURLs = $existingURLs.data.findScene.urls
            }
            catch{
                write-host "(2) Error: There was an issue with the GraphQL query/mutation." -ForegroundColor red
                write-host "Additional Error Info: `n`n$StashGQL_Query `n$StashGQL_QueryVariables"
                read-host "Press [Enter] to exit" 
                exit
            }

            #We use the skipscene variable to store information on whether or not this scene can be skipped based on whether or not the URL is already in stash
            $skipscene = $false
            foreach ($url in $existingURLs){
                if($url -eq $currenturlfromcsv){
                    $skipscene = $true
                    $skipcounter++
                }
            }

            #Alright, this scene doesn't have an URL. Let's run a GQL query to add it.
            if($skipscene -eq $false){
                $StashGQL_Query = 'mutation sceneUpdate($sceneUpdateInput: SceneUpdateInput!){
                    sceneUpdate(input: $sceneUpdateInput){
                        id
                        urls
                    }
                    }'  
                $StashGQL_QueryVariables = '{
                    "sceneUpdateInput": {
                        "id": "'+$CurrentSceneID+'",
                        "urls": "'+$currenturlfromcsv+'"
                    }
                }'

                try{
                    Invoke-GraphQLQuery -Headers $(if ($StashAPIKey){ @{ApiKey = "$StashAPIKey" }}) -Query $StashGQL_Query -Uri $StashGQL_URL -Variables $StashGQL_QueryVariables -escapehandling EscapeNonAscii | out-null
                }
                catch{
                    write-host "(3) Error: There was an issue with the GraphQL query/mutation." -ForegroundColor red
                    write-host "Additional Error Info: `n`n$StashGQL_Query `n$StashGQL_QueryVariables"
                    read-host "Press [Enter] to exit" 
                    exit
                }
                $successcounter++
            }
        }
        
        #Otherwise if there is no match we just iterate a counter and keep it pushing.
        else{
            $missingcounter++
        }
    }
}


            
write-host "`n-- Results --"
if($successcounter -gt 0){
    write-host "+ $successcounter scenes had an URL added to Stash" -ForegroundColor Cyan
}
if($missingcounter -gt 0){
    write-host "- $missingcounter scenes couldn't be found in Stash."
}
if($skipcounter -gt 0){
    write-host "- $skipcounter scenes already had a matching URL"
}









        