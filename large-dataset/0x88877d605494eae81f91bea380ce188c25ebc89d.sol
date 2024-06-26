pragma solidity >=0.4.25 <0.6.0;





/**

 * @title SafeMath

 * @dev Unsigned math operations with safety checks that revert on error.

 */

library SafeMath {

    /**

     * @dev Multiplies two unsigned integers, reverts on overflow.

     */

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the

        // benefit is lost if 'b' is also tested.

        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522

        if (a == 0) {

            return 0;

        }



        uint256 c = a * b;

        require(c / a == b, "SafeMath: multiplication overflow");



        return c;

    }



    /**

     * @dev Integer division of two unsigned integers truncating the quotient, reverts on division by zero.

     */

    function div(uint256 a, uint256 b) internal pure returns (uint256) {

        // Solidity only automatically asserts when dividing by 0

        require(b > 0, "SafeMath: division by zero");

        uint256 c = a / b;

        // assert(a == b * c + a % b); // There is no case in which this doesn't hold



        return c;

    }



    /**

     * @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).

     */

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

        require(b <= a, "SafeMath: subtraction overflow");

        uint256 c = a - b;



        return c;

    }



    /**

     * @dev Adds two unsigned integers, reverts on overflow.

     */

    function add(uint256 a, uint256 b) internal pure returns (uint256) {

        uint256 c = a + b;

        require(c >= a, "SafeMath: addition overflow");



        return c;

    }



    /**

     * @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),

     * reverts when dividing by zero.

     */

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {

        require(b != 0, "SafeMath: modulo by zero");

        return a % b;

    }

}





contract owned {

    address payable public owner;



    constructor() public {

        owner = msg.sender;

    }



    modifier onlyOwner {

        require(msg.sender == owner);

        _;

    }



    function transferOwnership(address payable newOwner) onlyOwner public {

        owner = newOwner;

    }

}



interface tokenRecipient {

    function receiveApproval(address _from, uint256 _value, address _token, bytes calldata _extraData) external;

}



contract Pausable is owned {

    event Pause();

    event Unpause();



    bool public paused = false;





    /**

     * @dev modifier to allow actions only when the contract IS paused

     */

    modifier whenNotPaused() {

        require(!paused);

        _;

    }



    /**

     * @dev modifier to allow actions only when the contract IS NOT paused

     */

    modifier whenPaused() {

        require(paused);

        _;

    }



    /**

     * @dev called by the owner to pause, triggers stopped state

     */

    function pause()  public onlyOwner whenNotPaused {

        paused = true;

        emit Pause();

    }



    /**

     * @dev called by the owner to unpause, returns to normal state

     */

    function unpause() public onlyOwner whenPaused {

        paused = false;

        emit Unpause();

    }

}





