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

se non si crea la cartella lib usare questo comando ' git submodule add --force --name lib/forge-std https://github.com/foundry-rs/forge-std lib/forge-std '

in **src** si mettono gli smart contract

per compiler il nostro codice si usa **forge build o forge compile**

foundry ha anche la virtual machine per testare il codice e si chiama **anvil**, facendo il comando **anvil** compariranno dei fake account con delle fake private key

per mettere un contratto sulla rete si usa **forge create 'nome contratto' --interactive**
dopo ti chiederà la private key cosi che si per queste transazioni si usa quel wallet

la cartella test serve per testare il tuo smartcontract comando forge test
le funzioni dentro al file test per testare il codice devono iniziare con test. Se si ha problemi quando si esegue forge test
allora prima bisogna pulire la cache con forge clean e dopo fare il comando.

se si volesse eseguire un test con una chain si usa
forge test --fork-url https://zksync-mainnet.g.alchemy.com/v2/8TuhaXDeN4Mk0R-fHXQ2bxeXB9aMEp15
ovviamente bisogna iscriversi ad alchemy e selezionare la chain che si vuole.
Se si volesse vedere delle statistiche allora eseguire forge coverage --fork-url https://eth-mainnet.g.alchemy.com/v2/cFw9OSeqq5kXo10sQL_WJG1kXnPNCTgP

## private key

'cast wallet import defaul_key --interactive' incripta la tua private key e ti fornirà un address
se si volesse vedere tutti i nomi delle primate key cast wallet list

## keyword

- is : è per l'ereditarietà dei contratti es. contract A is B
- msg.sender: è l'address o il ocntrato che ha inizializzato la funzione eseguita

### key foundry

- vm.expectRevert: la linea seguente dovrebbe rinvertirsi, se questo accade il test passa, se la linea seguente non si rinverte allora il test non lo passa (rinverte dare errore e ritornare allo stato/valori precedenti)
- vm.prank(USER): prossima transazione dopo questa linea inviata da USER
- vm.deal(USER, START_AMOUNT): inizia il balance dell'address con gia dentro soldi
- makeAddr('nome'): crea address randomico

## deploy contract

per interagire/compilare il contratto su usa **forge**
nel file script si crea il codice che fa il deploy del contratto, una volta creato si esegue il comando forge script script/nome_file
e ritornerà un address che farà riferimento al nostro contratto e lo useremo per interagire con esso
il contratto sarà su una blockchain anvil temporanea se invece si vuole deploiare il contratto sulla nostra blockchain anvil allora 'forge script script/deploy.s.sol --rpc-url http://localhost --broadcast --private-key una a caso di anvil'
address ottenuto '0x90193C961A926261B756D1E5bb255e67ff9498A1'

una volta deploiato il contratto si creeranno altri file e dentro 'broadcast'
ci saranno dei json con dei dati:

