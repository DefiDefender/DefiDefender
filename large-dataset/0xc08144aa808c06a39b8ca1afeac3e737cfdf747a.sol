// File: @openzeppelin/contracts/GSN/Context.sol



pragma solidity ^0.5.0;



/*

 * @dev Provides information about the current execution context, including the

 * sender of the transaction and its data. While these are generally available

 * via msg.sender and msg.data, they should not be accessed in such a direct

 * manner, since when dealing with GSN meta-transactions the account sending and

 * paying for execution may not be the actual sender (as far as an application

 * is concerned).

 *

 * This contract is only required for intermediate, library-like contracts.

 */

contract Context {

    // Empty internal constructor, to prevent people from mistakenly deploying

    // an instance of this contract, which should be used via inheritance.

    constructor () internal { }

    // solhint-disable-previous-line no-empty-blocks



    function _msgSender() internal view returns (address payable) {

        return msg.sender;

    }



    function _msgData() internal view returns (bytes memory) {

        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691

        return msg.data;

    }

}



// File: @openzeppelin/contracts/token/ERC20/IERC20.sol



pragma solidity ^0.5.0;



/**

 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include

 * the optional functions; to access them see {ERC20Detailed}.

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



// File: @openzeppelin/contracts/math/SafeMath.sol



pragma solidity ^0.5.0;



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

     * - Subtraction cannot overflow.

     *

     * _Available since v2.4.0._

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

     * - The divisor cannot be zero.

     *

     * _Available since v2.4.0._

     */

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        // Solidity only automatically asserts when dividing by 0

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

     * - The divisor cannot be zero.

     *

     * _Available since v2.4.0._

     */

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b != 0, errorMessage);

        return a % b;

    }

}



// File: @openzeppelin/contracts/utils/Address.sol



pragma solidity ^0.5.5;



/**

 * @dev Collection of functions related to the address type

 */

library Address {

    /**

     * @dev Returns true if `account` is a contract.

     *

     * [IMPORTANT]

     * ====

     * It is unsafe to assume that an address for which this function returns

     * false is an externally-owned account (EOA) and not a contract.

     *

     * Among others, `isContract` will return false for the following 

     * types of addresses:

     *

     *  - an externally-owned account

     *  - a contract in construction

     *  - an address where a contract will be created

     *  - an address where a contract lived, but was destroyed

     * ====

     */

    function isContract(address account) internal view returns (bool) {

        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts

        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned

        // for accounts without code, i.e. `keccak256('')`

        bytes32 codehash;

        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;

        // solhint-disable-next-line no-inline-assembly

        assembly { codehash := extcodehash(account) }

        return (codehash != accountHash && codehash != 0x0);

    }



    /**

     * @dev Converts an `address` into `address payable`. Note that this is

     * simply a type cast: the actual underlying value is not changed.

     *

     * _Available since v2.4.0._

     */

    function toPayable(address account) internal pure returns (address payable) {

        return address(uint160(account));

    }



    /**

     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to

     * `recipient`, forwarding all available gas and reverting on errors.

     *

     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost

     * of certain opcodes, possibly making contracts go over the 2300 gas limit

     * imposed by `transfer`, making them unable to receive funds via

     * `transfer`. {sendValue} removes this limitation.

     *

     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].

     *

     * IMPORTANT: because control is transferred to `recipient`, care must be

     * taken to not create reentrancy vulnerabilities. Consider using

     * {ReentrancyGuard} or the

     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].

     *

     * _Available since v2.4.0._

     */

    function sendValue(address payable recipient, uint256 amount) internal {

        require(address(this).balance >= amount, "Address: insufficient balance");



        // solhint-disable-next-line avoid-call-value

        (bool success, ) = recipient.call.value(amount)("");

        require(success, "Address: unable to send value, recipient may have reverted");

    }

}



// File: @openzeppelin/contracts/token/ERC20/SafeERC20.sol



pragma solidity ^0.5.0;









/**

 * @title SafeERC20

 * @dev Wrappers around ERC20 operations that throw on failure (when the token

 * contract returns false). Tokens that return no value (and instead revert or

 * throw on failure) are also supported, non-reverting calls are assumed to be

 * successful.

 * To use this library you can add a `using SafeERC20 for ERC20;` statement to your contract,

 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.

 */

library SafeERC20 {

    using SafeMath for uint256;

    using Address for address;



    function safeTransfer(IERC20 token, address to, uint256 value) internal {

        callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));

    }



    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {

        callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));

    }



    function safeApprove(IERC20 token, address spender, uint256 value) internal {

        // safeApprove should only be called when setting an initial allowance,

        // or when resetting it to zero. To increase and decrease it, use

        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'

        // solhint-disable-next-line max-line-length

        require((value == 0) || (token.allowance(address(this), spender) == 0),

            "SafeERC20: approve from non-zero to non-zero allowance"

        );

        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));

    }



    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {

        uint256 newAllowance = token.allowance(address(this), spender).add(value);

        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));

    }



    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {

        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");

        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));

    }



    /**

     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement

     * on the return value: the return value is optional (but if data is returned, it must not be false).

     * @param token The token targeted by the call.

     * @param data The call data (encoded using abi.encode or one of its variants).

     */

    function callOptionalReturn(IERC20 token, bytes memory data) private {

        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since

        // we're implementing it ourselves.



        // A Solidity high level call has three parts:

        //  1. The target address is checked to verify it contains contract code

        //  2. The call itself is made, and success asserted

        //  3. The return value is decoded, which in turn checks the size of the returned data.

        // solhint-disable-next-line max-line-length

        require(address(token).isContract(), "SafeERC20: call to non-contract");



        // solhint-disable-next-line avoid-low-level-calls

        (bool success, bytes memory returndata) = address(token).call(data);

        require(success, "SafeERC20: low-level call failed");



        if (returndata.length > 0) { // Return data is optional

            // solhint-disable-next-line max-line-length

            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");

        }

    }

}



