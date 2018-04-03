# Chronos 
Chronos is a smart contract in the Ethereum network that allows contracts to program calls to themselves at a particular time (block). 


## How it works?
**Chronos** allows clients to register a request for being called at a particular block. When the block at which the call was requested arrives, **Chromos** calls a *callBack* function in the client contract. It is that simple.



## Is it difficult to interact with Chronos?
No. The motivation behind Chronos is to make the use of the system as simple as possible. The code below show a template that can be used for any contract that interact with the Chronos system.



``` solidity
    pragma solidity ^0.4.20; 

    /* Interface to Chronos*/
    contract _Chronos {
        function registerCall(address contractAddress, uint256 callOnBlock) public returns (bool);
        function calculateCost(uint256 gasAmount) public pure returns (uint256);
        function clientsWithdraw(uint256 value) public;
        function clientFunding(address contractAddress) public payable;
    }
    
    contract YourContract is Client {
        
        // your functions
        function YourFirstFunction() public {}
        function YourSecondFunction() public {}        
        function etc() public {}
        
        
        
        // Functions to interact with Chronos
        function setCallrequest(uint256 blockNumber) public payable {       
            uint gasAmount = 200000;                                        // amount of gas to be used (change according to your needs)
            _Chronos ChronosInstance = _Chronos(chronosAddress);            // Instance of Chronos                
            uint costs = ChronosInstance.calculateCost(gasAmount);          // Calculate the cost of the transaction using gas Price and gasAmount + fee
            require(address(this).balance >= costs);                        // Your cotract must have the cost of the transaction
            ChronosInstance.registerCall(address(this),blockNumber);        // Register the call in the system
            ChronosInstance.clientFunding.value(costs)(address(this));      // Send the cost (need to execute the call)
        }

        // CallBacl Funtion will be called at the requested blockNumber
        function callBack() public {
            //Add here the code (functions) you want to execute after the call
        }
    }
```


## Can you show me a working example?
Sure, you can see an example [here](to be created)



## what if I send more gas than required, Can I get back the exccess?
Yes. When the Client send the gas-cost to execute a call, a balance is created for that client contract. If your call does not consume all the gas-cost that you provided, it is stored in the balance, to be used later on future calls or to be withdraw by your contract using the function `clientWithdraw(uint value)`. 



## What is the address of Chronos?
You can reach Chronos on:
* Rinkeby test network at:
* Main Ethereum Network at :



## Does this service has a cost?
The client contract (the contract that request the call) must provide the gas-cost necessary to run the callBack function. (See example above). As the calls need to be initiated outside the network, the system also charge a small fee of 1 cent of dollar ($0.01) per call to mantein the system working. The price is updated with the change of ethereum as listed on [Cryptocompare](https://www.cryptocompare.com/coins/eth/overview/USD)
