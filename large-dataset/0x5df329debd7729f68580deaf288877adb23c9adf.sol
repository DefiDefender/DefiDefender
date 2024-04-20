pragma solidity ^0.4.16;





 

/* \u7075\u611f\u6765\u81ea\u4e8e\u516b\u6212  coin*/

contract SafeMath {

 

 

    function safeAdd(uint256 x, uint256 y) internal returns(uint256) {

        uint256 z = x + y;

        assert((z >= x) && (z >= y));

        return z;

    }

 

    function safeSubtract(uint256 x, uint256 y) internal returns(uint256) {

        assert(x >= y);

        uint256 z = x - y;

        return z;

    }

 

    function safeMult(uint256 x, uint256 y) internal returns(uint256) {

        uint256 z = x * y;

        assert((x == 0)||(z/x == y));

        return z;

    }

 

}

 

contract TokenERC20 {

    uint256 public totalSupply;

    function balanceOf(address _owner) constant returns (uint256 balance);

    function transfer(address _to, uint256 _value) returns (bool success);

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success);

    function approve(address _spender, uint256 _value) returns (bool success);

    function allowance(address _owner, address _spender) constant returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}

 

 

/*  ERC 20 token */

contract StartMyToken is TokenERC20 {

 

    function transfer(address _to, uint256 _value) returns (bool success) {

        if (balances[msg.sender] >= _value && _value > 0) {

            balances[msg.sender] -= _value;

            balances[_to] += _value;

            Transfer(msg.sender, _to, _value);

            return true;

        } else {

            return false;

        }

    }

 

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {

        if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {

            balances[_to] += _value;

            balances[_from] -= _value;

            allowed[_from][msg.sender] -= _value;

            Transfer(_from, _to, _value);

            return true;

        } else {

            return false;

        }

    }

 

    function balanceOf(address _owner) constant returns (uint256 balance) {

        return balances[_owner];

    }

 

    function approve(address _spender, uint256 _value) returns (bool success) {

        allowed[msg.sender][_spender] = _value;

        Approval(msg.sender, _spender, _value);

        return true;

    }

 

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {

        return allowed[_owner][_spender];

    }

 

    mapping (address => uint256) balances;

    mapping (address => mapping (address => uint256)) allowed;

}





 

