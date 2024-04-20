pragma solidity ^0.6.12;

pragma experimental ABIEncoderV2;



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

     */

    function sendValue(address payable recipient, uint256 amount) internal {

        require(address(this).balance >= amount, "Address: insufficient balance");



        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value

        (bool success, ) = recipient.call{ value: amount }("");

        require(success, "Address: unable to send value, recipient may have reverted");

    }



    /**

     * @dev Performs a Solidity function call using a low level `call`. A

     * plain`call` is an unsafe replacement for a function call: use this

     * function instead.

     *

     * If `target` reverts with a revert reason, it is bubbled up by this

     * function (like regular Solidity function calls).

     *

     * Returns the raw returned data. To convert to the expected return value,

     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].

     *

     * Requirements:

     *

     * - `target` must be a contract.

     * - calling `target` with `data` must not revert.

     *

     * _Available since v3.1._

     */

    function functionCall(address target, bytes memory data) internal returns (bytes memory) {

      return functionCall(target, data, "Address: low-level call failed");

    }



    /**

     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with

     * `errorMessage` as a fallback revert reason when `target` reverts.

     *

     * _Available since v3.1._

     */

    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {

        return _functionCallWithValue(target, data, 0, errorMessage);

    }



    /**

     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],

     * but also transferring `value` wei to `target`.

     *

     * Requirements:

     *

     * - the calling contract must have an ETH balance of at least `value`.

     * - the called Solidity function must be `payable`.

     *

     * _Available since v3.1._

     */

    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {

        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");

    }



    /**

     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but

     * with `errorMessage` as a fallback revert reason when `target` reverts.

     *

     * _Available since v3.1._

     */

    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {

        require(address(this).balance >= value, "Address: insufficient balance for call");

        return _functionCallWithValue(target, data, value, errorMessage);

    }



    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {

        require(isContract(target), "Address: call to non-contract");



        // solhint-disable-next-line avoid-low-level-calls

        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);

        if (success) {

            return returndata;

        } else {

            // Look for revert reason and bubble it up if present

            if (returndata.length > 0) {

                // The easiest way to bubble the revert reason is using memory via assembly



                // solhint-disable-next-line no-inline-assembly

                assembly {

                    let returndata_size := mload(returndata)

                    revert(add(32, returndata), returndata_size)

                }

            } else {

                revert(errorMessage);

            }

        }

    }

}



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

}



/**

 * @title SafeERC20

 * @dev Wrappers around ERC20 operations that throw on failure (when the token

 * contract returns false). Tokens that return no value (and instead revert or

 * throw on failure) are also supported, non-reverting calls are assumed to be

 * successful.

 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,

 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.

 */

library SafeERC20 {

    using SafeMath for uint256;

    using Address for address;



    function safeTransfer(IERC20 token, address to, uint256 value) internal {

        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));

    }



    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {

        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));

    }



    /**

     * @dev Deprecated. This function has issues similar to the ones found in

     * {IERC20-approve}, and its usage is discouraged.

     *

     * Whenever possible, use {safeIncreaseAllowance} and

     * {safeDecreaseAllowance} instead.

     */

    function safeApprove(IERC20 token, address spender, uint256 value) internal {

        // safeApprove should only be called when setting an initial allowance,

        // or when resetting it to zero. To increase and decrease it, use

        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'

        // solhint-disable-next-line max-line-length

        require((value == 0) || (token.allowance(address(this), spender) == 0),

            "SafeERC20: approve from non-zero to non-zero allowance"

        );

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));

    }



    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {

        uint256 newAllowance = token.allowance(address(this), spender).add(value);

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));

    }



    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {

        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));

    }



    /**

     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement

     * on the return value: the return value is optional (but if data is returned, it must not be false).

     * @param token The token targeted by the call.

     * @param data The call data (encoded using abi.encode or one of its variants).

     */

    function _callOptionalReturn(IERC20 token, bytes memory data) private {

        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since

        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that

        // the target address contains contract code and also asserts for success in the low-level call.



        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");

        if (returndata.length > 0) { // Return data is optional

            // solhint-disable-next-line max-line-length

            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");

        }

    }

}





interface Uni {

    function swapExactTokensForTokens(

        uint256 amountIn,

        uint256 amountOutMin,

        address[] calldata path,

        address to,

        uint256 deadline

    ) external returns (uint256[] memory amounts);

}



interface GemLike {

    function approve(address, uint256) external;



    function transfer(address, uint256) external;



    function transferFrom(

        address,

        address,

        uint256

    ) external;



    function deposit() external payable;



    function withdraw(uint256) external;

}



interface ManagerLike {

    function cdpCan(

        address,

        uint256,

        address

    ) external view returns (uint256);



    function ilks(uint256) external view returns (bytes32);



    function owns(uint256) external view returns (address);



    function urns(uint256) external view returns (address);



    function vat() external view returns (address);



    function open(bytes32, address) external returns (uint256);



    function give(uint256, address) external;



    function cdpAllow(

        uint256,

        address,

        uint256

    ) external;



    function urnAllow(address, uint256) external;



    function frob(

        uint256,

        int256,

        int256

    ) external;



    function flux(

        uint256,

        address,

        uint256

    ) external;



    function move(

        uint256,

        address,

        uint256

    ) external;



    function exit(

        address,

        uint256,

        address,

        uint256

    ) external;



    function quit(uint256, address) external;



    function enter(address, uint256) external;



    function shift(uint256, uint256) external;

}



interface VatLike {

    function can(address, address) external view returns (uint256);



    function ilks(bytes32)

        external

        view

        returns (

            uint256,

            uint256,

            uint256,

            uint256,

            uint256

        );



    function dai(address) external view returns (uint256);



    function urns(bytes32, address) external view returns (uint256, uint256);



    function frob(

        bytes32,

        address,

        address,

        address,

        int256,

        int256

    ) external;



    function hope(address) external;



    function move(

        address,

        address,

        uint256

    ) external;

}



