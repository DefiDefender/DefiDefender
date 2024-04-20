// File: zeppelin-solidity\\contracts\\ownership\\Ownable.sol



pragma solidity ^0.4.11;





/**

 * @title Ownable

 * @dev The Ownable contract has an owner address, and provides basic authorization control

 * functions, this simplifies the implementation of "user permissions".

 */

contract Ownable {

  address public owner;





  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);





  /**

   * @dev The Ownable constructor sets the original `owner` of the contract to the sender

   * account.

   */

  function Ownable() {

    owner = msg.sender;

  }





  /**

   * @dev Throws if called by any account other than the owner.

   */

  modifier onlyOwner() {

    require(msg.sender == owner);

    _;

  }





  /**

   * @dev Allows the current owner to transfer control of the contract to a newOwner.

   * @param newOwner The address to transfer ownership to.

   */

  function transferOwnership(address newOwner) onlyOwner public {

    require(newOwner != address(0));

    OwnershipTransferred(owner, newOwner);

    owner = newOwner;

  }



}



// File: node_modules\\zeppelin-solidity\\contracts  oken\\ERC20Basic.sol



pragma solidity ^0.4.11;





/**

 * @title ERC20Basic

 * @dev Simpler version of ERC20 interface

 * @dev see https://github.com/ethereum/EIPs/issues/179

 */

contract ERC20Basic {

  uint256 public totalSupply;

  function balanceOf(address who) public constant returns (uint256);

  function transfer(address to, uint256 value) public returns (bool);

  event Transfer(address indexed from, address indexed to, uint256 value);

}



// File: node_modules\\zeppelin-solidity\\contracts\\math\\SafeMath.sol



pragma solidity ^0.4.11;





/**

 * @title SafeMath

 * @dev Math operations with safety checks that throw on error

 */

