# How to use Chronos.

The code in `clientExample.sol` show how simple is to schedule calls to your contract using Chronos. Assume we want to create a contract that request to be called every 10 minutes and every time that the contract is executed, it increments a counter. You can, of course, execute any function you want every time the contract is executed but for simplicity, we will just increase a counter.

The code of the example is as follows:

``` Solidity
pragma solidity ^0.4.23; 

import "./ChronosClients.sol";

contract YourContract is Client {
    address public chronosAddress;
    address public admin; 
    uint256 public counter;

    constructor(address serviceAddress) public {
        admin = msg.sender;
        chronosAddress = serviceAddress;
    }



    function callBack() public {
        counter++;
        setCallrequest(block.number + 400, 200000, chronosAddress);
    }

    
    function () public payable {}
    function kill() public {
        selfdestruct(admin);
    }

}
```

The functions required to interact with Chronos are included in the imported fine `ChrnosClients.sol`. The `callBack` function is called by Chronos when the requested time or block is reached. You should include the function that you want to execute, inside the `callBack`.

In our case, we merely increase a counter and set a request again to be executed 400 blocks in the future (10 mins, average block durations is 15 seconds).

However, the first request needs to be set by the user, by executing:

``` solidity
setCallrequest(uint blockNumber, uint gasAmount, address chronosAddress);
```

`blockNumber` is the block number in which the `callBack` function will be called, gasAmount is the amount of gas to be passed for the execution of the contract, and chronosAddress is the address of the Chronos contract.

The amount of gas should be enough to execute the call. This means that the contract requesting the execution should contain enough ether. The total gas cost is calculated by multiplying the `gasAmount` passed by the gas price. This `gasPrice` correspond to the current gas price in the network. Therefore gas cost = gasPrice*gasAmount. In our example the gasAmount is 200000 gas, at the average gasPrice in Rinkeby of 1GWei, the total amount of (test) ether is 0.0002 ETH. If this amount is not consumed completely, Chronos creates an account for the contract and the remaining ether can be withdrawn at any time using the function: 

```solidity
withdrawFromChronos(uint value, address chronosAddress)
```

For testing, you can directly deploy the `clientExample.sol` file. Remember to include the `ChronosClients.sol` file, which is required.