interface GemJoinLike {

    function dec() external returns (uint256);



    function gem() external returns (GemLike);



    function join(address, uint256) external payable;



    function exit(address, uint256) external;

}



interface GNTJoinLike {

    function bags(address) external view returns (address);



    function make(address) external returns (address);

}



interface DaiJoinLike {

    function vat() external returns (VatLike);



    function dai() external returns (GemLike);



    function join(address, uint256) external payable;



    function exit(address, uint256) external;

}



interface HopeLike {

    function hope(address) external;



    function nope(address) external;

}



interface EndLike {

    function fix(bytes32) external view returns (uint256);



    function cash(bytes32, uint256) external;



    function free(bytes32) external;



    function pack(uint256) external;



    function skim(bytes32, address) external;

}



interface JugLike {

    function drip(bytes32) external returns (uint256);

}



interface PotLike {

    function pie(address) external view returns (uint256);



    function drip() external returns (uint256);



    function join(uint256) external;



    function exit(uint256) external;

}



interface SpotLike {

    function ilks(bytes32) external view returns (address, uint256);

}



interface OSMedianizer {

    function read() external view returns (uint256, bool);



    function foresight() external view returns (uint256, bool);

}





struct StrategyParams {

    uint256 performanceFee;

    uint256 activation;

    uint256 debtLimit;

    uint256 rateLimit;

    uint256 lastReport;

    uint256 totalDebt;

    uint256 totalGain;

    uint256 totalLoss;

}



interface VaultAPI is IERC20 {

    function apiVersion() external view returns (string memory);



    function token() external view returns (address);



    function strategies(address _strategy) external view returns (StrategyParams memory);



    /**

     * View how much the Vault would increase this Strategy's borrow limit,

     * based on its present performance (since its last report). Can be used to

     * determine expectedReturn in your Strategy.

     */

    function creditAvailable() external view returns (uint256);



    /**

     * View how much the Vault would like to pull back from the Strategy,

     * based on its present performance (since its last report). Can be used to

     * determine expectedReturn in your Strategy.

     */

    function debtOutstanding() external view returns (uint256);



    /**

     * View how much the Vault expect this Strategy to return at the current

     * block, based on its present performance (since its last report). Can be

     * used to determine expectedReturn in your Strategy.

     */

    function expectedReturn() external view returns (uint256);



    /**

     * This is the main contact point where the Strategy interacts with the

     * Vault. It is critical that this call is handled as intended by the

     * Strategy. Therefore, this function will be called by BaseStrategy to

     * make sure the integration is correct.

     */

    function report(

        uint256 _gain,

        uint256 _loss,

        uint256 _debtPayment

    ) external returns (uint256);



    /**

     * This function is used in the scenario where there is a newer Strategy

     * that would hold the same positions as this one, and those positions are

     * easily transferrable to the newer Strategy. These positions must be able

     * to be transferred at the moment this call is made, if any prep is

     * required to execute a full transfer in one transaction, that must be

     * accounted for separately from this call.

     */

    function migrateStrategy(address _newStrategy) external;



    /**

     * This function should only be used in the scenario where the Strategy is

     * being retired but no migration of the positions are possible, or in the

     * extreme scenario that the Strategy needs to be put into "Emergency Exit"

     * mode in order for it to exit as quickly as possible. The latter scenario

     * could be for any reason that is considered "critical" that the Strategy

     * exits its position as fast as possible, such as a sudden change in

     * market conditions leading to losses, or an imminent failure in an

     * external dependency.

     */

    function revokeStrategy() external;



    /**

     * View the governance address of the Vault to assert privileged functions

     * can only be called by governance. The Strategy serves the Vault, so it

     * is subject to governance defined by the Vault.

     */

    function governance() external view returns (address);

}



/**

 * This interface is here for the keeper bot to use.

 */

interface StrategyAPI {

    function apiVersion() external pure returns (string memory);



    function name() external pure returns (string memory);



    function vault() external view returns (address);



    function keeper() external view returns (address);



    function tendTrigger(uint256 callCost) external view returns (bool);



    function tend() external;



    function harvestTrigger(uint256 callCost) external view returns (bool);



    function harvest() external;



    event Harvested(uint256 profit, uint256 loss, uint256 debtPayment, uint256 debtOutstanding);

}



/**

 * @title Yearn Base Strategy

 * @author yearn.finance

 * @notice

 *  BaseStrategy implements all of the required functionality to interoperate

 *  closely with the Vault contract. This contract should be inherited and the

 *  abstract methods implemented to adapt the Strategy to the particular needs

 *  it has to create a return.

 *

 *  Of special interest is the relationship between `harvest()` and

 *  `vault.report()'. `harvest()` may be called simply because enough time has

 *  elapsed since the last report, and not because any funds need to be moved

 *  or positions adjusted. This is critical so that the Vault may maintain an

 *  accurate picture of the Strategy's performance. See  `vault.report()`,

 *  `harvest()`, and `harvestTrigger()` for further details.

 */

