pragma solidity ^0.4.20; 


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

contract Chronos {
    function registerCall(address contractAddress, uint256 callOnBlock, uint256 gasAmount) public returns (uint256);
    function clientWithdraw(uint256 value) public;
    function clientFunding(address contractAddress) public payable;

}

contract Client {
    function setCallrequest(uint256 blockNumber, uint256 gasAmount, address chronosAddress) public {
        Chronos ChronosInstance = Chronos(chronosAddress);
        uint256 costs = ChronosInstance.registerCall(address(this), blockNumber, gasAmount);
        require(address(this).balance >= costs);
        ChronosInstance.clientFunding.value(costs)(address(this));
    }

    
    function withdrawFromChronos(uint value, address chronosAddress) public {
        Chronos ChronosInstance = Chronos(chronosAddress);
        ChronosInstance.clientWithdraw(value);
    }

    function getDepositsFromChronos() public payable {}

    function callBack() public;
}



