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
Se si volesse vedere delle statistiche allora eseguire forge coverage --fork-url https://eth-mainnet.g.alchemy.com/v2/cFw9OSeqq5kXo10sQL_WJG1kXnPNCTgP.

N.B alcuni test funzionano sul vanilla foundry ma non sulla foundry-sksync e viceversa alcuni funzionano su foundry-sksync ma non su fundry

Se si volesse vedere quando gas usano i tuoi test si scrive nel prompt **forge snapshot**

## private key

'cast wallet import defaul_key --interactive' incripta la tua private key e ti fornirà un address
se si volesse vedere tutti i nomi delle primate key cast wallet list

## chisel

Chisel è un componente che si trova direttamente dentro foundry e se si scrive nel terminale chisel permetterà di eseguire linea di codice uno a uno 'It can be used to quickly test the behavior of Solidity snippets on a local or forked network.'.
Ti permette di scrivere direttamente codice nel terminale

## storage

Ogni volta che noi creiamo una variabile viene salvate nello storage, invece le variabili dentro a funzioni non vengono messe dentro allo storage essendo che dopo l'esecuzione della funzione queste vengono eliminate. Le variabili all'interno delle funzioni vengono salvate dentro alla memory

Se si volesse vedere lo storage di un contratto allora si esegue 'forge inspect 'nome contratto' storagelayout', un altro modo sarebbe prima di deploiare il contratto e dopo eseguire cast storage 'address contratto'

Compiler run successful!
| Name | Type | Slot | Offset | Bytes | Value | Hex Value | Contract |
|-----------------|-----------------------------|------|--------|-------|--------------|--------------------------------------------------------------------|-------------------------------------------------------|
| decimals | uint8 | 0 | 0 | 1 | 8 | 0x0000000000000000000000000000000000000000000000000000000000000008 | test/mocks/AggregatorV3Interface.sol:MockV3Aggregator |
| latestAnswer | int256 | 1 | 0 | 32 | 200000000000 | 0x0000000000000000000000000000000000000000000000000000002e90edd000 | test/mocks/AggregatorV3Interface.sol:MockV3Aggregator |
| latestTimestamp | uint256 | 2 | 0 | 32 | 1729348236 | 0x000000000000000000000000000000000000000000000000000000006713c28c | test/mocks/AggregatorV3Interface.sol:MockV3Aggregator |
| latestRound | uint256 | 3 | 0 | 32 | 1 | 0x0000000000000000000000000000000000000000000000000000000000000001 | test/mocks/AggregatorV3Interface.sol:MockV3Aggregator |
| getAnswer | mapping(uint256 => int256) | 4 | 0 | 32 | 0 | 0x0000000000000000000000000000000000000000000000000000000000000000 | test/mocks/AggregatorV3Interface.sol:MockV3Aggregator |
| getTimestamp | mapping(uint256 => uint256) | 5 | 0 | 32 | 0 | 0x0000000000000000000000000000000000000000000000000000000000000000 | test/mocks/AggregatorV3Interface.sol:MockV3Aggregator |
| getStartedAt | mapping(uint256 => uint256) | 6 | 0 | 32 | 0 | 0x0000000000000000000000000000000000000000000000000000000000000000 | test/mocks/AggregatorV3Interface.sol:MockV3Aggregator |

