# Chronos 
Chronos is a smart contract in the Ethereum network that allows contracts to program calls to themselves at a particular time (block).
Main features are:


* Simple integration with your smart contract.
* Allows for withdrawal of the gas-cost not consumed during the call.
* Single or recurrent call to the contract.
* Available on the Test Network (Rinkeby).
* Avaylable in the main Network.
<br><br><br>


## How it works?
**Chronos** allows clients (contracts) to make a calling request to be executed at a particular time (block). When the block at which the call was requested arrives, **Chromos** calls a *callBack* function in the client contract. It is that simple. The system allows to call any number of times or to program a recurrent call to a contract. 
<br><br><br>


## Is it difficult to interact with Chronos?
No. One of the most critical aspects of Chronos is that it is simple to use. Only adding two functions to your smart contract is enough to start requesting and receiving temporized calls. 
<br><br><br>


## Can you show me a working example?
Sure, you can see an example for:
* A single call request to Chronos [here](https://github.com/jfdelgad/Chronos/blob/master/Example/SingleCall.md)
* A request for recurrent calls from Chronos [here](https://github.com/jfdelgad/Chronos/blob/master/Example/recurrentCalls.md)
<br><br><br>


## What if I send more gas than required, Can I get back the excess?
Yes. When the Client sends the gas-cost to execute a call, a balance is created for that client-contract. If your request does not consume all the gas-cost that you provided, it is stored in the balance. Chronos provides a function to send the gas-cost in your balance back to the contract that initially made the transaction. 
<br><br><br>


## Chronos address?
You can reach Chronos on:
* Rinkeby test network at: **0x4896FE22970B06b778592F9d56F7003799E7400f**
* Main Ethereum Network at : (Not Available Yet)
<br><br><br>



## Does this service has a cost?
The client contract (the contract that requests the call) must provide the gas-cost necessary to run the callBack function. (See example above). As the calls need to be initiated outside the network, the system also charges a small fee of  1 cent of a dollar (~0.01 USD) per request to maintain the system working. The price is updated with the change of ethereum as listed on [Cryptocompare](https://www.cryptocompare.com/coins/eth/overview/USD)
<br><br><br>
