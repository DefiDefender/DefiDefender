pragma solidity >=0.4.22 <0.6.0;



contract IMigrationContract {

    function migrate(address addr, uint256 nas) public returns (bool success);

}



contract SafeMath {





    function safeAdd(uint256 x, uint256 y) internal pure returns(uint256) {

        uint256 z = x + y;

        assert((z >= x) && (z >= y));

        return z;

    }



    function safeSubtract(uint256 x, uint256 y) internal pure returns(uint256) {

        assert(x >= y);

        uint256 z = x - y;

        return z;

    }



    function safeMult(uint256 x, uint256 y) internal pure returns(uint256) {

        uint256 z = x * y;

        assert((x == 0)||(z/x == y));

        return z;

    }



    function safeDiv(uint256 x, uint256 y) internal pure returns (uint256) {

        assert(y > 0);

        uint256 z = x / y;

        assert(x == y * z + x % y);

        return z;

    }



}



contract Token {

    uint256 public totalSupply;

    function balanceOf(address _owner) public view returns (uint256 balance);

    function transfer(address _to, uint256 _value) public returns (bool success);

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);

    function approve(address _spender, uint256 _value) public returns (bool success);

    function allowance(address _owner, address _spender) public view returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}





/*  ERC 20 token */

contract StandardToken is SafeMath, Token {



    function transfer(address _to, uint256 _value) public returns (bool success) {

        require(_to != address(0));

        require(_value <= balances[msg.sender]);



        balances[msg.sender] = safeSubtract(balances[msg.sender], _value);

        balances[_to] = safeAdd(balances[_to], _value);

        emit Transfer(msg.sender, _to, _value);

        return true;

    }



    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {

        require(_from != address(0));

        require(_to != address(0));

        require(_value <= balances[_from]);

        require(_value > 0);

        require(allowed[_from][msg.sender] >= _value);



        balances[_from] = safeSubtract(balances[_from], _value);

        allowed[_from][msg.sender] = safeSubtract(allowed[_from][msg.sender], _value);

        balances[_to] = safeAdd(balances[_to], _value);

        emit Transfer(_from, _to, _value);

        return true;

    }



    function balanceOf(address _owner) public view returns (uint256 balance) {

        return balances[_owner];

    }



    function approve(address _spender, uint256 _value) public returns (bool success) {

        allowed[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;

    }



    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {

        return allowed[_owner][_spender];

    }



    mapping (address => uint256) balances;

    mapping (address => mapping (address => uint256)) allowed;

}



contract GENEToken is StandardToken {

    // metadata

    string  public constant name = "GENE";

    string  public constant symbol = "GE";

    uint8   public constant decimals = 18;

    string  public version = "1.0";



    // contracts

    address payable public ethFundDeposit;  // ETH\u5b58\u653e\u5730\u5740

    address public newContractAddr;         // token\u66f4\u65b0\u5730\u5740



    // crowdsale parameters

    bool    public isFunding;                // \u72b6\u6001\u5207\u6362\u5230true

    uint256 public fundingStartBlock;

    uint256 public fundingStopBlock;



    uint256 public currentSupply;           // \u6b63\u5728\u552e\u5356\u4e2d\u7684tokens\u6570\u91cf

    uint256 public tokenRaised = 0;         // \u603b\u7684\u552e\u5356\u6570\u91cftoken

    uint256 public tokenMigrated = 0;       // \u603b\u7684\u5df2\u7ecf\u4ea4\u6613\u7684 token

    uint256 public tokenExchangeRate = 1;             // 1 GE \u5151\u6362 1 ETH



    // events

    event AllocateToken(address indexed _to, uint256 _value);   // \u5206\u914d\u7684\u79c1\u6709\u4ea4\u6613token;

    event IssueToken(address indexed _to, uint256 _value);      // \u516c\u5f00\u53d1\u884c\u552e\u5356\u7684token;

    event IncreaseSupply(uint256 _value);

    event DecreaseSupply(uint256 _value);

    event Migrate(address indexed _to, uint256 _value);



    // \u8f6c\u6362

    function formatDecimals(uint256 _value) internal pure returns (uint256 ) {

        return _value * 10 ** uint256(decimals);

    }



    // constructor

    constructor(address payable _ethFundDeposit, uint256 _currentSupply) public{

        ethFundDeposit = _ethFundDeposit;



        isFunding = false;                           // \u901a\u8fc7\u63a7\u5236\u9884CrowdS ale\u72b6\u6001

        fundingStartBlock = 0;

        fundingStopBlock = 0;



        currentSupply = formatDecimals(_currentSupply);

        totalSupply = formatDecimals(1000000000);

        balances[msg.sender] = totalSupply;

        require(currentSupply <= totalSupply);

    }



    modifier isOwner()  { require(msg.sender == ethFundDeposit); _; }



    /// \u8bbe\u7f6etoken\u6c47\u7387

    function setTokenExchangeRate(uint256 _tokenExchangeRate) isOwner external {

        require(_tokenExchangeRate != 0);

        require(_tokenExchangeRate != tokenExchangeRate);



        tokenExchangeRate = _tokenExchangeRate;

    }



    /// @dev \u8d85\u53d1token\u5904\u7406

    function increaseSupply (uint256 _value) isOwner external {

        uint256 value = formatDecimals(_value);

        require(value + currentSupply <= totalSupply);

        currentSupply = safeAdd(currentSupply, value);

        emit IncreaseSupply(value);

    }



    /// @dev \u88ab\u76d7token\u5904\u7406

    function decreaseSupply (uint256 _value) isOwner external {

        uint256 value = formatDecimals(_value);

        require(value + tokenRaised <= currentSupply);



        currentSupply = safeSubtract(currentSupply, value);

        emit DecreaseSupply(value);

    }



    /// \u542f\u52a8\u533a\u5757\u68c0\u6d4b \u5f02\u5e38\u7684\u5904\u7406

    function startFunding (uint256 _fundingStartBlock, uint256 _fundingStopBlock) isOwner external {

        require(!isFunding);

        require(_fundingStartBlock < _fundingStopBlock);

        require(block.number < _fundingStartBlock);



        fundingStartBlock = _fundingStartBlock;

        fundingStopBlock = _fundingStopBlock;

        isFunding = true;

    }



    /// \u5173\u95ed\u533a\u5757\u5f02\u5e38\u5904\u7406

    function stopFunding() isOwner external {

        require(isFunding);

        isFunding = false;

    }



    /// \u5f00\u53d1\u4e86\u4e00\u4e2a\u65b0\u7684\u5408\u540c\u6765\u63a5\u6536token\uff08\u6216\u8005\u66f4\u65b0token\uff09

    function setMigrateContract(address _newContractAddr) isOwner external {

        require(_newContractAddr != newContractAddr);

        newContractAddr = _newContractAddr;

    }



    /// \u8bbe\u7f6e\u65b0\u7684\u6240\u6709\u8005\u5730\u5740

    function changeOwner(address payable _newFundDeposit) isOwner external {

        require(_newFundDeposit != address(0x0));

        ethFundDeposit = _newFundDeposit;

    }



    /// \u8f6c\u79fbtoken\u5230\u65b0\u7684\u5408\u7ea6

    function migrate() external {

        require(!isFunding);

        require(newContractAddr != address(0x0));



        uint256 tokens = balances[msg.sender];

        require(tokens != 0);



        balances[msg.sender] = 0;

        tokenMigrated = safeAdd(tokenMigrated, tokens);



        IMigrationContract newContract = IMigrationContract(newContractAddr);

        require(newContract.migrate(msg.sender, tokens));



        emit Migrate(msg.sender, tokens);               // log it

    }



    /// \u8f6c\u8d26ETH \u5230 GE \u56e2\u961f

    function transferETH() isOwner external {

        require(address(this).balance != 0);

        require(ethFundDeposit.send(address(this).balance));

    }



    /// \u5c06GE token\u5206\u914d\u5230\u9884\u5904\u7406\u5730\u5740\u3002

    function allocateToken (address _addr, uint256 _eth) isOwner external {

        require(_eth != 0);

        require(_addr != address(0x0));

        require(isFunding);



        uint256 tokens = safeDiv(formatDecimals(_eth), tokenExchangeRate);

        require(tokens + tokenRaised <= currentSupply);



        tokenRaised = safeAdd(tokenRaised, tokens);

        balances[_addr] = safeAdd(balances[_addr], tokens);

        balances[msg.sender] = safeSubtract(balances[msg.sender], tokens);



        emit AllocateToken(_addr, tokens); // \u8bb0\u5f55token\u65e5\u5fd7

    }



    /// \u8d2d\u4e70token

    function () external payable {

        require(isFunding);

        require(msg.value != 0);



        require(block.number >= fundingStartBlock);

        require(block.number <= fundingStopBlock);



        uint256 tokens = safeDiv(msg.value, tokenExchangeRate);

        require(tokens + tokenRaised <= currentSupply);



        tokenRaised = safeAdd(tokenRaised, tokens);

        balances[msg.sender] = safeAdd(balances[msg.sender], tokens);

        balances[ethFundDeposit] = safeSubtract(balances[ethFundDeposit], tokens);



        emit IssueToken(msg.sender, tokens); //\u8bb0\u5f55\u65e5\u5fd7

    }

}