// File: @openzeppelin/contracts/utils/ReentrancyGuard.sol



pragma solidity ^0.5.0;



/**

 * @dev Contract module that helps prevent reentrant calls to a function.

 *

 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier

 * available, which can be applied to functions to make sure there are no nested

 * (reentrant) calls to them.

 *

 * Note that because there is a single `nonReentrant` guard, functions marked as

 * `nonReentrant` may not call one another. This can be worked around by making

 * those functions `private`, and then adding `external` `nonReentrant` entry

 * points to them.

 *

 * TIP: If you would like to learn more about reentrancy and alternative ways

 * to protect against it, check out our blog post

 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].

 *

 * _Since v2.5.0:_ this module is now much more gas efficient, given net gas

 * metering changes introduced in the Istanbul hardfork.

 */

contract ReentrancyGuard {

    bool private _notEntered;



    constructor () internal {

        // Storing an initial non-zero value makes deployment a bit more

        // expensive, but in exchange the refund on every call to nonReentrant

        // will be lower in amount. Since refunds are capped to a percetange of

        // the total transaction's gas, it is best to keep them low in cases

        // like this one, to increase the likelihood of the full refund coming

        // into effect.

        _notEntered = true;

    }



    /**

     * @dev Prevents a contract from calling itself, directly or indirectly.

     * Calling a `nonReentrant` function from another `nonReentrant`

     * function is not supported. It is possible to prevent this from happening

     * by making the `nonReentrant` function external, and make it call a

     * `private` function that does the actual work.

     */

    modifier nonReentrant() {

        // On the first call to nonReentrant, _notEntered will be true

        require(_notEntered, "ReentrancyGuard: reentrant call");



        // Any calls to nonReentrant after this point will fail

        _notEntered = false;



        _;



        // By storing the original value once again, a refund is triggered (see

        // https://eips.ethereum.org/EIPS/eip-2200)

        _notEntered = true;

    }

}



// File: @openzeppelin/contracts/crowdsale/Crowdsale.sol



pragma solidity ^0.5.0;













/**

 * @title Crowdsale

 * @dev Crowdsale is a base contract for managing a token crowdsale,

 * allowing investors to purchase tokens with ether. This contract implements

 * such functionality in its most fundamental form and can be extended to provide additional

 * functionality and/or custom behavior.

 * The external interface represents the basic interface for purchasing tokens, and conforms

 * the base architecture for crowdsales. It is *not* intended to be modified / overridden.

 * The internal interface conforms the extensible and modifiable surface of crowdsales. Override

 * the methods to add functionality. Consider using 'super' where appropriate to concatenate

 * behavior.

 */

