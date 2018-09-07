$displayName = "John Smith"
$firstName = $displayName.Split(' ')[0]
$lastName = $displayName.Split(' ')[1]
New-ADUser -Name ($firstName + ' ' + $lastName) `
    -AccountPassword (ConvertTo-SecureString -AsPlainText -Force -String "P@ssword1") `
    -SamAccountName ($firstName.ToLower() + '.' + $lastName.ToLower()) `
    -DisplayName ($firstName + ' ' + $lastName) `
    -EmailAddress  ($firstName.ToLower() + '.' + $lastName.ToLower() + '@cashrewards.com')`
    -Enabled $True `
    -GivenName $firstName `
    -PassThru `
    -Path "OU=Technical,OU=Users,OU=Cashrewards,DC=awsad,DC=internal,DC=cashrewards,DC=com" `
    -PasswordNeverExpires $True `
    -Surname $lastName `
    -UserPrincipalName  ($firstName.ToLower() + '.' + $lastName.ToLower() + '@awsad.internal.cashrewards.com')
Add-ADGroupMember -Identity CR-VPN2 -Members ($firstName.ToLower() + '.' + $lastName.ToLower())