**leggere e scrivere nello storage è molto dispendioso e consuma molto gas** ogni volta che si legge dello storage o si salva una parola si consuma minimo 100 gas [vedere](https://www.evm.codes/)
per consumare meno gas fare poche chiamate ad altri contratti e all'intenro di un contratto cercare di fare meno operazioni e metodi per trovare un elemento con un loop, questi due compiti consumano molto gas

## pragma

questa definisce la versione del compiler di soliditi che trasforma il codice in codice macchina per EVM
ci possono essere due tipi una con davant ^ pragma solidity ^0.8.28; dice che si usa un compiler da quella versione in su o senza la ^ pragma solidity 0.8.28; in questo caso la versione è solo uella

## convenzioni

quando una variabile è immutabile allora deve iniziare con i*, quando è privata allora deve iniziare con s*
i file script diniscono con s.sol
una buona pratica è di specificare sempre la visibilità di una funzione

## keyword

- is: è per l'ereditarietà dei contratti es. contract A is B
- msg.sender: è l'address della persona che interagisse con il contratto o l'address di un altro contratto
- msg.value: quantità di eth inviati
- msg.data: il payload
- msg.sig: i primi 4 bytes del payload
- block.blockhash(**blockNumber**): l'hash del blocco messo tra parentesi
- block.coinbase: address miner
- block.gaslimit: limite del gas spendibile
- block.number: l'altezza della blockchain
- block.timestamp: data del blocco minato
- address.balance: bilancio dell'address
- address.transfer(**amount**): trasferisce l'amount (in wei) all'address
- address(this): è l'address del contratto
- selfdestruct(**recipient_address**): per eliminare l'address
- tx.gasprice: costo del gas
- tx.origin: l’indirizzo dell'account esterno che ha interagito con il contratto
- gasleft(): quanto gas si ha
- immutable: una volta che alla variabile è asseganata un valore non può essere cambiata
- constant: il valore della variabile non può essete cabiato una volta che si è inizializzata
- external: la funzione può essere chiamata solo dall'esterno e quindi non si può fare la ricursione
- visibilità della funzione:
  1. private: possono essere chiamate solo all'interno del contratto in cui sono, non possono essere chiamate da altri contratti
  2. public: è di default e possono essere chiamate da qualsiasi altro contratto
  3. external: sono come public function ma non possono essere chiamate dall'interno del contratto
  4. internal: sono simili alle private function l'unica differenza è che queste funzioni possono essere chiamate anche da contratti che ereditano altri contratti, quindi sia il contratto che main e il contratto che viene ereditato possono accedere a queste funzioni
- comportamento funzioni
  1. view: si può solo leggere dati dalla blockchain ma non può modificarli
  2. pure: non permette di leggere ne scrivere nessuna variabile salvata nello storage
  3. payable: è una funzione che accetta pagamenti in arrivo
- costructor: la funzione costructor viene messa dentro al contratto e viene eseguita solo una volta durenate la creazione del contratto
- Function Modifiers: vengono usate spesso per creare condizioni che vengono usate spesso all'interno del contratto
  es
- delegatecall: permette al altri contratti di leggere e modificare il suo storage. es quando il contratto A chiama B con delegatecall, allora il codice di B viene eseguito come se facesse parte di A e quindi può leggere sia le variabili di A ma può anche modificarle
- send: invii soldi ad un address
- transfer: fa lo stesso di send ma se fallisce fa il **revert** cosa che **send non fa** e ritornerà solo false, infatti transfer è più sicura di send essendo che con send devi per forza mettere una condizione se la funzione ha ritornato true
- call: altro metodo per inviare i soldi e anche in questo bisogna controllare se ritorna true o no come con send
- selfdestruct: unico metodo per distruggere il contratto sulla blockchain
  modifier onlyOwner {
  require(msg.sender == owner);
  \_;
  }

function destroy() public onlyOwner {
selfdestruct(owner);
}

qua la funzione destroy viene applicata solo se onlyOwner ritorna true

- Quando una transazione viene completata (con successo o meno), produce una ricevuta della transazione (receipt). La ricevuta della transazione contiene voci di registro che forniscono informazioni sulle azioni che si sono verificate durante l'esecuzione della transazione. gli eventi sono usati per costruire questi logs
  Gli eventi sono particolarmente utili per i client leggeri e i servizi DApp, che possono “osservare” eventi specifici e segnalarli all'interfaccia utente, oppure modificare lo stato dell'applicazione per riflettere un evento in un contratto sottostante.
- valori che si possono usare per rappresentare soldi sono:
  1. ether
  2. gwei 1 gwei === 1^9 wei
  3. wei, 1 ether === 1^18 wei
- type:
  Es. type Price is uint128;
  type C is V;, where C is the name of the newly introduced type and V has to be a built-in value type
  queste tipo di variabili scelte dall'user possono avere due funzioni
  Price.wrap() che prende il valore (che è un uint128) all'interno e lo fa diventare di tipo Price
  Price.unwrap() che prende un valore di tipo Price e lo ritrasforma di tipo uint128
  di solito si utilizza questo tipo di semnatica per migliorare la leggibilità e la sicurezza
- memory: si utilizza memory con i parametri delle funzioni o array che sono creati dinamicamente durante l'esecuzione della funzione
- storage: si usa quando si deve salvare dei dati permanentemente
- calldata: è come memory si utilizza solo per argomenti delle funzioni ma calldata può solo leggere i dati e non può sovrascriverli
- require: controlla una condizione e se quella condizione è falsa allora fa il revert
- revert: è uguale al require ma cambia solo la sintassi di scrittura
- assert: controlla codice che non dovrebbe mai essere falso
- interface: sono un tipo di contratto che hanno dentro la dichiarazione della funzione ma non l'implementazione [vedi esempio](./ES/solidity2.sol)

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

## logs

nei logs ci saranno gli eventi che si vogliono registrare cosi che le persone all'esterno della blockchain possano capire cosa sta succedendo.
Per scrivere questi eventi nei logs si usano gli **eventi**.
Gli smart contract non possono accedere ai log ed è per questo che salvare dati sui logs è più economico rispetto a salvarli nello storage

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

## P.S

se si volesse evitare di eseguire sempre questi comandi lunghi per interagire con i contratti allora è meglio fare un MAKEFILE

**SOLIDITY NON SUPPORTA IL FLOAT**

per ottenere un numero randomico bisogna farsi aiutare da terze parti essendo che blockchain è deterministica è difficile ottener eun numero randomico. Per generare un numero randomico in solidity bisogna inviare un **seed** off-chain ad un oracle che genererà un numero randomico

## TIPI DI ATTACCHI

- Quando si passano i parametri a uno smart contract, questi sono codificati secondo le specifiche ABI. È possibile inviare parametri codificati più corti della lunghezza prevista (ad esempio, l'invio di un indirizzo di soli 38 caratteri esadecimali (19 byte) invece dei 40 caratteri esadecimali standard (20 byte)). In questo caso, l'EVM aggiungerà degli zeri alla fine dei parametri codificati per recuperare la lunghezza prevista
  L'esempio più chiaro è quello di uno scambio che non verifica l'indirizzo di un token ERC20 quando un utente richiede un prelievo.

- underflow si ha quando si sottrae un numero da una variabile che è 0 es. sottrae 1 da unit8 = 0 porterà a 255 e non a -1
  overflow si ha quando si aggiunge un numero troppo granse ad un tipo di variabile es. aggiungere 257 a uint8 = 0 porterà a 1

- codice che chiama contratti esterni devono essere fatti **attentamente**
  usando la key **new**.
  constructor() {
  encryptionLibrary = new Rot13Encryption();
  }
  se un contratto non ha new ma ha direttamente un address quel contratto potrebbe essere manevolo essendo che non si sa dove porta quell'address
  es
  constructor() {
  encryptionLibrary = 'address qua '
  }

- usare timestamp o now è rischioso essendo che possono essere manipolati dai miner che decidono quali transazioni mettere nel blocco

- attacchi di dos se si usa un array che può essre manipolato dal un utente e si fa un loop su l'array

- con delegate essendo che si lascia modificare il storage da un altro contratto

- non dare lo stato di visibilità alle funzioni (essendo che di default è public)

- Solidity ha una variabile globale, tx.origin, che attraversa l'intero stack delle chiamate e contiene l'indirizzo dell'account che ha originariamente inviato la chiamata (o la transazione). L'uso di questa variabile per l'autenticazione in uno smart contract rende il contratto vulnerabile a un attacco di tipo phishing


## SICUREZZA

delle pratiche per rendere il codice più sicuro

1. Meno codice, più codice c'è e la probabilità di avere bugs aumenta
2. Tenere le funzionalità che si possono fare nel front-end nel front-end 
3. Attenzione ai for loop che possono essere soggetti ai DOS attack, qualsiasi cosa che può causare un spesa di gas illimitato **bisogna cercare di evitarla** 
4. se ci sono parametri importanti verificare subito la loro validità e non controllarli in mezzo dell'esecuzione o alla fine dell'esecuzione della funzione 
5. Gestire tutti i casi sopratutto quando si gestisce protocolli con collaterali ecc.
6. **chiamate esterne** perchè possono portare a manipolazione o exploit 
7. Mai inviare tutto il gas a uno smart contract inviare solo il **gas limit** 