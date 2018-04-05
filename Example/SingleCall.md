# Single call to Chronos.
This example explains how to create a contract that calls to Chronos and request to be called at a particular block. When the call is receibed a counter is increased.

<br><br><br><br>


```Solidity
pragma solidity ^0.4.20; 
import "https://github.com/jfdelgad/Chronos/blob/master/Chronos/Chronos.sol"

contract _Chronos {
    function registerCall(address contractAddress, uint256 callOnBlock, uint256 gasAmount) public returns (uint256);
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
        setCallrequest(5000000, 200000); /* request call for block 5000000 passing 200000 gas*/
        
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
}

```
