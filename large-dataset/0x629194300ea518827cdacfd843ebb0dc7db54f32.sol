pragma solidity ^0.6.0;



// SPDX-License-Identifier: UNLICENSED



/**

 * @dev Wrappers over Solidity's arithmetic operations with added overflow

 * checks.

 *

 * Arithmetic operations in Solidity wrap on overflow. This can easily result

 * in bugs, because programmers usually assume that an overflow raises an

 * error, which is the standard behavior in high level programming languages.

 * `SafeMath` restores this intuition by reverting the transaction when an

 * operation overflows.

 *

 * Using this library instead of the unchecked operations eliminates an entire

 * class of bugs, so it's recommended to use it always.

 */

library SafeMath {

    /**

     * @dev Returns the addition of two unsigned integers, reverting on

     * overflow.

     *

     * Counterpart to Solidity's `+` operator.

     *

     * Requirements:

     *

     * - Addition cannot overflow.

     */

    function add(uint256 a, uint256 b) internal pure returns (uint256) {

        uint256 c = a + b;

        require(c >= a, "SafeMath: addition overflow");



        return c;

    }



    /**

     * @dev Returns the subtraction of two unsigned integers, reverting on

     * overflow (when the result is negative).

     *

     * Counterpart to Solidity's `-` operator.

     *

     * Requirements:

     *

     * - Subtraction cannot overflow.

     */

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

        return sub(a, b, "SafeMath: subtraction overflow");

    }



    /**

     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on

     * overflow (when the result is negative).

     *

     * Counterpart to Solidity's `-` operator.

     *

     * Requirements:

     *

     * - Subtraction cannot overflow.

     */

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b <= a, errorMessage);

        uint256 c = a - b;



        return c;

    }



    /**

     * @dev Returns the multiplication of two unsigned integers, reverting on

     * overflow.

     *

     * Counterpart to Solidity's `*` operator.

     *

     * Requirements:

     *

     * - Multiplication cannot overflow.

     */

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the

        // benefit is lost if 'b' is also tested.

        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522

        if (a == 0) {

            return 0;

        }



        uint256 c = a * b;

        require(c / a == b, "SafeMath: multiplication overflow");



        return c;

    }



    /**

     * @dev Returns the integer division of two unsigned integers. Reverts on

     * division by zero. The result is rounded towards zero.

     *

     * Counterpart to Solidity's `/` operator. Note: this function uses a

     * `revert` opcode (which leaves remaining gas untouched) while Solidity

     * uses an invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     *

     * - The divisor cannot be zero.

     */

    function div(uint256 a, uint256 b) internal pure returns (uint256) {

        return div(a, b, "SafeMath: division by zero");

    }



    /**

     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on

     * division by zero. The result is rounded towards zero.

     *

     * Counterpart to Solidity's `/` operator. Note: this function uses a

     * `revert` opcode (which leaves remaining gas untouched) while Solidity

     * uses an invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     *

     * - The divisor cannot be zero.

     */

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b > 0, errorMessage);

        uint256 c = a / b;

        // assert(a == b * c + a % b); // There is no case in which this doesn't hold



        return c;

    }



    /**

     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),

     * Reverts when dividing by zero.

     *

     * Counterpart to Solidity's `%` operator. This function uses a `revert`

     * opcode (which leaves remaining gas untouched) while Solidity uses an

     * invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     *

     * - The divisor cannot be zero.

     */

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {

        return mod(a, b, "SafeMath: modulo by zero");

    }



    /**

     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),

     * Reverts with custom message when dividing by zero.

     *

     * Counterpart to Solidity's `%` operator. This function uses a `revert`

     * opcode (which leaves remaining gas untouched) while Solidity uses an

     * invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     *

     * - The divisor cannot be zero.

     */

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b != 0, errorMessage);

        return a % b;

    }

    

    function ceil(uint256 a, uint256 m) internal pure returns (uint256 r) {

        require(m != 0, "SafeMath: to ceil number shall not be zero");

        return (a + m - 1) / m * m;

    }

}





// ----------------------------------------------------------------------------

// ERC Token Standard #20 Interface

// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md

// ----------------------------------------------------------------------------

/**

 * @dev Interface of the ERC20 standard as defined in the EIP.

 */

interface IERC20 {