abstract contract BaseStrategy {

    using SafeMath for uint256;



    /**

     * @notice

     *  Used to track which version of `StrategyAPI` this Strategy

     *  implements.

     * @dev The Strategy's version must match the Vault's `API_VERSION`.

     * @return A string which holds the current API version of this contract.

     */

    function apiVersion() public pure returns (string memory) {

        return "0.2.2";

    }



    /**

     * @notice This Strategy's name.

     * @dev

     *  You can use this field to manage the "version" of this Strategy, e.g.

     *  `StrategySomethingOrOtherV1`. However, "API Version" is managed by

     *  `apiVersion()` function above.

     * @return This Strategy's name.

     */

    function name() external virtual pure returns (string memory);



    VaultAPI public vault;

    address public strategist;

    address public rewards;

    address public keeper;



    IERC20 public want;



    // So indexers can keep track of this

    event Harvested(uint256 profit, uint256 loss, uint256 debtPayment, uint256 debtOutstanding);



    event UpdatedStrategist(address newStrategist);



    event UpdatedKeeper(address newKeeper);



    event UpdatedRewards(address rewards);



    event UpdatedReportDelay(uint256 delay);



    event UpdatedProfitFactor(uint256 profitFactor);



    event UpdatedDebtThreshold(uint256 debtThreshold);



    // The minimum number of seconds between harvest calls. See

    // `setMinReportDelay()` for more details.

    uint256 public minReportDelay = 86400; // ~ once a day



    // The minimum multiple that `callCost` must be above the credit/profit to

    // be "justifiable". See `setProfitFactor()` for more details.

    uint256 public profitFactor = 100;



    // Use this to adjust the threshold at which running a debt causes a

    // harvest trigger. See `setDebtThreshold()` for more details.

    uint256 public debtThreshold = 0;



    // See note on `setEmergencyExit()`.

    bool public emergencyExit;



    // modifiers

    modifier onlyAuthorized() {

        require(msg.sender == strategist || msg.sender == governance(), "!authorized");

        _;

    }



    modifier onlyStrategist() {

        require(msg.sender == strategist, "!strategist");

        _;

    }



    modifier onlyGovernance() {

        require(msg.sender == governance(), "!authorized");

        _;

    }



    modifier onlyKeepers() {

        require(msg.sender == keeper || msg.sender == strategist || msg.sender == governance(), "!authorized");

        _;

    }



    /**

     * @notice

     *  Initializes the Strategy, this is called only once, when the

     *  contract is deployed.

     * @dev `_vault` should implement `VaultAPI`.

     * @param _vault The address of the Vault responsible for this Strategy.

     */

    constructor(address _vault) public {

        vault = VaultAPI(_vault);

        want = IERC20(vault.token());

        want.approve(_vault, uint256(-1)); // Give Vault unlimited access (might save gas)

        strategist = msg.sender;

        rewards = msg.sender;

        keeper = msg.sender;

    }



    /**

     * @notice

     *  Used to change `strategist`.

     *

     *  This may only be called by governance or the existing strategist.

     * @param _strategist The new address to assign as `strategist`.

     */

    function setStrategist(address _strategist) external onlyAuthorized {

        strategist = _strategist;

        emit UpdatedStrategist(_strategist);

    }



    /**

     * @notice

     *  Used to change `keeper`.

     *

     *  `keeper` is the only address that may call `tend()` or `harvest()`,

     *  other than `governance()` or `strategist`. However, unlike

     *  `governance()` or `strategist`, `keeper` may *only* call `tend()`

     *  and `harvest()`, and no other authorized functions, following the

     *  principle of least privilege.

     *

     *  This may only be called by governance or the strategist.

     * @param _keeper The new address to assign as `keeper`.

     */

    function setKeeper(address _keeper) external onlyAuthorized {

        keeper = _keeper;

        emit UpdatedKeeper(_keeper);

    }



    /**

     * @notice

     *  Used to change `rewards`. Any distributed rewards will cease flowing

     *  to the old address and begin flowing to this address once the change

     *  is in effect.

     *

     *  This will not change any Strategy reports in progress, only

     *  new reports made after this change goes into effect.

     *

     *  This may only be called by the strategist.

     * @param _rewards The address to use for collecting rewards.

     */

    function setRewards(address _rewards) external onlyStrategist {

        rewards = _rewards;

        emit UpdatedRewards(_rewards);

    }



    /**

     * @notice

     *  Used to change `minReportDelay`. `minReportDelay` is the minimum number

     *  of blocks that should pass before `harvest()` is called.

     *

     *  For external keepers (such as the Keep3r network), this is the minimum

     *  time between jobs, to prevent excessive costs. (see `harvestTrigger()`

     *  for more details.)

     *

     *  This may only be called by governance or the strategist.

     * @param _delay The minimum number of blocks to wait between harvests.

     */

    function setMinReportDelay(uint256 _delay) external onlyAuthorized {

        minReportDelay = _delay;

        emit UpdatedReportDelay(_delay);

    }



    /**

     * @notice

     *  Used to change `profitFactor`. `profitFactor` is used to determine

     *  if it's worthwhile to harvest, given gas costs. (See `harvestTrigger()`

     *  for more details.)

     *

     *  This may only be called by governance or the strategist.

     * @param _profitFactor A ratio to multiply anticipated

     * `harvest()` gas cost against.

     */

    function setProfitFactor(uint256 _profitFactor) external onlyAuthorized {

        profitFactor = _profitFactor;

        emit UpdatedProfitFactor(_profitFactor);

    }



    /**

     * @notice

     *  Sets how far the Strategy can go into loss without a harvest and report

     *  being required.

     *

     *  By default this is 0, meaning any losses would cause a harvest which

     *  will subsequently report the loss to the Vault for tracking. (See

     *  `harvestTrigger()` for more details.)

     *

     *  This may only be called by governance or the strategist.

     * @param _debtThreshold How big of a loss this Strategy may carry without

     * being required to report to the Vault.

     */

    function setDebtThreshold(uint256 _debtThreshold) external onlyAuthorized {

        debtThreshold = _debtThreshold;

        emit UpdatedDebtThreshold(_debtThreshold);

    }



    /**

     * Resolve governance address from Vault contract, used to make assertions

     * on protected functions in the Strategy.

     */

    function governance() internal view returns (address) {

        return vault.governance();

    }



    /**

     * @notice

     *  Provide an accurate estimate for the total amount of assets

     *  (principle + return) that this Strategy is currently managing,

     *  denominated in terms of `want` tokens.

     *

     *  This total should be "realizable" e.g. the total value that could

     *  *actually* be obtained from this Strategy if it were to divest its

     *  entire position based on current on-chain conditions.

     * @dev

     *  Care must be taken in using this function, since it relies on external

     *  systems, which could be manipulated by the attacker to give an inflated

     *  (or reduced) value produced by this function, based on current on-chain

     *  conditions (e.g. this function is possible to influence through

     *  flashloan attacks, oracle manipulations, or other DeFi attack

     *  mechanisms).

     *

     *  It is up to governance to use this function to correctly order this

     *  Strategy relative to its peers in the withdrawal queue to minimize

     *  losses for the Vault based on sudden withdrawals. This value should be

     *  higher than the total debt of the Strategy and higher than its expected

     *  value to be "safe".

     * @return The estimated total assets in this Strategy.

     */

    function estimatedTotalAssets() public virtual view returns (uint256);



    /**

     * Perform any Strategy unwinding or other calls necessary to capture the

     * "free return" this Strategy has generated since the last time its core

     * position(s) were adjusted. Examples include unwrapping extra rewards.

     * This call is only used during "normal operation" of a Strategy, and

     * should be optimized to minimize losses as much as possible.

     *

     * This method returns any realized profits and/or realized losses

     * incurred, and should return the total amounts of profits/losses/debt

     * payments (in `want` tokens) for the Vault's accounting (e.g.

     * `want.balanceOf(this) >= _debtPayment + _profit - _loss`).

     *

     * `_debtOutstanding` will be 0 if the Strategy is not past the configured

     * debt limit, otherwise its value will be how far past the debt limit

     * the Strategy is. The Strategy's debt limit is configured in the Vault.

     *

     * NOTE: `_debtPayment` should be less than or equal to `_debtOutstanding`.

     *       It is okay for it to be less than `_debtOutstanding`, as that

     *       should only used as a guide for how much is left to pay back.

     *       Payments should be made to minimize loss from slippage, debt,

     *       withdrawal fees, etc.

     *

     * See `vault.debtOutstanding()`.

     */

    function prepareReturn(uint256 _debtOutstanding)

        internal

        virtual

        returns (

            uint256 _profit,

            uint256 _loss,

            uint256 _debtPayment

        );



    /**

     * Perform any adjustments to the core position(s) of this Strategy given

     * what change the Vault made in the "investable capital" available to the

     * Strategy. Note that all "free capital" in the Strategy after the report

     * was made is available for reinvestment. Also note that this number

     * could be 0, and you should handle that scenario accordingly.

     *

     * See comments regarding `_debtOutstanding` on `prepareReturn()`.

     */

    function adjustPosition(uint256 _debtOutstanding) internal virtual;



    /**

     * Make as much capital as possible "free" for the Vault to take. Some

     * slippage is allowed, since when this method is called the strategist is

     * no longer receiving their performance fee. The goal is for the Strategy

     * to divest as quickly as possible while not suffering exorbitant losses.

     * This function is used during emergency exit instead of

     * `prepareReturn()`. This method returns any realized losses incurred,

     * and should also return the amount of `want` tokens available to repay

     * outstanding debt to the Vault.

     */

    function exitPosition(uint256 _debtOutstanding)

        internal

        virtual

        returns (

            uint256 _profit,

            uint256 _loss,

            uint256 _debtPayment

        );



    /**

     *  `Harvest()` calls this function after shares are created during

     *  `vault.report()`. You can customize this function to any share

     *  distribution mechanism you want.

     *

     *   See `vault.report()` for further details.

     */

    function distributeRewards() internal virtual {

        // Transfer 100% of newly-minted shares awarded to this contract to the rewards address.

        uint256 balance = vault.balanceOf(address(this));

        if (balance > 0) {

            vault.transfer(rewards, balance);

        }

    }



    /**

     * @notice

     *  Provide a signal to the keeper that `tend()` should be called. The

     *  keeper will provide the estimated gas cost that they would pay to call

     *  `tend()`, and this function should use that estimate to make a

     *  determination if calling it is "worth it" for the keeper. This is not

     *  the only consideration into issuing this trigger, for example if the

     *  position would be negatively affected if `tend()` is not called

     *  shortly, then this can return `true` even if the keeper might be

     *  "at a loss" (keepers are always reimbursed by Yearn).

     * @dev

     *  `callCost` must be priced in terms of `want`.

     *

     *  This call and `harvestTrigger()` should never return `true` at the same

     *  time.

     * @param callCost The keeper's estimated cast cost to call `tend()`.

     * @return `true` if `tend()` should be called, `false` otherwise.

     */

    function tendTrigger(uint256 callCost) public virtual view returns (bool) {

        // We usually don't need tend, but if there are positions that need

        // active maintainence, overriding this function is how you would

        // signal for that.

        return false;

    }



    /**

     * @notice

     *  Adjust the Strategy's position. The purpose of tending isn't to

     *  realize gains, but to maximize yield by reinvesting any returns.

     *

     *  See comments on `adjustPosition()`.

     *

     *  This may only be called by governance, the strategist, or the keeper.

     */

    function tend() external onlyKeepers {

        // Don't take profits with this call, but adjust for better gains

        adjustPosition(vault.debtOutstanding());

    }



    /**

     * @notice

     *  Provide a signal to the keeper that `harvest()` should be called. The

     *  keeper will provide the estimated gas cost that they would pay to call

     *  `harvest()`, and this function should use that estimate to make a

     *  determination if calling it is "worth it" for the keeper. This is not

     *  the only consideration into issuing this trigger, for example if the

     *  position would be negatively affected if `harvest()` is not called

     *  shortly, then this can return `true` even if the keeper might be "at a

     *  loss" (keepers are always reimbursed by Yearn).

     * @dev

     *  `callCost` must be priced in terms of `want`.

     *

     *  This call and `tendTrigger` should never return `true` at the

     *  same time.

     *

     *  See `minReportDelay`, `profitFactor`, `debtThreshold` to adjust the

     *  strategist-controlled parameters that will influence whether this call

     *  returns `true` or not. These parameters will be used in conjunction

     *  with the parameters reported to the Vault (see `params`) to determine

     *  if calling `harvest()` is merited.

     *

     *  It is expected that an external system will check `harvestTrigger()`.

     *  This could be a script run off a desktop or cloud bot (e.g.

     *  https://github.com/iearn-finance/yearn-vaults/blob/master/scripts/keep.py),

     *  or via an integration with the Keep3r network (e.g.

     *  https://github.com/Macarse/GenericKeep3rV2/blob/master/contracts/keep3r/GenericKeep3rV2.sol).

     * @param callCost The keeper's estimated cast cost to call `harvest()`.

     * @return `true` if `harvest()` should be called, `false` otherwise.

     */

    function harvestTrigger(uint256 callCost) public virtual view returns (bool) {

        StrategyParams memory params = vault.strategies(address(this));



        // Should not trigger if Strategy is not activated

        if (params.activation == 0) return false;



        // Should trigger if hasn't been called in a while

        if (block.timestamp.sub(params.lastReport) >= minReportDelay) return true;



        // If some amount is owed, pay it back

        // NOTE: Since debt is adjusted in step-wise fashion, it is appropriate

        //       to always trigger here, because the resulting change should be

        //       large (might not always be the case).

        uint256 outstanding = vault.debtOutstanding();

        if (outstanding > 0) return true;



        // Check for profits and losses

        uint256 total = estimatedTotalAssets();

        // Trigger if we have a loss to report

        if (total.add(debtThreshold) < params.totalDebt) return true;



        uint256 profit = 0;

        if (total > params.totalDebt) profit = total.sub(params.totalDebt); // We've earned a profit!



        // Otherwise, only trigger if it "makes sense" economically (gas cost

        // is <N% of value moved)

        uint256 credit = vault.creditAvailable();

        return (profitFactor.mul(callCost) < credit.add(profit));

    }



    /**

     * @notice

     *  Harvests the Strategy, recognizing any profits or losses and adjusting

     *  the Strategy's position.

     *

     *  In the rare case the Strategy is in emergency shutdown, this will exit

     *  the Strategy's position.

     *

     *  This may only be called by governance, the strategist, or the keeper.

     * @dev

     *  When `harvest()` is called, the Strategy reports to the Vault (via

     *  `vault.report()`), so in some cases `harvest()` must be called in order

     *  to take in profits, to borrow newly available funds from the Vault, or

     *  otherwise adjust its position. In other cases `harvest()` must be

     *  called to report to the Vault on the Strategy's position, especially if

     *  any losses have occurred.

     */

    function harvest() external onlyKeepers {

        uint256 profit = 0;

        uint256 loss = 0;

        uint256 debtPayment = 0;

        if (emergencyExit) {

            // Free up as much capital as possible

            // NOTE: Don't take performance fee in this scenario

            (profit, loss, debtPayment) = exitPosition(vault.debtOutstanding());

        } else {

            // Free up returns for Vault to pull

            (profit, loss, debtPayment) = prepareReturn(vault.debtOutstanding());

        }



        // Allow Vault to take up to the "harvested" balance of this contract,

        // which is the amount it has earned since the last time it reported to

        // the Vault.

        uint256 debtOutstanding = vault.report(profit, loss, debtPayment);



        // Distribute any reward shares earned by the strategy on this report

        distributeRewards();



        // Check if free returns are left, and re-invest them

        adjustPosition(debtOutstanding);



        emit Harvested(profit, loss, debtPayment, debtOutstanding);

    }



    /**

     * Liquidate as many assets as possible to `want`, irregardless of

     * slippage, up to `_amountNeeded`. Any excess should be re-invested

     * here as well.

     */

    function liquidatePosition(uint256 _amountNeeded) internal virtual returns (uint256 _amountFreed);



    /**

     * @notice

     *  Withdraws `_amountNeeded` to `vault`.

     *

     *  This may only be called by the Vault.

     * @param _amountNeeded How much `want` to withdraw.

     */

    function withdraw(uint256 _amountNeeded) external {

        require(msg.sender == address(vault), "!vault");

        // Liquidate as much as possible to `want`, up to `_amount`

        uint256 amountFreed = liquidatePosition(_amountNeeded);

        // Send it directly back (NOTE: Using `msg.sender` saves some gas here)

        want.transfer(msg.sender, amountFreed);

    }



    /**

     * Do anything necessary to prepare this Strategy for migration, such as

     * transferring any reserve or LP tokens, CDPs, or other tokens or stores of

     * value.

     */

    function prepareMigration(address _newStrategy) internal virtual;



    /**

     * @notice

     *  Transfers all `want` from this Strategy to `_newStrategy`.

     *

     *  This may only be called by governance or the Vault.

     * @dev

     *  The new Strategy's Vault must be the same as this Strategy's Vault.

     * @param _newStrategy The Strategy to migrate to.

     */

    function migrate(address _newStrategy) external {

        require(msg.sender == address(vault) || msg.sender == governance());

        require(BaseStrategy(_newStrategy).vault() == vault);

        prepareMigration(_newStrategy);

        want.transfer(_newStrategy, want.balanceOf(address(this)));

    }



    /**

     * @notice

     *  Activates emergency exit. Once activated, the Strategy will exit its

     *  position upon the next harvest, depositing all funds into the Vault as

     *  quickly as is reasonable given on-chain conditions.

     *

     *  This may only be called by governance or the strategist.

     * @dev

     *  See `vault.setEmergencyShutdown()` and `harvest()` for further details.

     */

    function setEmergencyExit() external onlyAuthorized {

        emergencyExit = true;

        vault.revokeStrategy();

    }



    /**

     * Override this to add all tokens/tokenized positions this contract

     * manages on a *persistent* basis (e.g. not just for swapping back to

     * want ephemerally).

     *

     * NOTE: Do *not* include `want`, already included in `sweep` below.

     *

     * Example:

     *

     *    function protectedTokens() internal override view returns (address[] memory) {

     *      address[] memory protected = new address[](3);

     *      protected[0] = tokenA;

     *      protected[1] = tokenB;

     *      protected[2] = tokenC;

     *      return protected;

     *    }

     */

    function protectedTokens() internal virtual view returns (address[] memory);



    /**

     * @notice

     *  Removes tokens from this Strategy that are not the type of tokens

     *  managed by this Strategy. This may be used in case of accidentally

     *  sending the wrong kind of token to this Strategy.

     *

     *  Tokens will be sent to `governance()`.

     *

     *  This will fail if an attempt is made to sweep `want`, or any tokens

     *  that are protected by this Strategy.

     *

     *  This may only be called by governance.

     * @dev

     *  Implement `protectedTokens()` to specify any additional tokens that

     *  should be protected from sweeping in addition to `want`.

     * @param _token The token to transfer out of this vault.

     */

    function sweep(address _token) external onlyGovernance {

        require(_token != address(want), "!want");

        require(_token != address(vault), "!shares");



        address[] memory _protectedTokens = protectedTokens();

        for (uint256 i; i < _protectedTokens.length; i++) require(_token != _protectedTokens[i], "!protected");



        IERC20(_token).transfer(governance(), IERC20(_token).balanceOf(address(this)));

    }

}







