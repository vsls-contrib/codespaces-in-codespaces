# Azure DevOps Repos in Codespaces

[<img title="Run in Codespace in one click" src="https://cdn.jsdelivr.net/gh/bookish-potato/codespaces-in-codespaces@f097ccddfc401ab6b09d233dc47c3efa3f9513f6/images/badge.svg">](https://github.com/features/codespaces)

Script to create GitHub Codespace out of any Azure DevOps repo.

### Use

1. Create a Codespace from this repo.

2. Get a PAT in ADO ([link](https://devdiv.visualstudio.com/_usersSettings/tokens)), at least `code:read&write` and `packaging:read` scopes expected on the PAT.

![image](https://user-images.githubusercontent.com/33612256/100295528-ae14ab00-2f3e-11eb-953a-781874c31f6e.png)

3. Add a secret in GitHub Codespaces settings called ADO_PAT, paste the ADO PAT as the value, and select this repo for repository access. You may skip this step and paste the PAT when prompted in the next step.

![image](https://user-images.githubusercontent.com/33612256/100295149-c0421980-2f3d-11eb-979f-2dd3cbf36622.png)

4. Run the `./init` script in the codespaces-in-codespaces directory and follow instructions. If you added the ADO_PAT secret, the script will run with no interaction needed and clone the vsclk-core repo for you. If you didn't add the ADO_PAT secret, you will be prompted to paste it into the terminal.

![image](https://user-images.githubusercontent.com/33612256/100568140-2cdf5000-327f-11eb-8e5a-40c8a8fae46a.png)

### Issues/Feedback

- Feedback appreciated, create issues on this repo if anything 🤗
