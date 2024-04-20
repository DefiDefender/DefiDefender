/**
 *Submitted for verification at Etherscan.io on 2018-11-20
*/

pragma solidity ^0.4.19;

// File: contracts/SafeMath.sol

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

// File: contracts/ERC20.sol

// Abstract contract for the full ERC 20 Token standard
// https://github.com/ethereum/EIPs/issues/20
pragma solidity ^0.4.19;


/*
This contract was editted and deploy by ICONEMY - An platform that makes crypto easy! 
For more information check: www.iconemy.io

This Token Contract implements the standard token functionality (https://github.com/ethereum/EIPs/issues/20) as well as the following OPTIONAL extras intended for use by humans. 

This contract was adapted by Iconemy to suit the EtherMania token.
*/
contract ERC20 {
    using SafeMath for uint256;

    /* Public variables of the token */
    uint256 constant MAX_UINT256 = 2**256 - 1;
    string public name = "EtherMania Asset";                   
    uint8 public decimals = 18;                
    string public symbol = "EMA";                 
    uint256 public totalSupply = 1200000000000000000000000;  
    uint256 public multiplier = 100000000;
    address public initialOwner = 0x715b94a938dC6c3651CD43bd61284719772F3D86;
    mapping (address => uint256) balances;   

    function ERC20() public {
        balances[initialOwner] = totalSupply;               
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Burn(address indexed burner, uint256 value);

    /**
     * @dev Burns a specific amount of tokens.
     * @param _value The amount of token to be burned.
     */
    function burn(uint256 _value) public {
        require(_value <= balances[msg.sender]);
        // no need to require value <= totalSupply, since that would imply the
        // sender's balance is greater than the totalSupply, which *should* be an assertion failure

        address burner = msg.sender;
        balances[burner] = balances[burner].sub(_value);
        totalSupply = totalSupply.sub(_value);
        Burn(burner, _value);
    }

    // Get the balance of this caller
    function balanceOf(address _owner) constant public returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        //Call internal transfer method
        if(_transfer(msg.sender, _to, _value)){
            return true;
        } else {
            return false;
        }
    }

    function _transfer(address _from, address _to, uint256 _value) internal returns(bool success){
        // Prevent transfer to 0x0 address. Use burn() instead
        require(_to != 0x0);
        // Check if the sender has enough
        require(balances[_from] >= _value);
        // Check for overflows (as max number is 2**256 - 1 - balances will overflow after that)
        require(balances[_to] + _value > balances[_to]);
        // Save this for an assertion in the future
        uint previousBalances = balances[_from] + balances[_to];
        // Subtract from the sender
        balances[_from] = balances[_from].sub(_value);
        // Add the same to the recipient
        balances[_to] =  balances[_to].add(_value);

        Transfer(_from, _to, _value);

        // Asserts are used to use static analysis to find bugs in your code. They should never fail
        assert(balances[_from] + balances[_to] == previousBalances);

        return true;
    }
}

// File: contracts/ERC20_allowance.sol

// Abstract contract for the full ERC 20 Token standard
// https://github.com/ethereum/EIPs/issues/20
pragma solidity ^0.4.19;



/*
This contract was editted and deploy by ICONEMY - An platform that makes crypto easy! 
For more information check: www.iconemy.io

This Token Contract implements the standard token functionality (https://github.com/ethereum/EIPs/issues/20) as well as the following OPTIONAL extras intended for use by humans.

This contract was then adapted by Iconemy to suit the EtherMania token 

1) Initial Finite Supply (upon creation one specifies how much is minted).
2) Optional approveAndCall() functionality to notify a contract if an approval() has occurred.
*/
contract ERC20_allowance is ERC20 {
    using SafeMath for uint256;

    mapping (address => mapping (address => uint256)) allowed;   

    // Constructor function which takes in values from migrations and passes to parent contract
    function ERC20_allowance() public ERC20() {}

    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // Get the allowance of a spender for a certain account
    function allowanceOf(address _owner, address _spender) public constant returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        //Check the allowance of the address spending tokens on behalf of account
        uint256 allowance = allowanceOf(_from, msg.sender);
        //Require that they must have more in their allowance than they wish to send
        require(allowance >= _value);

        //Require that allowance isnt the max integer
        require(allowance < MAX_UINT256);
            
        //If so, take from their allowance and transfer
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);

        if(_transfer(_from, _to, _value)){
            return true;
        } else {
            return false;
        } 
        
    }

    // Approve the allowance for a certain spender
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function approveAndCall(address _spender, uint256 _value) public returns (bool success) {
        // This function is used by contracts to allowing the token to notify them when an approval has been made. 
        tokenSpender spender = tokenSpender(_spender);

        if(approve(_spender, _value)){
            spender.receiveApproval();
            return true;
        }
    }
}

// Interface for Metafusions crowdsale contract
contract tokenSpender { 
    function receiveApproval() external; 
}