contract Crowdsale is Context, ReentrancyGuard {

    using SafeMath for uint256;

    using SafeERC20 for IERC20;



    // The token being sold

    IERC20 private _token;



    // Address where funds are collected

    address payable private _wallet;



    // How many token units a buyer gets per wei.

    // The rate is the conversion between wei and the smallest and indivisible token unit.

    // So, if you are using a rate of 1 with a ERC20Detailed token with 3 decimals called TOK

    // 1 wei will give you 1 unit, or 0.001 TOK.

    uint256 private _rate;



    // Amount of wei raised

    uint256 private _weiRaised;



    /**

     * Event for token purchase logging

     * @param purchaser who paid for the tokens

     * @param beneficiary who got the tokens

     * @param value weis paid for purchase

     * @param amount amount of tokens purchased

     */

    event TokensPurchased(address indexed purchaser, address indexed beneficiary, uint256 value, uint256 amount);



    /**

     * @param rate Number of token units a buyer gets per wei

     * @dev The rate is the conversion between wei and the smallest and indivisible

     * token unit. So, if you are using a rate of 1 with a ERC20Detailed token

     * with 3 decimals called TOK, 1 wei will give you 1 unit, or 0.001 TOK.

     * @param wallet Address where collected funds will be forwarded to

     * @param token Address of the token being sold

     */

    constructor (uint256 rate, address payable wallet, IERC20 token) public {

        require(rate > 0, "Crowdsale: rate is 0");

        require(wallet != address(0), "Crowdsale: wallet is the zero address");

        require(address(token) != address(0), "Crowdsale: token is the zero address");



        _rate = rate;

        _wallet = wallet;

        _token = token;

    }



    /**

     * @dev fallback function ***DO NOT OVERRIDE***

     * Note that other contracts will transfer funds with a base gas stipend

     * of 2300, which is not enough to call buyTokens. Consider calling

     * buyTokens directly when purchasing tokens from a contract.

     */

    function () external payable {

        buyTokens(_msgSender());

    }



    /**

     * @return the token being sold.

     */

    function token() public view returns (IERC20) {

        return _token;

    }



    /**

     * @return the address where funds are collected.

     */

    function wallet() public view returns (address payable) {

        return _wallet;

    }



    /**

     * @return the number of token units a buyer gets per wei.

     */

    function rate() public view returns (uint256) {

        return _rate;

    }



    /**

     * @return the amount of wei raised.

     */

    function weiRaised() public view returns (uint256) {

        return _weiRaised;

    }



    /**

     * @dev low level token purchase ***DO NOT OVERRIDE***

     * This function has a non-reentrancy guard, so it shouldn't be called by

     * another `nonReentrant` function.

     * @param beneficiary Recipient of the token purchase

     */

    function buyTokens(address beneficiary) public nonReentrant payable {

        uint256 weiAmount = msg.value;

        _preValidatePurchase(beneficiary, weiAmount);



        // calculate token amount to be created

        uint256 tokens = _getTokenAmount(weiAmount);



        // update state

        _weiRaised = _weiRaised.add(weiAmount);



        _processPurchase(beneficiary, tokens);

        emit TokensPurchased(_msgSender(), beneficiary, weiAmount, tokens);



        _updatePurchasingState(beneficiary, weiAmount);



        _forwardFunds();

        _postValidatePurchase(beneficiary, weiAmount);

    }



    /**

     * @dev Validation of an incoming purchase. Use require statements to revert state when conditions are not met.

     * Use `super` in contracts that inherit from Crowdsale to extend their validations.

     * Example from CappedCrowdsale.sol's _preValidatePurchase method:

     *     super._preValidatePurchase(beneficiary, weiAmount);

     *     require(weiRaised().add(weiAmount) <= cap);

     * @param beneficiary Address performing the token purchase

     * @param weiAmount Value in wei involved in the purchase

     */

    function _preValidatePurchase(address beneficiary, uint256 weiAmount) internal view {

        require(beneficiary != address(0), "Crowdsale: beneficiary is the zero address");

        require(weiAmount != 0, "Crowdsale: weiAmount is 0");

        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691

    }



    /**

     * @dev Validation of an executed purchase. Observe state and use revert statements to undo rollback when valid

     * conditions are not met.

     * @param beneficiary Address performing the token purchase

     * @param weiAmount Value in wei involved in the purchase

     */

    function _postValidatePurchase(address beneficiary, uint256 weiAmount) internal view {

        // solhint-disable-previous-line no-empty-blocks

    }



    /**

     * @dev Source of tokens. Override this method to modify the way in which the crowdsale ultimately gets and sends

     * its tokens.

     * @param beneficiary Address performing the token purchase

     * @param tokenAmount Number of tokens to be emitted

     */

    function _deliverTokens(address beneficiary, uint256 tokenAmount) internal {

        _token.safeTransfer(beneficiary, tokenAmount);

    }



    /**

     * @dev Executed when a purchase has been validated and is ready to be executed. Doesn't necessarily emit/send

     * tokens.

     * @param beneficiary Address receiving the tokens

     * @param tokenAmount Number of tokens to be purchased

     */

    function _processPurchase(address beneficiary, uint256 tokenAmount) internal {

        _deliverTokens(beneficiary, tokenAmount);

    }



    /**

     * @dev Override for extensions that require an internal state to check for validity (current user contributions,

     * etc.)

     * @param beneficiary Address receiving the tokens

     * @param weiAmount Value in wei involved in the purchase

     */

    function _updatePurchasingState(address beneficiary, uint256 weiAmount) internal {

        // solhint-disable-previous-line no-empty-blocks

    }



    /**

     * @dev Override to extend the way in which ether is converted to tokens.

     * @param weiAmount Value in wei to be converted into tokens

     * @return Number of tokens that can be purchased with the specified _weiAmount

     */

    function _getTokenAmount(uint256 weiAmount) internal view returns (uint256) {

        return weiAmount.mul(_rate);

    }



    /**

     * @dev Determines how ETH is stored/forwarded on purchases.

     */

    function _forwardFunds() internal {

        _wallet.transfer(msg.value);

    }

}



// File: @openzeppelin/contracts/crowdsale/validation/TimedCrowdsale.sol



pragma solidity ^0.5.0;







/**

 * @title TimedCrowdsale

 * @dev Crowdsale accepting contributions only within a time frame.

 */

