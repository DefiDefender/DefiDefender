// SPDX-License-Identifier: MIT



//     _   ______________     ____________                    

//    / | / / ____/_  __/__  / ____/ ____/_________  ____ ___ 

//   /  |/ / /_    / / / _ \\/ / __/ / __ / ___/ __ \\/ __ `__ 

//  / /|  / __/   / / /  __/ /_/ / /_/ // /__/ /_/ / / / / / /

// /_/ |_/_/     /_/  \\___/\\____/\\____(_)___/\\____/_/ /_/ /_/ 



pragma solidity ^0.6.0;





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

abstract contract Context {

    function _msgSender() internal view virtual returns (address payable) {

        return msg.sender;

    }



    function _msgData() internal view virtual returns (bytes memory) {

        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691

        return msg.data;

    }

}



/**

 * @dev String operations.

 */

library Strings {

    /**

     * @dev Converts a `uint256` to its ASCII `string` representation.

     */

    function toString(uint256 value) internal pure returns (string memory) {

        // Inspired by OraclizeAPI's implementation - MIT licence

        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol



        if (value == 0) {

            return "0";

        }

        uint256 temp = value;

        uint256 digits;

        while (temp != 0) {

            digits++;

            temp /= 10;

        }

        bytes memory buffer = new bytes(digits);

        uint256 index = digits - 1;

        temp = value;

        while (temp != 0) {

            buffer[index--] = byte(uint8(48 + temp % 10));

            temp /= 10;

        }

        return string(buffer);

    }

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

        // This method relies on extcodesize, which returns 0 for contracts in

        // construction, since the code is only stored at the end of the

        // constructor execution.



        uint256 size;

        // solhint-disable-next-line no-inline-assembly

        assembly { size := extcodesize(account) }

        return size > 0;

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

        return functionCallWithValue(target, data, 0, errorMessage);

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

        require(isContract(target), "Address: call to non-contract");



        // solhint-disable-next-line avoid-low-level-calls

        (bool success, bytes memory returndata) = target.call{ value: value }(data);

        return _verifyCallResult(success, returndata, errorMessage);

    }



    /**

     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],

     * but performing a static call.

     *

     * _Available since v3.3._

     */

    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {

        return functionStaticCall(target, data, "Address: low-level static call failed");

    }



    /**

     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],

     * but performing a static call.

     *

     * _Available since v3.3._

     */

    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {

        require(isContract(target), "Address: static call to non-contract");



        // solhint-disable-next-line avoid-low-level-calls

        (bool success, bytes memory returndata) = target.staticcall(data);

        return _verifyCallResult(success, returndata, errorMessage);

    }



    /**

     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],

     * but performing a delegate call.

     *

     * _Available since v3.3._

     */

    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {

        return functionDelegateCall(target, data, "Address: low-level delegate call failed");

    }



    /**

     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],

     * but performing a delegate call.

     *

     * _Available since v3.3._

     */

    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {

        require(isContract(target), "Address: delegate call to non-contract");



        // solhint-disable-next-line avoid-low-level-calls

        (bool success, bytes memory returndata) = target.delegatecall(data);

        return _verifyCallResult(success, returndata, errorMessage);

    }



    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {

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

 * @dev Implementation of the {IERC20} interface.

 *

 * This implementation is agnostic to the way tokens are created. This means

 * that a supply mechanism has to be added in a derived contract using {_mint}.

 * For a generic mechanism see {ERC20PresetMinterPauser}.

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



    string private _name;

    string private _symbol;

    uint8 private _decimals;



    /**

     * @dev Sets the values for {name} and {symbol}, initializes {decimals} with

     * a default value of 18.

     *

     * To select a different value for {decimals}, use {_setupDecimals}.

     *

     * All three of these values are immutable: they can only be set once during

     * construction.

     */

    constructor (string memory name_, string memory symbol_) public {

        _name = name_;

        _symbol = symbol_;

        _decimals = 18;

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

     * Ether and Wei. This is the value {ERC20} uses, unless {_setupDecimals} is

     * called.

     *

     * NOTE: This information is only used for _display_ purposes: it in

     * no way affects any of the arithmetic of the contract, including

     * {IERC20-balanceOf} and {IERC20-transfer}.

     */

    function decimals() public view returns (uint8) {

        return _decimals;

    }



    /**

     * @dev See {IERC20-totalSupply}.

     */

    function totalSupply() public view override returns (uint256) {

        return _totalSupply;

    }



    /**

     * @dev See {IERC20-balanceOf}.

     */

    function balanceOf(address account) public view override returns (uint256) {

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

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {

        _transfer(_msgSender(), recipient, amount);

        return true;

    }



    /**

     * @dev See {IERC20-allowance}.

     */

    function allowance(address owner, address spender) public view virtual override returns (uint256) {

        return _allowances[owner][spender];

    }



    /**

     * @dev See {IERC20-approve}.

     *

     * Requirements:

     *

     * - `spender` cannot be the zero address.

     */

    function approve(address spender, uint256 amount) public virtual override returns (bool) {

        _approve(_msgSender(), spender, amount);

        return true;

    }



    /**

     * @dev See {IERC20-transferFrom}.

     *

     * Emits an {Approval} event indicating the updated allowance. This is not

     * required by the EIP. See the note at the beginning of {ERC20}.

     *

     * Requirements:

     *

     * - `sender` and `recipient` cannot be the zero address.

     * - `sender` must have a balance of at least `amount`.

     * - the caller must have allowance for ``sender``'s tokens of at least

     * `amount`.

     */

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {

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

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {

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

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {

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

    function _transfer(address sender, address recipient, uint256 amount) internal virtual {

        require(sender != address(0), "ERC20: transfer from the zero address");

        require(recipient != address(0), "ERC20: transfer to the zero address");



        _beforeTokenTransfer(sender, recipient, amount);



        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");

        _balances[recipient] = _balances[recipient].add(amount);

        emit Transfer(sender, recipient, amount);

    }



    /** @dev Creates `amount` tokens and assigns them to `account`, increasing

     * the total supply.

     *

     * Emits a {Transfer} event with `from` set to the zero address.

     *

     * Requirements:

     *

     * - `to` cannot be the zero address.

     */

    function _mint(address account, uint256 amount) internal virtual {

        require(account != address(0), "ERC20: mint to the zero address");



        _beforeTokenTransfer(address(0), account, amount);



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

     * Requirements:

     *

     * - `account` cannot be the zero address.

     * - `account` must have at least `amount` tokens.

     */

    function _burn(address account, uint256 amount) internal virtual {

        require(account != address(0), "ERC20: burn from the zero address");



        _beforeTokenTransfer(account, address(0), amount);



        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");

        _totalSupply = _totalSupply.sub(amount);

        emit Transfer(account, address(0), amount);

    }



    /**

     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.

     *

     * This internal function is equivalent to `approve`, and can be used to

     * e.g. set automatic allowances for certain subsystems, etc.

     *

     * Emits an {Approval} event.

     *

     * Requirements:

     *

     * - `owner` cannot be the zero address.

     * - `spender` cannot be the zero address.

     */

    function _approve(address owner, address spender, uint256 amount) internal virtual {

        require(owner != address(0), "ERC20: approve from the zero address");

        require(spender != address(0), "ERC20: approve to the zero address");



        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);

    }



    /**

     * @dev Sets {decimals} to a value other than the default one of 18.

     *

     * WARNING: This function should only be called from the constructor. Most

     * applications that interact with token contracts will not expect

     * {decimals} to ever change, and may work incorrectly if it does.

     */

    function _setupDecimals(uint8 decimals_) internal {

        _decimals = decimals_;

    }



    /**

     * @dev Hook that is called before any transfer of tokens. This includes

     * minting and burning.

     *

     * Calling conditions:

     *

     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens

     * will be to transferred to `to`.

     * - when `from` is zero, `amount` tokens will be minted for `to`.

     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.

     * - `from` and `to` are never both zero.

     *

     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].

     */

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }

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



/**

 * @dev Contract module which provides a basic access control mechanism, where

 * there is an account (an owner) that can be granted exclusive access to

 * specific functions.

 *

 * By default, the owner account will be the one that deploys the contract. This

 * can later be changed with {transferOwnership}.

 *

 * This module is used through inheritance. It will make available the modifier

 * `onlyOwner`, which can be applied to your functions to restrict their use to

 * the owner.

 */

abstract contract Ownable is Context {

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

        require(_owner == _msgSender(), "Ownable: caller is not the owner");

        _;

    }



    /**

     * @dev Leaves the contract without owner. It will not be possible to call

     * `onlyOwner` functions anymore. Can only be called by the current owner.

     *

     * NOTE: Renouncing ownership will leave the contract without an owner,

     * thereby removing any functionality that is only available to the owner.

     */

    function renounceOwnership() public virtual onlyOwner {

        emit OwnershipTransferred(_owner, address(0));

        _owner = address(0);

    }



    /**

     * @dev Transfers ownership of the contract to a new account (`newOwner`).

     * Can only be called by the current owner.

     */

    function transferOwnership(address newOwner) public virtual onlyOwner {

        require(newOwner != address(0), "Ownable: new owner is the zero address");

        emit OwnershipTransferred(_owner, newOwner);

        _owner = newOwner;

    }

}



/**

 * @dev Library for managing

 * https://en.wikipedia.org/wiki/Set_(abstract_data_type)[sets] of primitive

 * types.

 *

 * Sets have the following properties:

 *

 * - Elements are added, removed, and checked for existence in constant time

 * (O(1)).

 * - Elements are enumerated in O(n). No guarantees are made on the ordering.

 *

 * ```

 * contract Example {

 *     // Add the library methods

 *     using EnumerableSet for EnumerableSet.AddressSet;

 *

 *     // Declare a set state variable

 *     EnumerableSet.AddressSet private mySet;

 * }

 * ```

 *

 * As of v3.3.0, sets of type `bytes32` (`Bytes32Set`), `address` (`AddressSet`)

 * and `uint256` (`UintSet`) are supported.

 */

library EnumerableSet {

    // To implement this library for multiple types with as little code

    // repetition as possible, we write it in terms of a generic Set type with

    // bytes32 values.

    // The Set implementation uses private functions, and user-facing

    // implementations (such as AddressSet) are just wrappers around the

    // underlying Set.

    // This means that we can only create new EnumerableSets for types that fit

    // in bytes32.



    struct Set {

        // Storage of set values

        bytes32[] _values;



        // Position of the value in the `values` array, plus 1 because index 0

        // means a value is not in the set.

        mapping (bytes32 => uint256) _indexes;

    }



    /**

     * @dev Add a value to a set. O(1).

     *

     * Returns true if the value was added to the set, that is if it was not

     * already present.

     */

    function _add(Set storage set, bytes32 value) private returns (bool) {

        if (!_contains(set, value)) {

            set._values.push(value);

            // The value is stored at length-1, but we add 1 to all indexes

            // and use 0 as a sentinel value

            set._indexes[value] = set._values.length;

            return true;

        } else {

            return false;

        }

    }



    /**

     * @dev Removes a value from a set. O(1).

     *

     * Returns true if the value was removed from the set, that is if it was

     * present.

     */

    function _remove(Set storage set, bytes32 value) private returns (bool) {

        // We read and store the value's index to prevent multiple reads from the same storage slot

        uint256 valueIndex = set._indexes[value];



        if (valueIndex != 0) { // Equivalent to contains(set, value)

            // To delete an element from the _values array in O(1), we swap the element to delete with the last one in

            // the array, and then remove the last element (sometimes called as 'swap and pop').

            // This modifies the order of the array, as noted in {at}.



            uint256 toDeleteIndex = valueIndex - 1;

            uint256 lastIndex = set._values.length - 1;



            // When the value to delete is the last one, the swap operation is unnecessary. However, since this occurs

            // so rarely, we still do the swap anyway to avoid the gas cost of adding an 'if' statement.



            bytes32 lastvalue = set._values[lastIndex];



            // Move the last value to the index where the value to delete is

            set._values[toDeleteIndex] = lastvalue;

            // Update the index for the moved value

            set._indexes[lastvalue] = toDeleteIndex + 1; // All indexes are 1-based



            // Delete the slot where the moved value was stored

            set._values.pop();



            // Delete the index for the deleted slot

            delete set._indexes[value];



            return true;

        } else {

            return false;

        }

    }



    /**

     * @dev Returns true if the value is in the set. O(1).

     */

    function _contains(Set storage set, bytes32 value) private view returns (bool) {

        return set._indexes[value] != 0;

    }



    /**

     * @dev Returns the number of values on the set. O(1).

     */

    function _length(Set storage set) private view returns (uint256) {

        return set._values.length;

    }



   /**

    * @dev Returns the value stored at position `index` in the set. O(1).

    *

    * Note that there are no guarantees on the ordering of values inside the

    * array, and it may change when more values are added or removed.

    *

    * Requirements:

    *

    * - `index` must be strictly less than {length}.

    */

    function _at(Set storage set, uint256 index) private view returns (bytes32) {

        require(set._values.length > index, "EnumerableSet: index out of bounds");

        return set._values[index];

    }



    // Bytes32Set



    struct Bytes32Set {

        Set _inner;

    }



    /**

     * @dev Add a value to a set. O(1).

     *

     * Returns true if the value was added to the set, that is if it was not

     * already present.

     */

    function add(Bytes32Set storage set, bytes32 value) internal returns (bool) {

        return _add(set._inner, value);

    }



    /**

     * @dev Removes a value from a set. O(1).

     *

     * Returns true if the value was removed from the set, that is if it was

     * present.

     */

    function remove(Bytes32Set storage set, bytes32 value) internal returns (bool) {

        return _remove(set._inner, value);

    }



    /**

     * @dev Returns true if the value is in the set. O(1).

     */

    function contains(Bytes32Set storage set, bytes32 value) internal view returns (bool) {

        return _contains(set._inner, value);

    }



    /**

     * @dev Returns the number of values in the set. O(1).

     */

    function length(Bytes32Set storage set) internal view returns (uint256) {

        return _length(set._inner);

    }



   /**

    * @dev Returns the value stored at position `index` in the set. O(1).

    *

    * Note that there are no guarantees on the ordering of values inside the

    * array, and it may change when more values are added or removed.

    *

    * Requirements:

    *

    * - `index` must be strictly less than {length}.

    */

    function at(Bytes32Set storage set, uint256 index) internal view returns (bytes32) {

        return _at(set._inner, index);

    }



    // AddressSet



    struct AddressSet {

        Set _inner;

    }



    /**

     * @dev Add a value to a set. O(1).

     *

     * Returns true if the value was added to the set, that is if it was not

     * already present.

     */

    function add(AddressSet storage set, address value) internal returns (bool) {

        return _add(set._inner, bytes32(uint256(value)));

    }



    /**

     * @dev Removes a value from a set. O(1).

     *

     * Returns true if the value was removed from the set, that is if it was

     * present.

     */

    function remove(AddressSet storage set, address value) internal returns (bool) {

        return _remove(set._inner, bytes32(uint256(value)));

    }



    /**

     * @dev Returns true if the value is in the set. O(1).

     */

    function contains(AddressSet storage set, address value) internal view returns (bool) {

        return _contains(set._inner, bytes32(uint256(value)));

    }



    /**

     * @dev Returns the number of values in the set. O(1).

     */

    function length(AddressSet storage set) internal view returns (uint256) {

        return _length(set._inner);

    }



   /**

    * @dev Returns the value stored at position `index` in the set. O(1).

    *

    * Note that there are no guarantees on the ordering of values inside the

    * array, and it may change when more values are added or removed.

    *

    * Requirements:

    *

    * - `index` must be strictly less than {length}.

    */

    function at(AddressSet storage set, uint256 index) internal view returns (address) {

        return address(uint256(_at(set._inner, index)));

    }





    // UintSet



    struct UintSet {

        Set _inner;

    }



    /**

     * @dev Add a value to a set. O(1).

     *

     * Returns true if the value was added to the set, that is if it was not

     * already present.

     */

    function add(UintSet storage set, uint256 value) internal returns (bool) {

        return _add(set._inner, bytes32(value));

    }



    /**

     * @dev Removes a value from a set. O(1).

     *

     * Returns true if the value was removed from the set, that is if it was

     * present.

     */

    function remove(UintSet storage set, uint256 value) internal returns (bool) {

        return _remove(set._inner, bytes32(value));

    }



    /**

     * @dev Returns true if the value is in the set. O(1).

     */

    function contains(UintSet storage set, uint256 value) internal view returns (bool) {

        return _contains(set._inner, bytes32(value));

    }



    /**

     * @dev Returns the number of values on the set. O(1).

     */

    function length(UintSet storage set) internal view returns (uint256) {

        return _length(set._inner);

    }



   /**

    * @dev Returns the value stored at position `index` in the set. O(1).

    *

    * Note that there are no guarantees on the ordering of values inside the

    * array, and it may change when more values are added or removed.

    *

    * Requirements:

    *

    * - `index` must be strictly less than {length}.

    */

    function at(UintSet storage set, uint256 index) internal view returns (uint256) {

        return uint256(_at(set._inner, index));

    }

}





/**

 * @dev Library for managing an enumerable variant of Solidity's

 * https://solidity.readthedocs.io/en/latest/types.html#mapping-types[`mapping`]

 * type.

 *

 * Maps have the following properties:

 *

 * - Entries are added, removed, and checked for existence in constant time

 * (O(1)).

 * - Entries are enumerated in O(n). No guarantees are made on the ordering.

 *

 * ```

 * contract Example {

 *     // Add the library methods

 *     using EnumerableMap for EnumerableMap.UintToAddressMap;

 *

 *     // Declare a set state variable

 *     EnumerableMap.UintToAddressMap private myMap;

 * }

 * ```

 *

 * As of v3.0.0, only maps of type `uint256 -> address` (`UintToAddressMap`) are

 * supported.

 */

library EnumerableMap {

    // To implement this library for multiple types with as little code

    // repetition as possible, we write it in terms of a generic Map type with

    // bytes32 keys and values.

    // The Map implementation uses private functions, and user-facing

    // implementations (such as Uint256ToAddressMap) are just wrappers around

    // the underlying Map.

    // This means that we can only create new EnumerableMaps for types that fit

    // in bytes32.



    struct MapEntry {

        bytes32 _key;

        bytes32 _value;

    }



    struct Map {

        // Storage of map keys and values

        MapEntry[] _entries;



        // Position of the entry defined by a key in the `entries` array, plus 1

        // because index 0 means a key is not in the map.

        mapping (bytes32 => uint256) _indexes;

    }



    /**

     * @dev Adds a key-value pair to a map, or updates the value for an existing

     * key. O(1).

     *

     * Returns true if the key was added to the map, that is if it was not

     * already present.

     */

    function _set(Map storage map, bytes32 key, bytes32 value) private returns (bool) {

        // We read and store the key's index to prevent multiple reads from the same storage slot

        uint256 keyIndex = map._indexes[key];



        if (keyIndex == 0) { // Equivalent to !contains(map, key)

            map._entries.push(MapEntry({ _key: key, _value: value }));

            // The entry is stored at length-1, but we add 1 to all indexes

            // and use 0 as a sentinel value

            map._indexes[key] = map._entries.length;

            return true;

        } else {

            map._entries[keyIndex - 1]._value = value;

            return false;

        }

    }



    /**

     * @dev Removes a key-value pair from a map. O(1).

     *

     * Returns true if the key was removed from the map, that is if it was present.

     */

    function _remove(Map storage map, bytes32 key) private returns (bool) {

        // We read and store the key's index to prevent multiple reads from the same storage slot

        uint256 keyIndex = map._indexes[key];



        if (keyIndex != 0) { // Equivalent to contains(map, key)

            // To delete a key-value pair from the _entries array in O(1), we swap the entry to delete with the last one

            // in the array, and then remove the last entry (sometimes called as 'swap and pop').

            // This modifies the order of the array, as noted in {at}.



            uint256 toDeleteIndex = keyIndex - 1;

            uint256 lastIndex = map._entries.length - 1;



            // When the entry to delete is the last one, the swap operation is unnecessary. However, since this occurs

            // so rarely, we still do the swap anyway to avoid the gas cost of adding an 'if' statement.



            MapEntry storage lastEntry = map._entries[lastIndex];



            // Move the last entry to the index where the entry to delete is

            map._entries[toDeleteIndex] = lastEntry;

            // Update the index for the moved entry

            map._indexes[lastEntry._key] = toDeleteIndex + 1; // All indexes are 1-based



            // Delete the slot where the moved entry was stored

            map._entries.pop();



            // Delete the index for the deleted slot

            delete map._indexes[key];



            return true;

        } else {

            return false;

        }

    }



    /**

     * @dev Returns true if the key is in the map. O(1).

     */

    function _contains(Map storage map, bytes32 key) private view returns (bool) {

        return map._indexes[key] != 0;

    }



    /**

     * @dev Returns the number of key-value pairs in the map. O(1).

     */

    function _length(Map storage map) private view returns (uint256) {

        return map._entries.length;

    }



   /**

    * @dev Returns the key-value pair stored at position `index` in the map. O(1).

    *

    * Note that there are no guarantees on the ordering of entries inside the

    * array, and it may change when more entries are added or removed.

    *

    * Requirements:

    *

    * - `index` must be strictly less than {length}.

    */

    function _at(Map storage map, uint256 index) private view returns (bytes32, bytes32) {

        require(map._entries.length > index, "EnumerableMap: index out of bounds");



        MapEntry storage entry = map._entries[index];

        return (entry._key, entry._value);

    }



    /**

     * @dev Returns the value associated with `key`.  O(1).

     *

     * Requirements:

     *

     * - `key` must be in the map.

     */

    function _get(Map storage map, bytes32 key) private view returns (bytes32) {

        return _get(map, key, "EnumerableMap: nonexistent key");

    }



    /**

     * @dev Same as {_get}, with a custom error message when `key` is not in the map.

     */

    function _get(Map storage map, bytes32 key, string memory errorMessage) private view returns (bytes32) {

        uint256 keyIndex = map._indexes[key];

        require(keyIndex != 0, errorMessage); // Equivalent to contains(map, key)

        return map._entries[keyIndex - 1]._value; // All indexes are 1-based

    }



    // UintToAddressMap



    struct UintToAddressMap {

        Map _inner;

    }



    /**

     * @dev Adds a key-value pair to a map, or updates the value for an existing

     * key. O(1).

     *

     * Returns true if the key was added to the map, that is if it was not

     * already present.

     */

    function set(UintToAddressMap storage map, uint256 key, address value) internal returns (bool) {

        return _set(map._inner, bytes32(key), bytes32(uint256(value)));

    }



    /**

     * @dev Removes a value from a set. O(1).

     *

     * Returns true if the key was removed from the map, that is if it was present.

     */

    function remove(UintToAddressMap storage map, uint256 key) internal returns (bool) {

        return _remove(map._inner, bytes32(key));

    }



    /**

     * @dev Returns true if the key is in the map. O(1).

     */

    function contains(UintToAddressMap storage map, uint256 key) internal view returns (bool) {

        return _contains(map._inner, bytes32(key));

    }



    /**

     * @dev Returns the number of elements in the map. O(1).

     */

    function length(UintToAddressMap storage map) internal view returns (uint256) {

        return _length(map._inner);

    }



   /**

    * @dev Returns the element stored at position `index` in the set. O(1).

    * Note that there are no guarantees on the ordering of values inside the

    * array, and it may change when more values are added or removed.

    *

    * Requirements:

    *

    * - `index` must be strictly less than {length}.

    */

    function at(UintToAddressMap storage map, uint256 index) internal view returns (uint256, address) {

        (bytes32 key, bytes32 value) = _at(map._inner, index);

        return (uint256(key), address(uint256(value)));

    }



    /**

     * @dev Returns the value associated with `key`.  O(1).

     *

     * Requirements:

     *

     * - `key` must be in the map.

     */

    function get(UintToAddressMap storage map, uint256 key) internal view returns (address) {

        return address(uint256(_get(map._inner, bytes32(key))));

    }



    /**

     * @dev Same as {get}, with a custom error message when `key` is not in the map.

     */

    function get(UintToAddressMap storage map, uint256 key, string memory errorMessage) internal view returns (address) {

        return address(uint256(_get(map._inner, bytes32(key), errorMessage)));

    }

}



pragma solidity >=0.6.0 <0.8.0;



/**

 * @dev Interface of the ERC165 standard, as defined in the

 * https://eips.ethereum.org/EIPS/eip-165[EIP].

 *

 * Implementers can declare support of contract interfaces, which can then be

 * queried by others ({ERC165Checker}).

 *

 * For an implementation, see {ERC165}.

 */

interface IERC165 {

    /**

     * @dev Returns true if this contract implements the interface defined by

     * `interfaceId`. See the corresponding

     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]

     * to learn more about how these ids are created.

     *

     * This function call must use less than 30 000 gas.

     */

    function supportsInterface(bytes4 interfaceId) external view returns (bool);

}





/**

 * @dev Implementation of the {IERC165} interface.

 *

 * Contracts may inherit from this and call {_registerInterface} to declare

 * their support of an interface.

 */

abstract contract ERC165 is IERC165 {

    /*

     * bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7

     */

    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;



    /**

     * @dev Mapping of interface ids to whether or not it's supported.

     */

    mapping(bytes4 => bool) private _supportedInterfaces;



    constructor () internal {

        // Derived contracts need only register support for their own interfaces,

        // we register support for ERC165 itself here

        _registerInterface(_INTERFACE_ID_ERC165);

    }



    /**

     * @dev See {IERC165-supportsInterface}.

     *

     * Time complexity O(1), guaranteed to always use less than 30 000 gas.

     */

    function supportsInterface(bytes4 interfaceId) public view override returns (bool) {

        return _supportedInterfaces[interfaceId];

    }



    /**

     * @dev Registers the contract as an implementer of the interface defined by

     * `interfaceId`. Support of the actual ERC165 interface is automatic and

     * registering its interface id is not required.

     *

     * See {IERC165-supportsInterface}.

     *

     * Requirements:

     *

     * - `interfaceId` cannot be the ERC165 invalid interface (`0xffffffff`).

     */

    function _registerInterface(bytes4 interfaceId) internal virtual {

        require(interfaceId != 0xffffffff, "ERC165: invalid interface id");

        _supportedInterfaces[interfaceId] = true;

    }

}



/**

 * @dev Required interface of an ERC721 compliant contract.

 */

interface IERC721 is IERC165 {

    /**

     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.

     */

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);



    /**

     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.

     */

    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);



    /**

     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.

     */

    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);



    /**

     * @dev Returns the number of tokens in ``owner``'s account.

     */

    function balanceOf(address owner) external view returns (uint256 balance);



    /**

     * @dev Returns the owner of the `tokenId` token.

     *

     * Requirements:

     *

     * - `tokenId` must exist.

     */

    function ownerOf(uint256 tokenId) external view returns (address owner);



    /**

     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients

     * are aware of the ERC721 protocol to prevent tokens from being forever locked.

     *

     * Requirements:

     *

     * - `from` cannot be the zero address.

     * - `to` cannot be the zero address.

     * - `tokenId` token must exist and be owned by `from`.

     * - If the caller is not `from`, it must be have been allowed to move this token by either {approve} or {setApprovalForAll}.

     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.

     *

     * Emits a {Transfer} event.

     */

    function safeTransferFrom(address from, address to, uint256 tokenId) external;



    /**

     * @dev Transfers `tokenId` token from `from` to `to`.

     *

     * WARNING: Usage of this method is discouraged, use {safeTransferFrom} whenever possible.

     *

     * Requirements:

     *

     * - `from` cannot be the zero address.

     * - `to` cannot be the zero address.

     * - `tokenId` token must be owned by `from`.

     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.

     *

     * Emits a {Transfer} event.

     */

    function transferFrom(address from, address to, uint256 tokenId) external;



    /**

     * @dev Gives permission to `to` to transfer `tokenId` token to another account.

     * The approval is cleared when the token is transferred.

     *

     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.

     *

     * Requirements:

     *

     * - The caller must own the token or be an approved operator.

     * - `tokenId` must exist.

     *

     * Emits an {Approval} event.

     */

    function approve(address to, uint256 tokenId) external;



    /**

     * @dev Returns the account approved for `tokenId` token.

     *

     * Requirements:

     *

     * - `tokenId` must exist.

     */

    function getApproved(uint256 tokenId) external view returns (address operator);



    /**

     * @dev Approve or remove `operator` as an operator for the caller.

     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.

     *

     * Requirements:

     *

     * - The `operator` cannot be the caller.

     *

     * Emits an {ApprovalForAll} event.

     */

    function setApprovalForAll(address operator, bool _approved) external;



    /**

     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.

     *

     * See {setApprovalForAll}

     */

    function isApprovedForAll(address owner, address operator) external view returns (bool);



    /**

      * @dev Safely transfers `tokenId` token from `from` to `to`.

      *

      * Requirements:

      *

     * - `from` cannot be the zero address.

     * - `to` cannot be the zero address.

      * - `tokenId` token must exist and be owned by `from`.

      * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.

      * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.

      *

      * Emits a {Transfer} event.

      */

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

}



/**

 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension

 * @dev See https://eips.ethereum.org/EIPS/eip-721

 */

interface IERC721Metadata is IERC721 {



    /**

     * @dev Returns the token collection name.

     */

    function name() external view returns (string memory);



    /**

     * @dev Returns the token collection symbol.

     */

    function symbol() external view returns (string memory);



    /**

     * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.

     */

    function tokenURI(uint256 tokenId) external view returns (string memory);

}



/**

 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension

 * @dev See https://eips.ethereum.org/EIPS/eip-721

 */

interface IERC721Enumerable is IERC721 {



    /**

     * @dev Returns the total amount of tokens stored by the contract.

     */

    function totalSupply() external view returns (uint256);



    /**

     * @dev Returns a token ID owned by `owner` at a given `index` of its token list.

     * Use along with {balanceOf} to enumerate all of ``owner``'s tokens.

     */

    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256 tokenId);



    /**

     * @dev Returns a token ID at a given `index` of all the tokens stored by the contract.

     * Use along with {totalSupply} to enumerate all tokens.

     */

    function tokenByIndex(uint256 index) external view returns (uint256);

}



