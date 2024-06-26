// File: @openzeppelin/contracts/math/Math.sol



pragma solidity ^0.5.0;



/**

 * @dev Standard math utilities missing in the Solidity language.

 */

library Math {

    /**

     * @dev Returns the largest of two numbers.

     */

    function max(uint256 a, uint256 b) internal pure returns (uint256) {

        return a >= b ? a : b;

    }



    /**

     * @dev Returns the smallest of two numbers.

     */

    function min(uint256 a, uint256 b) internal pure returns (uint256) {

        return a < b ? a : b;

    }



    /**

     * @dev Returns the average of two numbers. The result is rounded towards

     * zero.

     */

    function average(uint256 a, uint256 b) internal pure returns (uint256) {

        // (a + b) / 2 can overflow, so we distribute

        return (a / 2) + (b / 2) + ((a % 2 + b % 2) / 2);

    }

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



// File: @openzeppelin/contracts/token/ERC20/ERC20Detailed.sol



pragma solidity ^0.5.0;





/**

 * @dev Optional functions from the ERC20 standard.

 */

contract ERC20Detailed is IERC20 {

    string private _name;

    string private _symbol;

    uint8 private _decimals;



    /**

     * @dev Sets the values for `name`, `symbol`, and `decimals`. All three of

     * these values are immutable: they can only be set once during

     * construction.

     */

    constructor (string memory name, string memory symbol, uint8 decimals) public {

        _name = name;

        _symbol = symbol;

        _decimals = decimals;

    }



    /**

     * @dev Returns the name of the token.

     */

    function name() public view returns (string memory) {

        return _name;

    }



    /**

     * @dev Returns the symbol of the token, usually a shorter version of the

     * name.

     */

    function symbol() public view returns (string memory) {

        return _symbol;

    }



    /**

     * @dev Returns the number of decimals used to get its user representation.

     * For example, if `decimals` equals `2`, a balance of `505` tokens should

     * be displayed to a user as `5,05` (`505 / 10 ** 2`).

     *

     * Tokens usually opt for a value of 18, imitating the relationship between

     * Ether and Wei.

     *

     * NOTE: This information is only used for _display_ purposes: it in

     * no way affects any of the arithmetic of the contract, including

     * {IERC20-balanceOf} and {IERC20-transfer}.

     */

    function decimals() public view returns (uint8) {

        return _decimals;

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



// File: @openzeppelin/contracts/ownership/Ownable.sol



pragma solidity ^0.5.0;



/**

 * @dev Contract module which provides a basic access control mechanism, where

 * there is an account (an owner) that can be granted exclusive access to

 * specific functions.

 *

 * This module is used through inheritance. It will make available the modifier

 * `onlyOwner`, which can be applied to your functions to restrict their use to

 * the owner.

 */

contract Ownable is Context {

    address private _owner;



    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);



    /**

     * @dev Initializes the contract setting the deployer as the initial owner.

     */

    constructor () internal {

        address msgSender = _msgSender();

        _owner = msgSender;

        emit OwnershipTransferred(address(0), msgSender);

    }



    /**

     * @dev Returns the address of the current owner.

     */

    function owner() public view returns (address) {

        return _owner;

    }



    /**

     * @dev Throws if called by any account other than the owner.

     */

    modifier onlyOwner() {

        require(isOwner(), "Ownable: caller is not the owner");

        _;

    }



    /**

     * @dev Returns true if the caller is the current owner.

     */

    function isOwner() public view returns (bool) {

        return _msgSender() == _owner;

    }



    /**

     * @dev Leaves the contract without owner. It will not be possible to call

     * `onlyOwner` functions anymore. Can only be called by the current owner.

     *

     * NOTE: Renouncing ownership will leave the contract without an owner,

     * thereby removing any functionality that is only available to the owner.

     */

    function renounceOwnership() public onlyOwner {

        emit OwnershipTransferred(_owner, address(0));

        _owner = address(0);

    }



    /**

     * @dev Transfers ownership of the contract to a new account (`newOwner`).

     * Can only be called by the current owner.

     */

    function transferOwnership(address newOwner) public onlyOwner {

        _transferOwnership(newOwner);

    }



    /**

     * @dev Transfers ownership of the contract to a new account (`newOwner`).

     */

    function _transferOwnership(address newOwner) internal {

        require(newOwner != address(0), "Ownable: new owner is the zero address");

        emit OwnershipTransferred(_owner, newOwner);

        _owner = newOwner;

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



// File: contracts/compound/ComptrollerInterface.sol



pragma solidity ^0.5.16;



contract ComptrollerInterface {

    // implemented, but missing from the interface

    function getAccountLiquidity(address account) external view returns (uint, uint, uint);

    function getHypotheticalAccountLiquidity(

        address account,

        address cTokenModify,

        uint redeemTokens,

        uint borrowAmount) external view returns (uint, uint, uint);

    function claimComp(address holder) external;



    /// @notice Indicator that this is a Comptroller contract (for inspection)

    bool public constant isComptroller = true;



    /*** Assets You Are In ***/



    function enterMarkets(address[] calldata cTokens) external returns (uint[] memory);

    function exitMarket(address cToken) external returns (uint);



    /*** Policy Hooks ***/



    function mintAllowed(address cToken, address minter, uint mintAmount) external returns (uint);

    function mintVerify(address cToken, address minter, uint mintAmount, uint mintTokens) external;



    function redeemAllowed(address cToken, address redeemer, uint redeemTokens) external returns (uint);

    function redeemVerify(address cToken, address redeemer, uint redeemAmount, uint redeemTokens) external;



    function borrowAllowed(address cToken, address borrower, uint borrowAmount) external returns (uint);

    function borrowVerify(address cToken, address borrower, uint borrowAmount) external;



    function repayBorrowAllowed(

        address cToken,

        address payer,

        address borrower,

        uint repayAmount) external returns (uint);

    function repayBorrowVerify(

        address cToken,

        address payer,

        address borrower,

        uint repayAmount,

        uint borrowerIndex) external;



    function liquidateBorrowAllowed(

        address cTokenBorrowed,

        address cTokenCollateral,

        address liquidator,

        address borrower,

        uint repayAmount) external returns (uint);

    function liquidateBorrowVerify(

        address cTokenBorrowed,

        address cTokenCollateral,

        address liquidator,

        address borrower,

        uint repayAmount,

        uint seizeTokens) external;



    function seizeAllowed(

        address cTokenCollateral,

        address cTokenBorrowed,

        address liquidator,

        address borrower,

        uint seizeTokens) external returns (uint);

    function seizeVerify(

        address cTokenCollateral,

        address cTokenBorrowed,

        address liquidator,

        address borrower,

        uint seizeTokens) external;



    function transferAllowed(address cToken, address src, address dst, uint transferTokens) external returns (uint);

    function transferVerify(address cToken, address src, address dst, uint transferTokens) external;



    /*** Liquidity/Liquidation Calculations ***/



    function liquidateCalculateSeizeTokens(

        address cTokenBorrowed,

        address cTokenCollateral,

        uint repayAmount) external view returns (uint, uint);



    function markets(address cToken) external view returns (bool, uint);

    function compSpeeds(address cToken) external view returns (uint);

}



// File: contracts/compound/InterestRateModel.sol



pragma solidity ^0.5.16;



/**

  * @title Compound's InterestRateModel Interface

  * @author Compound

  */

contract InterestRateModel {

    /// @notice Indicator that this is an InterestRateModel contract (for inspection)

    bool public constant isInterestRateModel = true;



    /**

      * @notice Calculates the current borrow interest rate per block

      * @param cash The total amount of cash the market has

      * @param borrows The total amount of borrows the market has outstanding

      * @param reserves The total amnount of reserves the market has

      * @return The borrow rate per block (as a percentage, and scaled by 1e18)

      */

    function getBorrowRate(uint cash, uint borrows, uint reserves) external view returns (uint);



    /**

      * @notice Calculates the current supply interest rate per block

      * @param cash The total amount of cash the market has

      * @param borrows The total amount of borrows the market has outstanding

      * @param reserves The total amnount of reserves the market has

      * @param reserveFactorMantissa The current reserve factor the market has

      * @return The supply rate per block (as a percentage, and scaled by 1e18)

      */

    function getSupplyRate(uint cash, uint borrows, uint reserves, uint reserveFactorMantissa) external view returns (uint);



}



// File: contracts/compound/CTokenInterfaces.sol



pragma solidity ^0.5.16;







contract CTokenStorage {

    /**

     * @dev Guard variable for re-entrancy checks

     */

    bool internal _notEntered;



    /**

     * @notice EIP-20 token name for this token

     */

    string public name;



    /**

     * @notice EIP-20 token symbol for this token

     */

    string public symbol;



    /**

     * @notice EIP-20 token decimals for this token

     */

    uint8 public decimals;



    /**

     * @notice Maximum borrow rate that can ever be applied (.0005% / block)

     */



    uint internal constant borrowRateMaxMantissa = 0.0005e16;



    /**

     * @notice Maximum fraction of interest that can be set aside for reserves

     */

    uint internal constant reserveFactorMaxMantissa = 1e18;



    /**

     * @notice Administrator for this contract

     */

    address payable public admin;



    /**

     * @notice Pending administrator for this contract

     */

    address payable public pendingAdmin;



    /**

     * @notice Contract which oversees inter-cToken operations

     */

    ComptrollerInterface public comptroller;



    /**

     * @notice Model which tells what the current interest rate should be

     */

    InterestRateModel public interestRateModel;



    /**

     * @notice Initial exchange rate used when minting the first CTokens (used when totalSupply = 0)

     */

    uint internal initialExchangeRateMantissa;



    /**

     * @notice Fraction of interest currently set aside for reserves

     */

    uint public reserveFactorMantissa;



    /**

     * @notice Block number that interest was last accrued at

     */

    uint public accrualBlockNumber;



    /**

     * @notice Accumulator of the total earned interest rate since the opening of the market

     */

    uint public borrowIndex;



    /**

     * @notice Total amount of outstanding borrows of the underlying in this market

     */

    uint public totalBorrows;



    /**

     * @notice Total amount of reserves of the underlying held in this market

     */

    uint public totalReserves;



    /**

     * @notice Total number of tokens in circulation

     */

    uint public totalSupply;



    /**

     * @notice Official record of token balances for each account

     */

    mapping (address => uint) internal accountTokens;



    /**

     * @notice Approved token transfer amounts on behalf of others

     */

    mapping (address => mapping (address => uint)) internal transferAllowances;



    /**

     * @notice Container for borrow balance information

     * @member principal Total balance (with accrued interest), after applying the most recent balance-changing action

     * @member interestIndex Global borrowIndex as of the most recent balance-changing action

     */

    struct BorrowSnapshot {

        uint principal;

        uint interestIndex;

    }



    /**

     * @notice Mapping of account addresses to outstanding borrow balances

     */

    mapping(address => BorrowSnapshot) internal accountBorrows;

}



contract CTokenInterface is CTokenStorage {

    /**

     * @notice Indicator that this is a CToken contract (for inspection)

     */

    bool public constant isCToken = true;





    /*** Market Events ***/



    /**

     * @notice Event emitted when interest is accrued

     */

    event AccrueInterest(uint cashPrior, uint interestAccumulated, uint borrowIndex, uint totalBorrows);



    /**

     * @notice Event emitted when tokens are minted

     */

    event Mint(address minter, uint mintAmount, uint mintTokens);



    /**

     * @notice Event emitted when tokens are redeemed

     */

    event Redeem(address redeemer, uint redeemAmount, uint redeemTokens);



    /**

     * @notice Event emitted when underlying is borrowed

     */

    event Borrow(address borrower, uint borrowAmount, uint accountBorrows, uint totalBorrows);



    /**

     * @notice Event emitted when a borrow is repaid

     */

    event RepayBorrow(address payer, address borrower, uint repayAmount, uint accountBorrows, uint totalBorrows);



    /**

     * @notice Event emitted when a borrow is liquidated

     */

    event LiquidateBorrow(address liquidator, address borrower, uint repayAmount, address cTokenCollateral, uint seizeTokens);





    /*** Admin Events ***/



    /**

     * @notice Event emitted when pendingAdmin is changed

     */

    event NewPendingAdmin(address oldPendingAdmin, address newPendingAdmin);



    /**

     * @notice Event emitted when pendingAdmin is accepted, which means admin is updated

     */

    event NewAdmin(address oldAdmin, address newAdmin);



    /**

     * @notice Event emitted when comptroller is changed

     */

    event NewComptroller(ComptrollerInterface oldComptroller, ComptrollerInterface newComptroller);



    /**

     * @notice Event emitted when interestRateModel is changed

     */

    event NewMarketInterestRateModel(InterestRateModel oldInterestRateModel, InterestRateModel newInterestRateModel);



    /**

     * @notice Event emitted when the reserve factor is changed

     */

    event NewReserveFactor(uint oldReserveFactorMantissa, uint newReserveFactorMantissa);



    /**

     * @notice Event emitted when the reserves are added

     */

    event ReservesAdded(address benefactor, uint addAmount, uint newTotalReserves);



    /**

     * @notice Event emitted when the reserves are reduced

     */

    event ReservesReduced(address admin, uint reduceAmount, uint newTotalReserves);



    /**

     * @notice EIP20 Transfer event

     */

    event Transfer(address indexed from, address indexed to, uint amount);



    /**

     * @notice EIP20 Approval event

     */

    event Approval(address indexed owner, address indexed spender, uint amount);



    /**

     * @notice Failure event

     */

    event Failure(uint error, uint info, uint detail);





    /*** User Interface ***/



    function transfer(address dst, uint amount) external returns (bool);

    function transferFrom(address src, address dst, uint amount) external returns (bool);

    function approve(address spender, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function balanceOf(address owner) external view returns (uint);

    function balanceOfUnderlying(address owner) external returns (uint);

    function getAccountSnapshot(address account) external view returns (uint, uint, uint, uint);

    function borrowRatePerBlock() external view returns (uint);

    function supplyRatePerBlock() external view returns (uint);

    function totalBorrowsCurrent() external returns (uint);

    function borrowBalanceCurrent(address account) external returns (uint);

    function borrowBalanceStored(address account) public view returns (uint);

    function exchangeRateCurrent() public returns (uint);

    function exchangeRateStored() public view returns (uint);

    function getCash() external view returns (uint);

    function accrueInterest() public returns (uint);

    function seize(address liquidator, address borrower, uint seizeTokens) external returns (uint);





    /*** Admin Functions ***/



    function _setPendingAdmin(address payable newPendingAdmin) external returns (uint);

    function _acceptAdmin() external returns (uint);

    function _setComptroller(ComptrollerInterface newComptroller) public returns (uint);

    function _setReserveFactor(uint newReserveFactorMantissa) external returns (uint);

    function _reduceReserves(uint reduceAmount) external returns (uint);

    function _setInterestRateModel(InterestRateModel newInterestRateModel) public returns (uint);

}



contract CErc20Storage {

    /**

     * @notice Underlying asset for this CToken

     */

    address public underlying;

}



contract CErc20Interface is CErc20Storage {



    /*** User Interface ***/



    function mint(uint mintAmount) external returns (uint);

    function redeem(uint redeemTokens) external returns (uint);

    function redeemUnderlying(uint redeemAmount) external returns (uint);

    function borrow(uint borrowAmount) external returns (uint);

    function repayBorrow(uint repayAmount) external returns (uint);

    function repayBorrowBehalf(address borrower, uint repayAmount) external returns (uint);

    function liquidateBorrow(address borrower, uint repayAmount, CTokenInterface cTokenCollateral) external returns (uint);





    /*** Admin Functions ***/



    function _addReserves(uint addAmount) external returns (uint);

}



contract CDelegationStorage {

    /**

     * @notice Implementation address for this contract

     */

    address public implementation;

}



contract CDelegatorInterface is CDelegationStorage {

    /**

     * @notice Emitted when implementation is changed

     */

    event NewImplementation(address oldImplementation, address newImplementation);



    /**

     * @notice Called by the admin to update the implementation of the delegator

     * @param implementation_ The address of the new implementation for delegation

     * @param allowResign Flag to indicate whether to call _resignImplementation on the old implementation

     * @param becomeImplementationData The encoded bytes data to be passed to _becomeImplementation

     */

    function _setImplementation(address implementation_, bool allowResign, bytes memory becomeImplementationData) public;

}



contract CDelegateInterface is CDelegationStorage {

    /**

     * @notice Called by the delegator on a delegate to initialize it for duty

     * @dev Should revert if any issues arise which make it unfit for delegation

     * @param data The encoded bytes data for any initialization

     */

    function _becomeImplementation(bytes memory data) public;



    /**

     * @notice Called by the delegator on a delegate to forfeit its responsibility

     */

    function _resignImplementation() public;

}



// File: contracts/strategies/compound/CompleteCToken.sol



pragma solidity 0.5.16;







contract CompleteCToken is CErc20Interface, CTokenInterface {}



// File: contracts/hardworkInterface/IStrategy.sol



pragma solidity 0.5.16;



interface IStrategy {

    

    function unsalvagableTokens(address tokens) external view returns (bool);

    

    function governance() external view returns (address);

    function controller() external view returns (address);

    function underlying() external view returns (address);

    function vault() external view returns (address);



    function withdrawAllToVault() external;

    function withdrawToVault(uint256 amount) external;



    function investedUnderlyingBalance() external view returns (uint256); // itsNotMuch()



    // should only be called by controller

    function salvage(address recipient, address token, uint256 amount) external;



    function doHardWork() external;

    function depositArbCheck() external view returns(bool);

}



// File: contracts/weth/WETH9.sol



// based on https://etherscan.io/address/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2#code



/**

 *Submitted for verification at Etherscan.io on 2017-12-12

*/



// Copyright (C) 2015, 2016, 2017 Dapphub



// This program is free software: you can redistribute it and/or modify

// it under the terms of the GNU General Public License as published by

// the Free Software Foundation, either version 3 of the License, or

// (at your option) any later version.



// This program is distributed in the hope that it will be useful,

// but WITHOUT ANY WARRANTY; without even the implied warranty of

// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the

// GNU General Public License for more details.



// You should have received a copy of the GNU General Public License

// along with this program.  If not, see <http://www.gnu.org/licenses/>.



pragma solidity 0.5.16;



contract WETH9 {



    function balanceOf(address target) public view returns (uint256); 



    function deposit() public payable ;

    function withdraw(uint wad) public ;

    function totalSupply() public view returns (uint) ;

    function approve(address guy, uint wad) public returns (bool) ;

    function transfer(address dst, uint wad) public returns (bool) ;

    function transferFrom(address src, address dst, uint wad) public returns (bool);



}





/*

                    GNU GENERAL PUBLIC LICENSE

                       Version 3, 29 June 2007



 Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>

 Everyone is permitted to copy and distribute verbatim copies

 of this license document, but changing it is not allowed.



                            Preamble



  The GNU General Public License is a free, copyleft license for

software and other kinds of works.



  The licenses for most software and other practical works are designed

to take away your freedom to share and change the works.  By contrast,

the GNU General Public License is intended to guarantee your freedom to

share and change all versions of a program--to make sure it remains free

software for all its users.  We, the Free Software Foundation, use the

GNU General Public License for most of our software; it applies also to

any other work released this way by its authors.  You can apply it to

your programs, too.



  When we speak of free software, we are referring to freedom, not

price.  Our General Public Licenses are designed to make sure that you

have the freedom to distribute copies of free software (and charge for

them if you wish), that you receive source code or can get it if you

want it, that you can change the software or use pieces of it in new

free programs, and that you know you can do these things.



  To protect your rights, we need to prevent others from denying you

these rights or asking you to surrender the rights.  Therefore, you have

certain responsibilities if you distribute copies of the software, or if

you modify it: responsibilities to respect the freedom of others.



  For example, if you distribute copies of such a program, whether

gratis or for a fee, you must pass on to the recipients the same

freedoms that you received.  You must make sure that they, too, receive

or can get the source code.  And you must show them these terms so they

know their rights.



  Developers that use the GNU GPL protect your rights with two steps:

(1) assert copyright on the software, and (2) offer you this License

giving you legal permission to copy, distribute and/or modify it.



  For the developers' and authors' protection, the GPL clearly explains

that there is no warranty for this free software.  For both users' and

authors' sake, the GPL requires that modified versions be marked as

changed, so that their problems will not be attributed erroneously to

authors of previous versions.



  Some devices are designed to deny users access to install or run

modified versions of the software inside them, although the manufacturer

can do so.  This is fundamentally incompatible with the aim of

protecting users' freedom to change the software.  The systematic

pattern of such abuse occurs in the area of products for individuals to

use, which is precisely where it is most unacceptable.  Therefore, we

have designed this version of the GPL to prohibit the practice for those

products.  If such problems arise substantially in other domains, we

stand ready to extend this provision to those domains in future versions

of the GPL, as needed to protect the freedom of users.



  Finally, every program is threatened constantly by software patents.

States should not allow patents to restrict development and use of

software on general-purpose computers, but in those that do, we wish to

avoid the special danger that patents applied to a free program could

make it effectively proprietary.  To prevent this, the GPL assures that

patents cannot be used to render the program non-free.



  The precise terms and conditions for copying, distribution and

modification follow.



                       TERMS AND CONDITIONS



  0. Definitions.



  "This License" refers to version 3 of the GNU General Public License.



  "Copyright" also means copyright-like laws that apply to other kinds of

works, such as semiconductor masks.



  "The Program" refers to any copyrightable work licensed under this

License.  Each licensee is addressed as "you".  "Licensees" and

"recipients" may be individuals or organizations.



  To "modify" a work means to copy from or adapt all or part of the work

in a fashion requiring copyright permission, other than the making of an

exact copy.  The resulting work is called a "modified version" of the

earlier work or a work "based on" the earlier work.



  A "covered work" means either the unmodified Program or a work based

on the Program.



  To "propagate" a work means to do anything with it that, without

permission, would make you directly or secondarily liable for

infringement under applicable copyright law, except executing it on a

computer or modifying a private copy.  Propagation includes copying,

distribution (with or without modification), making available to the

public, and in some countries other activities as well.



  To "convey" a work means any kind of propagation that enables other

parties to make or receive copies.  Mere interaction with a user through

a computer network, with no transfer of a copy, is not conveying.



  An interactive user interface displays "Appropriate Legal Notices"

to the extent that it includes a convenient and prominently visible

feature that (1) displays an appropriate copyright notice, and (2)

tells the user that there is no warranty for the work (except to the

extent that warranties are provided), that licensees may convey the

work under this License, and how to view a copy of this License.  If

the interface presents a list of user commands or options, such as a

menu, a prominent item in the list meets this criterion.



  1. Source Code.



  The "source code" for a work means the preferred form of the work

for making modifications to it.  "Object code" means any non-source

form of a work.



  A "Standard Interface" means an interface that either is an official

standard defined by a recognized standards body, or, in the case of

interfaces specified for a particular programming language, one that

is widely used among developers working in that language.



  The "System Libraries" of an executable work include anything, other

than the work as a whole, that (a) is included in the normal form of

packaging a Major Component, but which is not part of that Major

Component, and (b) serves only to enable use of the work with that

Major Component, or to implement a Standard Interface for which an

implementation is available to the public in source code form.  A

"Major Component", in this context, means a major essential component

(kernel, window system, and so on) of the specific operating system

(if any) on which the executable work runs, or a compiler used to

produce the work, or an object code interpreter used to run it.



  The "Corresponding Source" for a work in object code form means all

the source code needed to generate, install, and (for an executable

work) run the object code and to modify the work, including scripts to

control those activities.  However, it does not include the work's

System Libraries, or general-purpose tools or generally available free

programs which are used unmodified in performing those activities but

which are not part of the work.  For example, Corresponding Source

includes interface definition files associated with source files for

the work, and the source code for shared libraries and dynamically

linked subprograms that the work is specifically designed to require,

such as by intimate data communication or control flow between those

subprograms and other parts of the work.



  The Corresponding Source need not include anything that users

can regenerate automatically from other parts of the Corresponding

Source.



  The Corresponding Source for a work in source code form is that

same work.



  2. Basic Permissions.



  All rights granted under this License are granted for the term of

copyright on the Program, and are irrevocable provided the stated

conditions are met.  This License explicitly affirms your unlimited

permission to run the unmodified Program.  The output from running a

covered work is covered by this License only if the output, given its

content, constitutes a covered work.  This License acknowledges your

rights of fair use or other equivalent, as provided by copyright law.



  You may make, run and propagate covered works that you do not

convey, without conditions so long as your license otherwise remains

in force.  You may convey covered works to others for the sole purpose

of having them make modifications exclusively for you, or provide you

with facilities for running those works, provided that you comply with

the terms of this License in conveying all material for which you do

not control copyright.  Those thus making or running the covered works

for you must do so exclusively on your behalf, under your direction

and control, on terms that prohibit them from making any copies of

your copyrighted material outside their relationship with you.



  Conveying under any other circumstances is permitted solely under

the conditions stated below.  Sublicensing is not allowed; section 10

makes it unnecessary.



  3. Protecting Users' Legal Rights From Anti-Circumvention Law.



  No covered work shall be deemed part of an effective technological

measure under any applicable law fulfilling obligations under article

11 of the WIPO copyright treaty adopted on 20 December 1996, or

similar laws prohibiting or restricting circumvention of such

measures.



  When you convey a covered work, you waive any legal power to forbid

circumvention of technological measures to the extent such circumvention

is effected by exercising rights under this License with respect to

the covered work, and you disclaim any intention to limit operation or

modification of the work as a means of enforcing, against the work's

users, your or third parties' legal rights to forbid circumvention of

technological measures.



  4. Conveying Verbatim Copies.



  You may convey verbatim copies of the Program's source code as you

receive it, in any medium, provided that you conspicuously and

appropriately publish on each copy an appropriate copyright notice;

keep intact all notices stating that this License and any

non-permissive terms added in accord with section 7 apply to the code;

keep intact all notices of the absence of any warranty; and give all

recipients a copy of this License along with the Program.



  You may charge any price or no price for each copy that you convey,

and you may offer support or warranty protection for a fee.



  5. Conveying Modified Source Versions.



  You may convey a work based on the Program, or the modifications to

produce it from the Program, in the form of source code under the

terms of section 4, provided that you also meet all of these conditions:



    a) The work must carry prominent notices stating that you modified

    it, and giving a relevant date.



    b) The work must carry prominent notices stating that it is

    released under this License and any conditions added under section

    7.  This requirement modifies the requirement in section 4 to

    "keep intact all notices".



    c) You must license the entire work, as a whole, under this

    License to anyone who comes into possession of a copy.  This

    License will therefore apply, along with any applicable section 7

    additional terms, to the whole of the work, and all its parts,

    regardless of how they are packaged.  This License gives no

    permission to license the work in any other way, but it does not

    invalidate such permission if you have separately received it.



    d) If the work has interactive user interfaces, each must display

    Appropriate Legal Notices; however, if the Program has interactive

    interfaces that do not display Appropriate Legal Notices, your

    work need not make them do so.



  A compilation of a covered work with other separate and independent

works, which are not by their nature extensions of the covered work,

and which are not combined with it such as to form a larger program,

in or on a volume of a storage or distribution medium, is called an

"aggregate" if the compilation and its resulting copyright are not

used to limit the access or legal rights of the compilation's users

beyond what the individual works permit.  Inclusion of a covered work

in an aggregate does not cause this License to apply to the other

parts of the aggregate.



  6. Conveying Non-Source Forms.



  You may convey a covered work in object code form under the terms

of sections 4 and 5, provided that you also convey the

machine-readable Corresponding Source under the terms of this License,

in one of these ways:



    a) Convey the object code in, or embodied in, a physical product

    (including a physical distribution medium), accompanied by the

    Corresponding Source fixed on a durable physical medium

    customarily used for software interchange.



    b) Convey the object code in, or embodied in, a physical product

    (including a physical distribution medium), accompanied by a

    written offer, valid for at least three years and valid for as

    long as you offer spare parts or customer support for that product

    model, to give anyone who possesses the object code either (1) a

    copy of the Corresponding Source for all the software in the

    product that is covered by this License, on a durable physical

    medium customarily used for software interchange, for a price no

    more than your reasonable cost of physically performing this

    conveying of source, or (2) access to copy the

    Corresponding Source from a network server at no charge.



    c) Convey individual copies of the object code with a copy of the

    written offer to provide the Corresponding Source.  This

    alternative is allowed only occasionally and noncommercially, and

    only if you received the object code with such an offer, in accord

    with subsection 6b.



    d) Convey the object code by offering access from a designated

    place (gratis or for a charge), and offer equivalent access to the

    Corresponding Source in the same way through the same place at no

    further charge.  You need not require recipients to copy the

    Corresponding Source along with the object code.  If the place to

    copy the object code is a network server, the Corresponding Source

    may be on a different server (operated by you or a third party)

    that supports equivalent copying facilities, provided you maintain

    clear directions next to the object code saying where to find the

    Corresponding Source.  Regardless of what server hosts the

    Corresponding Source, you remain obligated to ensure that it is

    available for as long as needed to satisfy these requirements.



    e) Convey the object code using peer-to-peer transmission, provided

    you inform other peers where the object code and Corresponding

    Source of the work are being offered to the general public at no

    charge under subsection 6d.



  A separable portion of the object code, whose source code is excluded

from the Corresponding Source as a System Library, need not be

included in conveying the object code work.



  A "User Product" is either (1) a "consumer product", which means any

tangible personal property which is normally used for personal, family,

or household purposes, or (2) anything designed or sold for incorporation

into a dwelling.  In determining whether a product is a consumer product,

doubtful cases shall be resolved in favor of coverage.  For a particular

product received by a particular user, "normally used" refers to a

typical or common use of that class of product, regardless of the status

of the particular user or of the way in which the particular user

actually uses, or expects or is expected to use, the product.  A product

is a consumer product regardless of whether the product has substantial

commercial, industrial or non-consumer uses, unless such uses represent

the only significant mode of use of the product.



  "Installation Information" for a User Product means any methods,

procedures, authorization keys, or other information required to install

and execute modified versions of a covered work in that User Product from

a modified version of its Corresponding Source.  The information must

suffice to ensure that the continued functioning of the modified object

code is in no case prevented or interfered with solely because

modification has been made.



  If you convey an object code work under this section in, or with, or

specifically for use in, a User Product, and the conveying occurs as

part of a transaction in which the right of possession and use of the

User Product is transferred to the recipient in perpetuity or for a

fixed term (regardless of how the transaction is characterized), the

Corresponding Source conveyed under this section must be accompanied

by the Installation Information.  But this requirement does not apply

if neither you nor any third party retains the ability to install

modified object code on the User Product (for example, the work has

been installed in ROM).



  The requirement to provide Installation Information does not include a

requirement to continue to provide support service, warranty, or updates

for a work that has been modified or installed by the recipient, or for

the User Product in which it has been modified or installed.  Access to a

network may be denied when the modification itself materially and

adversely affects the operation of the network or violates the rules and

protocols for communication across the network.



  Corresponding Source conveyed, and Installation Information provided,

in accord with this section must be in a format that is publicly

documented (and with an implementation available to the public in

source code form), and must require no special password or key for

unpacking, reading or copying.



  7. Additional Terms.



  "Additional permissions" are terms that supplement the terms of this

License by making exceptions from one or more of its conditions.

Additional permissions that are applicable to the entire Program shall

be treated as though they were included in this License, to the extent

that they are valid under applicable law.  If additional permissions

apply only to part of the Program, that part may be used separately

under those permissions, but the entire Program remains governed by

this License without regard to the additional permissions.



  When you convey a copy of a covered work, you may at your option

remove any additional permissions from that copy, or from any part of

it.  (Additional permissions may be written to require their own

removal in certain cases when you modify the work.)  You may place

additional permissions on material, added by you to a covered work,

for which you have or can give appropriate copyright permission.



  Notwithstanding any other provision of this License, for material you

add to a covered work, you may (if authorized by the copyright holders of

that material) supplement the terms of this License with terms:



    a) Disclaiming warranty or limiting liability differently from the

    terms of sections 15 and 16 of this License; or



    b) Requiring preservation of specified reasonable legal notices or

    author attributions in that material or in the Appropriate Legal

    Notices displayed by works containing it; or



    c) Prohibiting misrepresentation of the origin of that material, or

    requiring that modified versions of such material be marked in

    reasonable ways as different from the original version; or



    d) Limiting the use for publicity purposes of names of licensors or

    authors of the material; or



    e) Declining to grant rights under trademark law for use of some

    trade names, trademarks, or service marks; or



    f) Requiring indemnification of licensors and authors of that

    material by anyone who conveys the material (or modified versions of

    it) with contractual assumptions of liability to the recipient, for

    any liability that these contractual assumptions directly impose on

    those licensors and authors.



  All other non-permissive additional terms are considered "further

restrictions" within the meaning of section 10.  If the Program as you

received it, or any part of it, contains a notice stating that it is

governed by this License along with a term that is a further

restriction, you may remove that term.  If a license document contains

a further restriction but permits relicensing or conveying under this

License, you may add to a covered work material governed by the terms

of that license document, provided that the further restriction does

not survive such relicensing or conveying.



  If you add terms to a covered work in accord with this section, you

must place, in the relevant source files, a statement of the

additional terms that apply to those files, or a notice indicating

where to find the applicable terms.



  Additional terms, permissive or non-permissive, may be stated in the

form of a separately written license, or stated as exceptions;

the above requirements apply either way.



  8. Termination.



  You may not propagate or modify a covered work except as expressly

provided under this License.  Any attempt otherwise to propagate or

modify it is void, and will automatically terminate your rights under

this License (including any patent licenses granted under the third

paragraph of section 11).



  However, if you cease all violation of this License, then your

license from a particular copyright holder is reinstated (a)

provisionally, unless and until the copyright holder explicitly and

finally terminates your license, and (b) permanently, if the copyright

holder fails to notify you of the violation by some reasonable means

prior to 60 days after the cessation.



  Moreover, your license from a particular copyright holder is

reinstated permanently if the copyright holder notifies you of the

violation by some reasonable means, this is the first time you have

received notice of violation of this License (for any work) from that

copyright holder, and you cure the violation prior to 30 days after

your receipt of the notice.



  Termination of your rights under this section does not terminate the

licenses of parties who have received copies or rights from you under

this License.  If your rights have been terminated and not permanently

reinstated, you do not qualify to receive new licenses for the same

material under section 10.



  9. Acceptance Not Required for Having Copies.



  You are not required to accept this License in order to receive or

run a copy of the Program.  Ancillary propagation of a covered work

occurring solely as a consequence of using peer-to-peer transmission

to receive a copy likewise does not require acceptance.  However,

nothing other than this License grants you permission to propagate or

modify any covered work.  These actions infringe copyright if you do

not accept this License.  Therefore, by modifying or propagating a

covered work, you indicate your acceptance of this License to do so.



  10. Automatic Licensing of Downstream Recipients.



  Each time you convey a covered work, the recipient automatically

receives a license from the original licensors, to run, modify and

propagate that work, subject to this License.  You are not responsible

for enforcing compliance by third parties with this License.



  An "entity transaction" is a transaction transferring control of an

organization, or substantially all assets of one, or subdividing an

organization, or merging organizations.  If propagation of a covered

work results from an entity transaction, each party to that

transaction who receives a copy of the work also receives whatever

licenses to the work the party's predecessor in interest had or could

give under the previous paragraph, plus a right to possession of the

Corresponding Source of the work from the predecessor in interest, if

the predecessor has it or can get it with reasonable efforts.



  You may not impose any further restrictions on the exercise of the

rights granted or affirmed under this License.  For example, you may

not impose a license fee, royalty, or other charge for exercise of

rights granted under this License, and you may not initiate litigation

(including a cross-claim or counterclaim in a lawsuit) alleging that

any patent claim is infringed by making, using, selling, offering for

sale, or importing the Program or any portion of it.



  11. Patents.



  A "contributor" is a copyright holder who authorizes use under this

License of the Program or a work on which the Program is based.  The

work thus licensed is called the contributor's "contributor version".



  A contributor's "essential patent claims" are all patent claims

owned or controlled by the contributor, whether already acquired or

hereafter acquired, that would be infringed by some manner, permitted

by this License, of making, using, or selling its contributor version,

but do not include claims that would be infringed only as a

consequence of further modification of the contributor version.  For

purposes of this definition, "control" includes the right to grant

patent sublicenses in a manner consistent with the requirements of

this License.



  Each contributor grants you a non-exclusive, worldwide, royalty-free

patent license under the contributor's essential patent claims, to

make, use, sell, offer for sale, import and otherwise run, modify and

propagate the contents of its contributor version.



  In the following three paragraphs, a "patent license" is any express

agreement or commitment, however denominated, not to enforce a patent

(such as an express permission to practice a patent or covenant not to

sue for patent infringement).  To "grant" such a patent license to a

party means to make such an agreement or commitment not to enforce a

patent against the party.



  If you convey a covered work, knowingly relying on a patent license,

and the Corresponding Source of the work is not available for anyone

to copy, free of charge and under the terms of this License, through a

publicly available network server or other readily accessible means,

then you must either (1) cause the Corresponding Source to be so

available, or (2) arrange to deprive yourself of the benefit of the

patent license for this particular work, or (3) arrange, in a manner

consistent with the requirements of this License, to extend the patent

license to downstream recipients.  "Knowingly relying" means you have

actual knowledge that, but for the patent license, your conveying the

covered work in a country, or your recipient's use of the covered work

in a country, would infringe one or more identifiable patents in that

country that you have reason to believe are valid.



  If, pursuant to or in connection with a single transaction or

arrangement, you convey, or propagate by procuring conveyance of, a

covered work, and grant a patent license to some of the parties

receiving the covered work authorizing them to use, propagate, modify

or convey a specific copy of the covered work, then the patent license

you grant is automatically extended to all recipients of the covered

work and works based on it.



  A patent license is "discriminatory" if it does not include within

the scope of its coverage, prohibits the exercise of, or is

conditioned on the non-exercise of one or more of the rights that are

specifically granted under this License.  You may not convey a covered

work if you are a party to an arrangement with a third party that is

in the business of distributing software, under which you make payment

to the third party based on the extent of your activity of conveying

the work, and under which the third party grants, to any of the

parties who would receive the covered work from you, a discriminatory

patent license (a) in connection with copies of the covered work

conveyed by you (or copies made from those copies), or (b) primarily

for and in connection with specific products or compilations that

contain the covered work, unless you entered into that arrangement,

or that patent license was granted, prior to 28 March 2007.



  Nothing in this License shall be construed as excluding or limiting

any implied license or other defenses to infringement that may

otherwise be available to you under applicable patent law.



  12. No Surrender of Others' Freedom.



  If conditions are imposed on you (whether by court order, agreement or

otherwise) that contradict the conditions of this License, they do not

excuse you from the conditions of this License.  If you cannot convey a

covered work so as to satisfy simultaneously your obligations under this

License and any other pertinent obligations, then as a consequence you may

not convey it at all.  For example, if you agree to terms that obligate you

to collect a royalty for further conveying from those to whom you convey

the Program, the only way you could satisfy both those terms and this

License would be to refrain entirely from conveying the Program.



  13. Use with the GNU Affero General Public License.



  Notwithstanding any other provision of this License, you have

permission to link or combine any covered work with a work licensed

under version 3 of the GNU Affero General Public License into a single

combined work, and to convey the resulting work.  The terms of this

License will continue to apply to the part which is the covered work,

but the special requirements of the GNU Affero General Public License,

section 13, concerning interaction through a network will apply to the

combination as such.



  14. Revised Versions of this License.



  The Free Software Foundation may publish revised and/or new versions of

the GNU General Public License from time to time.  Such new versions will

be similar in spirit to the present version, but may differ in detail to

address new problems or concerns.



  Each version is given a distinguishing version number.  If the

Program specifies that a certain numbered version of the GNU General

Public License "or any later version" applies to it, you have the

option of following the terms and conditions either of that numbered

version or of any later version published by the Free Software

Foundation.  If the Program does not specify a version number of the

GNU General Public License, you may choose any version ever published

by the Free Software Foundation.



  If the Program specifies that a proxy can decide which future

versions of the GNU General Public License can be used, that proxy's

public statement of acceptance of a version permanently authorizes you

to choose that version for the Program.



  Later license versions may give you additional or different

permissions.  However, no additional obligations are imposed on any

author or copyright holder as a result of your choosing to follow a

later version.



  15. Disclaimer of Warranty.



  THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY

APPLICABLE LAW.  EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT

HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY

OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO,

THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR

PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM

IS WITH YOU.  SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF

ALL NECESSARY SERVICING, REPAIR OR CORRECTION.



  16. Limitation of Liability.



  IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING

WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS

THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY

GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE

USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF

DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD

PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS),

EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF

SUCH DAMAGES.



  17. Interpretation of Sections 15 and 16.



  If the disclaimer of warranty and limitation of liability provided

above cannot be given local legal effect according to their terms,

reviewing courts shall apply local law that most closely approximates

an absolute waiver of all civil liability in connection with the

Program, unless a warranty or assumption of liability accompanies a

copy of the Program in return for a fee.



                     END OF TERMS AND CONDITIONS



            How to Apply These Terms to Your New Programs



  If you develop a new program, and you want it to be of the greatest

possible use to the public, the best way to achieve this is to make it

free software which everyone can redistribute and change under these terms.



  To do so, attach the following notices to the program.  It is safest

to attach them to the start of each source file to most effectively

state the exclusion of warranty; and each file should have at least

the "copyright" line and a pointer to where the full notice is found.



    <one line to give the program's name and a brief idea of what it does.>

    Copyright (C) <year>  <name of author>



    This program is free software: you can redistribute it and/or modify

    it under the terms of the GNU General Public License as published by

    the Free Software Foundation, either version 3 of the License, or

    (at your option) any later version.



    This program is distributed in the hope that it will be useful,

    but WITHOUT ANY WARRANTY; without even the implied warranty of

    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the

    GNU General Public License for more details.



    You should have received a copy of the GNU General Public License

    along with this program.  If not, see <http://www.gnu.org/licenses/>.



Also add information on how to contact you by electronic and paper mail.



  If the program does terminal interaction, make it output a short

notice like this when it starts in an interactive mode:



    <program>  Copyright (C) <year>  <name of author>

    This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.

    This is free software, and you are welcome to redistribute it

    under certain conditions; type `show c' for details.



The hypothetical commands `show w' and `show c' should show the appropriate

parts of the General Public License.  Of course, your program's commands

might be different; for a GUI interface, you would use an "about box".



  You should also get your employer (if you work as a programmer) or school,

if any, to sign a "copyright disclaimer" for the program, if necessary.

For more information on this, and how to apply and follow the GNU GPL, see

<http://www.gnu.org/licenses/>.



  The GNU General Public License does not permit incorporating your program

into proprietary programs.  If your program is a subroutine library, you

may consider it more useful to permit linking proprietary applications with

the library.  If this is what you want to do, use the GNU Lesser General

Public License instead of this License.  But first, please read

<http://www.gnu.org/philosophy/why-not-lgpl.html>.



*/



// File: @studydefi/money-legos/compound/contracts/ICEther.sol



pragma solidity ^0.5.0;



contract ICEther {

    function mint() external payable;

    function borrow(uint borrowAmount) external returns (uint);

    function redeem(uint redeemTokens) external returns (uint);

    function redeemUnderlying(uint redeemAmount) external returns (uint);

    function repayBorrow() external payable;

    function repayBorrowBehalf(address borrower) external payable;

    function borrowBalanceCurrent(address account) external returns (uint);

    function borrowBalanceStored(address account) external view returns (uint256);

    function balanceOfUnderlying(address account) external returns (uint);

    function balanceOf(address owner) external view returns (uint256);

    function getAccountSnapshot(address account) external view returns (uint, uint, uint, uint);

}



// File: contracts/strategies/compound/CompoundInteractor.sol



pragma solidity 0.5.16;























contract CompoundInteractor is ReentrancyGuard {



  using SafeMath for uint256;

  using SafeERC20 for IERC20;



  IERC20 public underlying;

  IERC20 public _weth = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

  CompleteCToken public ctoken;

  ComptrollerInterface public comptroller;



  constructor(

    address _underlying,

    address _ctoken,

    address _comptroller

  ) public {

    // Comptroller:

    comptroller = ComptrollerInterface(_comptroller);



    underlying = IERC20(_underlying);

    ctoken = CompleteCToken(_ctoken);



    // Enter the market

    address[] memory cTokens = new address[](1);

    cTokens[0] = _ctoken;

    comptroller.enterMarkets(cTokens);

  }



  /**

  * Supplies Ether to Compound

  * Unwraps WETH to Ether, then invoke the special mint for cEther

  * We ask to supply "amount", if the "amount" we asked to supply is

  * more than balance (what we really have), then only supply balance.

  * If we the "amount" we want to supply is less than balance, then

  * only supply that amount.

  */

  function _supplyEtherInWETH(uint256 amountInWETH) internal nonReentrant {

    // underlying here is WETH

    uint256 balance = underlying.balanceOf(address(this)); // supply at most "balance"

    if (amountInWETH < balance) {

      balance = amountInWETH; // only supply the "amount" if its less than what we have

    }

    WETH9 weth = WETH9(address(_weth));

    weth.withdraw(balance); // Unwrapping

    ICEther(address(ctoken)).mint.value(balance)();

  }



  /**

  * Redeems Ether from Compound

  * receives Ether. Wrap all the ether that is in this contract.

  */

  function _redeemEtherInCTokens(uint256 amountCTokens) internal nonReentrant {

    _redeemInCTokens(amountCTokens);

    WETH9 weth = WETH9(address(_weth));

    weth.deposit.value(address(this).balance)();

  }



  /**

  * Supplies to Compound

  */

  function _supply(uint256 amount) internal returns(uint256) {

    uint256 balance = underlying.balanceOf(address(this));

    if (amount < balance) {

      balance = amount;

    }

    underlying.safeApprove(address(ctoken), 0);

    underlying.safeApprove(address(ctoken), balance);

    uint256 mintResult = ctoken.mint(balance);

    require(mintResult == 0, "Supplying failed");

    return balance;

  }



  /**

  * Borrows against the collateral

  */

  function _borrow(

    uint256 amountUnderlying

  ) internal {

    // Borrow DAI, check the DAI balance for this contract's address

    uint256 result = ctoken.borrow(amountUnderlying);

    require(result == 0, "Borrow failed");

  }



  /**

  * Repays a loan

  */

  function _repay(uint256 amountUnderlying) internal {

    underlying.safeApprove(address(ctoken), 0);

    underlying.safeApprove(address(ctoken), amountUnderlying);

    ctoken.repayBorrow(amountUnderlying);

    underlying.safeApprove(address(ctoken), 0);

  }



  /**

  * Redeem liquidity in cTokens

  */

  function _redeemInCTokens(uint256 amountCTokens) internal {

    if(amountCTokens > 0){

      ctoken.redeem(amountCTokens);

    }

  }



  /**

  * Redeem liquidity in underlying

  */

  function _redeemUnderlying(uint256 amountUnderlying) internal {

    if (amountUnderlying > 0) {

      ctoken.redeemUnderlying(amountUnderlying);

    }

  }



  /**

  * Redeem liquidity in underlying

  */

  function redeemUnderlyingInWeth(uint256 amountUnderlying) internal {

    _redeemUnderlying(amountUnderlying);

    WETH9 weth = WETH9(address(_weth));

    weth.deposit.value(address(this).balance)();

  }



  /**

  * Get COMP

  */

  function claimComp() public {

    comptroller.claimComp(address(this));

  }



  /**

  * Redeem the minimum of the WETH we own, and the WETH that the cToken can

  * immediately retrieve. Ensures that `redeemMaximum` doesn't fail silently

  */

  function redeemMaximumWeth() internal {

      // amount of WETH in contract

      uint256 available = ctoken.getCash();

      // amount of WETH we own

      uint256 owned = ctoken.balanceOfUnderlying(address(this));



      // redeem the most we can redeem

      redeemUnderlyingInWeth(available < owned ? available : owned);

  }



  function getLiquidity() external view returns(uint256) {

    return ctoken.getCash();

  }



  function redeemMaximumToken() internal {

    // amount of tokens in ctoken

    uint256 available = ctoken.getCash();

    // amount of tokens we own

    uint256 owned = ctoken.balanceOfUnderlying(address(this));



    // redeem the most we can redeem

    _redeemUnderlying(available < owned ? available : owned);

  }



  function () external payable {} // this is needed for the WETH unwrapping

}



// File: contracts/Storage.sol



pragma solidity 0.5.16;



contract Storage {



  address public governance;

  address public controller;



  constructor() public {

    governance = msg.sender;

  }



  modifier onlyGovernance() {

    require(isGovernance(msg.sender), "Not governance");

    _;

  }



  function setGovernance(address _governance) public onlyGovernance {

    require(_governance != address(0), "new governance shouldn't be empty");

    governance = _governance;

  }



  function setController(address _controller) public onlyGovernance {

    require(_controller != address(0), "new controller shouldn't be empty");

    controller = _controller;

  }



  function isGovernance(address account) public view returns (bool) {

    return account == governance;

  }



  function isController(address account) public view returns (bool) {

    return account == controller;

  }

}



// File: contracts/Governable.sol



pragma solidity 0.5.16;





contract Governable {



  Storage public store;



  constructor(address _store) public {

    require(_store != address(0), "new storage shouldn't be empty");

    store = Storage(_store);

  }



  modifier onlyGovernance() {

    require(store.isGovernance(msg.sender), "Not governance");

    _;

  }



  function setStorage(address _store) public onlyGovernance {

    require(_store != address(0), "new storage shouldn't be empty");

    store = Storage(_store);

  }



  function governance() public view returns (address) {

    return store.governance();

  }

}



// File: contracts/Controllable.sol



pragma solidity 0.5.16;





contract Controllable is Governable {



  constructor(address _storage) Governable(_storage) public {

  }



  modifier onlyController() {

    require(store.isController(msg.sender), "Not a controller");

    _;

  }



  modifier onlyControllerOrGovernance(){

    require((store.isController(msg.sender) || store.isGovernance(msg.sender)),

      "The caller must be controller or governance");

    _;

  }



  function controller() public view returns (address) {

    return store.controller();

  }

}



// File: contracts/uniswap/interfaces/IUniswapV2Router01.sol



pragma solidity >=0.5.0;



interface IUniswapV2Router01 {

    function factory() external pure returns (address);

    function WETH() external pure returns (address);



    function addLiquidity(

        address tokenA,

        address tokenB,

        uint amountADesired,

        uint amountBDesired,

        uint amountAMin,

        uint amountBMin,

        address to,

        uint deadline

    ) external returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityETH(

        address token,

        uint amountTokenDesired,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline

    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function removeLiquidity(

        address tokenA,

        address tokenB,

        uint liquidity,

        uint amountAMin,

        uint amountBMin,

        address to,

        uint deadline

    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETH(

        address token,

        uint liquidity,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline

    ) external returns (uint amountToken, uint amountETH);

    function removeLiquidityWithPermit(

        address tokenA,

        address tokenB,

        uint liquidity,

        uint amountAMin,

        uint amountBMin,

        address to,

        uint deadline,

        bool approveMax, uint8 v, bytes32 r, bytes32 s

    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETHWithPermit(

        address token,

        uint liquidity,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline,

        bool approveMax, uint8 v, bytes32 r, bytes32 s

    ) external returns (uint amountToken, uint amountETH);

    function swapExactTokensForTokens(

        uint amountIn,

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(

        uint amountOut,

        uint amountInMax,

        address[] calldata path,

        address to,

        uint deadline

    ) external returns (uint[] memory amounts);

    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)

        external

        payable

        returns (uint[] memory amounts);

    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)

        external

        returns (uint[] memory amounts);

    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)

        external

        returns (uint[] memory amounts);

    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)

        external

        payable

        returns (uint[] memory amounts);



    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);

    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);

    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);

    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);

    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);

}



