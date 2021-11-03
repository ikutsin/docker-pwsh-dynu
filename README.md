# Docker Powershell Dynu IP update

Dynu - Dynamic DNS. Automaic IP update in docker container.

You can find many implementations of the updater in the internet. My aim was to improve my knowledge on PowerShell7 + Docker stack.

PowerShell choice makes is compatible with wider range of platforms.

## Some features

* In testing stage, makes it possible to validate your config (**.env** and **Dynu** account) before running the container.
* Does not send the update if IP have not changed.
* Health check, to make sure that all is good.
* Alpine based so have small size.

## Setup

* Use `.env-sample` as a base of your `.env` config. There are some links to help you understand what goes where.
* `docker-compose -f docker-compose.yml -f docker-compose.tests.yml up -build` to run tests. 
* `docker-compose -f docker-compose.yml up -d -build` to install. 

## Environment Variables



| Environment Variable | Example  | Purpose | 
|----------------------|----------|---------|
| DYNU_USERNAME        | username | your login name in dynu.com |
| DYNU_DOMAIN          | myhome.accesscam.org | your login name in dynu.com |
| DYNU_PASSWORD        | mySecret | your login name in dynu.com |
| DYNU_APIKEY          | a6De5034 | REST API KEY for dynu.com |
| DYNU_SLEEP           | 120      | sleep seconds between checks |

Allthrough DYNU_APIKEY is only used for validation, all variables are mandatory.