/**

 * @title ERC721 token receiver interface

 * @dev Interface for any contract that wants to support safeTransfers

 * from ERC721 asset contracts.

 */

interface IERC721Receiver {

    /**

     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}

     * by `operator` from `from`, this function is called.

     *

     * It must return its Solidity selector to confirm the token transfer.

     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.

     *

     * The selector can be obtained in Solidity with `IERC721.onERC721Received.selector`.

     */

    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4);

}





/**

 * @title ERC721 Non-Fungible Token Standard basic implementation

 * @dev see https://eips.ethereum.org/EIPS/eip-721

 */

contract ERC721 is Context, ERC165, IERC721, IERC721Metadata, IERC721Enumerable {

    using SafeMath for uint256;

    using Address for address;

    using EnumerableSet for EnumerableSet.UintSet;

    using EnumerableMap for EnumerableMap.UintToAddressMap;

    using Strings for uint256;



    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`

    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`

    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;



    // Mapping from holder address to their (enumerable) set of owned tokens

    mapping (address => EnumerableSet.UintSet) private _holderTokens;



    // Enumerable mapping from token ids to their owners

    EnumerableMap.UintToAddressMap private _tokenOwners;



    // Mapping from token ID to approved address

    mapping (uint256 => address) private _tokenApprovals;



    // Mapping from owner to operator approvals

    mapping (address => mapping (address => bool)) private _operatorApprovals;



    // Token name

    string private _name;



    // Token symbol

    string private _symbol;



    // Optional mapping for token URIs

    mapping (uint256 => string) private _tokenURIs;



    // Base URI

    string private _baseURI;



    /*

     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231

     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e

     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3

     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc

     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465

     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5

     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd

     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e

     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde

     *

     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^

     *        0xa22cb465 ^ 0xe985e9c5 ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd

     */

    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;



    /*

     *     bytes4(keccak256('name()')) == 0x06fdde03

     *     bytes4(keccak256('symbol()')) == 0x95d89b41

     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd

     *

     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f

     */

    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;



    /*

     *     bytes4(keccak256('totalSupply()')) == 0x18160ddd

     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59

     *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7

     *

     *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63

     */

    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;



    /**

     * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.

     */

    constructor (string memory name_, string memory symbol_) public {

        _name = name_;

        _symbol = symbol_;



        // register the supported interfaces to conform to ERC721 via ERC165

        _registerInterface(_INTERFACE_ID_ERC721);

        _registerInterface(_INTERFACE_ID_ERC721_METADATA);

        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);

    }



    /**

     * @dev See {IERC721-balanceOf}.

     */

    function balanceOf(address owner) public view override returns (uint256) {

        require(owner != address(0), "ERC721: balance query for the zero address");



        return _holderTokens[owner].length();

    }



    /**

     * @dev See {IERC721-ownerOf}.

     */

    function ownerOf(uint256 tokenId) public view override returns (address) {

        return _tokenOwners.get(tokenId, "ERC721: owner query for nonexistent token");

    }



    /**

     * @dev See {IERC721Metadata-name}.

     */

    function name() public view override returns (string memory) {

        return _name;

    }



    /**

     * @dev See {IERC721Metadata-symbol}.

     */

    function symbol() public view override returns (string memory) {

        return _symbol;

    }



    /**

     * @dev See {IERC721Metadata-tokenURI}.

     */

    function tokenURI(uint256 tokenId) public view override returns (string memory) {

        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");



        string memory _tokenURI = _tokenURIs[tokenId];



        // If there is no base URI, return the token URI.

        if (bytes(_baseURI).length == 0) {

            return _tokenURI;

        }

        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).

        if (bytes(_tokenURI).length > 0) {

            return string(abi.encodePacked(_baseURI, _tokenURI));

        }

        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.

        return string(abi.encodePacked(_baseURI, tokenId.toString()));

    }



    /**

    * @dev Returns the base URI set via {_setBaseURI}. This will be

    * automatically added as a prefix in {tokenURI} to each token's URI, or

    * to the token ID if no specific URI is set for that token ID.

    */

    function baseURI() public view returns (string memory) {

        return _baseURI;

    }



    /**

     * @dev See {IERC721Enumerable-tokenOfOwnerByIndex}.

     */

    function tokenOfOwnerByIndex(address owner, uint256 index) public view override returns (uint256) {

        return _holderTokens[owner].at(index);

    }



    /**

     * @dev See {IERC721Enumerable-totalSupply}.

     */

    function totalSupply() public view override returns (uint256) {

        // _tokenOwners are indexed by tokenIds, so .length() returns the number of tokenIds

        return _tokenOwners.length();

    }



    /**

     * @dev See {IERC721Enumerable-tokenByIndex}.

     */

    function tokenByIndex(uint256 index) public view override returns (uint256) {

        (uint256 tokenId, ) = _tokenOwners.at(index);

        return tokenId;

    }



    /**

     * @dev See {IERC721-approve}.

     */

    function approve(address to, uint256 tokenId) public virtual override {

        address owner = ownerOf(tokenId);

        require(to != owner, "ERC721: approval to current owner");



        require(_msgSender() == owner || isApprovedForAll(owner, _msgSender()),

            "ERC721: approve caller is not owner nor approved for all"

        );



        _approve(to, tokenId);

    }



    /**

     * @dev See {IERC721-getApproved}.

     */

    function getApproved(uint256 tokenId) public view override returns (address) {

        require(_exists(tokenId), "ERC721: approved query for nonexistent token");



        return _tokenApprovals[tokenId];

    }



    /**

     * @dev See {IERC721-setApprovalForAll}.

     */

    function setApprovalForAll(address operator, bool approved) public virtual override {

        require(operator != _msgSender(), "ERC721: approve to caller");



        _operatorApprovals[_msgSender()][operator] = approved;

        emit ApprovalForAll(_msgSender(), operator, approved);

    }



    /**

     * @dev See {IERC721-isApprovedForAll}.

     */

    function isApprovedForAll(address owner, address operator) public view override returns (bool) {

        return _operatorApprovals[owner][operator];

    }



    /**

     * @dev See {IERC721-transferFrom}.

     */

    function transferFrom(address from, address to, uint256 tokenId) public virtual override {

        //solhint-disable-next-line max-line-length

        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");



        _transfer(from, to, tokenId);

    }



    /**

     * @dev See {IERC721-safeTransferFrom}.

     */

    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override {

        safeTransferFrom(from, to, tokenId, "");

    }



    /**

     * @dev See {IERC721-safeTransferFrom}.

     */

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public virtual override {

        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");

        _safeTransfer(from, to, tokenId, _data);

    }



    /**

     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients

     * are aware of the ERC721 protocol to prevent tokens from being forever locked.

     *

     * `_data` is additional data, it has no specified format and it is sent in call to `to`.

     *

     * This internal function is equivalent to {safeTransferFrom}, and can be used to e.g.

     * implement alternative mechanisms to perform token transfer, such as signature-based.

     *

     * Requirements:

     *

     * - `from` cannot be the zero address.

     * - `to` cannot be the zero address.

     * - `tokenId` token must exist and be owned by `from`.

     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.

     *

     * Emits a {Transfer} event.

     */

    function _safeTransfer(address from, address to, uint256 tokenId, bytes memory _data) internal virtual {

        _transfer(from, to, tokenId);

        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");

    }



    /**

     * @dev Returns whether `tokenId` exists.

     *

     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.

     *

     * Tokens start existing when they are minted (`_mint`),

     * and stop existing when they are burned (`_burn`).

     */

    function _exists(uint256 tokenId) internal view returns (bool) {

        return _tokenOwners.contains(tokenId);

    }



    /**

     * @dev Returns whether `spender` is allowed to manage `tokenId`.

     *

     * Requirements:

     *

     * - `tokenId` must exist.

     */

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {

        require(_exists(tokenId), "ERC721: operator query for nonexistent token");

        address owner = ownerOf(tokenId);

        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));

    }



    /**

     * @dev Safely mints `tokenId` and transfers it to `to`.

     *

     * Requirements:

     d*

     * - `tokenId` must not exist.

     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.

     *

     * Emits a {Transfer} event.

     */

    function _safeMint(address to, uint256 tokenId) internal virtual {

        _safeMint(to, tokenId, "");

    }



    /**

     * @dev Same as {xref-ERC721-_safeMint-address-uint256-}[`_safeMint`], with an additional `data` parameter which is

     * forwarded in {IERC721Receiver-onERC721Received} to contract recipients.

     */

    function _safeMint(address to, uint256 tokenId, bytes memory _data) internal virtual {

        _mint(to, tokenId);

        require(_checkOnERC721Received(address(0), to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");

    }



    /**

     * @dev Mints `tokenId` and transfers it to `to`.

     *

     * WARNING: Usage of this method is discouraged, use {_safeMint} whenever possible

     *

     * Requirements:

     *

     * - `tokenId` must not exist.

     * - `to` cannot be the zero address.

     *

     * Emits a {Transfer} event.

     */

    function _mint(address to, uint256 tokenId) internal virtual {

        require(to != address(0), "ERC721: mint to the zero address");

        require(!_exists(tokenId), "ERC721: token already minted");



        _beforeTokenTransfer(address(0), to, tokenId);



        _holderTokens[to].add(tokenId);



        _tokenOwners.set(tokenId, to);



        emit Transfer(address(0), to, tokenId);

    }



    /**

     * @dev Destroys `tokenId`.

     * The approval is cleared when the token is burned.

     *

     * Requirements:

     *

     * - `tokenId` must exist.

     *

     * Emits a {Transfer} event.

     */

    function _burn(uint256 tokenId) internal virtual {

        address owner = ownerOf(tokenId);



        _beforeTokenTransfer(owner, address(0), tokenId);



        // Clear approvals

        _approve(address(0), tokenId);



        // Clear metadata (if any)

        if (bytes(_tokenURIs[tokenId]).length != 0) {

            delete _tokenURIs[tokenId];

        }



        _holderTokens[owner].remove(tokenId);



        _tokenOwners.remove(tokenId);



        emit Transfer(owner, address(0), tokenId);

    }



    /**

     * @dev Transfers `tokenId` from `from` to `to`.

     *  As opposed to {transferFrom}, this imposes no restrictions on msg.sender.

     *

     * Requirements:

     *

     * - `to` cannot be the zero address.

     * - `tokenId` token must be owned by `from`.

     *

     * Emits a {Transfer} event.

     */

    function _transfer(address from, address to, uint256 tokenId) internal virtual {

        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");

        require(to != address(0), "ERC721: transfer to the zero address");



        _beforeTokenTransfer(from, to, tokenId);



        // Clear approvals from the previous owner

        _approve(address(0), tokenId);



        _holderTokens[from].remove(tokenId);

        _holderTokens[to].add(tokenId);



        _tokenOwners.set(tokenId, to);



        emit Transfer(from, to, tokenId);

    }



    /**

     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.

     *

     * Requirements:

     *

     * - `tokenId` must exist.

     */

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {

        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");

        _tokenURIs[tokenId] = _tokenURI;

    }



    /**

     * @dev Internal function to set the base URI for all token IDs. It is

     * automatically added as a prefix to the value returned in {tokenURI},

     * or to the token ID if {tokenURI} is empty.

     */

    function _setBaseURI(string memory baseURI_) internal virtual {

        _baseURI = baseURI_;

    }



    /**

     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.

     * The call is not executed if the target address is not a contract.

     *

     * @param from address representing the previous owner of the given token ID

     * @param to target address that will receive the tokens

     * @param tokenId uint256 ID of the token to be transferred

     * @param _data bytes optional data to send along with the call

     * @return bool whether the call correctly returned the expected magic value

     */

    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data)

        private returns (bool)

    {

        if (!to.isContract()) {

            return true;

        }

        bytes memory returndata = to.functionCall(abi.encodeWithSelector(

            IERC721Receiver(to).onERC721Received.selector,

            _msgSender(),

            from,

            tokenId,

            _data

        ), "ERC721: transfer to non ERC721Receiver implementer");

        bytes4 retval = abi.decode(returndata, (bytes4));

        return (retval == _ERC721_RECEIVED);

    }



    function _approve(address to, uint256 tokenId) private {

        _tokenApprovals[tokenId] = to;

        emit Approval(ownerOf(tokenId), to, tokenId);

    }



    /**

     * @dev Hook that is called before any token transfer. This includes minting

     * and burning.

     *

     * Calling conditions:

     *

     * - When `from` and `to` are both non-zero, ``from``'s `tokenId` will be

     * transferred to `to`.

     * - When `from` is zero, `tokenId` will be minted for `to`.

     * - When `to` is zero, ``from``'s `tokenId` will be burned.

     * - `from` cannot be the zero address.

     * - `to` cannot be the zero address.

     *

     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].

     */

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual { }

}