// File: contracts/uniswap/interfaces/IUniswapV2Router02.sol



pragma solidity >=0.5.0;





interface IUniswapV2Router02 {

    function factory() external pure returns (address);

    function WETH() external pure returns (address);



    function addLiquidity(

        address tokenA,

        address tokenB,

        uint amountADesired,

        uint amountBDesired,

        uint amountAMin,

        uint amountBMin,

        address to,

        uint deadline

    ) external returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityETH(

        address token,

        uint amountTokenDesired,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline

    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function removeLiquidity(

        address tokenA,

        address tokenB,

        uint liquidity,

        uint amountAMin,

        uint amountBMin,

        address to,

        uint deadline

    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETH(

        address token,

        uint liquidity,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline

    ) external returns (uint amountToken, uint amountETH);

    function removeLiquidityWithPermit(

        address tokenA,

        address tokenB,

        uint liquidity,

        uint amountAMin,

        uint amountBMin,

        address to,

        uint deadline,

        bool approveMax, uint8 v, bytes32 r, bytes32 s

    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETHWithPermit(

        address token,

        uint liquidity,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline,

        bool approveMax, uint8 v, bytes32 r, bytes32 s

    ) external returns (uint amountToken, uint amountETH);

    function swapExactTokensForTokens(

        uint amountIn,

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(

        uint amountOut,

        uint amountInMax,

        address[] calldata path,

        address to,

        uint deadline

    ) external returns (uint[] memory amounts);

    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)

        external

        payable

        returns (uint[] memory amounts);

    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)

        external

        returns (uint[] memory amounts);

    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)

        external

        returns (uint[] memory amounts);

    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)

