/**
 *Submitted for verification at Etherscan.io on 2017-09-15
*/

pragma solidity ^0.4.13;
contract token { 
    function transfer(address receiver, uint amount);
    function balanceOf(address _owner) constant returns (uint256 balance); 
}

contract PlatoPresale {
    address public beneficiary;
    uint public min_fundingGoal; 
    uint public max_fundingGoal;
    uint public amountRaised; 
    uint public deadline; 
    uint public start;
    uint public rate;
    token public tokenReward;
    mapping(address => uint256) public balanceOf;
    bool fundingGoalReached = false;
    event GoalReached(address beneficiary, uint amountRaised);
    event FundTransfer(address backer, uint amount, bool isContribution);
    bool crowdsaleClosed = false;

    /* data structure to hold information about campaign contributors */

    /*  at initialization, setup the owner */
    function PlatoPresale() {
        beneficiary = msg.sender;
        min_fundingGoal = 100 * 1 ether;
        max_fundingGoal = 2000 * 1 ether;
        start = now + 10 * 1 hours;
        deadline = start + 30 * 1 days;
        rate = 1500;     // Each ether exchange for 1500.00000000 PAT
        tokenReward = token(0x432fFe79337cBaA1B921c7d0802e4ADe89F474E5);
    }

    /* The function without name is the default function that is called whenever anyone sends funds to a contract */
    function () payable{
        uint amount = msg.value;
        require (now >= start);
        require (!crowdsaleClosed);
        require (amountRaised + amount <= max_fundingGoal);
        require (amount >= 5 * 1 ether);
        
        balanceOf[msg.sender] += amount;
        amountRaised += amount;
        tokenReward.transfer(msg.sender, amount * rate * 10 ** 8 / 1 ether);
        if(amountRaised >= min_fundingGoal){
        	fundingGoalReached = true;
            GoalReached(beneficiary, amountRaised);
        }
        FundTransfer(msg.sender, amount, true);
    }

    modifier afterDeadline() { if (now >= deadline) _; }
    modifier MaxGoalHit() { if (amountRaised >= max_fundingGoal - 10 ether) _; }

    /* checks if the goal or time limit has been reached and ends the campaign */
    function checkGoalReached() afterDeadline {
        if (amountRaised >= min_fundingGoal){
            fundingGoalReached = true;
            GoalReached(beneficiary, amountRaised);
        }
        crowdsaleClosed = true;
    }

    function safeWithdrawal() afterDeadline {
        if (!fundingGoalReached) {
            uint amount = balanceOf[msg.sender];
            balanceOf[msg.sender] = 0;
            if (amount > 0) {
                if (msg.sender.send(amount)) {
                    FundTransfer(msg.sender, amount, false);
                } else {
                    balanceOf[msg.sender] = amount;
                }
            }
        }

        if (fundingGoalReached && beneficiary == msg.sender) {
            if (beneficiary.send(amountRaised)) {
                FundTransfer(beneficiary, amountRaised, false);
            } else {
                //If we fail to send the funds to beneficiary, unlock funders balance
                fundingGoalReached = false;
            }
        }
    }

    function GoalHitWithdrawl() MaxGoalHit {
    	require(msg.sender == beneficiary);
    	if (beneficiary.send(amountRaised)) {
    		crowdsaleClosed = true;
            FundTransfer(beneficiary, amountRaised, false);
        } else {
            //If we fail to send the funds to beneficiary, unlock funders balance
            fundingGoalReached = false;
        }
    }
}
