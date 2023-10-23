
# [INFO] About User Attributes ===========================================================
#
# -Name: The full name of the user.
# -GivenName: First name.
# -Suranem: Last name
# -SamAccountName: this is username it think. It is unique identifier for a user account
# -UserPrincipalName: account identifier in AD in the format of an email address
# -Path: name of the target OU in format like (OU=IT,DC=foo,DC=local)
# -AccountPassword: just password
# -Enabled: I should set it to $true to enable the user account 
# ========================================================================================

Import-Module ActiveDirectory

$csvFilePath="PUT HERE PATH TO YOUR CSV FILE WHERE THE ORDER OF DATA IS SAME AS BELOW HEADERS!"
$headers = "Name", "GivenName", "Surname", "SamAccountName", "UserPrincipalName", "OU", "AccountPassword"

$users = Import-Csv -Path $csvFilePath -Delimiter "," -Header $headers

foreach($user in $users) {

    $name = $user.Name
    $givenName = $user.GivenName
    $surname = $user.Surname
    $samAccountName = $user.SamAccountName
    $userPrincipalName = $user.UserPrincipalName
    $ou = $user.OU
    $accountPassword = $user.AccountPassword

    # ========================================================================================
    # Create New User
    # ---> P.S. Backtick (`) is a line-continuation character in PowerShell.
    # ========================================================================================
    New-ADUser `
    -Name $name `
    -GivenName $givenName `
    -Surname $surname `
    -SamAccountName $samAccountName `
    -UserPrincipalName $userPrincipalName `
    -Path "OU=$ou,DC=foo,DC=local" `
    -AccountPassword (ConvertTo-SecureString -AsPlainText $accountPassword -Force) `
    -Enabled $true
}
