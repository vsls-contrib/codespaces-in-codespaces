# Codespaces portal inside GitHub Codespaces

[<img title="Run in Codespace in one click" src="https://cdn.jsdelivr.net/gh/bookish-potato/codespaces-in-codespaces@f097ccddfc401ab6b09d233dc47c3efa3f9513f6/images/badge.svg">](https://github.com/features/codespaces)

Script to create GitHub Codespace out of DevOps repo.

### Use

*From desktop VSCode:*

1. Create a Codespace using this repo.
2. Once connected, run `./init` command to start the bootstrap process, follow instructions.
3. Once complete, run `code -r .` in the terminal to open the current folder.
4. Run `yarn start:bare` to start the portal, it will auto-forward the port `5000`.
5. Download the `nginx` folder from this repo, open it in vscode and run `./start.sh` script.
6. Go to `https://github.com/codespaces` and create a repo with `Local` VSCS target.
7. Done.

### Issues/Feedback

- Feedback appreciated, create issues on this repo if anything 🤗
