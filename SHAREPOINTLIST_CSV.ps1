# To execute the script without agreeing with the execution policy
Set-ExecutionPolicy Bypass -Scope Process

# Import the Sharepoint Online module
Import-Module SharePointPnPPowerShellOnline

# Sharepoint website URL that will connect
# The URL can be something like https://example.sharepoint.com/sites/BI
$SiteURL = "Your-URL"

# List name that will get the list items
$ListName = "Your-List-Name"

# Email to connect to Sharepoint
$UserName = "Your-Email"

# Password from your email to connect to Sharepoint
$Password = "Your-Password"

# Connects to the Sharepoint service
$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName,(ConvertTo-SecureString $Password -AsPlainText -Force))
$creds = (New-Object System.Management.Automation.PSCredential $UserName,(ConvertTo-SecureString $Password -AsPlainText -Force))

# Connect to the PNP module using the variables previously informed
Connect-PnPOnline -Url $SiteURL -Credentials $creds

# Variable to define the columns belonging to the list
$ListItems = Get-PnPListItem -List $ListName -Fields "Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8"

# Variable to save the final result
$results = @()

# Loop for each item, get the data from the column below
foreach($ListItem in $ListItems)
{ 

            $results += New-Object psobject -Property @{
                RenamedColumn1  = $ListItem["Column1"]
                RenamedColumn2  = $ListItem["Column2"]
                RenamedColumn3  = $ListItem["Column3"]
                RenamedColumn4  = $ListItem["Column4"]
                RenamedColumn5  = $ListItem["Column5"]
                RenamedColumn6  = $ListItem["Column6"]
                RenamedColumn7  = $ListItem["Column7"]
                RenamedColumn8  = $ListItem["Column8"]
            }
}

# Defines the directory and name of the file to be exported to the CSV file
$Dir = "YOUR_DIR\SHAREPOINTLIST_CSV.csv"

# Exports the result to the CSV file in the directory informed above
$results |
    Select-Object "RenamedColumn1", "RenamedColumn2", "RenamedColumn3", "RenamedColumn4", "RenamedColumn5", "RenamedColumn6", "RenamedColumn7", "RenamedColumn8" |
    Export-Csv -Path $Dir -NoTypeInformation -Encoding UTF8

# Disconnects from PnP module
Disconnect-PnPOnline