#!/usr/bin/env pwsh

Invoke-Command -HostName CR-SYD-DC1 -FilePath ./createUserOnPremisDomain.ps1 -ArgumentList $1