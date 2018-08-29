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

/Users/jason.liu/bin/gam/gam create user $email firstname $firstName  lastname $lastName password "P@ssword1" changepassword off
/Users/jason.liu/bin/gam/gam update group 2million@cashrewards.com add member user $email
/Users/jason.liu/bin/gam/gam update group jira-users@cashrewards.com add member user $email
/Users/jason.liu/bin/gam/gam update group slack-users@cashrewards.com add member user $email

/Users/jason.liu/bin/gam/gam update user $email \
    SSO.role multivalued arn:aws:iam::752830773963:role/dev-saml-Developer,arn:aws:iam::752830773963:saml-provider/Google \
    SSO.role multivalued arn:aws:iam::356724879491:role/prod-saml-Developer,arn:aws:iam::356724879491:saml-provider/Google 

replaceText="replaceText"

#echo $powerShell 
sed -i -e "s/${replaceText}/${displayName}/g" powerShellTemplate.json

#cat powerShellTemplate.json

aws ssm send-command --document-name "AWS-RunPowerShellScript" --document-version "\$DEFAULT" --targets "Key=instanceids,Values=i-0007a190dbe1ad5a7" --parameters file://powerShellTemplate.json  --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --region ap-southeast-2 --profile crtool

sed -i -e "s/${displayName}/${replaceText}/g" powerShellTemplate.json

ssh -t cr-syd-dc1 ".\CreateUsers.ps1 -displayName '${displayName}'"