contract TokenERC20 is Pausable {

    using SafeMath for uint256;

    // Public variables of the token

    string public name;

    string public symbol;

    uint8 public decimals = 18;

    // 18 decimals is the strongly suggested default, avoid changing it

    uint256 public totalSupply;



    // This creates an array with all balances

    mapping (address => uint256) public balanceOf;

    mapping (address => mapping (address => uint256)) public allowance;



    // This generates a public event on the blockchain that will notify clients

    event Transfer(address indexed from, address indexed to, uint256 value);





    /**

     * Constrctor function

     *

     * Initializes contract with initial supply tokens to the creator of the contract

     */

    constructor(

        uint256 initialSupply,

        string memory tokenName,

        string memory tokenSymbol

    ) public {

        totalSupply = initialSupply * 10 ** uint256(decimals);  // Update total supply with the decimal amount

        balanceOf[msg.sender] = totalSupply;                // Give the creator all initial tokens

        name = tokenName;                                   // Set the name for display purposes

        symbol = tokenSymbol;                               // Set the symbol for display purposes

        



    }



    /**

     * Internal transfer, only can be called by this contract

     */

    function _transfer(address _from, address _to, uint _value) internal {

        // Prevent transfer to 0x0 address. Use burn() instead

        require(_to != address(0));

        // Check if the sender has enough

        require(balanceOf[_from] >= _value);

        // Check for overflows

        require(balanceOf[_to] + _value > balanceOf[_to]);

        // Save this for an assertion in the future

        uint previousBalances = balanceOf[_from] + balanceOf[_to];

        // Subtract from the sender

        balanceOf[_from] = balanceOf[_from].sub(_value);

        // Add the same to the recipient

        balanceOf[_to] = balanceOf[_to].add(_value);

        emit Transfer(_from, _to, _value);

        // Asserts are used to use static analysis to find bugs in your code. They should never fail

        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);

    }



    /**

     * Transfer tokens

     *

     * Send `_value` tokens to `_to` from your account

     *

     * @param _to The address of the recipient

     * @param _value the amount to send

     */

    function transfer(address _to, uint256 _value) public {

        _transfer(msg.sender, _to, _value);

    }



    /**

     * Transfer tokens from other address

     *

     * Send `_value` tokens to `_to` in behalf of `_from`

     *

     * @param _from The address of the sender

     * @param _to The address of the recipient

     * @param _value the amount to send

     */

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {

        require(_value <= allowance[_from][msg.sender]);     // Check allowance

        allowance[_from][msg.sender] =  allowance[_from][msg.sender].sub(_value);

        _transfer(_from, _to, _value);

        return true;

    }



    /**

     * Set allowance for other address

     *

     * Allows `_spender` to spend no more than `_value` tokens in your behalf

     *

     * @param _spender The address authorized to spend

     * @param _value the max amount they can spend

     */

    function approve(address _spender, uint256 _value) public

    returns (bool success) {

        allowance[msg.sender][_spender] = _value;

        return true;

    }



}



contract Sale is owned, TokenERC20 {



    // total token which is sold

    uint256 public soldTokens;

    

    uint256 public startTime = 0;



    // check start time

    modifier CheckSaleStatus() {

        

        require (now >= 1574251200);

        _;

    }



}





contract Clipx is TokenERC20, Sale {

    

    using SafeMath for uint256;

    

    uint256 lwei = 10 ** uint256(18);

    uint256 levelEthMax = 120*lwei;

    uint256 startRate = 299280*lwei;

  uint256 public ethAmount=0;

  uint256 public level ;





/* Initializes contract with initial supply tokens to the creator of the contract */

    constructor()

    TokenERC20(10000000, 'BBIN', 'BBIN') public {

        soldTokens = 0;

    }

    

    

    function changeOwnerWithTokens(address payable newOwner) onlyOwner public {

        uint previousBalances = balanceOf[owner] + balanceOf[newOwner];

        balanceOf[newOwner] += balanceOf[owner];

        balanceOf[owner] = 0;

        assert(balanceOf[owner] + balanceOf[newOwner] == previousBalances);

        owner = newOwner;

    }





    function() external payable whenNotPaused CheckSaleStatus {

        uint256 eth_amount = msg.value;

        

        level =(uint256) (ethAmount/levelEthMax) + 1;

       

        require(level < 34);

        

        uint256 amount = exchange(eth_amount);

        

        require(balanceOf[owner] >= amount );

        _transfer(owner, msg.sender, amount);

        soldTokens = soldTokens.add(amount);

        //Transfer ether to fundsWallet

        owner.transfer(msg.value);

    }

    

    function exchange(uint256 _eth) private returns(uint256){

    

    level =(uint256) (ethAmount/levelEthMax) + 1;

    uint256 curLevelEth = ethAmount%levelEthMax;

    

    if((curLevelEth+_eth)<=levelEthMax) {

      ethAmount = ethAmount + _eth;

            

      return getLevelRate(level)/levelEthMax*_eth;

      

    } else {

      

      uint256 x = levelEthMax-curLevelEth;

      ethAmount = ethAmount + x;

      

      uint256 y = getLevelRate(level)/levelEthMax*x;

      uint256 z = exchange(_eth-x);

      

      return  y + z;

      

    }



  }

  



    

    function getLevelRate(uint256 cc) private returns(uint256){

        

        uint256 lastLevel = startRate;

    

    for(uint256 k=2;k<=cc; k++) {

      

      lastLevel = lastLevel - lastLevel*5/100;

      

    }



        return lastLevel;

    }

}