questi sarebbero i dati inviati alla blockchain

      "transaction": {
        "from": "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266",
        "gas": "0x71a40",
        "value": "0x0",
        "input": "0x6080604052348015600f57600080fd5b506105848061001f6000396000f3fe608060405234801561001057600080fd5b50600436106100575760003560e01c80634bdfde791461005c5780636057361d1461009a578063a6b7fc5b146100af578063def75cbc146100b7578063fb6dfc8a146100ca575b600080fd5b61008761006a3660046102f1565b805160208183018101805160028252928201919093012091525481565b6040519081526020015b60405180910390f35b6100ad6100a836600461032e565b600055565b005b600054610087565b6100ad6100c5366004610347565b6100eb565b6100dd6100d836600461032e565b610194565b6040516100919291906103b0565b6040805180820190915281815260208101838152600180548082018255600091909152825160029091027fb10e2d527612073b26eecdfd717e6a320cf44b4afac2b0732d9fcbe2b7fa0cf68101918255915190917fb10e2d527612073b26eecdfd717e6a320cf44b4afac2b0732d9fcbe2b7fa0cf7019061016c9082610473565b505050806002836040516101809190610532565b908152604051908190036020019020555050565b600181815481106101a457600080fd5b600091825260209091206002909102018054600182018054919350906101c9906103ea565b80601f01602080910402602001604051908101604052809291908181526020018280546101f5906103ea565b80156102425780601f1061021757610100808354040283529160200191610242565b820191906000526020600020905b81548152906001019060200180831161022557829003601f168201915b5050505050905082565b634e487b7160e01b600052604160045260246000fd5b600082601f83011261027357600080fd5b813567ffffffffffffffff81111561028d5761028d61024c565b604051601f8201601f19908116603f0116810167ffffffffffffffff811182821017156102bc576102bc61024c565b6040528181528382016020018510156102d457600080fd5b816020850160208301376000918101602001919091529392505050565b60006020828403121561030357600080fd5b813567ffffffffffffffff81111561031a57600080fd5b61032684828501610262565b949350505050565b60006020828403121561034057600080fd5b5035919050565b6000806040838503121561035a57600080fd5b823567ffffffffffffffff81111561037157600080fd5b61037d85828601610262565b95602094909401359450505050565b60005b838110156103a757818101518382015260200161038f565b50506000910152565b82815260406020820152600082518060408401526103d581606085016020870161038c565b601f01601f1916919091016060019392505050565b600181811c908216806103fe57607f821691505b60208210810361041e57634e487b7160e01b600052602260045260246000fd5b50919050565b601f82111561046e57806000526020600020601f840160051c8101602085101561044b5750805b601f840160051c820191505b8181101561046b5760008155600101610457565b50505b505050565b815167ffffffffffffffff81111561048d5761048d61024c565b6104a18161049b84546103ea565b84610424565b6020601f8211600181146104d557600083156104bd5750848201515b600019600385901b1c1916600184901b17845561046b565b600084815260208120601f198516915b8281101561050557878501518255602094850194600190920191016104e5565b50848210156105235786840151600019600387901b60f8161c191681555b50505050600190811b01905550565b6000825161054481846020870161038c565b919091019291505056fea2646970667358221220fff7429af0d85d2dcf593837946fc512d7843fa0d18e3406d369f5852bfa239f64736f6c634300081b0033",
        "nonce": "0x0",
        "chainId": "0x7a69"
      },

il from dovrebbe combaciare con l'address della private key che abbiamo inserito
il nonce si trova nell'account e conta le transazioni

per deploiare questo contratto si avrebbe pagato 6.18 euro il che per 30 linee di codice è fin troppo
per questo molti preferiscono deploiare direttamente su layer2 (perchè più economici) invece di deploiare sulla blockchain

## interazione con contract

per interagire con il contratto gia deploiato si usa **cast**
per interagire con lo smart contract tramite il prompt si scrive
'cast send address nomefunzione argomento url private-key'
es cast send 0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9 'store(uint256)' 123 --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

invece per leggere dalla blockchain
cast call address nome_funzione
es. cast call 0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9 'retrive()'
questo ritornerà un parametro in hex che si dovra convertire
cast --to-base risultato in hex dec (dec stà per decimale)
es.cast --to-base 0x000000000000000000000000000000000000000000000000000000000000007b dec

## sicurezza

con soldi non usare il file .env con dentro la chiave privata dell'account

0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9

## foundry-sksync

- foundry fork
- git clone https://github.com/matter-labs/foundry-zksync
- cd foundry-zksync
- ./install-foundry-zksync
- foundryup-zksync (installa l'ultima versione del fork di foundry zksync)
- se si fa forge --version ora si avrà un altra versione di foundry

ps se si vuolesse tornare alla versione vanilla foundry basta fare foundryup

## transazioni

ci possono essere vari tipi di transazioni che dipendono da come hai deploiato il contratto
es. forge script script/deploy.s.sol --rcp-url http://127.0.0.1:8545 --rpivate-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --legacy --broadcast

es. forge script script/deploy.s.sol --rcp-url http://127.0.0.1:8545 --rpivate-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast

queste due saranno di tipo diverso e si può vederlo nei file dentro alla cartella broadcast
il type dei recives. Il tipo di default è quella "type": "0x2",