contract LoveToken is StartMyToken, SafeMath {

 

   

    // metadata

    string  public constant name = "LOVE Token";

    string  public constant symbol = "LOVE";

    uint256 public constant decimals = 1;

    string  public version = "1.1";

 

    // contracts

    address public ethFundDeposit;          // ETH\u5b58\u653e\u5730\u5740

    address public newContractAddr;         // token\u66f4\u65b0\u5730\u5740

 

    // crowdsale parameters

    bool    public isFunding;                // \u72b6\u6001\u5207\u6362\u5230true

    uint256 public fundingStartBlock;

    uint256 public fundingStopBlock;

 

    uint256 public currentSupply;           // \u6b63\u5728\u552e\u5356\u4e2d\u7684tokens\u6570\u91cf

    uint256 public tokenRaised = 0;         // \u603b\u7684\u552e\u5356\u6570\u91cftoken

    uint256 public tokenMigrated = 0;     // \u603b\u7684\u5df2\u7ecf\u4ea4\u6613\u7684 token

    uint256 public tokenExchangeRate = 521;             // 625 BILIBILI \u5151\u6362 1 ETH

 

    // events

    event AllocateToken(address indexed _to, uint256 _value);   // \u5206\u914d\u7684\u79c1\u6709\u4ea4\u6613token;

    event IssueToken(address indexed _to, uint256 _value);      // \u516c\u5f00\u53d1\u884c\u552e\u5356\u7684token;

    event IncreaseSupply(uint256 _value);

    event DecreaseSupply(uint256 _value);

    //event Migrate(address indexed _to, uint256 _value);

    

    mapping (address => bool) public frozenAccount;

    event FrozenFunds(address target, bool frozen);

   

    

    // \u8f6c\u6362

    function formatDecimals(uint256 _value) internal returns (uint256 ) {

        return _value * 10 ** decimals;

    }

 

    // constructor

    function LoveToken(

        address _ethFundDeposit,

        uint256 _currentSupply)

    {

        ethFundDeposit = _ethFundDeposit;

 

        isFunding = false;                           //\u901a\u8fc7\u63a7\u5236\u9884CrowdS ale\u72b6\u6001

        fundingStartBlock = 0;

        fundingStopBlock = 0;

 

        currentSupply = formatDecimals(_currentSupply);

        totalSupply = formatDecimals(5201314);

        balances[msg.sender] = totalSupply;

        if(currentSupply > totalSupply) revert();

    }



    modifier isOwner()  { require(msg.sender == ethFundDeposit); _; }

 

    ///  \u8bbe\u7f6etoken\u6c47\u7387

    function setTokenExchangeRate(uint256 _tokenExchangeRate) isOwner external {

        if (_tokenExchangeRate == 0) revert();

        if (_tokenExchangeRate == tokenExchangeRate) revert();

 

        tokenExchangeRate = _tokenExchangeRate;

    }

 

    /// @dev \u8d85\u53d1token\u5904\u7406

    function increaseSupply (uint256 _value) isOwner external {

        uint256 value = formatDecimals(_value);

        if (value + currentSupply > totalSupply) revert();

        currentSupply = safeAdd(currentSupply, value);

        IncreaseSupply(value);

    }

 

    /// @dev \u88ab\u76d7token\u5904\u7406

    function decreaseSupply (uint256 _value) isOwner external {

        uint256 value = formatDecimals(_value);

        if (value + tokenRaised > currentSupply) revert();

 

        currentSupply = safeSubtract(currentSupply, value);

        DecreaseSupply(value);

    }

 

    ///  \u542f\u52a8\u533a\u5757\u68c0\u6d4b \u5f02\u5e38\u7684\u5904\u7406

    function startFunding (uint256 _fundingStartBlock, uint256 _fundingStopBlock) isOwner external {

        if (isFunding) revert();

        if (_fundingStartBlock >= _fundingStopBlock) revert();

        if (block.number >= _fundingStartBlock) revert();

 

        fundingStartBlock = _fundingStartBlock;

        fundingStopBlock = _fundingStopBlock;

        isFunding = true;

    }

 

    ///  \u5173\u95ed\u533a\u5757\u5f02\u5e38\u5904\u7406

    function stopFunding() isOwner external {

        if (!isFunding) revert();

        isFunding = false;

    }

 

    /// \u5f00\u53d1\u4e86\u4e00\u4e2a\u65b0\u7684\u5408\u540c\u6765\u63a5\u6536token\uff08\u6216\u8005\u66f4\u65b0token\uff09

    function setMigrateContract(address _newContractAddr) isOwner external {

        if (_newContractAddr == newContractAddr) revert();

        newContractAddr = _newContractAddr;

    }

 

    /// \u8bbe\u7f6e\u65b0\u7684\u6240\u6709\u8005\u5730\u5740

    function changeOwner(address _newFundDeposit) isOwner() external {

        if (_newFundDeposit == address(0x0)) revert();

        ethFundDeposit = _newFundDeposit;

    }

 

    ///\u8f6c\u79fbtoken\u5230\u65b0\u7684\u5408\u7ea6

   

 

    /// \u8f6c\u8d26ETH \u5230love\u56e2\u961f

    function transferETH() isOwner external {

        if (this.balance == 0) revert();

        if (!ethFundDeposit.send(this.balance)) revert();

    }

 

    ///  \u5c06LOVE token\u5206\u914d\u5230\u9884\u5904\u7406\u5730\u5740\u3002

    function allocateToken (address _addr, uint256 _eth) isOwner external {

        if (_eth == 0) revert();

        if (_addr == address(0x0)) revert();

 

        uint256 tokens = safeMult(formatDecimals(_eth), tokenExchangeRate);

        if (tokens + tokenRaised > currentSupply) revert();

 

        tokenRaised = safeAdd(tokenRaised, tokens);

        balances[_addr] += tokens;

 

        AllocateToken(_addr, tokens);  // \u8bb0\u5f55token\u65e5\u5fd7

    }

 

    /// \u8d2d\u4e70love token

    function () payable {

        require (!isFunding);

        if (msg.value == 0) revert();

 

        if (block.number < fundingStartBlock) revert();

        if (block.number > fundingStopBlock) revert();

 

        uint256 tokens = safeMult(msg.value, tokenExchangeRate);

        if (tokens + tokenRaised > currentSupply) revert();

 

        tokenRaised = safeAdd(tokenRaised, tokens);

        balances[msg.sender] += tokens;

 

        IssueToken(msg.sender, tokens);  //\u8bb0\u5f55\u65e5\u5fd7

    }

}