contract TimedCrowdsale is Crowdsale {

    using SafeMath for uint256;



    uint256 private _openingTime;

    uint256 private _closingTime;



    /**

     * Event for crowdsale extending

     * @param newClosingTime new closing time

     * @param prevClosingTime old closing time

     */

    event TimedCrowdsaleExtended(uint256 prevClosingTime, uint256 newClosingTime);



    /**

     * @dev Reverts if not in crowdsale time range.

     */

    modifier onlyWhileOpen {

        require(isOpen(), "TimedCrowdsale: not open");

        _;

    }



    /**

     * @dev Constructor, takes crowdsale opening and closing times.

     * @param openingTime Crowdsale opening time

     * @param closingTime Crowdsale closing time

     */

    constructor (uint256 openingTime, uint256 closingTime) public {

        // solhint-disable-next-line not-rely-on-time

        require(openingTime >= block.timestamp, "TimedCrowdsale: opening time is before current time");

        // solhint-disable-next-line max-line-length

        require(closingTime > openingTime, "TimedCrowdsale: opening time is not before closing time");



        _openingTime = openingTime;

        _closingTime = closingTime;

    }



    /**

     * @return the crowdsale opening time.

     */

    function openingTime() public view returns (uint256) {

        return _openingTime;

    }



    /**

     * @return the crowdsale closing time.

     */

    function closingTime() public view returns (uint256) {

        return _closingTime;

    }



    /**

     * @return true if the crowdsale is open, false otherwise.

     */

    function isOpen() public view returns (bool) {

        // solhint-disable-next-line not-rely-on-time

        return block.timestamp >= _openingTime && block.timestamp <= _closingTime;

    }



    /**

     * @dev Checks whether the period in which the crowdsale is open has already elapsed.

     * @return Whether crowdsale period has elapsed

     */

    function hasClosed() public view returns (bool) {

        // solhint-disable-next-line not-rely-on-time

        return block.timestamp > _closingTime;

    }



    /**

     * @dev Extend parent behavior requiring to be within contributing period.

     * @param beneficiary Token purchaser

     * @param weiAmount Amount of wei contributed

     */

    function _preValidatePurchase(address beneficiary, uint256 weiAmount) internal onlyWhileOpen view {

        super._preValidatePurchase(beneficiary, weiAmount);

    }



    /**

     * @dev Extend crowdsale.

     * @param newClosingTime Crowdsale closing time

     */

    function _extendTime(uint256 newClosingTime) internal {

        require(!hasClosed(), "TimedCrowdsale: already closed");

        // solhint-disable-next-line max-line-length

        require(newClosingTime > _closingTime, "TimedCrowdsale: new closing time is before current closing time");



        emit TimedCrowdsaleExtended(_closingTime, newClosingTime);

        _closingTime = newClosingTime;

    }

}



// File: @openzeppelin/contracts/ownership/Secondary.sol



pragma solidity ^0.5.0;



/**

 * @dev A Secondary contract can only be used by its primary account (the one that created it).

 */

contract Secondary is Context {

    address private _primary;



    /**

     * @dev Emitted when the primary contract changes.

     */

    event PrimaryTransferred(

        address recipient

    );



    /**

     * @dev Sets the primary account to the one that is creating the Secondary contract.

     */

    constructor () internal {

        address msgSender = _msgSender();

        _primary = msgSender;

        emit PrimaryTransferred(msgSender);

    }



    /**

     * @dev Reverts if called from any account other than the primary.

     */

    modifier onlyPrimary() {

        require(_msgSender() == _primary, "Secondary: caller is not the primary account");

        _;

    }



    /**

     * @return the address of the primary.

     */

    function primary() public view returns (address) {

        return _primary;

    }



    /**

     * @dev Transfers contract to a new primary.

     * @param recipient The address of new primary.

     */

    function transferPrimary(address recipient) public onlyPrimary {

        require(recipient != address(0), "Secondary: new primary is the zero address");

        _primary = recipient;

        emit PrimaryTransferred(recipient);

    }

}



// File: @openzeppelin/contracts/crowdsale/distribution/PostDeliveryCrowdsale.sol



pragma solidity ^0.5.0;











/**

 * @title PostDeliveryCrowdsale

 * @dev Crowdsale that locks tokens from withdrawal until it ends.

 */

contract PostDeliveryCrowdsale is TimedCrowdsale {

    using SafeMath for uint256;



    mapping(address => uint256) private _balances;

    __unstable__TokenVault private _vault;



    constructor() public {

        _vault = new __unstable__TokenVault();

    }



    /**

     * @dev Withdraw tokens only after crowdsale ends.

     * @param beneficiary Whose tokens will be withdrawn.

     */

    function withdrawTokens(address beneficiary) public {

        require(hasClosed(), "PostDeliveryCrowdsale: not closed");

        uint256 amount = _balances[beneficiary];

        require(amount > 0, "PostDeliveryCrowdsale: beneficiary is not due any tokens");



        _balances[beneficiary] = 0;

        _vault.transfer(token(), beneficiary, amount);

    }



    /**

     * @return the balance of an account.

     */

    function balanceOf(address account) public view returns (uint256) {

        return _balances[account];

    }



    /**

     * @dev Overrides parent by storing due balances, and delivering tokens to the vault instead of the end user. This

     * ensures that the tokens will be available by the time they are withdrawn (which may not be the case if

     * `_deliverTokens` was called later).

     * @param beneficiary Token purchaser

     * @param tokenAmount Amount of tokens purchased

     */

    function _processPurchase(address beneficiary, uint256 tokenAmount) internal {

        _balances[beneficiary] = _balances[beneficiary].add(tokenAmount);

        _deliverTokens(address(_vault), tokenAmount);

    }

}



/**

 * @title __unstable__TokenVault

 * @dev Similar to an Escrow for tokens, this contract allows its primary account to spend its tokens as it sees fit.

 * This contract is an internal helper for PostDeliveryCrowdsale, and should not be used outside of this context.

 */

// solhint-disable-next-line contract-name-camelcase

contract __unstable__TokenVault is Secondary {

    function transfer(IERC20 token, address to, uint256 amount) public onlyPrimary {

        token.transfer(to, amount);

    }

}



// File: @openzeppelin/contracts/token/ERC20/ERC20.sol



pragma solidity ^0.5.0;