        external

        payable

        returns (uint[] memory amounts);



    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);

    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);

    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);

    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);

    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);



    function removeLiquidityETHSupportingFeeOnTransferTokens(

        address token,

        uint liquidity,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline

    ) external returns (uint amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(

        address token,

        uint liquidity,

        uint amountTokenMin,

        uint amountETHMin,

        address to,

        uint deadline,

        bool approveMax, uint8 v, bytes32 r, bytes32 s

    ) external returns (uint amountETH);



    function swapExactTokensForTokensSupportingFeeOnTransferTokens(

        uint amountIn,

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(

        uint amountIn,

        uint amountOutMin,

        address[] calldata path,

        address to,

        uint deadline

    ) external;

}



// File: contracts/strategies/LiquidityRecipient.sol



pragma solidity 0.5.16;















contract LiquidityRecipient is Controllable {



  using SafeMath for uint256;

  using SafeERC20 for IERC20;



  event LiquidityProvided(uint256 farmIn, uint256 wethIn, uint256 lpOut);

  event LiquidityRemoved(uint256 lpIn, uint256 wethOut, uint256 farmOut);



  modifier onlyStrategy() {

    require(msg.sender == wethStrategy, "only the weth strategy");

    _;

  }



  modifier onlyStrategyOrGovernance() {

    require(msg.sender == wethStrategy || msg.sender == governance(),

      "only not the weth strategy or governance");

    _;

  }



  // Address for WETH

  address public weth;



  // Address for FARM

  address public farm;



  // The WETH strategy this contract is hooked up to. The strategy cannot be changed.

  address public wethStrategy;



  // The treasury to provide FARM, and to receive FARM or overdraft weth

  address public treasury;



  // The address of the uniswap router

  address public uniswap;



  // The UNI V2 LP token matching the pool

  address public uniLp;



  // These tokens cannot be claimed by the controller

  mapping(address => bool) public unsalvagableTokens;



  constructor(

    address _storage,

    address _weth,

    address _farm,

    address _treasury,

    address _uniswap,

    address _uniLp,

    address _wethStrategy

  )

  Controllable(_storage)

  public {

    weth = _weth;

    farm = _farm;

    require(_treasury != address(0), "treasury cannot be address(0)");

    treasury = _treasury;

    uniswap = _uniswap;

    require(_uniLp != address(0), "uniLp cannot be address(0)");

    uniLp = _uniLp;

    unsalvagableTokens[_weth] = true;

    unsalvagableTokens[_uniLp] = true;

    wethStrategy = _wethStrategy;

  }



  /**

  * Adds liquidity to Uniswap.

  */

  function addLiquidity() internal {

    uint256 farmBalance = IERC20(farm).balanceOf(address(this));

    uint256 wethBalance = IERC20(weth).balanceOf(address(this));



    IERC20(farm).safeApprove(uniswap, 0);

    IERC20(farm).safeApprove(uniswap, farmBalance);

    IERC20(weth).safeApprove(uniswap, 0);

    IERC20(weth).safeApprove(uniswap, wethBalance);



    (uint256 amountFarm,

    uint256 amountWeth,

    uint256 liquidity) = IUniswapV2Router02(uniswap).addLiquidity(farm,

        weth,

        farmBalance,

        wethBalance,

        0,

        0,

        address(this),

        block.timestamp);



    emit LiquidityProvided(amountFarm, amountWeth, liquidity);

  }



  /**

  * Removes liquidity from Uniswap.

  */

  function removeLiquidity() internal {

    uint256 lpBalance = IERC20(uniLp).balanceOf(address(this));

    if (lpBalance > 0) {

      IERC20(uniLp).safeApprove(uniswap, 0);

      IERC20(uniLp).safeApprove(uniswap, lpBalance);

      (uint256 amountFarm, uint256 amountWeth) = IUniswapV2Router02(uniswap).removeLiquidity(farm,

        weth,

        lpBalance,

        0,

        0,

        address(this),

        block.timestamp

      );

      emit LiquidityRemoved(lpBalance, amountWeth, amountFarm);

    } else {

      emit LiquidityRemoved(0, 0, 0);

    }

  }



  /**

  * Adds liquidity to Uniswap. There is no vault for this cannot be invoked via controller. It has

  * to be restricted for market manipulation reasons, so only governance can call this method.

  */

  function doHardWork() public onlyGovernance {

    addLiquidity();

  }



  /**

  * Borrows the set amount of WETH from the strategy, and will invest all available liquidity

  * to Uniswap. This assumes that an approval from the strategy exists.

  */

  function takeLoan(uint256 amount) public onlyStrategy {

    IERC20(weth).safeTransferFrom(wethStrategy, address(this), amount);

    addLiquidity();

  }



  /**

  * Prepares for settling the loan to the strategy by withdrawing all liquidity from Uniswap,

  * and providing approvals to the strategy (for WETH) and to treasury (for FARM). The strategy

  * will make the WETH withdrawal by the pull pattern, and so will the treasury.

  */

  function settleLoan() public onlyStrategyOrGovernance {

    removeLiquidity();

    IERC20(weth).safeApprove(wethStrategy, 0);

    IERC20(weth).safeApprove(wethStrategy, uint256(-1));

    IERC20(farm).safeApprove(treasury, 0);

    IERC20(farm).safeApprove(treasury, uint256(-1));

  }



  /**

  * If Uniswap returns less FARM and more WETH, the WETH excess will be present in this strategy.

  * The governance can send this WETH to the treasury by invoking this function through the

  * strategy. The strategy ensures that this function is not called unless the entire WETH loan

  * was settled.

  */

  function wethOverdraft() external onlyStrategy {

    IERC20(weth).safeTransfer(treasury, IERC20(weth).balanceOf(address(this)));

  }



  /**

  * Salvages a token.

  */

  function salvage(address recipient, address token, uint256 amount) external onlyGovernance {

    // To make sure that governance cannot come in and take away the coins

    require(!unsalvagableTokens[token], "token is defined as not salvagable");

    IERC20(token).safeTransfer(recipient, amount);

  }

}



// File: contracts/hardworkInterface/IController.sol



pragma solidity 0.5.16;



interface IController {

    // [Grey list]

    // An EOA can safely interact with the system no matter what.

    // If you're using Metamask, you're using an EOA.

    // Only smart contracts may be affected by this grey list.

    //

    // This contract will not be able to ban any EOA from the system

    // even if an EOA is being added to the greyList, he/she will still be able

    // to interact with the whole system as if nothing happened.

    // Only smart contracts will be affected by being added to the greyList.

    // This grey list is only used in Vault.sol, see the code there for reference

    function greyList(address _target) external view returns(bool);



    function addVaultAndStrategy(address _vault, address _strategy) external;

    function doHardWork(address _vault) external;

    function hasVault(address _vault) external returns(bool);



    function salvage(address _token, uint256 amount) external;

    function salvageStrategy(address _strategy, address _token, uint256 amount) external;



    function notifyFee(address _underlying, uint256 fee) external;

    function profitSharingNumerator() external view returns (uint256);

    function profitSharingDenominator() external view returns (uint256);

}



// File: contracts/strategies/RewardTokenProfitNotifier.sol



pragma solidity 0.5.16;













contract RewardTokenProfitNotifier is Controllable {

  using SafeMath for uint256;

  using SafeERC20 for IERC20;



  uint256 public profitSharingNumerator;

  uint256 public profitSharingDenominator;

  address public rewardToken;



  constructor(

    address _storage,

    address _rewardToken

  ) public Controllable(_storage){

    rewardToken = _rewardToken;

    // persist in the state for immutability of the fee

    profitSharingNumerator = 30; //IController(controller()).profitSharingNumerator();

    profitSharingDenominator = 100; //IController(controller()).profitSharingDenominator();

    require(profitSharingNumerator < profitSharingDenominator, "invalid profit share");

  }



  event ProfitLogInReward(uint256 profitAmount, uint256 feeAmount, uint256 timestamp);



  function notifyProfitInRewardToken(uint256 _rewardBalance) internal {

    if( _rewardBalance > 0 ){

      uint256 feeAmount = _rewardBalance.mul(profitSharingNumerator).div(profitSharingDenominator);

      emit ProfitLogInReward(_rewardBalance, feeAmount, block.timestamp);

      IERC20(rewardToken).safeApprove(controller(), 0);

      IERC20(rewardToken).safeApprove(controller(), feeAmount);

      

      IController(controller()).notifyFee(

        rewardToken,

        feeAmount

      );

    } else {

      emit ProfitLogInReward(0, 0, block.timestamp);

    }

  }



}



// File: contracts/hardworkInterface/IVault.sol



pragma solidity 0.5.16;



interface IVault {



    function underlyingBalanceInVault() external view returns (uint256);

    function underlyingBalanceWithInvestment() external view returns (uint256);



    // function store() external view returns (address);

    function governance() external view returns (address);

    function controller() external view returns (address);

    function underlying() external view returns (address);

    function strategy() external view returns (address);



    function setStrategy(address _strategy) external;

    function setVaultFractionToInvest(uint256 numerator, uint256 denominator) external;



    function deposit(uint256 amountWei) external;

    function depositFor(uint256 amountWei, address holder) external;



    function withdrawAll() external;

    function withdraw(uint256 numberOfShares) external;

    function getPricePerFullShare() external view returns (uint256);



    function underlyingBalanceWithInvestmentForHolder(address holder) view external returns (uint256);



    // hard work should be callable only by the controller (by the hard worker) or by governance

    function doHardWork() external;

    function rebalance() external;

}



// File: contracts/strategies/compound/CompoundNoFoldStrategy.sol



pragma solidity 0.5.16;































contract CompoundNoFoldStrategy is IStrategy, RewardTokenProfitNotifier, CompoundInteractor {



  using SafeMath for uint256;

  using SafeERC20 for IERC20;



  event ProfitNotClaimed();

  event TooLowBalance();



  ERC20Detailed public underlying;

  CompleteCToken public ctoken;

  ComptrollerInterface public comptroller;



  address public vault;

  ERC20Detailed public comp; // this will be Cream or Comp



  address public uniswapRouterV2;

  uint256 public suppliedInUnderlying;

  bool public liquidationAllowed = false;

  uint256 public sellFloor = 0;

  bool public allowEmergencyLiquidityShortage = false;



  // These tokens cannot be claimed by the controller

  mapping(address => bool) public unsalvagableTokens;



  modifier restricted() {

    require(msg.sender == vault || msg.sender == address(controller()) || msg.sender == address(governance()),

      "The sender has to be the controller or vault");

    _;

  }



  constructor(

    address _storage,

    address _underlying,

    address _ctoken,

    address _vault,

    address _comptroller,

    address _comp,

    address _uniswap

  )

  RewardTokenProfitNotifier(_storage, _comp)

  CompoundInteractor(_underlying, _ctoken, _comptroller) public {

    require(IVault(_vault).underlying() == _underlying, "vault does not support underlying");

    comptroller = ComptrollerInterface(_comptroller);

    comp = ERC20Detailed(_comp);

    underlying = ERC20Detailed(_underlying);

    ctoken = CompleteCToken(_ctoken);

    vault = _vault;

    uniswapRouterV2 = _uniswap;



    // set these tokens to be not salvagable

    unsalvagableTokens[_underlying] = true;

    unsalvagableTokens[_ctoken] = true;

    unsalvagableTokens[_comp] = true;

  }



  modifier updateSupplyInTheEnd() {

    _;

    suppliedInUnderlying = ctoken.balanceOfUnderlying(address(this));

  }



  function depositArbCheck() public view returns (bool) {

    // there's no arb here.

    return true;

  }



  /**

  * The strategy invests by supplying the underlying as a collateral.

  */

  function investAllUnderlying() public restricted updateSupplyInTheEnd {

    uint256 balance = underlying.balanceOf(address(this));

    _supply(balance);

  }



  /**

  * Exits Compound and transfers everything to the vault.

  */

  function withdrawAllToVault() external restricted updateSupplyInTheEnd {

    if (allowEmergencyLiquidityShortage) {

      withdrawMaximum();

    } else {

      withdrawAllWeInvested();

    }

    IERC20(address(underlying)).safeTransfer(vault, underlying.balanceOf(address(this)));

  }



  function emergencyExit() external onlyGovernance updateSupplyInTheEnd {

    withdrawMaximum();

  }



  function withdrawMaximum() internal updateSupplyInTheEnd {

    if (liquidationAllowed) {

      claimComp();

      liquidateComp();

    } else {

      emit ProfitNotClaimed();

    }

    redeemMaximum();

  }



  function withdrawAllWeInvested() internal updateSupplyInTheEnd {

    if (liquidationAllowed) {

      claimComp();

      liquidateComp();

    } else {

      emit ProfitNotClaimed();

    }

    uint256 currentBalance = ctoken.balanceOfUnderlying(address(this));

    mustRedeemPartial(currentBalance);

  }



  function withdrawToVault(uint256 amountUnderlying) external restricted updateSupplyInTheEnd {

    if (amountUnderlying <= underlying.balanceOf(address(this))) {

      IERC20(address(underlying)).safeTransfer(vault, amountUnderlying);

      return;

    }



    // get some of the underlying

    mustRedeemPartial(amountUnderlying);



    // transfer the amount requested (or the amount we have) back to vault

    IERC20(address(underlying)).safeTransfer(vault, amountUnderlying);



    // invest back to cream

    investAllUnderlying();

  }



  /**

  * Withdraws all assets, liquidates COMP/CREAM, and invests again in the required ratio.

  */

  function doHardWork() public restricted {

    if (liquidationAllowed) {

      claimComp();

      liquidateComp();

    } else {

      emit ProfitNotClaimed();

    }

    investAllUnderlying();

  }



  /**

  * Redeems maximum that can be redeemed from Compound.

  * Redeem the minimum of the underlying we own, and the underlying that the cToken can

  * immediately retrieve. Ensures that `redeemMaximum` doesn't fail silently.

  *

  * DOES NOT ensure that the strategy cUnderlying balance becomes 0.

  */

  function redeemMaximum() internal {

    redeemMaximumToken();

  }



  /**

  * Redeems `amountUnderlying` or fails.

  */

  function mustRedeemPartial(uint256 amountUnderlying) internal {

    require(

      ctoken.getCash() >= amountUnderlying,

      "market cash cannot cover liquidity"

    );

    _redeemUnderlying(amountUnderlying);

  }



  /**

  * Salvages a token.

  */

  function salvage(address recipient, address token, uint256 amount) public onlyGovernance {

    // To make sure that governance cannot come in and take away the coins

    require(!unsalvagableTokens[token], "token is defined as not salvagable");

    IERC20(token).safeTransfer(recipient, amount);

  }



  function liquidateComp() internal {

    uint256 balance = comp.balanceOf(address(this));

    if (balance < sellFloor) {

      emit TooLowBalance();

      return;

    }



    // give a profit share to fee forwarder, which re-distributes this to

    // the profit sharing pools

    notifyProfitInRewardToken(balance);



    balance = comp.balanceOf(address(this));

    // we can accept 1 as minimum as this will be called by trusted roles only

    uint256 amountOutMin = 1;

    IERC20(address(comp)).safeApprove(address(uniswapRouterV2), 0);

    IERC20(address(comp)).safeApprove(address(uniswapRouterV2), balance);

    address[] memory path = new address[](3);

    path[0] = address(comp);

    path[1] = IUniswapV2Router02(uniswapRouterV2).WETH();

    path[2] = address(underlying);

    IUniswapV2Router02(uniswapRouterV2).swapExactTokensForTokens(

      balance,

      amountOutMin,

      path,

      address(this),

      block.timestamp

    );

  }



  /**

  * Returns the current balance. Ignores COMP/CREAM that was not liquidated and invested.

  */

  function investedUnderlyingBalance() public view returns (uint256) {

    // underlying in this strategy + underlying redeemable from Compound/Cream

    return underlying.balanceOf(address(this)).add(suppliedInUnderlying);

  }



  /**

  * Allows liquidation

  */

  function setLiquidationAllowed(

    bool allowed

  ) external restricted {

    liquidationAllowed = allowed;

  }



  function setAllowLiquidityShortage(

    bool allowed

  ) external restricted {

    allowEmergencyLiquidityShortage = allowed;

  }



  function setSellFloor(uint256 value) external restricted {

    sellFloor = value;

  }

}



// File: contracts/strategies/compound/CompoundNoFoldStrategyDAIMainnet.sol



pragma solidity 0.5.16;





contract CompoundNoFoldStrategyDAIMainnet is CompoundNoFoldStrategy {



  // token addresses

  address constant public __underlying = address(0x6B175474E89094C44Da98b954EedeAC495271d0F);

  address constant public __ctoken = address(0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643);

  address constant public __comptroller = address(0x3d9819210A31b4961b30EF54bE2aeD79B9c9Cd3B);

  address constant public __comp = address(0xc00e94Cb662C3520282E6f5717214004A7f26888);

  address constant public __uniswap = address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);



  constructor(

    address _storage,

    address _vault

  )

  CompoundNoFoldStrategy(

    _storage,

    __underlying,

    __ctoken,

    _vault,

    __comptroller,

    __comp,

    __uniswap

  )

  public {

  }



}
