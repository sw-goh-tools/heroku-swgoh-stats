# Deploy SWGOH Stats to a hosting service
This repo is used to create a quick and easy way to deploy and update SWGOH Stats using GitHub.

SWGOH Stats was designed to calculate stats for units obtained from [SWGOH Comlink](https://github.com/swgoh-utils/swgoh-comlink) or any other API that can retrieve player data for Star Wars Galaxy of Heroes. Visit the main [SWGOH Stats repo](https://github.com/swgoh-utils/swgoh-stats) to learn more about what SWGOH Stats is and how to use it. If you are interested in using it with SWGOH Comlink or wouldlike to see more details on getting this working on specific hosting sites you can use the following link: [swgoh-utils/deploy-swgoh-comlink](https://github.com/swgoh-utils/deploy-swgoh-comlink).

### Limitations
SWGOH Stats requires a volume in order to save the updated gameData.json file. If you do not set up some type of storage option you must keep the application from going to sleep. 

It is highly recommended to create a separate account to use with SWGOH Stats especially if you are running it without a volume attached to it or on a free hosting plan.

Check out [Discord](https://discord.gg/Kwnrfwu2NP) for a list of free hosting providers that work decent with Comlink.

_
## GENERAL DEPLOY STEPS
#### 1. Create a GitHub account.

#### 2. Create a new private repository and copy the files from this repo into it.
If you Fork this repo it will remain public and others can see the app you have delpoyed it to. It is recommended that you copy these files to a private repo to keep others from using your service hours/resources.

#### 3. Create an account on the hosting service if you have not already and then navigate in their dashboard to where you can add a new application/dyno/service. Make sure to select Web Service for the application type.

#### 4. Choose to add the applictaion from Github, it could also be stated as Connect with Github. It is recommended to only give it access to specific repositories and to auto-deploy new updates when prompted. Some hosting providers may require you to do manual deploys for updates.

#### 5. Select your private fork of this repo. It should start the install automatically. After the install it will most likely fail starting up due to required Environment Variables.

#### 6. Navigate to the settings in that application that deal with environment variables. This could be stated as Reveal Config Vars, Configure Environment Variables, etc... 

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
If no data path is set the updated gameData file will be removed when the application goes to sleep.

#### 7. Once you have set the environment variables restart the application and verify in the logs that it started successfully. You may also check by clicking the link to the service.
