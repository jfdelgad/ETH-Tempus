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
