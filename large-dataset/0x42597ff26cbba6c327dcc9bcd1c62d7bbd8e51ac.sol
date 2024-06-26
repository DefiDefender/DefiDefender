/**
 * Source Code first verified at https://etherscan.io on Wednesday, February 14, 2018
 (UTC) */

pragma solidity ^0.4.18;

/** These Contract is created for Pre-Sale and Sale of TILX Coin,
 * this is created for all coins required for crowdfunding
 * this includes bonus for Pre-Sale and Sale, that are in this way:
 * 65% Pre Sale (Huge Competitive Percent)
 * 50% First Round
 * 40% Second Round
 * 20% Third Round
 * Detailed at www.tilxcoin.com
 * 
 * All these coins are the necessary amount for covering Bonus needed.
 * Exact distribution announced will be done.
 * 
 * SafeMath library used for security
 * 
 * THESE IS A COIN FOR A GREAT, EDUCATIONAL, SOCIAL AND ENTERTAINMENT PROJECT*/
 

/** All needed functions here in IERC20,
 * this will be used for contract*/
 

interface IERC20 {
    function totalSupply() public constant returns (uint256);
    function balanceOf(address _owner) public constant returns (uint256 balance);
    function transfer(address _to, uint256 _value) public returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
    function approve(address _spender, uint256 _value) public returns (bool success);
    function allowance(address _owner, address _spender) public constant returns (uint256 remaining);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}




/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  /**
  * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}




contract tilxtoken is IERC20 {
    
    using SafeMath for uint256;
    
    uint public constant _totalSupply = 52500000000000000000000000;
    
    string public constant symbol = "TILX";
    string public constant name = "TILX COIN";
    uint8 public constant decimals = 18;
    
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    
    
    function tilxtoken() public {
        balances[msg.sender] = _totalSupply;
    }
    
    function totalSupply() public constant returns (uint256){
        return _totalSupply;
        
    }
    function balanceOf(address _owner) public constant returns (uint256 balance){
        return balances[_owner];
        
    }
    function transfer(address _to, uint256 _value) public returns (bool success){
        require(
            balances[msg.sender] >= _value
            && _value>0 
        );
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        Transfer(msg.sender, _to, _value);
        return true;
        
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(
            allowed[_from][msg.sender] >= _value
            && balances[_from] >= _value
            && _value > 0 
        );
        balances[_from] -= balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        Transfer(_from, _to, _value);
        return true;
        
    }
    
    function approve(address _spender, uint256 _value) public returns (bool success){
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
        
    }
    function allowance(address _owner, address _spender) public constant returns (uint256 remaining){
         return allowed[_owner][_spender];
        
    }
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