// #################################################

/**

 * @dev Contract module that can be used to recover ERC20 compatible tokens stuck in the contract.

 */

contract ERC20Recoverable is Ownable {

    /**

     * @dev Used to transfer tokens stuck on this contract to another address.

     */

    function recoverERC20(address token, address recipient, uint256 amount) external onlyOwner returns (bool) {

        return IERC20(token).transfer(recipient, amount);

    }



    /**

     * @dev Used to approve recovery of stuck tokens. May also be used to approve token transfers in advance.

     */

     function recoverERC20Approve(address token, address spender, uint256 amount) external onlyOwner returns (bool) {

        return IERC20(token).approve(spender, amount);

    }

}



/**

 * @dev Contract module that can be used to recover ERC721 compatible tokens stuck in the contract.

 */

contract ERC721Recoverable is Ownable {

    /**

     * @dev Used to recover a stuck token.

     */

    function recoverERC721(address token, address recipient, uint256 tokenId) external onlyOwner {

        return IERC721(token).transferFrom(address(this), recipient, tokenId);

    }



    /**

     * @dev Used to recover a stuck token using the safe transfer function of ERC721.

     */

    function recoverERC721Safe(address token, address recipient, uint256 tokenId) external onlyOwner {

        return IERC721(token).safeTransferFrom(address(this), recipient, tokenId);

    }



    /**

     * @dev Used to approve the recovery of a stuck token.

     */

    function recoverERC721Approve(address token, address recipient, uint256 tokenId) external onlyOwner {

        return IERC721(token).approve(recipient, tokenId);

    }



    /**

     * @dev Used to approve the recovery of stuck token, also in future.

     */

    function recoverERC721ApproveAll(address token, address recipient, bool approved) external onlyOwner {

        return IERC721(token).setApprovalForAll(recipient, approved);

    }

}



