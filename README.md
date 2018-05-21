# ETH-Tempus.
ETH-Tempus is a smart contract in the Ethereum network that allows other contracts to program calls to themselves at a particular time (block).

The  main Features of ETH-Tempus are:


* Simple integration with your smart contract.
* No need to pay up front for the service. 
* Single or recurrent call to the contract.
* Available on the Test Network (Rinkeby).
* Available in the main Network. (Soon)
<br><br><br>


## How it works?
**ETH-Tempus** allows contracts to schedule execution of functions at a particular time (block). When the block at which the call was schedule arrives, **ETH-Tempus** calls a *callBack* function in the client's contract.
<br><br><br>


## How much cost to schedule a call?
In order to schedule a call, your contract should call the function `requestCall` in ETH-Tempus contract. This has no cost. The average gas used to schedule a call is about 25K gas. 

When the block (time) at which the call was programmd arrives, the front-end application of ETH-Tempus call the target contract. After this, the contract calculate the gas used and request the payment of the gas plus a fee. This fee is 5 cents of dollar (0.05 USD). The overhead of gas used to execute the transaction is low, in average 40K gas. This make the scheduling execution higly efficient.
<br><br><br>


## ETH-Tempus address?
You can reach the service on:
* Rinkeby test network at: **0x3e82a82f018a8ebf007c3805f467164dc11f47ac**
* Main Ethereum Network at : (Soon)
<br><br><br>


## ETH-Tempus usage Example: .

This example shows how to request and receive a call every 100 blocks. The contract should have enough ether at the time of execution to pay for the gas cost and the fee of 5 cents. Any code included inside the callBack will be executed. Use ETH-Tempus on Rinkeby for free testing.


``` solidity
pragma solidity ^0.4.23; 
import "./EthTempusClient.sol"; // use import "./EthTempusClientRinkeby.sol"; for testing on Rinkeby

contract YourContract is Client {
    
    uint256 public counter;

    constructor() public payable {
    // In this example:
    // Schedule a call for 100 blocks after deploying (uint256)
    // Maximun gas to expend 200K (uint256) - the sytem uses only what the network requires (including fee of ~ 5 cents of dollar).
    // Aditional parameter to identify the call (uint256)  if not required, set to zero.  
        setCallrequest(block.number + 100, 200000, 0);    
    }

    
    function callBack(uint callId) public {
        // add here the code you want to execute
        counter = callId; 
        setCallrequest(block.number + 1000, 200000, 0); // request another call in 100 blocks
    }

    
    function () public payable {}
    }

}


```

