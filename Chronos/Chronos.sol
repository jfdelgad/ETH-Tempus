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


contract Client {
    function setCallrequest(uint256 blockNumber, uint256 gasAmount) public;
    function callBack() public;
    function withdrawFromChronos(uint value) public;
    function getDepositsFromChronos() public payable;
}

contract Chronos {
    using SafeMath for uint256;

    uint256 public gasPrice;
    address public admin;
    uint256 public serviceFee;
    mapping( uint256 => address[] ) public callRequests;
    mapping ( address => uint256 ) public Balances;

    event RegisterCall(address contractAddress, uint256 callOnBlockNumber);
    event ExecutedCall(address clientAddress, uint256 ExecutedOnBlockNumber);
    modifier onlyAdmin {require(msg.sender == admin);_;}
    
    constructor () public {
        admin = msg.sender;
        gasPrice = 10**9;
        serviceFee = 23000000000000; // fee = 0.01 USD
    }    

    function registerCall(address clientAddress, uint256 callOnBlockNumber, uint256 gasAmount) public returns (uint256) {
        require(callOnBlockNumber>block.number+5);
        callRequests[callOnBlockNumber].push(clientAddress);
        uint256 costs = gasPrice*gasAmount + serviceFee;
        emit RegisterCall(clientAddress,callOnBlockNumber);
        return costs;
    }

    function executeCall(address clientAddress, uint256 blockNumber, uint256 index, uint gasCost, uint gasprice_update) public onlyAdmin returns (bool) {
        require(callRequests[blockNumber][index]==clientAddress);
        gasPrice = gasprice_update;
        Balances[clientAddress] = Balances[clientAddress].sub(gasCost.add(serviceFee));
        Balances[msg.sender] = Balances[msg.sender].add(gasCost.add(serviceFee));
        delete callRequests[blockNumber][index];
        if (index == callRequests[blockNumber].length-1) {delete callRequests[blockNumber];}
        
        Client clientContract = Client(clientAddress);
        clientContract.callBack();
        emit ExecutedCall(clientAddress, block.number);
        return true;
    }



    function updateFee(uint value) public onlyAdmin{
        serviceFee = value;
    } 

    function executerWithdraw() public {        
        msg.sender.transfer(Balances[msg.sender]);
    }
    
    function clientWithdraw(uint256 value) public {
        Balances[msg.sender] = Balances[msg.sender].sub(value);
        Client clientContract = Client(msg.sender);
        clientContract.getDepositsFromChronos.value(value);
        msg.sender.transfer(value);
    }


    function clientFunding(address contractAddress) public payable {
        Balances[contractAddress] = Balances[contractAddress].add(msg.value);
    }

    function getRequestedCalls(uint256 blockNumber) public view returns(address[]){
        return callRequests[blockNumber];
    }


    function () public payable {
    
    }

    function kill() public {
        selfdestruct(admin);
    }



}