/**

 * @dev Most credited to OpenZeppelin ERC721.sol, but with some adjustments.

 */

contract T2 is Context, Ownable, ERC165, IERC721, IERC721Metadata, IERC721Enumerable, ERC20Recoverable, ERC721Recoverable {

    using SafeMath for uint256;

    using Address for address;

    using EnumerableSet for EnumerableSet.UintSet;

    using EnumerableMap for EnumerableMap.UintToAddressMap;

    using Strings for uint256;



    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`

    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`

    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;



    // Mapping from holder address to their (enumerable) set of owned tokens

    mapping (address => EnumerableSet.UintSet) private _holderTokens;



    // Enumerable mapping from token ids to their owners

    EnumerableMap.UintToAddressMap private _tokenOwners;



    // Mapping from token ID to approved address

    mapping (uint256 => address) private _tokenApprovals;



    // Mapping from owner to operator approvals

    mapping (address => mapping (address => bool)) private _operatorApprovals;



    // Token name

    string private _name;



    // Token symbol

    string private _symbol;



    // Base URI

    string private _baseURI;



    // Specified if tokens are transferable. Can be flipped by the owner.

    bool private _transferable;



    // Price per token. Is chosen and can be changed by contract owner.

    uint256 private _tokenPrice;



    // Counter for token id

    uint256 private _nextId = 1;



    /*

     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231

     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e

     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3

     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc

     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465

     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5

     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd

     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e

     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde

     *

     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^

     *        0xa22cb465 ^ 0xe985e9c5 ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd

     */

    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;



    /*

     *     bytes4(keccak256('name()')) == 0x06fdde03

     *     bytes4(keccak256('symbol()')) == 0x95d89b41

     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd

     *

     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f

     */

    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;



    /*

     *     bytes4(keccak256('totalSupply()')) == 0x18160ddd

     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59

     *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7

     *

     *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63

     */

    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;



    /**

     * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.

     */

    constructor (string memory name, string memory symbol, string memory baseURI, bool transferable, uint256 tokenPrice) public {

        _name = name;

        _symbol = symbol;

        _baseURI = baseURI;

        _transferable = transferable;

        _tokenPrice = tokenPrice;



        // register the supported interfaces to conform to ERC721 via ERC165

        _registerInterface(_INTERFACE_ID_ERC721);

        _registerInterface(_INTERFACE_ID_ERC721_METADATA);

        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);

    }