/**

 * @dev Implementation of the {IERC20} interface.

 *

 * This implementation is agnostic to the way tokens are created. This means

 * that a supply mechanism has to be added in a derived contract using {_mint}.

 * For a generic mechanism see {ERC20Mintable}.

 *

 * TIP: For a detailed writeup see our guide

 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How

 * to implement supply mechanisms].

 *

 * We have followed general OpenZeppelin guidelines: functions revert instead

 * of returning `false` on failure. This behavior is nonetheless conventional

 * and does not conflict with the expectations of ERC20 applications.

 *

 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.

 * This allows applications to reconstruct the allowance for all accounts just

 * by listening to said events. Other implementations of the EIP may not emit

 * these events, as it isn't required by the specification.

 *

 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}

 * functions have been added to mitigate the well-known issues around setting

 * allowances. See {IERC20-approve}.

 */

contract ERC20 is Context, IERC20 {

    using SafeMath for uint256;



    mapping (address => uint256) private _balances;



    mapping (address => mapping (address => uint256)) private _allowances;



    uint256 private _totalSupply;



    /**

     * @dev See {IERC20-totalSupply}.

     */

    function totalSupply() public view returns (uint256) {

        return _totalSupply;

    }



    /**

     * @dev See {IERC20-balanceOf}.

     */

    function balanceOf(address account) public view returns (uint256) {

        return _balances[account];

    }



    /**

     * @dev See {IERC20-transfer}.

     *

     * Requirements:

     *

     * - `recipient` cannot be the zero address.

     * - the caller must have a balance of at least `amount`.

     */

    function transfer(address recipient, uint256 amount) public returns (bool) {

        _transfer(_msgSender(), recipient, amount);

        return true;

    }



    /**

     * @dev See {IERC20-allowance}.

     */

    function allowance(address owner, address spender) public view returns (uint256) {

        return _allowances[owner][spender];

    }



    /**

     * @dev See {IERC20-approve}.

     *

     * Requirements:

     *

     * - `spender` cannot be the zero address.

     */

    function approve(address spender, uint256 amount) public returns (bool) {

        _approve(_msgSender(), spender, amount);

        return true;

    }



    /**

     * @dev See {IERC20-transferFrom}.

     *

     * Emits an {Approval} event indicating the updated allowance. This is not

     * required by the EIP. See the note at the beginning of {ERC20};

     *

     * Requirements:

     * - `sender` and `recipient` cannot be the zero address.

     * - `sender` must have a balance of at least `amount`.

     * - the caller must have allowance for `sender`'s tokens of at least

     * `amount`.

     */

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {

        _transfer(sender, recipient, amount);

        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));

        return true;

    }



    /**

     * @dev Atomically increases the allowance granted to `spender` by the caller.

     *

     * This is an alternative to {approve} that can be used as a mitigation for

     * problems described in {IERC20-approve}.

     *

     * Emits an {Approval} event indicating the updated allowance.

     *

     * Requirements:

     *

     * - `spender` cannot be the zero address.

     */

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {

        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));

        return true;

    }



    /**

     * @dev Atomically decreases the allowance granted to `spender` by the caller.

     *

     * This is an alternative to {approve} that can be used as a mitigation for

     * problems described in {IERC20-approve}.

     *

     * Emits an {Approval} event indicating the updated allowance.

     *

     * Requirements:

     *

     * - `spender` cannot be the zero address.

     * - `spender` must have allowance for the caller of at least

     * `subtractedValue`.

     */

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {

        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));

        return true;

    }



    /**

     * @dev Moves tokens `amount` from `sender` to `recipient`.

     *

     * This is internal function is equivalent to {transfer}, and can be used to

     * e.g. implement automatic token fees, slashing mechanisms, etc.

     *

     * Emits a {Transfer} event.

     *

     * Requirements:

     *

     * - `sender` cannot be the zero address.

     * - `recipient` cannot be the zero address.

     * - `sender` must have a balance of at least `amount`.

     */

    function _transfer(address sender, address recipient, uint256 amount) internal {

        require(sender != address(0), "ERC20: transfer from the zero address");

        require(recipient != address(0), "ERC20: transfer to the zero address");



        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");

        _balances[recipient] = _balances[recipient].add(amount);

        emit Transfer(sender, recipient, amount);

    }



    /** @dev Creates `amount` tokens and assigns them to `account`, increasing

     * the total supply.

     *

     * Emits a {Transfer} event with `from` set to the zero address.

     *

     * Requirements

     *

     * - `to` cannot be the zero address.

     */

    function _mint(address account, uint256 amount) internal {

        require(account != address(0), "ERC20: mint to the zero address");



        _totalSupply = _totalSupply.add(amount);

        _balances[account] = _balances[account].add(amount);

        emit Transfer(address(0), account, amount);

    }



    /**

     * @dev Destroys `amount` tokens from `account`, reducing the

     * total supply.

     *

     * Emits a {Transfer} event with `to` set to the zero address.

     *

     * Requirements

     *

     * - `account` cannot be the zero address.

     * - `account` must have at least `amount` tokens.

     */

    function _burn(address account, uint256 amount) internal {

        require(account != address(0), "ERC20: burn from the zero address");



        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");

        _totalSupply = _totalSupply.sub(amount);

        emit Transfer(account, address(0), amount);

    }



    /**

     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.

     *

     * This is internal function is equivalent to `approve`, and can be used to

     * e.g. set automatic allowances for certain subsystems, etc.

     *

     * Emits an {Approval} event.

     *

     * Requirements:

     *

     * - `owner` cannot be the zero address.

     * - `spender` cannot be the zero address.

     */

    function _approve(address owner, address spender, uint256 amount) internal {

        require(owner != address(0), "ERC20: approve from the zero address");

        require(spender != address(0), "ERC20: approve to the zero address");



        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);

    }



    /**

     * @dev Destroys `amount` tokens from `account`.`amount` is then deducted

     * from the caller's allowance.

     *

     * See {_burn} and {_approve}.

     */

    function _burnFrom(address account, uint256 amount) internal {

        _burn(account, amount);

        _approve(account, _msgSender(), _allowances[account][_msgSender()].sub(amount, "ERC20: burn amount exceeds allowance"));

    }

}



