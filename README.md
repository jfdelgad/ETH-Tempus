# ETH-Tempus.
ETH-Tempus is a smart contract in the Ethereum network that allows other contracts to program calls to themselves at a particular time (block).

The  main Features of ETH-Tempus are:


* Simple integration with your smart contract.
* No need to pay up front for the service. 
* Single or recurrent call to the contract.
* Available on the Test Network (Rinkeby).
* Available in the main Network.
<br><br><br>


## How it works?
**ETH-Tempus** allows clients (contracts) to schedule execution of functions at a particular time (block). When the block at which the call was requested arrives, **ETH-Tempus** calls a *callBack* function in the client contract. It is that simple. The system allows to call any number of times or to program a recurrent call to a contract. 
<br><br><br>


## how much cost to schedule a call?
In order to schedule a call, your contract should call the function `requestCall` from ETH-Tempus contract. This has no cost. The average gas used by a contract to schedule a call is about 25K gas. 

When the block (time) at which the call was programmd arrives, the front-end application of ETH-Tempus call the target contract. After this, the contract calculate the gas used and request the payment of the gas plus a fee. This fee is 5 cents of dollar (0.05 USD). The overhead of gas used to execute the transaction is low, in average 40K gas. Making the scheduling execution higly efficient.


## ETH-Tempus address?
You can reach the service on:
* Rinkeby test network at: **0x4896FE22970B06b778592F9d56F7003799E7400f**
* Main Ethereum Network at : (Not Available Yet)
<br><br><br>