// public functions:

    /**

     * @dev See {IERC721-balanceOf}.

     */

    function balanceOf(address owner) external view override returns (uint256) {

        require(owner != address(0), "ERC721: balance query for the zero address");



        return _holderTokens[owner].length();

    }



    /**

     * @dev See {IERC721-ownerOf}.

     */

    function ownerOf(uint256 tokenId) public view override returns (address) {

        return _tokenOwners.get(tokenId, "ERC721: owner query for nonexistent token");

    }



    /**

     * @dev See {IERC721Metadata-name}.

     */

    function name() external view override returns (string memory) {

        return _name;

    }



    /**

     * @dev See {IERC721Metadata-symbol}.

     */

    function symbol() external view override returns (string memory) {

        return _symbol;

    }



    /**

     * @dev See {IERC721Metadata-tokenURI}.

     */

    function tokenURI(uint256 tokenId) external view override returns (string memory) {

        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");



        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.

        return string(abi.encodePacked(_baseURI, tokenId.toString()));

    }



    /**

    * @dev Returns the base URI set via {_setBaseURI}. This will be

    * automatically added as a prefix in {tokenURI} to each token's URI, or

    * to the token ID if no specific URI is set for that token ID.

    */

    function baseURI() external view returns (string memory) {

        return _baseURI;

    }



    /**

     * @dev Returns if tokens are globally transferable currently. That may be decided by the contract owner.

     */

    function transferable() external view returns (bool) {

        return _transferable;

    }



    /**

     * @dev Price per token for public purchase.

     */

    function tokenPrice() external view returns (uint256) {

        return _tokenPrice;

    }



    /**

     * @dev Next token id.

     */

    function nextTokenId() public view returns (uint256) {

        return _nextId;

    }



    /**

     * @dev See {IERC721Enumerable-tokenOfOwnerByIndex}.

     */

    function tokenOfOwnerByIndex(address owner, uint256 index) external view override returns (uint256) {

        return _holderTokens[owner].at(index);

    }



    /**

     * @dev See {IERC721Enumerable-totalSupply}.

     */

    function totalSupply() external view override returns (uint256) {

        // _tokenOwners are indexed by tokenIds, so .length() returns the number of tokenIds

        return _tokenOwners.length();

    }



    /**

     * @dev See {IERC721Enumerable-tokenByIndex}.

     */

    function tokenByIndex(uint256 index) external view override returns (uint256) {

        (uint256 tokenId, ) = _tokenOwners.at(index);

        return tokenId;

    }



    /**

     * @dev See {IERC721-approve}.

     */

    function approve(address to, uint256 tokenId) external virtual override {

        address owner = ownerOf(tokenId);

        require(to != owner, "ERC721: approval to current owner");



        require(_msgSender() == owner || isApprovedForAll(owner, _msgSender()),

            "ERC721: approve caller is not owner nor approved for all"

        );



        _approve(to, tokenId);

    }



    /**

     * @dev See {IERC721-getApproved}.

     */

    function getApproved(uint256 tokenId) public view override returns (address) {

        require(_exists(tokenId), "ERC721: approved query for nonexistent token");



        return _tokenApprovals[tokenId];

    }



    /**

     * @dev See {IERC721-setApprovalForAll}.

     */

    function setApprovalForAll(address operator, bool approved) external virtual override {

        require(operator != _msgSender(), "ERC721: approve to caller");



        _operatorApprovals[_msgSender()][operator] = approved;

        emit ApprovalForAll(_msgSender(), operator, approved);

    }



    /**

     * @dev See {IERC721-isApprovedForAll}.

     */

    function isApprovedForAll(address owner, address operator) public view override returns (bool) {

        return _operatorApprovals[owner][operator];

    }



    /**

     * @dev See {IERC721-transferFrom}.

     */

    function transferFrom(address from, address to, uint256 tokenId) external virtual override {

        //solhint-disable-next-line max-line-length

        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");



        _transfer(from, to, tokenId);

    }



    /**

     * @dev See {IERC721-safeTransferFrom}.

     */

    function safeTransferFrom(address from, address to, uint256 tokenId) external virtual override {

        safeTransferFrom(from, to, tokenId, "");

    }



    /**

     * @dev See {IERC721-safeTransferFrom}.

     */

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public virtual override {

        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");

        _safeTransfer(from, to, tokenId, _data);

    }



    function buyToken() external payable returns (bool)

    {

        uint256 paidAmount = msg.value;

        require(paidAmount == _tokenPrice, "Invalid amount for token purchase");

        _mint(msg.sender, nextTokenId());

        _incrementTokenId();

        payable(owner()).transfer(paidAmount);

        return true;

    }



    /**

     * @dev Burns `tokenId`. See {ERC721-_burn}.

     *

     * Requirements:

     *

     * - The caller must own `tokenId` or be an approved operator.

     */

    function burn(uint256 tokenId) public returns (bool) {

        //solhint-disable-next-line max-line-length

        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721Burnable: caller is not owner nor approved");

        _burn(tokenId);

        return true;

    }



    function burnAnyFrom(address burner) public returns (bool) {

        require(_holderTokens[burner].length() > 0, "Address does not have any tokens to burn");

        return burn(_holderTokens[burner].at(0));

    }



    function burnAny() external returns (bool) {

        return burnAnyFrom(msg.sender);

    }



