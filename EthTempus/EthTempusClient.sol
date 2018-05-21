pragma solidity ^0.4.23; 


/******************************************************************************************************* */
library SafeMath {
  /** @dev Multiplies two numbers, throws on overflow.*/
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {return 0;}
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

  /** @dev Integer division of two numbers, truncating the quotient.*/
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a / b;
        return c;
    }

  /**@dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).*/
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

  /** @dev Adds two numbers, throws on overflow.*/
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }

}


contract EthTempus {
    uint256 public serviceFee;
    function registerCall(uint256 callOnBlock, uint256 maxGasValue, uint256 callId) public;


}


contract EthTempusClient {
    
    address public ethTempusAddress;
    EthTempus ethTempusInstance;
    
    constructor() public {
        ethTempusAddress = 0x7c356001cb9e074af31b443e3fd29c348bda71b9;
        ethTempusInstance = EthTempus(ethTempusAddress);
    }
    function setCallrequest(uint256 blockNumber, uint256 maxGasValue, uint256 callId) public {
        ethTempusInstance.registerCall(blockNumber, maxGasValue, callId);
    }

    function pay(uint256 callCost) public {
        require(msg.sender == ethTempusAddress);
        msg.sender.transfer(callCost);
    }

    function callBack(uint callId) public;
}



