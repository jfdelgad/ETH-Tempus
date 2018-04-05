# Requesting repeated calls from Chronos
Thsi example shows a code to request recurrent calls from Chronos.
* Deploy the contract in Rinkeby (i.e, Mist).
* Send ether to the contract (Rinkeby). This is necessary as the contract should be able to pay for the gas.
* Execute `setCallrequest` once. (The contract will continue executing calls untill it runs out of ether)


```Solidity
pragma solidity ^0.4.20; 


contract _Chronos {
    function registerCall(address contractAddress, uint256 callOnBlock, uint256 gasAmount) public returns (uint256);
    function clientWithdraw(uint256 value) public;
    function clientFunding(address contractAddress) public payable;

}

contract Client {
    function setCallrequest(uint256 blockNumber, uint256 gasAmount) public;
    function callBack() public;
    function withdrawFromChronos(uint value) public;
    function getDepositsFromChronos() public payable;
}



contract YourContract is Client {
    address public chronosAddress;
    uint256 public counter;

    function YourContract public {
        chronosAddress = address(0x4896FE22970B06b778592F9d56F7003799E7400f);
    }


    

    function setCallrequest(uint256 blockNumber, uint256 gasAmount) public {
        _Chronos ChronosInstance = _Chronos(chronosAddress);
        uint256 costs = ChronosInstance.registerCall(address(this), blockNumber, gasAmount);
        require(address(this).balance >= costs);
        ChronosInstance.clientFunding.value(costs)(address(this));
    }

    
    function callBack() public {
        // functions to execute upon call
        counter++
        // request a new call 10 block from now. Passing 200000 gas
        setCallrequest(block.number + 10, 200000);
    }

    function withdrawFromChronos(uint value) public {
        _Chronos ChronosInstance = _Chronos(chronosAddress);
        ChronosInstance.clientWithdraw(value);
    }

    function getDepositsFromChronos() public payable {
        // do not addnaything here
    } 
    
    function () public payable {}

    function kill() public {
        selfdestruct(admin);
    }

}

```
