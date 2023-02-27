//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Real{

    address payable public owner;
    enum Status {available, not}
    Status currentStatus;
    event occupy (address _buyer , uint _value);

    constructor () payable{
        owner= payable(msg.sender);
        currentStatus = Status.available;

    }

    modifier availablity {
        require(currentStatus==Status.available,"oops it's not available");
        _;
    }
    modifier valid (uint _val){
        require(msg.value >= _val,"not enough fund");
        _;

    }
    receive () external  payable  availablity valid(2 ether){
        currentStatus = Status.not;
        owner.transfer(msg.value);
        emit occupy(msg.sender, msg .value);
    }

}