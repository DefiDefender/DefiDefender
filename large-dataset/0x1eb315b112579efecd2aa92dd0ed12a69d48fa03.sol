pragma solidity >=0.4.16 <0.7.0; /*

___________________________________________________________________
  _      _                                        ______           
  |  |  /          /                                /              
--|-/|-/-----__---/----__----__---_--_----__-------/-------__------
  |/ |/    /___) /   /   ' /   ) / /  ) /___)     /      /   )     
__/__|____(___ _/___(___ _(___/_/_/__/_(___ _____/______(___/__o_o_


 \u2588\u2588\u2557       \u2588\u2588\u2557\u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2557\u2588\u2588\u2588\u2588\u2588\u2588\u2557 \u2588\u2588\u2557     \u2588\u2588\u2557\u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2557\u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2557 \u2588\u2588\u2588\u2588\u2588\u2588\u2557  \u2588\u2588\u2588\u2588\u2588\u2557 \u2588\u2588\u2557     \u2588\u2588\u2588\u2588\u2588\u2588\u2557
 \u2588\u2588\u2551  \u2588\u2588\u2557  \u2588\u2588\u2551\u2588\u2588\u2554\u2550\u2550\u2550\u2550\u255d\u2588\u2588\u2554\u2550\u2550\u2588\u2588\u2557\u2588\u2588\u2551     \u2588\u2588\u2551\u2588\u2588\u2554\u2550\u2550\u2550\u2550\u255d\u2588\u2588\u2554\u2550\u2550\u2550\u2550\u255d\u2588\u2588\u2554\u2550\u2550\u2550\u2550\u255d \u2588\u2588\u2554\u2550\u2550\u2588\u2588\u2557\u2588\u2588\u2551     \u2588\u2588\u2554\u2550\u2550\u2588\u2588\u2557
 \u255a\u2588\u2588\u2557\u2588\u2588\u2588\u2588\u2557\u2588\u2588\u2554\u255d\u2588\u2588\u2588\u2588\u2588\u2557  \u2588\u2588\u2588\u2588\u2588\u2588\u2566\u255d\u2588\u2588\u2551     \u2588\u2588\u2551\u2588\u2588\u2588\u2588\u2588\u2557  \u2588\u2588\u2588\u2588\u2588\u2557  \u2588\u2588\u2551  \u2588\u2588\u2557 \u2588\u2588\u2551  \u2588\u2588\u2551\u2588\u2588\u2551     \u2588\u2588\u2551  \u2588\u2588\u2551
  \u2588\u2588\u2588\u2588\u2554\u2550\u2588\u2588\u2588\u2588\u2551 \u2588\u2588\u2554\u2550\u2550\u255d  \u2588\u2588\u2554\u2550\u2550\u2588\u2588\u2557\u2588\u2588\u2551     \u2588\u2588\u2551\u2588\u2588\u2554\u2550\u2550\u255d  \u2588\u2588\u2554\u2550\u2550\u255d  \u2588\u2588\u2551  \u255a\u2588\u2588\u2557\u2588\u2588\u2551  \u2588\u2588\u2551\u2588\u2588\u2551     \u2588\u2588\u2551  \u2588\u2588\u2551
  \u255a\u2588\u2588\u2554\u255d \u255a\u2588\u2588\u2554\u255d \u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2557\u2588\u2588\u2588\u2588\u2588\u2588\u2566\u255d\u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2557\u2588\u2588\u2551\u2588\u2588\u2551     \u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2557\u255a\u2588\u2588\u2588\u2588\u2588\u2588\u2554\u255d\u255a\u2588\u2588\u2588\u2588\u2588\u2554\u255d\u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2557\u2588\u2588\u2588\u2588\u2588\u2588\u2554\u255d
   \u255a\u2550\u255d   \u255a\u2550\u255d  \u255a\u2550\u2550\u2550\u2550\u2550\u2550\u255d\u255a\u2550\u2550\u2550\u2550\u2550\u255d \u255a\u2550\u2550\u2550\u2550\u2550\u2550\u255d\u255a\u2550\u255d\u255a\u2550\u255d     \u255a\u2550\u2550\u2550\u2550\u2550\u2550\u255d \u255a\u2550\u2550\u2550\u2550\u2550\u255d  \u255a\u2550\u2550\u2550\u2550\u255d \u255a\u2550\u2550\u2550\u2550\u2550\u2550\u255d\u255a\u2550\u2550\u2550\u2550\u2550\u255d


=== 'WeblifeGold' Token contract with following features ===
    => ERC20 Compliance
    => Higher degree of control by owner - safeguard functionality
    => SafeMath implementation 
    => Burnable and minting 


======================= Quick Stats ===================
    => Name             : WeblifeGold
    => Symbol           : WLG
    => Initial Supply   : 1000000
    => Total supply     : 180000000
    => Decimals         : 18
    
====================== Minting Logic ===================
    => 1:200

-------------------------------------------------------------------
 Copyright (c) 2020 onwards Weblifegold.
 Contract designed with \u2764 by P&P
-------------------------------------------------------------------
*/ 
library SafeMath {
  function mul(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal constant returns (uint256) {
    assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal constant returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

 interface ERC20 {
    function totalSupply() public view returns(uint supply);

    function balanceOf(address _owner) public view returns(uint balance);

    function transfer(address _to, uint _value) public returns(bool success);

    function transferFrom(address _from, address _to, uint _value) public returns(bool success);

    function approve(address _spender, uint _value) public returns(bool success);

    function allowance(address _owner, address _spender) public view returns(uint remaining);

    function decimals() public view returns(uint digits);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}


    // ERC20 Token Smart Contract
    contract C_weblifegold {
        
        string public constant name = "WeblifeGold";
        string public constant symbol = "WLG";
        uint8 public constant decimals = 18;
        uint public _totalSupply = 1000000000000000000000000000000000000;
        uint256 public RATE = 1;
        bool public isMinting = true;
        string public constant generatedBy  = "P&P";
        
        using SafeMath for uint256;
        address public owner;
        
         // Functions with this modifier can only be executed by the owner
         modifier onlyOwner() {
            if (msg.sender != owner) {
                throw;
            }
             _;
         }
     
        // Balances for each account
        mapping(address => uint256) balances;
        // Owner of account approves the transfer of an amount to another account
        mapping(address => mapping(address=>uint256)) allowed;

        // Its a payable function works as a token factory.
        function () payable{
            createTokens();
        }

        // Constructor
        constructor() {
            owner = 0x494590a9b9545964b60012De52930a1B0F13eD36; 
            balances[owner] = _totalSupply;
        }

        //allows owner to burn tokens that are not sold in a crowdsale
        function burnTokens(uint256 _value) onlyOwner {

             require(balances[msg.sender] >= _value && _value > 0 );
             _totalSupply = _totalSupply.sub(_value);
             balances[msg.sender] = balances[msg.sender].sub(_value);
             
        }



        // This function creates Tokens  
         function createTokens() payable {
            if(isMinting == true){
                require(msg.value > 0);
                uint256  tokens = msg.value.div(100000000000000).mul(RATE);
                balances[msg.sender] = balances[msg.sender].add(tokens);
                _totalSupply = _totalSupply.add(tokens);
                owner.transfer(msg.value);
            }
            else{
                throw;
            }
        }


        function endCrowdsale() onlyOwner {
            isMinting = false;
        }

        function changeCrowdsaleRate(uint256 _value) onlyOwner {
            RATE = _value;
        }


        
        function totalSupply() constant returns(uint256){
            return _totalSupply;
        }
        // What is the balance of a particular account?
        function balanceOf(address _owner) constant returns(uint256){
            return balances[_owner];
        }

         // Transfer the balance from owner's account to another account   
        function transfer(address _to, uint256 _value)  returns(bool) {
            require(balances[msg.sender] >= _value && _value > 0 );
            balances[msg.sender] = balances[msg.sender].sub(_value);
            balances[_to] = balances[_to].add(_value);
            Transfer(msg.sender, _to, _value);
            return true;
        }
        
    // Send _value amount of tokens from address _from to address _to
    // The transferFrom method is used for a withdraw workflow, allowing contracts to send
    // tokens on your behalf, for example to "deposit" to a contract address and/or to charge
    // fees in sub-currencies; the command should fail unless the _from account has
    // deliberately authorized the sender of the message via some mechanism; we propose
    // these standardized APIs for approval:
    function transferFrom(address _from, address _to, uint256 _value)  returns(bool) {
        require(allowed[_from][msg.sender] >= _value && balances[_from] >= _value && _value > 0);
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        Transfer(_from, _to, _value);
        return true;
    }
    
    // Allow _spender to withdraw from your account, multiple times, up to the _value amount.
    // If this function is called again it overwrites the current allowance with _value.
    function approve(address _spender, uint256 _value) returns(bool){
        allowed[msg.sender][_spender] = _value; 
        Approval(msg.sender, _spender, _value);
        return true;
    }
    
    // Returns the amount which _spender is still allowed to withdraw from _owner
    function allowance(address _owner, address _spender) constant returns(uint256){
        return allowed[_owner][_spender];
    }
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
