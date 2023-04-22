# Deploy SWGOH Stats to a hosting service

This repo is used to create a quick and easy way to deploy and update SWGOH Stats using GitHub.

SWGOH Stats was designed to calculate stats for units obtained from [SWGOH Comlink](https://github.com/swgoh-utils/swgoh-comlink) or any other API that can retrieve player data for Star Wars Galaxy of Heroes. Visit the main [SWGOH Stats repo](https://github.com/swgoh-utils/swgoh-stats) to learn more about what SWGOH Stats is and how to use it. If you are interested in using it with SWGOH Comlink or wouldlike to see more details on getting this working on specific hosting sites you can use the following link: [swgoh-utils/deploy-swgoh-comlink](https://github.com/swgoh-utils/deploy-swgoh-comlink).

### Limitations

SWGOH Stats requires a volume in order to save the updated gameData.json file. If you do not set up some type of storage option you must keep the application from going to sleep.

It is highly recommended to create a separate account to use with SWGOH Stats especially if you are running it without a volume attached to it or on a free hosting plan.

Check out [Discord](https://discord.gg/Kwnrfwu2NP) for a list of free hosting providers that work decent with Comlink.

\_

## GENERAL DEPLOY STEPS

#### 1. Create a GitHub account.

#### 2. Create a new private repository and copy the files from this repo into it.

If you Fork this repo it will remain public and others can see the app you have delpoyed it to. It is recommended that you copy these files to a private repo to keep others from using your service hours/resources.

#### 3. Create an account on the hosting service if you have not already and then navigate in their dashboard to where you can add a new application/dyno/service. Make sure to select Web Service for the application type.

#### 4. Choose to add the applictaion from Github, it could also be stated as Connect with Github. It is recommended to only give it access to specific repositories and to auto-deploy new updates when prompted. Some hosting providers may require you to do manual deploys for updates.

#### 5. Select your private fork of this repo. It should start the install automatically. After the install it will most likely fail starting up due to required Environment Variables.

#### 6. Navigate to the settings in that application that deal with environment variables. This could be stated as Reveal Config Vars, Configure Environment Variables, etc...

##### Environment variables:

| Variable Name     | Description                                                                            | Notes                                    |
| ----------------- | -------------------------------------------------------------------------------------- | ---------------------------------------- |
| `CLIENT_URL`      | the location of the api used to update the gameData file for new units                 | Required                                 |
| `ACCESS_KEY`      | your "public" key                                                                      | Optional, Recommended                    |
| `SECRET_KEY`      | your "private" key                                                                     | Optional, Recommended                    |
| `DATA_PATH`       | the volume location to save gameData file to                                           | Optional                                 |
| `UPDATE_INTERVAL` | The number of minutes the client should be checked for new units. Default is 5 minutes | Optional                                 |
| `USE_SEGMENTS`    | Requests Comlink to provide the data files in segments. Must be set to true            | Comlink=Required, already set at install |
| `USE_UNZIP`       | Requests the localization file stay zipped from Comlink. Must be set to false          | Comlink=Required, already set at install |

Setting an access key and secret key will keep unauthorized users from using your app.\
If no data path is set the updated gameData file will be removed when the application goes to sleep.

#### 7. Once you have set the environment variables restart the application and verify in the logs that it started successfully. You may also check by clicking the link to the service.

### Deploying with Railway (railway.app)

NOTE: These instructions assume you have a working, publicly available instance of Comlink running. You will need the web URL or IP address of that instance to set up SWGOH Stats. If you need to set up a comlink instance, you may also use [deploy-swgoh-comlink](https://github.com/swgoh-utils/swgoh-comlink) - there is a guide there for deploying to Railway as well!

1. Download a copy of the files in this repository to your local machine; unzip the download and grab the `Dockerfile` and the `app.json` file (For simplicity, you can discard the README and heroku.yml files if you like.)

2. Create a new private GitHub repository, and upload the `Dockerfile` and `app.json` files you downloaded.

3. In the Railway Dashboard, create a new Project (with whatever name you choose) and enter the project.

4. Inside the project, click the `+ New` button in the top right, and select `GitHub Repo` --> `Configure GitHub App`, and log into your GitHub account

5. Under `Repository Access`, select `Only select repositories`, then use the dropdown to select the stats repository you created. Click the green `Save` button and exit the pop up window.

6. In your Railway project, click `+ New` again, then `GitHub Repo`, then the name of the repository you created. A new deployment with a random name will appear in the Project window.

7. Once the deployment shows a green check mark, click the deployment to enter the settings window. In the `Deployments` tab, click the `View Logs` button on the right side. If the build was successful, you'll see a version of the following message in the Deploy Logs window:

> swgoh-stats:1.3.0 is listening on port 5804 for swgoh stat requests.
> Unable to check for updates for swgoh-stats on startup: connect ECONNREFUSED 127.0.0.1:3000

8. Move to the `Settings` tab and under `Environment` --> `Domains`, click the `Generate Domain` button. A new URL ending in `.up.railway.app` will appear. _Save this address for later! This is the URL you will send requests to to access stats data._

9. Move to the `Variables` tab and click the `+ Add Variable` button in the top right. Set the new variable name as `CLIENT` and its value as _the URL or IP address - including port number, if needed - of your swgoh-comlink instance. Make sure to include the http:// or https:// prefix to your address._ (If you deployed comlink on Railway, this will be another up.railway.app address and you will not need to include the port number). Exit the settings window, which will cause the app to restart.

10. When you see the green check mark, navigate back to the Deploy Log. Once stats has connected to comlink, you will see a version of the following message in the log window:

> swgoh-stats:1.3.0 is listening on port 5832 for swgoh stat requests.
> Updating game data to version 0.31.5:TrS-lZljSHmTxPbeI5q4Ww...

11. Enjoy your new SWGOH Stats instance!

**NOTE**: When you send requests to stats, you will _not need to provide a port number_. Railway automatically maps the URL you generated to the port your comlink instance is listening on!