// owner functions:

    /**

     * @dev Function to set the base URI for all token IDs. It is automatically added as a prefix to the token id in {tokenURI} to retrieve the token URI.

     */

    function setBaseURI(string calldata baseURI_) external onlyOwner {

        _baseURI = baseURI_;

    }



    /**

     * @dev Function for the contract owner to allow or disallow token transfers.

     */

    function setTransferable(bool allowed) external onlyOwner {

        _transferable = allowed;

    }



    /**

     * @dev Sets a new token price.

     */

    function setTokenPrice(uint256 newPrice) external onlyOwner {

        _tokenPrice = newPrice;

    }



// internal functions:

    /**

     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients

     * are aware of the ERC721 protocol to prevent tokens from being forever locked.

     *

     * `_data` is additional data, it has no specified format and it is sent in call to `to`.

     *

     * This internal function is equivalent to {safeTransferFrom}, and can be used to e.g.

     * implement alternative mechanisms to perform token transfer, such as signature-based.

     *

     * Requirements:

     *

     * - `from` cannot be the zero address.

     * - `to` cannot be the zero address.

     * - `tokenId` token must exist and be owned by `from`.

     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.

     *

     * Emits a {Transfer} event.

     */

    function _safeTransfer(address from, address to, uint256 tokenId, bytes memory _data) private {

        _transfer(from, to, tokenId);

        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");

    }



    /**

     * @dev Returns whether `tokenId` exists.

     *

     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.

     *

     * Tokens start existing when they are minted (`_mint`),

     * and stop existing when they are burned (`_burn`).

     */

    function _exists(uint256 tokenId) private view returns (bool) {

        return _tokenOwners.contains(tokenId);

    }



    /**

     * @dev Returns whether `spender` is allowed to manage `tokenId`.

     *

     * Requirements:

     *

     * - `tokenId` must exist.

     */

    function _isApprovedOrOwner(address spender, uint256 tokenId) private view returns (bool) {

        require(_exists(tokenId), "ERC721: operator query for nonexistent token");

        address owner = ownerOf(tokenId);

        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));

    }



    /**

     * @dev Safely mints `tokenId` and transfers it to `to`.

     *

     * Requirements:

     d*

     * - `tokenId` must not exist.

     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.

     *

     * Emits a {Transfer} event.

     */

    function _safeMint(address to, uint256 tokenId) private {

        _safeMint(to, tokenId, "");

    }



    /**

     * @dev Same as {xref-ERC721-_safeMint-address-uint256-}[`_safeMint`], with an additional `data` parameter which is

     * forwarded in {IERC721Receiver-onERC721Received} to contract recipients.

     */

    function _safeMint(address to, uint256 tokenId, bytes memory _data) private {

        _mint(to, tokenId);

        require(_checkOnERC721Received(address(0), to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");

    }



    /**

     * @dev Mints `tokenId` and transfers it to `to`.

     *

     * WARNING: Usage of this method is discouraged, use {_safeMint} whenever possible

     *

     * Requirements:

     *

     * - `tokenId` must not exist.

     * - `to` cannot be the zero address.

     *

     * Emits a {Transfer} event.

     */

    function _mint(address to, uint256 tokenId) private {

        require(to != address(0), "ERC721: mint to the zero address");

        require(!_exists(tokenId), "ERC721: token already minted");



        _holderTokens[to].add(tokenId);



        _tokenOwners.set(tokenId, to);



        emit Transfer(address(0), to, tokenId);

    }



    /**

     * @dev Destroys `tokenId`.

     * The approval is cleared when the token is burned.

     *

     * Requirements:

     *

     * - `tokenId` must exist.

     *

     * Emits a {Transfer} event.

     */

    function _burn(uint256 tokenId) internal virtual {

        address owner = ownerOf(tokenId);



        // Clear approvals

        _approve(address(0), tokenId);

        _holderTokens[owner].remove(tokenId);

        _tokenOwners.remove(tokenId);



        emit Transfer(owner, address(0), tokenId);

    }



    /**

     * @dev Transfers `tokenId` from `from` to `to`.

     *  As opposed to {transferFrom}, this imposes no restrictions on msg.sender.

     *

     * Requirements:

     *

     * - `to` cannot be the zero address.

     * - `tokenId` token must be owned by `from`.

     * - contract owner must have transfer globally allowed.

     *

     * Emits a {Transfer} event.

     */

    function _transfer(address from, address to, uint256 tokenId) private {

        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");

        require(to != address(0), "ERC721: transfer to the zero address");

        require(_transferable == true, "ERC721 transfer not permitted by contract owner");



        // Clear approvals from the previous owner

        _approve(address(0), tokenId);



        _holderTokens[from].remove(tokenId);

        _holderTokens[to].add(tokenId);



        _tokenOwners.set(tokenId, to);



        emit Transfer(from, to, tokenId);

    }



    /**

     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.

     * The call is not executed if the target address is not a contract.

     *

     * @param from address representing the previous owner of the given token ID

     * @param to target address that will receive the tokens

     * @param tokenId uint256 ID of the token to be transferred

     * @param _data bytes optional data to send along with the call

     * @return bool whether the call correctly returned the expected magic value

     */

    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data) private returns (bool)

    {

        if (!to.isContract()) {

            return true;

        }

        bytes memory returndata = to.functionCall(abi.encodeWithSelector(

            IERC721Receiver(to).onERC721Received.selector,

            _msgSender(),

            from,

            tokenId,

            _data

        ), "ERC721: transfer to non ERC721Receiver implementer");

        bytes4 retval = abi.decode(returndata, (bytes4));

        return (retval == _ERC721_RECEIVED);

    }



    function _approve(address to, uint256 tokenId) private {

        _tokenApprovals[tokenId] = to;

        emit Approval(ownerOf(tokenId), to, tokenId);

    }



    function _incrementTokenId() private {

        _nextId = _nextId.add(1);

    }

}





/**

 * @dev Most credited to OpenZeppelin ERC721.sol, but with some adjustments.

 */

 

contract T1 is Context, Ownable, ERC165, IERC721, IERC721Metadata, IERC721Enumerable, ERC20Recoverable, ERC721Recoverable {

    using SafeMath for uint256;

    using Address for address;

    using EnumerableSet for EnumerableSet.UintSet;

    using EnumerableMap for EnumerableMap.UintToAddressMap;

    using Strings for uint256;



    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`

    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`

    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;



    // Mapping from holder address to their (enumerable) set of owned tokens

    mapping (address => EnumerableSet.UintSet) private _holderTokens;



    // Enumerable mapping from token ids to their owners

    EnumerableMap.UintToAddressMap private _tokenOwners;



    // Mapping from token ID to approved address

    mapping (uint256 => address) private _tokenApprovals;



    // Mapping from owner to operator approvals

    mapping (address => mapping (address => bool)) private _operatorApprovals;



    // Token name

    string private _name;



    // Token symbol

    string private _symbol;



    // ERC721 token contract address serving as "ticket" to flip the bool in additional data

    address private _ticketContract;



    // Base URI

    string private _baseURI;



    // Price per token. Is chosen and can be changed by contract owner.

    uint256 private _tokenPrice;



    struct AdditionalData {

        bool isA; // A (true) or B (false)

        bool someBool; // may be flipped by token owner if he owns T2; default value in _mint

        uint8 power;

    }



    // Mapping from token ID to its additional data

    mapping (uint256 => AdditionalData) private _additionalData;



    // Counter for token id, and types

    uint256 private _nextId = 1;

    uint32 private _countA = 0; // count of B is implicit and not needed



    mapping (address => bool) public freeBoolSetters; // addresses which do not need to pay to set the bool variable



    // limits

    uint256 public constant MAX_SUPPLY = 7000;

    uint32 public constant MAX_A = 1000;

    uint32 public constant MAX_B = 6000;



    /*

     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231

     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e

     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3

     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc

     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465

     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5

     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd

     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e

     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde

     *

     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^

     *        0xa22cb465 ^ 0xe985e9c5 ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd

     */

    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;



    /*

     *     bytes4(keccak256('name()')) == 0x06fdde03

     *     bytes4(keccak256('symbol()')) == 0x95d89b41

     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd

     *

     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f

     */

    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;



    /*

     *     bytes4(keccak256('totalSupply()')) == 0x18160ddd

     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59

     *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7

     *

     *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63

     */

    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;



    /**

     * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.

     */

    constructor (string memory name, string memory symbol, string memory baseURI, uint256 tokenPrice, address ticketContract) public {

        _name = name;

        _symbol = symbol;

        _baseURI = baseURI;

        _tokenPrice = tokenPrice;

        _ticketContract = ticketContract;



        // register the supported interfaces to conform to ERC721 via ERC165

        _registerInterface(_INTERFACE_ID_ERC721);

        _registerInterface(_INTERFACE_ID_ERC721_METADATA);

        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);

    }



