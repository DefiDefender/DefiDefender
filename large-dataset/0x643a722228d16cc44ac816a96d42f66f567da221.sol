pragma solidity ^0.5.4;



contract Betnomi_Staking {



    using SafeMath for uint256;

    

    //address TokenContractAddress = address(0xAc7873699c0fBcac99d6c46A846505A60e6d8949); //testnet

    address TokenContractAddress = address(0xDDf4391Cf47dA6B0A26Ee94D900faf70FbE9C655); //mainnet

    TokenContract token; 

    address payable _owner;

    

    struct Variables {

        uint256         minInvestment;

        uint256         APY;

        uint256         ClaimTime;

        uint256         totalInvested;

        uint256         totalInterest;

    }

    Variables public vars;

    mapping(address => uint256) public investment;

    mapping(address => uint256) public interest;

    mapping(address => uint256) public lastInterestTime;

    mapping(address => uint256) public totalearnedInterest;

    

    event Invested(address _address,uint256 Amount);

    event WithdrawInvestment(address _address,uint256 Amount);

    event WithdrawInterest(address _address,uint256 Amount);

    

    constructor () public //creation settings

    {

        _owner              = msg.sender;

        token               = TokenContract(TokenContractAddress);

        

        vars.APY            = 2600;         //X% * 100 

        vars.minInvestment  = (10**16);    

        vars.ClaimTime      = 24*60*60;     //seconds

    }

    

    function stake(uint256 amount) public {

        require(amount>=vars.minInvestment,'not min Investment');

        

        //Check if the contract is allowed to send token on user behalf

        uint256 allowance = token.allowance(msg.sender,address(this));

        require (allowance>=amount,'allowance error');



        require(token.transferFrom(msg.sender,address(this),amount),'transfer Token Error');

        

        if (lastInterestTime[msg.sender] == 0)

            lastInterestTime[msg.sender] = now;

        else{

            interest[msg.sender] = interest[msg.sender].add(calculateInterest(msg.sender));

            lastInterestTime[msg.sender] = now;

        }

            

        investment[msg.sender] = investment[msg.sender].add(amount);

        vars.totalInvested = vars.totalInvested.add(amount);

        emit Invested(msg.sender,amount);

    }

    function Unstake(uint256 amount) public {

        require(lastInterestTime[msg.sender]!=0);

        require(lastInterestTime[msg.sender]<now);

        require(amount<=investment[msg.sender],'not enough fund');

        

        require(token.transfer(msg.sender, amount),'transfer Token Error');

        

        //accumulate current Interest and set new time

        interest[msg.sender] = interest[msg.sender].add(calculateInterest(msg.sender));

        lastInterestTime[msg.sender] = now;

        

        investment[msg.sender] = investment[msg.sender].sub(amount);

        vars.totalInvested = vars.totalInvested.sub(amount);

        emit WithdrawInvestment(msg.sender,amount);

    }

    function claimRewards() public {

        require(lastInterestTime[msg.sender]!=0);

        require(lastInterestTime[msg.sender]<now);

        uint256 currentInterest = calculateInterest(msg.sender);

        

        require(token.transfer(msg.sender, interest[msg.sender]+currentInterest),'transfer Token Error');

        emit WithdrawInterest(msg.sender,interest[msg.sender]+currentInterest);

        vars.totalInterest = vars.totalInterest.add(interest[msg.sender]+currentInterest);

        totalearnedInterest[msg.sender] = totalearnedInterest[msg.sender].add(interest[msg.sender]+currentInterest);

        

        interest[msg.sender] = 0;

        lastInterestTime[msg.sender] = now;

        

    }

    //interest from last withdrawTime

    function calculateInterest(address account) public view returns(uint256){

        require(lastInterestTime[account]!=0);

        require(lastInterestTime[account]<now);

        uint256 stakingDuration = now.sub(lastInterestTime[account]);  //in seconds

        

        return investment[account].mul(stakingDuration).mul(vars.APY).div(365*24*60*60*10000);

        

    }

    function getContractBalance() public view returns(uint256 _contractBalance) {

        return token.balanceOf(address(this));

    }

    //Setters

    function setAPY(uint256 _APY) public onlyOwner {

        vars.APY = _APY;

    }

    function setminInvestment(uint256 _min) public onlyOwner {

        vars.minInvestment = _min;

    }

    function setClaimTime(uint256 _ClaimTime) public onlyOwner {

        vars.ClaimTime = _ClaimTime;

    }

    

    modifier onlyOwner(){

        require(msg.sender==_owner,'Not Owner');

        _;

    }

    function getOwner() public view returns(address ) {

        return _owner;

    }

    //Protect the pool in case of hacking

    function kill() onlyOwner public {

        uint256 balance = token.balanceOf(address(this));

        token.transfer(_owner, balance);

        selfdestruct(_owner);

    }

    function transferFund(uint256 amount) onlyOwner public {

        uint256 balance = token.balanceOf(address(this));

        require(amount<=balance,'exceed contract balance');

        token.transfer(_owner, amount);

    }

    function transferOwnership(address payable _newOwner) onlyOwner external {

        require(_newOwner != address(0) && _newOwner != _owner);

        _owner = _newOwner;

    }

}



contract TokenContract

{

    function transferFrom(address, address, uint256) public returns (bool);

    function approve(address _spender, uint256 _value) public returns (bool);

    function balanceOf(address) external view returns (uint256);

    function allowance(address _owner, address _spender) public returns (uint256);

    function transfer(address _to, uint256 _value) public returns (bool);

}

// ----------------------------------------------------------------------------



// Safe maths



// ----------------------------------------------------------------------------



library SafeMath {



    function add(uint a, uint b) internal pure returns (uint c) {



        c = a + b;



        require(c >= a);



    }



    function sub(uint a, uint b) internal pure returns (uint c) {



        require(b <= a);



        c = a - b;



    }



    function mul(uint a, uint b) internal pure returns (uint c) {



        c = a * b;



        require(a == 0 || c / a == b);



    }



    function div(uint a, uint b) internal pure returns (uint c) {



        require(b > 0);



        c = a / b;



    }



}