interface yVault is VaultAPI {

    function pricePerShare() external view returns (uint);

    function deposit(uint) external returns (uint);

    function withdraw(uint) external returns (uint);

}



/* Need to override

 * [V] name()

 * [V] estimatedTotalAssets()

 * [V] prepareReturn(uint256 _debtOutstanding)

 * [V] adjustPosition(uint256 _debtOutstanding)

 * [V] exitPosition(uint256 _debtOutstanding)

 * [V] distributeRewards(uint256 _shares)

 * [V] tendTrigger(uint256 callCost)

 * [V] harvestTrigger(uint256 callCost)

 * [V] liquidatePosition(uint256 _amountNeeded)

 * [V] prepareMigration(address _newStrategy)

 * [V] protectedTokens()

 */



contract Strategy is BaseStrategy {

    using SafeERC20 for IERC20;

    using Address for address;

    using SafeMath for uint256;



    address constant public weth = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

    address constant public dai = address(0x6B175474E89094C44Da98b954EedeAC495271d0F);



    address public cdp_manager = address(0x5ef30b9986345249bc32d8928B7ee64DE9435E39);

    address public vat = address(0x35D1b3F3D7966A1DFe207aa4514C12a259A0492B);

    address public mcd_join_eth_a = address(0x2F0b23f53734252Bda2277357e97e1517d6B042A);

    address public mcd_join_dai = address(0x9759A6Ac90977b93B58547b4A71c78317f391A28);

    address public mcd_spot = address(0x65C79fcB50Ca1594B025960e539eD7A9a6D434A3);

    address public jug = address(0x19c0976f590D67707E62397C87829d896Dc0f1F1);



    address public eth_price_oracle = address(0xCF63089A8aD2a9D8BD6Bb8022f3190EB7e1eD0f1);

    address constant public yvdai = address(0xBFa4D8AA6d8a379aBFe7793399D3DdaCC5bBECBB);



    address constant public unirouter = address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);



    // DEFAULT VALUE

    // uint256 public minReportDelay = 86400;

    // uint256 public profitFactor = 100;

    // uint256 public debtThreshold = 0;



    uint public c = 20000;

    uint public c_safe = 40000;

    uint public buffer = 500;



    uint constant public DENOMINATOR = 10000;

    bytes32 constant public ilk = "ETH-A";



    uint public cdpId;



    constructor(address _vault) public BaseStrategy(_vault) {

        cdpId = ManagerLike(cdp_manager).open(ilk, address(this));

        _approveAll();

    }



    function name() external override pure returns (string memory) {

        return "StrategyMKRVaultDAIDelegate";

    }



    function setBorrowCollateralizationRatio(uint _c) external onlyAuthorized {

        c = _c;

    }



    function setWithdrawCollateralizationRatio(uint _c_safe) external onlyAuthorized {

        c_safe = _c_safe;

    }



    function setBuffer(uint _buffer) external onlyAuthorized {

        buffer = _buffer;

    }



    function setOracle(address _oracle) external onlyGovernance {

        eth_price_oracle = _oracle;

    }



    // optional

    function setMCDValue(

        address _manager,

        address _ethAdapter,

        address _daiAdapter,

        address _spot,

        address _jug

    ) external onlyGovernance {

        cdp_manager = _manager;

        vat = ManagerLike(_manager).vat();

        mcd_join_eth_a = _ethAdapter;

        mcd_join_dai = _daiAdapter;

        mcd_spot = _spot;

        jug = _jug;

    }



    function prepareMigration(address _newStrategy) internal override {

        allow(_newStrategy);

        IERC20(yvdai).safeTransfer(_newStrategy, IERC20(yvdai).balanceOf(address(this)));

    }



    function allow(address dst) public onlyAuthorized {

        ManagerLike(cdp_manager).cdpAllow(cdpId, dst, 1);

    }



    function gulp(uint srcCdp) public onlyAuthorized {

        ManagerLike(cdp_manager).shift(srcCdp, cdpId);

    }



    function _approveAll() internal {

        IERC20(want).approve(mcd_join_eth_a, uint(-1));

        IERC20(dai).approve(mcd_join_dai, uint(-1));

        VatLike(vat).hope(mcd_join_dai);

        IERC20(dai).approve(yvdai, uint(-1));

        IERC20(dai).approve(unirouter, uint(-1));

    }



    function protectedTokens() internal override view returns (address[] memory) {

        address[] memory protected = new address[](2);

        protected[0] = yvdai;

        protected[1] = dai;

        return protected;

    }



    function distributeRewards() internal override {

        // Transfer 100% of newly-minted shares awarded to this contract to the rewards address.

        vault.transfer(rewards, vault.balanceOf(address(this)));

    }



    function _deposit() internal {

        uint _token = IERC20(want).balanceOf(address(this));

        if (_token > 0) {

            uint p = _getPrice();

            uint _draw = _token.mul(p).mul(DENOMINATOR).div(c).div(1e18);

            // approve adapter to use token amount

            require(_checkDebtCeiling(_draw), "debt ceiling is reached!");

            _lockWETHAndDrawDAI(_token, _draw);



            // approve yvdai use DAI

            yVault(yvdai).deposit(IERC20(dai).balanceOf(address(this)));

        }

    }



    function _getPrice() internal view returns (uint p) {

        (uint _read,) = OSMedianizer(eth_price_oracle).read();

        (uint _foresight,) = OSMedianizer(eth_price_oracle).foresight();

        p = _foresight < _read ? _foresight : _read;

    }



    function _checkDebtCeiling(uint _amt) internal view returns (bool) {

        (,,,uint _line,) = VatLike(vat).ilks(ilk);

        uint _debt = getTotalDebtAmount().add(_amt);

        if (_line.div(1e27) < _debt) { return false; }

        return true;

    }



    function _lockWETHAndDrawDAI(uint wad, uint wadD) internal {

        address urn = ManagerLike(cdp_manager).urns(cdpId);

        if (wad > 0) { GemJoinLike(mcd_join_eth_a).join(urn, wad); }

        ManagerLike(cdp_manager).frob(cdpId, toInt(wad), _getDrawDart(urn, wadD));

        ManagerLike(cdp_manager).move(cdpId, address(this), wadD.mul(1e27));

        if (wadD > 0) { DaiJoinLike(mcd_join_dai).exit(address(this), wadD); }

    }



    function _getDrawDart(address urn, uint wad) internal returns (int dart) {

        uint rate = JugLike(jug).drip(ilk);

        uint _dai = VatLike(vat).dai(urn);



        // If there was already enough DAI in the vat balance, just exits it without adding more debt

        if (_dai < wad.mul(1e27)) {

            dart = toInt(wad.mul(1e27).sub(_dai).div(rate));

            dart = uint(dart).mul(rate) < wad.mul(1e27) ? dart + 1 : dart;

        }

    }



    function toInt(uint x) internal pure returns (int y) {

        y = int(x);

        require(y >= 0, "int-overflow");

    }



    function _freeWETHandWipeDAI(uint wad, uint wadD) internal {

        address urn = ManagerLike(cdp_manager).urns(cdpId);

        if (wadD > 0) { DaiJoinLike(mcd_join_dai).join(urn, wadD); }

        ManagerLike(cdp_manager).frob(cdpId, -toInt(wad), _getWipeDart(VatLike(vat).dai(urn), urn));

        ManagerLike(cdp_manager).flux(cdpId, address(this), wad);

        if (wad > 0) { GemJoinLike(mcd_join_eth_a).exit(address(this), wad); }

    }



    function _getWipeDart(

        uint _dai,

        address urn

    ) internal view returns (int dart) {

        (, uint rate,,,) = VatLike(vat).ilks(ilk);

        (, uint art) = VatLike(vat).urns(ilk, urn);



        dart = toInt(_dai / rate);

        dart = uint(dart) <= art ? - dart : - toInt(art);

    }



    function exitPosition(uint256 _debtOutstanding)

        internal

        override

        returns (

            uint256 _profit,

            uint256 _loss,

            uint256 _debtPayment

        ) {

        (_profit, _loss, _debtPayment) = prepareReturn(_debtOutstanding);

        _withdrawAll();

        uint _dai = IERC20(dai).balanceOf(address(this));

        if (_dai > 0) _swap(_dai);

        _debtPayment = _debtPayment.add(IERC20(want).balanceOf(address(this)));

    }



    function _withdrawAll() internal {

        yVault(yvdai).withdraw(IERC20(yvdai).balanceOf(address(this))); // get Dai

        _freeWETHandWipeDAI(balanceOfmVault(), getTotalDebtAmount().add(1)); // in case of edge case

    }



    function estimatedTotalAssets() public override view returns (uint256) {

        return balanceOfWant().add(balanceOfmVault()).add(realizedReturn());

    }



    function balanceOfWant() public view returns (uint) {

        return IERC20(want).balanceOf(address(this));

    }



    function balanceOfmVault() public view returns (uint) {

        uint ink;

        address urnHandler = ManagerLike(cdp_manager).urns(cdpId);

        (ink,) = VatLike(vat).urns(ilk, urnHandler);

        return ink;

    }



    function realizedReturn() public view returns(uint _profit) {

        uint v = getUnderlyingDai();

        uint d = getTotalDebtAmount();

        if (v > d) _profit = (v.sub(d)).mul(1e18).div(_getPrice());

    }



    function prepareReturn(uint256 _debtOutstanding)

        internal

        override

        returns (

            uint256 _profit,

            uint256 _loss,

            uint256 _debtPayment

        ) {

        _profit = IERC20(weth).balanceOf(address(this));

        uint v = getUnderlyingDai();

        uint d = getTotalDebtAmount();

        if (v > d) {

            _withdrawDaiMost(v.sub(d));

            _swap(IERC20(dai).balanceOf(address(this)));

            

            _profit = IERC20(want).balanceOf(address(this));

        }



        if (_debtOutstanding > 0) {

            _debtPayment = liquidatePosition(_debtOutstanding);

        }

    }



    function tendTrigger(uint256 callCost) public override view returns (bool) {

        // We usually don't need tend, but if there are positions that need active maintainence,

        // overriding this function is how you would signal for that

        return shouldDraw() || shouldRepay();

    }



    function harvestTrigger(uint256 callCost) public override view returns (bool) {

        StrategyParams memory params = vault.strategies(address(this));



        // Should not trigger if Strategy is not activated

        if (params.activation == 0) return false;



        // Should trigger if hasn't been called in a while

        if (block.timestamp.sub(params.lastReport) >= minReportDelay) return true;



        // If some amount is owed, pay it back

        // NOTE: Since debt is adjusted in step-wise fashion, it is appropriate

        //       to always trigger here, because the resulting change should be

        //       large (might not always be the case).

        uint256 outstanding = vault.debtOutstanding();

        if (outstanding > 0) return true;



        // Check for profits and losses

        uint256 total = estimatedTotalAssets();

        // Trigger if we have a loss to report

        if (total.add(debtThreshold) < params.totalDebt) return true;



        uint256 profit = 0;

        if (total > params.totalDebt) profit = total.sub(params.totalDebt); // We've earned a profit!



        // Otherwise, only trigger if it "makes sense" economically (gas cost

        // is <N% of value moved)

        uint256 credit = vault.creditAvailable();

        return (profitFactor.mul(callCost) < credit.add(profit));

    }



    function liquidatePosition(uint256 _amountNeeded) internal override returns (uint256 _amountFreed) {

        uint _wipe = 0;

        if (getTotalDebtAmount() != 0 && 

            getmVaultRatio(_amountNeeded) < c_safe.mul(1e2)) {

            uint p = _getPrice();

            _wipe = _withdrawDaiLeast(_amountNeeded.mul(p).div(1e18));

        }

        

        _freeWETHandWipeDAI(_amountNeeded, _wipe);

        _amountFreed = _amountNeeded;

    }



    function adjustPosition(uint256 _debtOutstanding) internal override {

        if (shouldDraw()) draw();

        else if (shouldRepay()) repay();

        _deposit();

    }



    function shouldDraw() public view returns (bool) {

        // 5% buffer to avoid deposit/rebalance loops

        return (getmVaultRatio(0) > c.mul(1e2).mul(DENOMINATOR).div((DENOMINATOR.sub(buffer))));

    }



    function drawAmount() public view returns (uint) {

        uint _safe = c.mul(1e2);

        uint _current = getmVaultRatio(0);

        if (_current > DENOMINATOR.mul(c_safe).mul(1e2)) {

            _current = DENOMINATOR.mul(c_safe).mul(1e2);

        }

        if (_current > _safe) {

            uint d = getTotalDebtAmount();

            uint diff = _current.sub(_safe);

            return d.mul(diff).div(_safe);

        }

        return 0;

    }



    function draw() internal {

        uint _drawD = drawAmount();

        if (_drawD > 0) {

            _lockWETHAndDrawDAI(0, _drawD);

            yVault(yvdai).deposit(IERC20(dai).balanceOf(address(this)));

        }

    }



    function shouldRepay() public view returns (bool) {

        // 5% buffer to avoid deposit/rebalance loops

        return (getmVaultRatio(0) < c.mul(1e2).mul(DENOMINATOR).div((DENOMINATOR.add(buffer))));

    }

    

    function repayAmount() public view returns (uint) {

        uint _safe = c.mul(1e2);

        uint _current = getmVaultRatio(0);

        if (_current < _safe) {

            uint d = getTotalDebtAmount();

            uint diff = _safe.sub(_current);

            return d.mul(diff).div(_safe);

        }

        return 0;

    }

    

    function repay() internal {

        uint free = repayAmount();

        if (free > 0) {

            _freeWETHandWipeDAI(0, _withdrawDaiLeast(free));

        }

    }

    

    function forceRebalance(uint _amount) external onlyAuthorized {

        _freeWETHandWipeDAI(0, _withdrawDaiLeast(_amount));

    }



    function getTotalDebtAmount() public view returns (uint) {

        uint art;

        uint rate;

        address urnHandler = ManagerLike(cdp_manager).urns(cdpId);

        (,art) = VatLike(vat).urns(ilk, urnHandler);

        (,rate,,,) = VatLike(vat).ilks(ilk);

        return art.mul(rate).div(1e27);

    }



    function getmVaultRatio(uint amount) public view returns (uint) {

        uint spot; // ray

        uint liquidationRatio; // ray

        uint denominator = getTotalDebtAmount();



        if (denominator == 0) {

            return uint(-1);

        }



        (,,spot,,) = VatLike(vat).ilks(ilk);

        (,liquidationRatio) = SpotLike(mcd_spot).ilks(ilk);

        uint delayedCPrice = spot.mul(liquidationRatio).div(1e27); // ray



        uint _balance = balanceOfmVault();

        if (_balance < amount) {

            _balance = 0;

        } else {

            _balance = _balance.sub(amount);

        }



        uint numerator = _balance.mul(delayedCPrice).div(1e18); // ray

        return numerator.div(denominator).div(1e3);

    }



    function getUnderlyingDai() public view returns (uint) {

        return IERC20(yvdai).balanceOf(address(this))

                .mul(yVault(yvdai).pricePerShare())

                .div(1e18);

    }



    function _withdrawDaiMost(uint _amount) internal returns (uint) {

        uint _shares = _amount

                        .mul(1e18)

                        .div(yVault(yvdai).pricePerShare());

        

        if (_shares > IERC20(yvdai).balanceOf(address(this))) {

            _shares = IERC20(yvdai).balanceOf(address(this));

        }



        uint _before = IERC20(dai).balanceOf(address(this));

        yVault(yvdai).withdraw(_shares);

        uint _after = IERC20(dai).balanceOf(address(this));

        return _after.sub(_before);

    }



    function _withdrawDaiLeast(uint _amount) internal returns (uint) {

        uint _shares = _amount

                        .mul(1e18)

                        .div(yVault(yvdai).pricePerShare())

                        .mul(DENOMINATOR)

                        .div(DENOMINATOR.sub(buffer.div(10)));



        if (_shares > IERC20(yvdai).balanceOf(address(this))) {

            _shares = IERC20(yvdai).balanceOf(address(this));

        }



        uint _before = IERC20(dai).balanceOf(address(this));

        yVault(yvdai).withdraw(_shares);

        uint _after = IERC20(dai).balanceOf(address(this));

        return _after.sub(_before);

    }



    function _swap(uint _amountIn) internal {

        address[] memory path = new address[](2);

        path[0] = address(dai);

        path[1] = address(want);



        // approve unirouter to use dai

        Uni(unirouter).swapExactTokensForTokens(_amountIn, 0, path, address(this), now.add(1 days));

    }

}