// File: @openzeppelin/contracts/access/Roles.sol



pragma solidity ^0.5.0;



/**

 * @title Roles

 * @dev Library for managing addresses assigned to a Role.

 */

library Roles {

    struct Role {

        mapping (address => bool) bearer;

    }



    /**

     * @dev Give an account access to this role.

     */

    function add(Role storage role, address account) internal {

        require(!has(role, account), "Roles: account already has role");

        role.bearer[account] = true;

    }



    /**

     * @dev Remove an account's access to this role.

     */

    function remove(Role storage role, address account) internal {

        require(has(role, account), "Roles: account does not have role");

        role.bearer[account] = false;

    }



    /**

     * @dev Check if an account has this role.

     * @return bool

     */

    function has(Role storage role, address account) internal view returns (bool) {

        require(account != address(0), "Roles: account is the zero address");

        return role.bearer[account];

    }

}



// File: @openzeppelin/contracts/access/roles/MinterRole.sol



pragma solidity ^0.5.0;







contract MinterRole is Context {

    using Roles for Roles.Role;



    event MinterAdded(address indexed account);

    event MinterRemoved(address indexed account);



    Roles.Role private _minters;



    constructor () internal {

        _addMinter(_msgSender());

    }



    modifier onlyMinter() {

        require(isMinter(_msgSender()), "MinterRole: caller does not have the Minter role");

        _;

    }



    function isMinter(address account) public view returns (bool) {

        return _minters.has(account);

    }



    function addMinter(address account) public onlyMinter {

        _addMinter(account);

    }



    function renounceMinter() public {

        _removeMinter(_msgSender());

    }



    function _addMinter(address account) internal {

        _minters.add(account);

        emit MinterAdded(account);

    }



    function _removeMinter(address account) internal {

        _minters.remove(account);

        emit MinterRemoved(account);

    }

}



// File: @openzeppelin/contracts/token/ERC20/ERC20Mintable.sol



pragma solidity ^0.5.0;







/**

 * @dev Extension of {ERC20} that adds a set of accounts with the {MinterRole},

 * which have permission to mint (create) new tokens as they see fit.

 *

 * At construction, the deployer of the contract is the only minter.

 */

contract ERC20Mintable is ERC20, MinterRole {

    /**

     * @dev See {ERC20-_mint}.

     *

     * Requirements:

     *

     * - the caller must have the {MinterRole}.

     */

    function mint(address account, uint256 amount) public onlyMinter returns (bool) {

        _mint(account, amount);

        return true;

    }

}



// File: @openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol



pragma solidity ^0.5.0;







/**

 * @title MintedCrowdsale

 * @dev Extension of Crowdsale contract whose tokens are minted in each purchase.

 * Token ownership should be transferred to MintedCrowdsale for minting.

 */

contract MintedCrowdsale is Crowdsale {

    /**

     * @dev Overrides delivery by minting tokens upon purchase.

     * @param beneficiary Token purchaser

     * @param tokenAmount Number of tokens to be minted

     */

    function _deliverTokens(address beneficiary, uint256 tokenAmount) internal {

        // Potentially dangerous assumption about the type of the token.

        require(

            ERC20Mintable(address(token())).mint(beneficiary, tokenAmount),

                "MintedCrowdsale: minting failed"

        );

    }

}



// File: @openzeppelin/contracts/crowdsale/distribution/FinalizableCrowdsale.sol



pragma solidity ^0.5.0;







/**

 * @title FinalizableCrowdsale

 * @dev Extension of TimedCrowdsale with a one-off finalization action, where one

 * can do extra work after finishing.

 */

contract FinalizableCrowdsale is TimedCrowdsale {

    using SafeMath for uint256;



    bool private _finalized;



    event CrowdsaleFinalized();



    constructor () internal {

        _finalized = false;

    }



    /**

     * @return true if the crowdsale is finalized, false otherwise.

     */

    function finalized() public view returns (bool) {

        return _finalized;

    }



    /**

     * @dev Must be called after crowdsale ends, to do some extra finalization

     * work. Calls the contract's finalization function.

     */

    function finalize() public {

        require(!_finalized, "FinalizableCrowdsale: already finalized");

        require(hasClosed(), "FinalizableCrowdsale: not closed");



        _finalized = true;



        _finalization();

        emit CrowdsaleFinalized();

    }



    /**

     * @dev Can be overridden to add finalization logic. The overriding function

     * should call super._finalization() to ensure the chain of finalization is

     * executed entirely.

     */

    function _finalization() internal {

        // solhint-disable-previous-line no-empty-blocks

    }

}



// File: contracts/crowdsale/WhitelistCrowdsale.sol



pragma solidity ^0.5.0;





// custom validation using the whitelister contract