    /**

     * @dev Returns the amount of tokens in existence.

     */

    function totalSupply() external view returns (uint256);



    /**

     * @dev Returns the amount of tokens owned by `account`.

     */

    function balanceOf(address account) external view returns (uint256);



    /**

     * @dev Moves `amount` tokens from the caller's account to `recipient`.

     *

     * Returns a boolean value indicating whether the operation succeeded.

     *

     * Emits a {Transfer} event.

     */

    function transfer(address recipient, uint256 amount) external returns (bool);



    /**

     * @dev Returns the remaining number of tokens that `spender` will be

     * allowed to spend on behalf of `owner` through {transferFrom}. This is

     * zero by default.

     *

     * This value changes when {approve} or {transferFrom} are called.

     */

    function allowance(address owner, address spender) external view returns (uint256);



    /**

     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.

     *

     * Returns a boolean value indicating whether the operation succeeded.

     *

     * IMPORTANT: Beware that changing an allowance with this method brings the risk

     * that someone may use both the old and the new allowance by unfortunate

     * transaction ordering. One possible solution to mitigate this race

     * condition is to first reduce the spender's allowance to 0 and set the

     * desired value afterwards:

     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729

     *

     * Emits an {Approval} event.

     */

    function approve(address spender, uint256 amount) external returns (bool);



    /**

     * @dev Moves `amount` tokens from `sender` to `recipient` using the

     * allowance mechanism. `amount` is then deducted from the caller's

     * allowance.

     *

     * Returns a boolean value indicating whether the operation succeeded.

     *

     * Emits a {Transfer} event.

     */

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);



    /**

     * @dev Emitted when `value` tokens are moved from one account (`from`) to

     * another (`to`).

     *

     * Note that `value` may be zero.

     */

    event Transfer(address indexed from, address indexed to, uint256 value);



    /**

     * @dev Emitted when the allowance of a `spender` for an `owner` is set by

     * a call to {approve}. `value` is the new allowance.

     */

    event Approval(address indexed owner, address indexed spender, uint256 value);

}



// ----------------------------------------------------------------------------

// Owned contract

// ----------------------------------------------------------------------------

contract Owned {

    address payable public owner;



    event OwnershipTransferred(address indexed _from, address indexed _to);



    constructor() public {

        owner = msg.sender;

    }



    modifier onlyOwner {

        require(msg.sender == owner, "only allowed by owner");

        _;

    }



    function transferOwnership(address payable _newOwner) public onlyOwner {

        owner = _newOwner;

        emit OwnershipTransferred(msg.sender, _newOwner);

    }

}



// ----------------------------------------------------------------------------

// 'Gundam' token contract



// Symbol      : Gundam

// Name        : GUNDAM SEED

// Total supply: 1,000,000,000

// Decimals    : 18



// ----------------------------------------------------------------------------

// ERC20 Token, with the addition of symbol, name and decimals and assisted

// token transfers

// ----------------------------------------------------------------------------

