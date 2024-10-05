framework foudry per eth 
## SCARICARE
- ' curl -L https://foundry.paradigm.xyz | bash '

## prerequisiti 
rust compiler e cargo essendo che foundry è sviluppato in rust 

[link documentazione](https://book.getfoundry.sh/getting-started/installation)

## libreria 
creazione libreria 
**forge init**
se da questo errore perchè il folder non è vuoto allora provare **forge init --force**
Error: 
The target directory is a part of or on its own an already initialized git repository,
and it requires clean working and staging areas, including no untracked files.

Check the current git repository's status with `git status`.
Then, you can track files with `git add ...` and then commit them with `git commit`,
ignore them in the `.gitignore` file, or run this command again with the `--no-commit` flag.

If none of the previous steps worked, please open an issue at:
https://github.com/foundry-rs/foundry/issues/new/choose


in **src** si mettono gli smart contract 

per compiler il nostro codice si usa **forge build o forge compile**

foundry ha anche la virtual machine per testare il codice e si chiama **anvil**, facendo il comando **anvil** compariranno dei fake account con delle
fake private key 
