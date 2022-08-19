# Deploy SWGOH Stats to Heroku
This repo is used to create a quick and easy way to deploy and update SWGOH Stats on Heroku using GitHub.

SWGOH Stats was designed to calculate stats for units obtained from [SWGOH Comlink](https://gitlab.com/swgoh-tools/swgoh-comlink) or any other API that can retrieve player data for Star Wars Galaxy of Heroes. Visit the main [SWGOH Stats repo on GitLab](https://gitlab.com/swgoh-tools/swgoh-stats) to learn more about what SWGOH Stats is and how to use it. If you are interested in using it with SWGOH Comlink you can use the following link to quickly set it up on Heroku: [swgoh-utils/heroku-swgoh-comlink](https://github.com/swgoh-utils/heroku-swgoh-comlink).

### Limitations
The free version of Heroku is limited on how much data it can deliver at one time. This is mainly an issue when connecting to a SWGOH Comlink on Heroku so additional steps may need to be taken.

SWGOH Stats requires a volume in order to save the updated gameData.json file. If you do not set up some type of storage option you must keep the Dyno it is on from going to sleep. You only get 500 hours for using SWGOH Comlink each month, so you must add a credit card to your account to increase it to 900 hours which would allow for it to run 24/7 if needed. Once a credit card has been provided you can search for a free [Heroku Add-on](https://elements.heroku.com/addons/) that will continuously keep your dyno awake. [New Relic APM](https://elements.heroku.com/addons/newrelic) is a good option to try.

It is highly recommended to create a separate Heroku account to use with SWGOH Stats especially if you are running it without a volume attached to it.

## Deploy steps
#### 1. Click the button below.
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://dashboard.heroku.com/new?button-url=https%3A%2F%2Fgithub.com%2Fswgoh-utils%2Fheroku-swgoh-stats&template=https%3A%2F%2Fgithub.com%2Fswgoh-utils%2Fheroku-swgoh-stats)

#### 2. Create the application with a unique name and press `Deploy app` button.

#### 3. Once deployed press `Manage App` button under the installation log window.

#### 4. Go to the Settings tab.

#### 5. Press `Reveal Config Vars` button in the Config Vars section and set environment variables.

##### Environment variables:

|Variable Name| Description                             | Notes |
|-------------|-----------------------------------------|------ |
|`CLIENT_URL` | the location of the api used to update the gameData file for new units  | Required |
|`ACCESS_KEY`| your "public" key | Optional, Recommended |
|`SECRET_KEY` | your "private" key | Optional, Recommended |
|`DATA_PATH` | the volume location to save gameData file to | Optional |
|`UPDATE_INTERVAL`| The number of minutes the client should be checked for new units. Default is 5 minutes | Optional |
|`USE_SEGMENTS` | Requests Comlink to provide the data files in segments. Must be set to true | Comlink=Required, already set at install |
|`USE_UNZIP` | Requests the localization file stay zipped from Comlink. Must be set to false | Comlink=Required, already set at install |

Setting an access key and secret key will keep unauthorized users from using your app.\
If no data path is set the updated gameData file will be removed when the Dyno goes to sleep.

#### 6. Check to see if the Dyno is running by going to the `Overview Tab` and seeing if it is listed as On under Dyno formation. If it is not, activate it under the `Resources tab` by clicking the slide bar to the right of it.

#### 7. Check logs for any errors by going to `More -> View logs` located in the top right corner of the page.


## Updating SWGOH Stats for new releases
SWGOH Stats is not likely to be updated often, however, if you would like to have an easy way to update it you can follow the steps below:

#### 1. Create a GitHub account.

#### 2. Fork this repository or copy the files from this repo into a new private repo.
If you Fork this repo it will remain public and others can see the app you have delpoyed it to. It is recommended that you copy these files to a private repo to keep others from using your Dyno hours.

#### 3. In your Heroku account for this Dyno go to `Deploy`

#### 4. Select `GitHub` as your deployment method and enter your login credentials in `Connect to GIthub`

#### 5. Search for the name of the forked repo and select Connect

#### 6. Any time the version of SWGOH Stats needs to be updated, go down to the `Manual Deploy` section on the `Deploy`screen, choose the branch and the click `Deploy Branch`