contract GundamSeed is IERC20, Owned {

    using SafeMath for uint256;

   

    string public symbol = "Gundam";

    string public  name = "GUNDAM SEED";

    uint256 public decimals = 18;

    uint256 _totalSupply = 1000000000 * 10 ** (18); // 1,000,000,000 

    

    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowed;

    

    uint256 preSaleStart = 1605128400; // 11-nov-2020 9pm gmt

    uint256 preSaleEnd = 1605560400; // 16-nov-2020 9pm gmt

    uint256 tokenRatePerEth = 1250000 ; // 1 Ethereum = 1,250,000  GUNDAM Tokens

    

    modifier saleOpen{

        require(block.timestamp >= preSaleStart && block.timestamp <= preSaleEnd, "sale is close");

        _;

    }



    // ------------------------------------------------------------------------

    // Constructor

    // ------------------------------------------------------------------------

    constructor() public {

        

        owner = 0xeB557d22bdFfBe0588bb9632A53883F6E011A15D;

        

        balances[address(owner)] =   5e8  * 10 ** (18); // 5,00,000,000 (500 million)

        emit Transfer(address(0), address(owner), 5e8  * 10 ** (18));

        

        // keep 500 million inside contract for presale

        balances[address(this)] =   5e8  * 10 ** (18); // 5,00,000,000 (500 million)

        emit Transfer(address(0), address(this), 5e8  * 10 ** (18));

    }



   

    /** ERC20Interface function's implementation **/

    

    // ------------------------------------------------------------------------

    // Get the total supply of the token

    // ------------------------------------------------------------------------

    function totalSupply() external override view returns (uint256){

       return _totalSupply;

    }

   

    // ------------------------------------------------------------------------

    // Get the token balance for account `tokenOwner`

    // ------------------------------------------------------------------------

    function balanceOf(address tokenOwner) external override view returns (uint256 balance) {

        return balances[tokenOwner];

    }

    

    // ------------------------------------------------------------------------

    // Token owner can approve for `spender` to transferFrom(...) `tokens`

    // from the token owner's account

    // ------------------------------------------------------------------------

    function approve(address spender, uint256 tokens) external override returns (bool success){

        allowed[msg.sender][spender] = tokens;

        emit Approval(msg.sender,spender,tokens);

        return true;

    }

    

    // ------------------------------------------------------------------------

    // Returns the amount of tokens approved by the owner that can be

    // transferred to the spender's account

    // ------------------------------------------------------------------------

    function allowance(address tokenOwner, address spender) external override view returns (uint256 remaining) {

        return allowed[tokenOwner][spender];

    }



    // ------------------------------------------------------------------------

    // Transfer the balance from token owner's account to `to` account

    // - Owner's account must have sufficient balance to transfer

    // - 0 value transfers are allowed

    // ------------------------------------------------------------------------

    function transfer(address to, uint256 tokens) public override returns (bool success) {

        // prevent transfer to 0x0, use burn instead

        require(address(to) != address(0));

        require(balances[msg.sender] >= tokens );

        require(balances[to] + tokens >= balances[to]);

        

        balances[msg.sender] = balances[msg.sender].sub(tokens);

        

        balances[to] = balances[to].add(tokens);

        emit Transfer(msg.sender, to, tokens);

        return true;

    }

    

    // ------------------------------------------------------------------------

    // Transfer `tokens` from the `from` account to the `to` account

    //

    // The calling account must already have sufficient tokens approve(...)-d

    // for spending from the `from` account and

    // - From account must have sufficient balance to transfer

    // - Spender must have sufficient allowance to transfer

    // - 0 value transfers are allowed

    // ------------------------------------------------------------------------

    function transferFrom(address from, address to, uint256 tokens) external override returns (bool success){

        require(tokens <= allowed[from][msg.sender]); //check allowance

        require(balances[from] >= tokens);

        balances[from] = balances[from].sub(tokens);

        allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);

        balances[to] = balances[to].add(tokens);

        emit Transfer(from, to, tokens);

        return true;

    }

    

    // ------------------------------------------------------------------------

    // Transfer `tokens` from the `from` contract to the `to` account

    // ------------------------------------------------------------------------

    function _transfer(address to, uint256 tokens) private returns(bool){

        // prevent transfer to 0x0, use burn instead

        require(address(to) != address(0));

        require(balances[address(this)] >= tokens );

        

        balances[address(this)] = balances[address(this)].sub(tokens);

        balances[to] = balances[to].add(tokens);

        

        emit Transfer(address(this),to,tokens);

        return true;

    }

    

    // ------------------------------------------------------------------------

    // Get ethers to buy tokens during pre-sale

    // ------------------------------------------------------------------------

    receive() external payable saleOpen{

        

        uint256 tokens = getTokenAmount(msg.value);

        

        require(_transfer(msg.sender, tokens), "Insufficient balance of sale contract!");

        

        // send received funds to the owner

        owner.transfer(msg.value);

    }

    

    // ------------------------------------------------------------------------

    // Calculate tokens based on ethers sent

    // ------------------------------------------------------------------------

    function getTokenAmount(uint256 amount) private view returns(uint256){

        return (amount.mul(tokenRatePerEth));

    }

    

    // ------------------------------------------------------------------------

    // Send the unsold tokens back to owner

    // ------------------------------------------------------------------------

    function getUnSoldTokens() external onlyOwner{

        require(block.timestamp > preSaleEnd, "Sale is not close yet");

        require(_transfer(msg.sender, balances[address(this)]), "Insufficient balance of sale contract!");

    }

}
