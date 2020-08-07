# Codespace in Codespace

[<img title="Run in Codespace in one click" src="https://cdn.jsdelivr.net/gh/bookish-potato/codespaces-in-codespaces@f097ccddfc401ab6b09d233dc47c3efa3f9513f6/images/badge.svg">](https://github.com/features/codespaces)

Codespaces Workbench inside a GitHub Codespace.

## Use

### 1. Open with Codespaces.

### 2. Once the codespace is initialized and connected (the terminal should be colorful):

```bash
script/bootstrap
```

This will initialize interactive flow in the terminal to pull the `vsclk-core` repo from the Azure DevOps and
settings up the `npm`/`nuget` credentials. The flow should be self explanatory but you can expand the `more info` section below.

<details>
    <summary>more info</summary>

- On the first step it will ask for your AzureDevOps alias:

![username bash prompt](./images/docs/bootsrap-username-bash-prompt.png)

Type you `AzureDevOps` alias or `email` and press enter.

- Next, it will ask you for `AzureDevOps` PAT, the token should have `Code [read/write] and Packaging[read]` scopes, paste the token and press `enter`:

![password bash prompt](./images/docs/bootsrap-pat-bash-prompt.png)

- ⛱️ _Relax and enjoy_. The bootstrap script will take it from here. If the credentials have the correct premissions, the script will:

  - pull down the `vsclk-core` repo that hosts the workbench source code
  - set up the `npm` and `nuget` credentials to auth with `AzureDevOps` private module feeds
  - pull down and install all the `npm`/`nuget` dependencies

- After the boostrapping is complete you will see the welcoming message at the end of the finished process:

![](./images/docs/bootsrap-complete-prompt.png)

</details>

### 3. Running the workbench

After the bootstraping is complete, you are left in the `Website` folder, that is the folder that contains the workbench client and used as entry point to start the app.

Try the workbench app:

```bash
yarn start
```

This will start the workbench app on port `5000`.

![App start with yarn start](./images/docs/app-yarn-start-screen.png)

### 4. Developing the workbench

So the workbench is up and running at port `5000` but that is the port
inside the codespace in the cloud, not that useful, huh. Not exactly, you have few options to see that app locally and beyond:

- [Port Forward the app port to your local machine (plays well with gh/gh local development)](https://asdda.com)

- [Use Port Forwarding Service in your browser](https://asdda.com)
