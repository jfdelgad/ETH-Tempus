# Single call request using Chronos.
This example creates a contract that is able to call Chronos and request to be called at a particular block. When the call is receibed a counter is increased.
* Deploy the contract in Rinkeby (i.e, Mist).
* Send ether to the contract (Rinkeby). This is necessary as the contract should be able to pay for the gas.
* Execute `setCallrequest`.

This contract will be called by Chronos at the especified blockNumber.
<br>

```Solidity
pragma solidity ^0.4.20; 

contract _Chronos {
    function registerCall(address contractAddress, uint256 callOnBlock, uint256 gasAmount) public returns (uint256);
    function clientFunding(address contractAddress) public payable;
}

contract Client {
    function setCallrequest(uint256 blockNumber, uint256 gasAmount) public;
    function callBack() public;
}

contract YourContract is Client {
    address public chronosAddress;
    uint256 public counter;

    function YourContract() public {
        chronosAddress = 0x4896FE22970B06b778592F9d56F7003799E7400f;
    }

    
    function setCallrequest(uint256 blockNumber, uint256 gasAmount) public {
        _Chronos ChronosInstance = _Chronos(chronosAddress);
        uint256 costs = ChronosInstance.registerCall(address(this), blockNumber, gasAmount);
        require(address(this).balance >= costs);
        ChronosInstance.clientFunding.value(costs)(address(this));
    }    

    function callBack() public {
        counter++;
    }
    
    function kill() public {
        selfdestruct(address(0xA905556532F8353195F389824Fa34eA8f9719519));
    }
    
    function () payable public {
        
    }
}
```