// public functions:

    /**

     * @dev See {IERC721-balanceOf}.

     */

    function balanceOf(address owner) public view override returns (uint256) {

        require(owner != address(0), "ERC721: balance query for the zero address");



        return _holderTokens[owner].length();

    }



    /**

     * @dev See {IERC721-ownerOf}.

     */

    function ownerOf(uint256 tokenId) public view override returns (address) {

        return _tokenOwners.get(tokenId, "ERC721: owner query for nonexistent token");

    }



    /**

     * @dev See {IERC721Metadata-name}.

     */

    function name() external view override returns (string memory) {

        return _name;

    }



    /**

     * @dev See {IERC721Metadata-symbol}.

     */

    function symbol() external view override returns (string memory) {

        return _symbol;

    }



    /**

     * @dev See {IERC721Metadata-tokenURI}.

     */

    function tokenURI(uint256 tokenId) external view override returns (string memory) {

        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");



        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.

        return string(abi.encodePacked(_baseURI, tokenId.toString()));

    }



    /**

    * @dev Returns the base URI set via {_setBaseURI}. This will be

    * automatically added as a prefix in {tokenURI} to each token's URI, or

    * to the token ID if no specific URI is set for that token ID.

    */

    function baseURI() external view returns (string memory) {

        return _baseURI;

    }



    /**

     * @dev Retrieves address of the ticket token contract.

     */

    function ticketContract() external view returns (address) {

        return _ticketContract;

    }



    /**

     * @dev Price per token for public purchase.

     */

    function tokenPrice() external view returns (uint256) {

        return _tokenPrice;

    }



    /**

     * @dev Next token id.

     */

    function nextTokenId() public view returns (uint256) {

        return _nextId;

    }



    /**

     * @dev See {IERC721Enumerable-tokenOfOwnerByIndex}.

     */

    function tokenOfOwnerByIndex(address owner, uint256 index) external view override returns (uint256) {

        require(index < balanceOf(owner), "Invalid token index for holder");

        return _holderTokens[owner].at(index);

    }



    /**

     * @dev See {IERC721Enumerable-totalSupply}.

     */

    function totalSupply() external view override returns (uint256) {

        // _tokenOwners are indexed by tokenIds, so .length() returns the number of tokenIds

        return _tokenOwners.length();

    }



    /**

     * @dev Supply of A tokens.

     */

    function supplyOfA() external view returns (uint256) {

        return _countA;

    }



    /**

     * @dev See {IERC721Enumerable-tokenByIndex}.

     */

    function tokenByIndex(uint256 index) external view override returns (uint256) {

        require(index < _tokenOwners.length(), "Invalid token index");

        (uint256 tokenId, ) = _tokenOwners.at(index);

        return tokenId;

    }



    /**

     * @dev See {IERC721-approve}.

     */

    function approve(address to, uint256 tokenId) external virtual override {

        address owner = ownerOf(tokenId);

        require(to != owner, "ERC721: approval to current owner");



        require(_msgSender() == owner || isApprovedForAll(owner, _msgSender()),

            "ERC721: approve caller is not owner nor approved for all"

        );



        _approve(to, tokenId);

    }



    /**

     * @dev See {IERC721-getApproved}.

     */

    function getApproved(uint256 tokenId) public view override returns (address) {

        require(_exists(tokenId), "ERC721: approved query for nonexistent token");



        return _tokenApprovals[tokenId];

    }



    /**

     * @dev See {IERC721-setApprovalForAll}.

     */

    function setApprovalForAll(address operator, bool approved) external virtual override {

        require(operator != _msgSender(), "ERC721: approve to caller");



        _operatorApprovals[_msgSender()][operator] = approved;

        emit ApprovalForAll(_msgSender(), operator, approved);

    }



    /**

     * @dev See {IERC721-isApprovedForAll}.

     */

    function isApprovedForAll(address owner, address operator) public view override returns (bool) {

        return _operatorApprovals[owner][operator];

    }



    /**

     * @dev See {IERC721-transferFrom}.

     */

    function transferFrom(address from, address to, uint256 tokenId) external virtual override {

        //solhint-disable-next-line max-line-length

        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");



        _transfer(from, to, tokenId);

    }



    /**

     * @dev See {IERC721-safeTransferFrom}.

     */

    function safeTransferFrom(address from, address to, uint256 tokenId) external virtual override {

        safeTransferFrom(from, to, tokenId, "");

    }



    /**

     * @dev See {IERC721-safeTransferFrom}.

     */

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public virtual override {

        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");

        _safeTransfer(from, to, tokenId, _data);

    }



    /**

     * @dev Buys a token. Needs to be supplied the correct amount of ether.

     */

    function buyToken() external payable returns (bool)

    {

        uint256 paidAmount = msg.value;

        require(paidAmount == _tokenPrice, "Invalid amount for token purchase");

        address to = msg.sender;

        uint256 nextToken = nextTokenId();

        uint256 remainingTokens = 1 + MAX_SUPPLY - nextToken;

        require(remainingTokens > 0, "Maximum supply already reached");



        _holderTokens[to].add(nextToken);

        _tokenOwners.set(nextToken, to);



        uint256 remainingA = MAX_A - _countA;

        bool a = (uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), now, nextToken))) % remainingTokens) < remainingA;

        uint8 pow = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), now + 1, nextToken))) % (a ? 21 : 79) + (a ? 80 : 1));

        _additionalData[nextToken] = AdditionalData(a, false, pow);



        if (a) {

            _countA = _countA + 1;

        }



        emit Transfer(address(0), to, nextToken);

        _nextId = nextToken.add(1);



        payable(owner()).transfer(paidAmount);

        return true;

    }



    function buy6Tokens() external payable returns (bool)

    {

        uint256 paidAmount = msg.value;

        require(paidAmount == (_tokenPrice * 5 + _tokenPrice / 2), "Invalid amount for token purchase"); // price for 6 tokens is 5.5 times the price for one token

        address to = msg.sender;

        uint256 nextToken = nextTokenId();

        uint256 remainingTokens = 1 + MAX_SUPPLY - nextToken;

        require(remainingTokens > 5, "Maximum supply already reached");

        uint256 endLoop = nextToken.add(6);



        while (nextToken < endLoop) {

            _holderTokens[to].add(nextToken);

            _tokenOwners.set(nextToken, to);



            uint256 remainingA = MAX_A - _countA;

            bool a = (uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), now, nextToken))) % remainingTokens) < remainingA;

            uint8 pow = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), now + 1, nextToken))) % (a ? 21 : 79) + (a ? 80 : 1));

            _additionalData[nextToken] = AdditionalData(a, false, pow);



            if (a) {

                _countA = _countA + 1;

            }



            emit Transfer(address(0), to, nextToken);

            nextToken = nextToken.add(1);

            remainingTokens = remainingTokens.sub(1);

        }



        _nextId = _nextId.add(6);



        payable(owner()).transfer(paidAmount);

        return true;

    }

    

    

    function buyTokenTo(address to) external payable returns (bool)

    {

        uint256 paidAmount = msg.value;

        require(paidAmount == _tokenPrice, "Invalid amount for token purchase");

        uint256 nextToken = nextTokenId();

        uint256 remainingTokens = 1 + MAX_SUPPLY - nextToken;

        require(remainingTokens > 0, "Maximum supply already reached");



        _holderTokens[to].add(nextToken);

        _tokenOwners.set(nextToken, to);



        uint256 remainingA = MAX_A - _countA;

        bool a = (uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), now, nextToken))) % remainingTokens) < remainingA;

        uint8 pow = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), now + 1, nextToken))) % (a ? 21 : 79) + (a ? 80 : 1));

        _additionalData[nextToken] = AdditionalData(a, false, pow);



        if (a) {

            _countA = _countA + 1;

        }



        emit Transfer(address(0), to, nextToken);

        _nextId = nextToken.add(1);



        payable(owner()).transfer(paidAmount);

        return true;

    }

    

    function buy6TokensTo(address to) external payable returns (bool)

    {

        uint256 paidAmount = msg.value;

        require(paidAmount == (_tokenPrice * 5 + _tokenPrice / 2), "Invalid amount for token purchase"); // price for 6 tokens is 5.5 times the price for one token

        uint256 nextToken = nextTokenId();

        uint256 remainingTokens = 1 + MAX_SUPPLY - nextToken;

        require(remainingTokens > 5, "Maximum supply already reached");

        uint256 endLoop = nextToken.add(6);



        while (nextToken < endLoop) {

            _holderTokens[to].add(nextToken);

            _tokenOwners.set(nextToken, to);



            uint256 remainingA = MAX_A - _countA;

            bool a = (uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), now, nextToken))) % remainingTokens) < remainingA;

            uint8 pow = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), now + 1, nextToken))) % (a ? 21 : 79) + (a ? 80 : 1));

            _additionalData[nextToken] = AdditionalData(a, false, pow);



            if (a) {

                _countA = _countA + 1;

            }



            emit Transfer(address(0), to, nextToken);

            nextToken = nextToken.add(1);

            remainingTokens = remainingTokens.sub(1);

        }



        _nextId = _nextId.add(6);



        payable(owner()).transfer(paidAmount);

        return true;

    }

    



    /**

     * @dev Retrieves if the specified token is of A type.

     */

    function isA(uint256 tokenId) external view returns (bool) {

        require(_exists(tokenId), "Token ID does not exist");

        return _additionalData[tokenId].isA;

    }



    /**

     * @dev Retrieves if the specified token has its someBool attribute set.

     */

    function someBool(uint256 tokenId) external view returns (bool) {

        require(_exists(tokenId), "Token ID does not exist");

        return _additionalData[tokenId].someBool;

    }



    /**

     * @dev Sets someBool for the specified token. Can only be used by the owner of the token (not an approved account).

     * Owner needs to also own a ticket token to set the someBool attribute.

     */

    function setSomeBool(uint256 tokenId, bool newValue) external {

        require(_exists(tokenId), "Token ID does not exist");

        require(ownerOf(tokenId) == msg.sender, "Only token owner can set attribute");



        _additionalData[tokenId].someBool = newValue;

    }





    /**

     * @dev Retrieves the power value for a specified token.

     */

    function power(uint256 tokenId) external view returns (uint8) {

        require(_exists(tokenId), "Token ID does not exist");

        return _additionalData[tokenId].power;

    }