library SafeMath {

  function mul(uint256 a, uint256 b) internal constant returns (uint256) {

    uint256 c = a * b;

    assert(a == 0 || c / a == b);

    return c;

  }



  function div(uint256 a, uint256 b) internal constant returns (uint256) {

    // assert(b > 0); // Solidity automatically throws when dividing by 0

    uint256 c = a / b;

    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

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



// File: node_modules\\zeppelin-solidity\\contracts  oken\\BasicToken.sol



pragma solidity ^0.4.11;









/**

 * @title Basic token

 * @dev Basic version of StandardToken, with no allowances.

 */

contract BasicToken is ERC20Basic {

  using SafeMath for uint256;



  mapping(address => uint256) balances;



  /**

  * @dev transfer token for a specified address

  * @param _to The address to transfer to.

  * @param _value The amount to be transferred.

  */

  function transfer(address _to, uint256 _value) public returns (bool) {

    require(_to != address(0));



    // SafeMath.sub will throw if there is not enough balance.

    balances[msg.sender] = balances[msg.sender].sub(_value);

    balances[_to] = balances[_to].add(_value);

    Transfer(msg.sender, _to, _value);

    return true;

  }



  /**

  * @dev Gets the balance of the specified address.

  * @param _owner The address to query the the balance of.

  * @return An uint256 representing the amount owned by the passed address.

  */

  function balanceOf(address _owner) public constant returns (uint256 balance) {

    return balances[_owner];

  }



}



// File: node_modules\\zeppelin-solidity\\contracts  oken\\ERC20.sol



pragma solidity ^0.4.11;







/**

 * @title ERC20 interface

 * @dev see https://github.com/ethereum/EIPs/issues/20

 */

contract ERC20 is ERC20Basic {

  function allowance(address owner, address spender) public constant returns (uint256);

  function transferFrom(address from, address to, uint256 value) public returns (bool);

  function approve(address spender, uint256 value) public returns (bool);

  event Approval(address indexed owner, address indexed spender, uint256 value);

}



// File: node_modules\\zeppelin-solidity\\contracts  oken\\StandardToken.sol



pragma solidity ^0.4.11;









/**

 * @title Standard ERC20 token

 *

 * @dev Implementation of the basic standard token.

 * @dev https://github.com/ethereum/EIPs/issues/20

 * @dev Based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol

 */

contract StandardToken is ERC20, BasicToken, Ownable {



  mapping (address => mapping (address => uint256)) allowed;





  /**

   * @dev Transfer tokens from one address to another

   * @param _from address The address which you want to send tokens from

   * @param _to address The address which you want to transfer to

   * @param _value uint256 the amount of tokens to be transferred

   */

  function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {

    require(_to != address(0));



    uint256 _allowance = allowed[_from][msg.sender];



    // Check is not needed because sub(_allowance, _value) will already throw if this condition is not met

    // require (_value <= _allowance);



    balances[_from] = balances[_from].sub(_value);

    balances[_to] = balances[_to].add(_value);

    allowed[_from][msg.sender] = _allowance.sub(_value);

    Transfer(_from, _to, _value);

    return true;

  }



  /**

   * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.

   *

   * Beware that changing an allowance with this method brings the risk that someone may use both the old

   * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this

   * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:

   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729

   * @param _spender The address which will spend the funds.

   * @param _value The amount of tokens to be spent.

   */

  function approve(address _spender, uint256 _value) public returns (bool) {

    allowed[msg.sender][_spender] = _value;

    Approval(msg.sender, _spender, _value);

    return true;

  }



  /**

   * @dev Function to check the amount of tokens that an owner allowed to a spender.

   * @param _owner address The address which owns the funds.

   * @param _spender address The address which will spend the funds.

   * @return A uint256 specifying the amount of tokens still available for the spender.

   */

  function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {

    return allowed[_owner][_spender];

  }



  /**

   * approve should be called when allowed[_spender] == 0. To increment

   * allowed value is better to use this function to avoid 2 calls (and wait until

   * the first transaction is mined)

   * From MonolithDAO Token.sol

   */

  function increaseApproval (address _spender, uint _addedValue)

    returns (bool success) {

    allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);

    Approval(msg.sender, _spender, allowed[msg.sender][_spender]);

    return true;

  }



  function decreaseApproval (address _spender, uint _subtractedValue)

    returns (bool success) {

    uint oldValue = allowed[msg.sender][_spender];

    if (_subtractedValue > oldValue) {

      allowed[msg.sender][_spender] = 0;

    } else {

      allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);

    }

    Approval(msg.sender, _spender, allowed[msg.sender][_spender]);

    return true;

  }

  

  event Mint(address indexed to, uint256 amount);

  event MintFinished();



  bool public mintingFinished = false;





  modifier canMint() {

    require(!mintingFinished);

    _;

  }



  /**

   * @dev Function to mint tokens

   * @param _to The address that will receive the minted tokens.

   * @param _amount The amount of tokens to mint.

   * @return A boolean that indicates if the operation was successful.

   */

  function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {

    totalSupply = totalSupply.add(_amount);

    balances[_to] = balances[_to].add(_amount);

    Mint(_to, _amount);

    Transfer(0x0, _to, _amount);

    return true;

  }



  /**

   * @dev Function to stop minting new tokens.

   * @return True if the operation was successful.

   */

  function finishMinting() onlyOwner public returns (bool) {

    mintingFinished = true;

    MintFinished();

    return true;

  }



}









// File: contracts\\OdinalaToken.sol



pragma solidity ^0.4.15;





/**

 * Final token

 */

contract OdinalaToken is StandardToken {



    string public constant name = "Odinala Token";

    string public constant symbol = "ODN";

    uint8 public constant decimals = 18;



    function OdinalaToken()

        public

         { }

}





// File: node_modules\\zeppelin-solidity\\contracts\\crowdsale\\Crowdsale.sol



pragma solidity ^0.4.11;







/**

 * @title Crowdsale

 * @dev Crowdsale is a base contract for managing a token crowdsale.

 * Crowdsales have a start and end timestamps, where investors can make

 * token purchases and the crowdsale will assign them tokens based

 * on a token per ETH rate. Funds collected are forwarded to a wallet

 * as they arrive.

 */