contract WhitelistCrowdsale is Crowdsale {

    address public whitelister;



    uint256 private _startTime;

    uint256 private timeForWhiteListOnly;





    constructor(address _whitelister, uint256 openingTime, uint256 closingTime) public {

        whitelister = _whitelister;

        _startTime = openingTime;

        timeForWhiteListOnly = closingTime.sub(openingTime).mul(66).div(100);

    }



    function _preValidatePurchase(address _beneficiary, uint256 _weiAmount) internal view {

        // if we are not 66% through with the time, make sure we check for whitelisted

        if(_startTime.add(timeForWhiteListOnly) >= block.timestamp ){

          require(IWhitelister(whitelister).whitelisted(_beneficiary) == true, "WhitelistCrowdsale: beneficiary not whitelisted");

        }

        super._preValidatePurchase(_beneficiary, _weiAmount);

    }



    function isWhitelisted(address _address) external view returns (bool) {

      return IWhitelister(whitelister).whitelisted(_address);

    }

}



interface IWhitelister {

    function whitelisted(address _address) external view returns (bool);

}



// File: @openzeppelin/contracts/access/roles/CapperRole.sol



pragma solidity ^0.5.0;







contract CapperRole is Context {

    using Roles for Roles.Role;



    event CapperAdded(address indexed account);

    event CapperRemoved(address indexed account);



    Roles.Role private _cappers;



    constructor () internal {

        _addCapper(_msgSender());

    }



    modifier onlyCapper() {

        require(isCapper(_msgSender()), "CapperRole: caller does not have the Capper role");

        _;

    }



    function isCapper(address account) public view returns (bool) {

        return _cappers.has(account);

    }



    function addCapper(address account) public onlyCapper {

        _addCapper(account);

    }



    function renounceCapper() public {

        _removeCapper(_msgSender());

    }



    function _addCapper(address account) internal {

        _cappers.add(account);

        emit CapperAdded(account);

    }



    function _removeCapper(address account) internal {

        _cappers.remove(account);

        emit CapperRemoved(account);

    }

}



// File: contracts/crowdsale/IndividuallyCappedCrowdsale.sol



pragma solidity ^0.5.0;









// a single cap applied to all users



/**

 * @title IndividuallyCappedCrowdsale

 * @dev Crowdsale with per-beneficiary caps.

 */

contract IndividuallyCappedCrowdsale is Crowdsale {

    using SafeMath for uint256;



    mapping(address => uint256) private _contributions;

    uint256 public individualCap;

    uint256 public minPurchase;





    constructor(uint256 _individualCap) public {

        individualCap = _individualCap;

        minPurchase = 5e17;

    }



    /**

     * @dev Returns the amount contributed so far by a specific beneficiary.

     * @param beneficiary Address of contributor

     * @return Beneficiary contribution so far

     */

    function getContribution(address beneficiary) public view returns (uint256) {

        return _contributions[beneficiary];

    }



    /**

     * @dev Extend parent behavior requiring purchase to respect the beneficiary's funding cap.

     * @param beneficiary Token purchaser

     * @param weiAmount Amount of wei contributed

     */

    function _preValidatePurchase(address beneficiary, uint256 weiAmount) internal view {

        super._preValidatePurchase(beneficiary, weiAmount);



        require(_contributions[beneficiary].add(weiAmount) >= minPurchase, "IndividuallyCappedCrowdsale: beneficiary's does not meet the min purchase");

        require(_contributions[beneficiary].add(weiAmount) <= individualCap, "IndividuallyCappedCrowdsale: beneficiary's cap exceeded");

    }



    /**

     * @dev Extend parent behavior to update beneficiary contributions.

     * @param beneficiary Token purchaser

     * @param weiAmount Amount of wei contributed

     */

    function _updatePurchasingState(address beneficiary, uint256 weiAmount) internal {

        super._updatePurchasingState(beneficiary, weiAmount);

        _contributions[beneficiary] = _contributions[beneficiary].add(weiAmount);

    }

}



// File: contracts/crowdsale/IncreasingPriceCrowdsale.sol



pragma solidity ^0.5.0;







/**

 * @title IncreasingPriceCrowdsale

 * @dev Extension of Crowdsale contract that increases the price of tokens linearly in time.

 * Note that what should be provided to the constructor is the initial and final _rates_, that is,

 * the amount of tokens per wei contributed. Thus, the initial rate must be greater than the final rate.

 */

