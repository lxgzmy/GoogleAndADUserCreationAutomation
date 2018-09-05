#!/bin/sh

firstName=$1
lastName=$2
displayName="$firstName $lastName"
dotCat="$firstName.$lastName"
lowercase=$(echo "$dotCat" | tr '[:upper:]' '[:lower:]')
email="$lowercase@cashrewards.com"

echo $email
echo $displayName
echo $lowercase

/Users/jason.liu/bin/gam/gam delete user $email

replaceText="replaceText"

#echo $powerShell 
sed -i -e "s/${replaceText}/${displayName}/g" powerShellDeleteTemplate.json

#cat powerShellDeleteTemplate.json

aws ssm send-command --document-name "AWS-RunPowerShellScript" --document-version "\$DEFAULT" --targets "Key=instanceids,Values=i-0007a190dbe1ad5a7" --parameters file://powerShellDeleteTemplate.json  --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --region ap-southeast-2 --profile crtool

sed -i -e "s/${displayName}/${replaceText}/g" powerShellDeleteTemplate.json

ssh -t cr-syd-dc1 ".\DeleteUser.ps1 -displayName '${displayName}'"