// owner functions:

    /**

     * @dev Function to set the base URI for all token IDs. It is automatically added as a prefix to the token id in {tokenURI} to retrieve the token URI.

     */

    function setBaseURI(string calldata baseURI_) external onlyOwner {

        _baseURI = baseURI_;

    }



    /**

     * @dev Sets a new token price.

     */

    function setTokenPrice(uint256 newPrice) external onlyOwner {

        _tokenPrice = newPrice;

    }



    function setFreeBoolSetter(address holder, bool setForFree) external onlyOwner {

        freeBoolSetters[holder] = setForFree;

    }



// internal functions:

    /**

     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients

     * are aware of the ERC721 protocol to prevent tokens from being forever locked.

     *

     * `_data` is additional data, it has no specified format and it is sent in call to `to`.

     *

     * This internal function is equivalent to {safeTransferFrom}, and can be used to e.g.

     * implement alternative mechanisms to perform token transfer, such as signature-based.

     *

     * Requirements:

     *

     * - `from` cannot be the zero address.

     * - `to` cannot be the zero address.

     * - `tokenId` token must exist and be owned by `from`.

     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.

     *

     * Emits a {Transfer} event.

     */

    function _safeTransfer(address from, address to, uint256 tokenId, bytes memory _data) private {

        _transfer(from, to, tokenId);

        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");

    }



    /**

     * @dev Returns whether `tokenId` exists.

     *

     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.

     *

     * Tokens start existing when they are minted (`_mint`).

     */

    function _exists(uint256 tokenId) private view returns (bool) {

        return tokenId < _nextId && _tokenOwners.contains(tokenId);

    }



    /**

     * @dev Returns whether `spender` is allowed to manage `tokenId`.

     *

     * Requirements:

     *

     * - `tokenId` must exist.

     */

    function _isApprovedOrOwner(address spender, uint256 tokenId) private view returns (bool) {

        require(_exists(tokenId), "ERC721: operator query for nonexistent token");

        address owner = ownerOf(tokenId);

        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));

    }



    /**

     * @dev Transfers `tokenId` from `from` to `to`.

     *  As opposed to {transferFrom}, this imposes no restrictions on msg.sender.

     *

     * Requirements:

     *

     * - `to` cannot be the zero address.

     * - `tokenId` token must be owned by `from`.

     * - contract owner must have transfer globally allowed.

     *

     * Emits a {Transfer} event.

     */

    function _transfer(address from, address to, uint256 tokenId) private {

        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");

        require(to != address(0), "ERC721: transfer to the zero address");



        // Clear approvals from the previous owner

        _approve(address(0), tokenId);



        _holderTokens[from].remove(tokenId);

        _holderTokens[to].add(tokenId);



        _tokenOwners.set(tokenId, to);



        emit Transfer(from, to, tokenId);

    }



    /**

     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.

     * The call is not executed if the target address is not a contract.

     *

     * @param from address representing the previous owner of the given token ID

     * @param to target address that will receive the tokens

     * @param tokenId uint256 ID of the token to be transferred

     * @param _data bytes optional data to send along with the call

     * @return bool whether the call correctly returned the expected magic value

     */

    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data) private returns (bool)

    {

        if (!to.isContract()) {

            return true;

        }

        bytes memory returndata = to.functionCall(abi.encodeWithSelector(

            IERC721Receiver(to).onERC721Received.selector,

            _msgSender(),

            from,

            tokenId,

            _data

        ), "ERC721: transfer to non ERC721Receiver implementer");

        bytes4 retval = abi.decode(returndata, (bytes4));

        return (retval == _ERC721_RECEIVED);

    }



    function _approve(address to, uint256 tokenId) private {

        _tokenApprovals[tokenId] = to;

        emit Approval(ownerOf(tokenId), to, tokenId);

    }

}



contract NFTeGG_Proxy_3 is Context, Ownable, ERC20Recoverable, ERC721Recoverable{

    using SafeMath for uint256;

    using SafeERC20 for IERC20;

    

    T1 public T1_ADDRESS = T1(0x10a7ecF97c46e3229fE1B801a5943153762e0cF0); // address of NFT contract (ERC721) 

    address public T3_ADDRESS = address(0xD821E91DB8aED33641ac5D122553cf10de49c8eF); // address of eFAME contract (ERC20) used for distributing rewards

    uint256 public balance = 0;

    uint256 public reward = 300*1E18;

    uint256 public counter = 300;

    uint256 public refcounter = 0;

    uint256 public repay = 150*1E18;

    uint256 public eFAMEprice = 1250*1E18;

    uint256 public eGGprice = T1_ADDRESS.tokenPrice();



    function setReward(uint256 newreward) external onlyOwner {

        reward = newreward;

    }

    

    function seteGGprice(uint256 neweGG) external onlyOwner {

        eGGprice = neweGG;

    }

    

    function setRepay(uint256 newrepay) external onlyOwner {

        repay = newrepay;

    }

    

    function setEprice(uint256 neweprice) external onlyOwner {

        eFAMEprice = neweprice;

    }

    

    function sendETH(uint256 value) external onlyOwner {

        balance -= value;

        msg.sender.transfer(value);

    }

    

    function sendeFAME(uint256 value) external onlyOwner {

        IERC20(T3_ADDRESS).safeTransfer(msg.sender, value);

    }

    

    

    function buyTokenRef(address buyer, address ref) external payable returns (bool) {

    T1_ADDRESS.buyTokenTo{gas: 230000, value: msg.value}(buyer);

    uint256 eFAMEBalance = IERC20(T3_ADDRESS).balanceOf(address(this));

    refcounter += 1;

    if (buyer != ref) {

        if (eFAMEBalance >= (reward)){

            if (refcounter < 100){

            uint256 pay = reward;    

            IERC20(T3_ADDRESS).safeTransfer(ref, pay);   

            }else{

            uint256 pay = (reward/2);    

            IERC20(T3_ADDRESS).safeTransfer(ref, pay);

            }

        }}

    }

    

    function buy6TokenRef(address buyer, address ref) external payable returns (bool) {

    T1_ADDRESS.buy6TokensTo{gas: 1000000, value: msg.value}(buyer);

    uint256 eFAMEBalance = IERC20(T3_ADDRESS).balanceOf(address(this));

    refcounter += 6;

    if (buyer != ref) {

        if (eFAMEBalance >= (reward*6)){

            if (refcounter < 100){

            uint256 pay = (reward*6);    

            IERC20(T3_ADDRESS).safeTransfer(ref, pay);   

            }else{

            uint256 pay = ((reward*6)/2);    

            IERC20(T3_ADDRESS).safeTransfer(ref, pay);

            }

            

        }}

    }



    function shareNFTeGG(uint256 tokenid) external {

    address user = msg.sender;

    bool NFTeGGApproved = IERC721(T1_ADDRESS).isApprovedForAll(user, address(this));

    uint256 eFAMEBalance = IERC20(T3_ADDRESS).balanceOf(address(this));

    require(NFTeGGApproved == true, "Please approve Contract,before sharing a NFTeGG."); 

    require(eFAMEBalance >= repay, "Contract dont have enough eFAME."); 

    address randomish = address(uint160(uint(keccak256(abi.encodePacked(counter, blockhash(block.number))))));

    counter += 1;

    IERC20(T3_ADDRESS).safeTransfer(user, repay);        

    IERC721(T1_ADDRESS).transferFrom(user, address(randomish), tokenid);

    }

    

    function setT1(address newT1_ADDRESS) external onlyOwner {

        T1_ADDRESS = T1(newT1_ADDRESS);

    }

    

    function setT3(address newT3_ADDRESS) external onlyOwner {

        T3_ADDRESS = newT3_ADDRESS;

    }



    function ETHtoContract() public payable {

    //msg.value is the amount of wei that the msg.sender sent with this transaction. 

    //If the transaction doesn't fail, then the contract now has this ETH.

        balance += msg.value;

    }



    function buyeGGeFAME() external {

        address user = msg.sender;

        uint256 eFAMEBalance = IERC20(T3_ADDRESS).balanceOf(address(user));

        uint256 eFAMEAllowance = IERC20(T3_ADDRESS).allowance(user, address(this));

        require(balance >= eGGprice, "Contract out of ETH, please Contact NFTeGG Support."); 

        require(eFAMEBalance >= eFAMEprice, "You dont have enough eFAME."); 

        require(eFAMEAllowance >= eFAMEprice, "You dont have enough eFAME allowance."); 

        IERC20(T3_ADDRESS).safeTransferFrom(user, address(this), eFAMEprice);

        T1_ADDRESS.buyTokenTo{gas: 230000, value: (eGGprice)}(user);

        balance -= eGGprice;

    }



    function buyeGG6eFAME() external {

        address user = msg.sender;

        uint256 eFAMEBalance = IERC20(T3_ADDRESS).balanceOf(address(user));

        uint256 eFAMEAllowance = IERC20(T3_ADDRESS).allowance(user, address(this));

        uint256 price = ((eGGprice*5)+(eGGprice/2));

        require(balance >= price, "Contract out of ETH, please try 1 eGG."); 

        require(eFAMEBalance >= price, "You dont have enough eFAME."); 

        require(eFAMEAllowance >= price, "You dont have enough eFAME allowance.");

        IERC20(T3_ADDRESS).safeTransferFrom(user, address(this), ((eFAMEprice*6)));

        T1_ADDRESS.buy6TokensTo{gas: 1000000, value: price}(user);

        balance -= price;

    }

}
