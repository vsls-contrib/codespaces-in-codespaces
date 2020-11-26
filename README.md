# Azure DevOps Repos in Codespaces

[<img title="Run in Codespace in one click" src="https://cdn.jsdelivr.net/gh/bookish-potato/codespaces-in-codespaces@f097ccddfc401ab6b09d233dc47c3efa3f9513f6/images/badge.svg">](https://github.com/features/codespaces)

Script to create GitHub Codespace out of any Azure DevOps repo.

### Use

1. Create a Codespace from this repo.

2. Get a PAT in ADO ([link](https://devdiv.visualstudio.com/_usersSettings/tokens)), at least `code:read&write` and `packaging:read` scopes expected on the PAT.

![image](https://user-images.githubusercontent.com/33612256/100295528-ae14ab00-2f3e-11eb-953a-781874c31f6e.png)

3. Add a secret in GitHub Codespaces settings called ADO_PAT, paste the ADO PAT as the value, and select this repo for repository access.

![image](https://user-images.githubusercontent.com/33612256/100295149-c0421980-2f3d-11eb-979f-2dd3cbf36622.png)

4. Run the `./init` script in the codespaces-in-codespaces directory and follow instructions. If you added the ADO_PAT secret, you should have the option to hit Enter to "reuse old PAT." This will use the ADO_PAT secret. If you don't have this option, you can paste the ADO PAT directly.

![image](https://user-images.githubusercontent.com/33612256/100295353-42cad900-2f3e-11eb-8c62-b8abfe464978.png)

### Issues/Feedback

- Feedback appreciated, create issues on this repo if anything 🤗