contract Crowdsale {

  using SafeMath for uint256;



  // The token being sold

  StandardToken public token;



  // start and end timestamps where investments are allowed (both inclusive)

  uint256 public startTime;

  uint256 public endTime;



  // address where funds are collected

  address public wallet;



  // how many token units a buyer gets per wei

  uint256 public rate;



  // amount of raised money in wei

  uint256 public weiRaised;



  /**

   * event for token purchase logging

   * @param purchaser who paid for the tokens

   * @param beneficiary who got the tokens

   * @param value weis paid for purchase

   * @param amount amount of tokens purchased

   */

  event TokenPurchase(address indexed purchaser, address indexed beneficiary, uint256 value, uint256 amount);





  function Crowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet) {

    require(_endTime >= _startTime);

    require(_rate > 0);

    require(_wallet != 0x0);



    token = createTokenContract();

    startTime = _startTime;

    endTime = _endTime;

    rate = _rate;

    wallet = _wallet;

  }



  // creates the token to be sold.

  // override this method to have crowdsale of a specific mintable token.

  function createTokenContract() internal returns (StandardToken) {

    return new StandardToken();

  }





  // fallback function can be used to buy tokens

  function () payable {

    buyTokens(msg.sender);

  }



  // low level token purchase function

  function buyTokens(address beneficiary) public payable {

    require(beneficiary != 0x0);

    require(validPurchase());



    uint256 weiAmount = msg.value;



    // calculate token amount to be created

    uint256 tokens = weiAmount.mul(rate);



    // update state

    weiRaised = weiRaised.add(weiAmount);



    token.approve(this,tokens);

    token.transferFrom(this,beneficiary,tokens);

    TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);



    forwardFunds();

  }



  // send ether to the fund collection wallet

  // override to create custom fund forwarding mechanisms

  function forwardFunds() internal {

    wallet.transfer(msg.value);

  }



  // @return true if the transaction can buy tokens

  function validPurchase() internal constant returns (bool) {

    bool withinPeriod = now >= startTime && now <= endTime;

    bool nonZeroPurchase = msg.value != 0;

    return withinPeriod && nonZeroPurchase;

  }



  // @return true if crowdsale event has ended

  function hasEnded() public constant returns (bool) {

    return now > endTime;

  }





}



// File: zeppelin-solidity\\contracts\\crowdsale\\CappedCrowdsale.sol



pragma solidity ^0.4.11;



/**

 * @title CappedCrowdsale

 * @dev Extension of Crowdsale with a max amount of funds raised

 */

contract CappedCrowdsale is Crowdsale {

  using SafeMath for uint256;



  uint256 public cap;

  bool private circuitBreaker;



  function CappedCrowdsale(uint256 _cap) {

    require(_cap > 0);

    cap = _cap;

    circuitBreaker = false;

  }



  // overriding Crowdsale#validPurchase to add extra cap logic

  // @return true if investors can buy at the moment

  function validPurchase() internal constant returns (bool) {

    bool withinCap = weiRaised.add(msg.value) <= cap;

    return super.validPurchase() && withinCap && !circuitBreaker;

  }



  // overriding Crowdsale#hasEnded to add cap logic

  // @return true if crowdsale event has ended

  function hasEnded() public constant returns (bool) {

    bool capReached = weiRaised >= cap;

    return super.hasEnded() || capReached || circuitBreaker;

  }

  

  function triggerCircuitBreaker() internal{

      require(circuitBreaker == false);

      circuitBreaker = true;

  }



}





// File: contracts\\ExternalTokenCrowdsale.sol



pragma solidity ^0.4.15;



/**

 * @title ExternalTokenCrowdsale

 * @dev Extension of Crowdsale with an externally provided token

 * with implicit ownership grant over it

 */

contract ExternalTokenCrowdsale is Crowdsale {

    function ExternalTokenCrowdsale(StandardToken _token) public {

        require(_token != address(0));

        // Modify underlying token variable 

        // (createTokenContract has already been called)

        token = _token;

    }



    function createTokenContract() internal returns (StandardToken) {

        return StandardToken(0x0); // Placeholder

    }

}





// File: contracts\\PreICOCrowdsale.sol



pragma solidity ^0.4.15;





/**

 * Crowdsale with injected token, permissions have to be ensured by creator

 */

contract PreICOCrowdsale is Ownable, CappedCrowdsale, ExternalTokenCrowdsale {



    //the value needs to less or equal than a cap which is limit for accepted funds

    uint256 public constant CAP = 619 ether;

    

    function PreICOCrowdsale(

        address _wallet,

        StandardToken _token,

        uint256 start

    )

        public

        CappedCrowdsale(CAP) // Cap

        Crowdsale(

            start, 

            1630454400, //sept 2021

            2439, // Rate

            _wallet

        )

        ExternalTokenCrowdsale(_token)

    { 

      

    }

    

     function stopSale() onlyOwner public{

       triggerCircuitBreaker();

    }

    

}