contract IncreasingPriceCrowdsale is TimedCrowdsale {

    using SafeMath for uint256;



    uint256 private _finalRate;

    uint256 private maxEth;

    address public referrers;



    /**

     * @dev Constructor, takes initial and final rates of tokens received per wei contributed.

     * @param finalRate Number of tokens a buyer gets per wei at the end of the crowdsale

     */

    constructor (uint256 finalRate, address _referrers, uint256 _maxEth) public {

        require(finalRate > 0, "IncreasingPriceCrowdsale: final rate is 0");

        // solhint-disable-next-line max-line-length

        _finalRate = finalRate;

        referrers = _referrers;

        maxEth = _maxEth;

    }



    function isReferrer(address _address) public view returns (bool) {

        if (referrers == address(0)) {

            return false;

        }

        return IReferrers(referrers).isReferrer(_address);

    }



    /**

     * The base rate function is overridden to revert, since this crowdsale doesn't use it, and

     * all calls to it are a mistake.

     */

    function rate() public view returns (uint256) {

        revert("IncreasingPriceCrowdsale: rate() called");

    }





    // function initialRate() public view returns (uint256) {

    //     return _initialRate;

    // }



    /**

     * @return the final rate of the crowdsale.

     */

    function finalRate() public view returns (uint256) {

        return _finalRate;

    }



    function maxETH() public view returns (uint256) {

        return maxEth;

    }



    /**

     * @dev Returns the rate of tokens per wei at the present time.

     * Note that, as price _increases_ with time, the rate _decreases_.

     * @return The number of tokens a buyer gets per wei at a given time

     */

    function getCurrentRate() public view returns (uint256) {

        if (!isOpen()) {

            return 0;

        }



        uint256 _weiRaised = weiRaised();

        uint256 _rate = _finalRate;



        // 0 tokens for sale after cap is raised

        if(_weiRaised > maxEth){

          require(maxEth > _weiRaised, "IncreasingPriceCrowdsale: The max amount of eth has been raised");

          return 0;

        }



        if (isReferrer(msg.sender)) {

            _rate = _rate.mul(110).div(100);

        }



        if (_weiRaised < 25e18) {

            return _rate.mul(128).div(100);

        }

        if (_weiRaised < 50e18) {

            return _rate.mul(124).div(100);

        }

        if (_weiRaised < 100e18) {

            return _rate.mul(120).div(100);

        }

        if (_weiRaised < 150e18) {

            return _rate.mul(116).div(100);

        }

        if (_weiRaised < 200e18) {

            return _rate.mul(112).div(100);

        }

        if (_weiRaised < 250e18) {

            return _rate.mul(108).div(100);

        }

        if (_weiRaised < 300e18) {

            return _rate.mul(104).div(100);

        }



        return _rate;

    }



    /**

     * @dev Overrides parent method taking into account variable rate.

     * @param weiAmount The value in wei to be converted into tokens

     * @return The number of tokens _weiAmount wei will buy at present time

     */

    function _getTokenAmount(uint256 weiAmount) internal view returns (uint256) {

        uint256 currentRate = getCurrentRate();

        // divide by 1e18 because reward is set to 9 decimals already

        return currentRate.mul(weiAmount).div(1e18);

    }

}



interface IReferrers {

    function isReferrer(address _address) external view returns (bool);

}



// File: contracts/AquaCrowdsale.sol



pragma solidity ^0.5.17;



















//import "./crowdsale/TreasuryCrowdsale.sol";



contract AquaCrowdsale is

    Crowdsale,

    MintedCrowdsale,

    WhitelistCrowdsale,

    TimedCrowdsale,

    IndividuallyCappedCrowdsale,

    IncreasingPriceCrowdsale,

    FinalizableCrowdsale

{

    uint256 private _finalRate = 25e9;

    uint256 private _individualCap = 1e19;

    uint256 private _maxEth = 1157e18;



    mapping(address => uint256) private _balances;

    __unstable__TokenVault private _vault;



    constructor(

        address payable crowdsaleWallet,

        IERC20 token,

        uint256 openingTime,

        uint256 closingTime,

        address whitelister,

        address referrers

    )

        FinalizableCrowdsale()

        WhitelistCrowdsale(whitelister, openingTime, closingTime)

        IncreasingPriceCrowdsale(_finalRate, referrers, _maxEth)

        TimedCrowdsale(openingTime, closingTime)

        IndividuallyCappedCrowdsale(_individualCap)

        MintedCrowdsale()

        Crowdsale(_finalRate, crowdsaleWallet, token)

        public

    {

      _vault = new __unstable__TokenVault();

    }



    /**

     * @dev Withdraw tokens only after crowdsale ends.

     * @param beneficiary Whose tokens will be withdrawn.

     */

    function withdrawTokens(address beneficiary) public {

        require(hasClosed(), "PostDeliveryCrowdsale: not closed");

        // mint treasury and liq amounts here

        if(finalized() == false){

          finalize();

        }



        uint256 amount = _balances[beneficiary];

        require(amount > 0, "PostDeliveryCrowdsale: beneficiary is not due any tokens");



        _balances[beneficiary] = 0;

        _vault.transfer(token(), beneficiary, amount);

    }



    /**

     * @return the balance of an account.

     */

    function balanceOf(address account) public view returns (uint256) {

        return _balances[account];

    }



    /**

     * @dev Overrides parent by storing due balances, and delivering tokens to the vault instead of the end user. This

     * ensures that the tokens will be available by the time they are withdrawn (which may not be the case if

     * `_deliverTokens` was called later).

     * @param beneficiary Token purchaser

     * @param tokenAmount Amount of tokens purchased

     */

    function _processPurchase(address beneficiary, uint256 tokenAmount) internal {

        _balances[beneficiary] = _balances[beneficiary].add(tokenAmount);

        _deliverTokens(address(_vault), tokenAmount);

    }



    // called before withdraw is possible

    function _finalization() internal {

        // 30% of total supply

        uint256 treasuryLiquidityLock = token().totalSupply().mul(50).div(100);

        // 10% of total supply

        uint256 treasuryAmount = token().totalSupply().mul(16).div(100);



        // mint to vault

        ERC20Mintable(address(token())).mint(address(_vault), treasuryLiquidityLock);

        ERC20Mintable(address(token())).mint(address(_vault), treasuryAmount);



        // remove crowdsale contract as minter, should be no more minters

        ERC20Mintable(address(token())).renounceMinter();

        // transfer from vault to treasury

        _vault.transfer(token(), wallet(), treasuryLiquidityLock.add(treasuryAmount));



        super._finalization();

    }

}
