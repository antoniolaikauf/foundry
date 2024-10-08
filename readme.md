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

per mettere un contratto sulla rete si usa **forge create 'nome contratto' --interactive**
dopo ti chiederà la private key cosi che si per queste transazioni si usa quel wallet 


## private key 
'cast wallet import defaul_key  --interactive' incripta la tua private key e ti fornirà un address 
se si volesse vedere tutti i nomi delle primate key cast wallet list

## keyword 
- is : è per l'ereditarietà dei contratti es. contract A is B 

## deploy contract 
nel file script si crea il codice che fa il deploy del contratto, una volta creato si esegue il comando forge script script/nome_file
e ritornerà un address che farà riferimento al nostro contratto e lo useremo per interagire con esso 
