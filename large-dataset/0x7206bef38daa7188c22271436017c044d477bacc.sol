// SPDX-License-Identifier: MIT

pragma solidity 0.6.10;



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



interface ILoanToken is IERC20 {

    enum Status {Awaiting, Funded, Withdrawn, Settled, Defaulted}



    function borrower() external view returns (address);



    function amount() external view returns (uint256);



    function term() external view returns (uint256);



    function apy() external view returns (uint256);



    function start() external view returns (uint256);



    function lender() external view returns (address);



    function debt() external view returns (uint256);



    function profit() external view returns (uint256);



    function status() external view returns (Status);



    function borrowerFee() external view returns (uint256);



    function receivedAmount() external view returns (uint256);



    function isLoanToken() external pure returns (bool);



    function getParameters()

        external

        view

        returns (

            uint256,

            uint256,

            uint256

        );



    function fund() external;



    function withdraw(address _beneficiary) external;



    function close() external;



    function redeem(uint256 _amount) external;



    function repay(address _sender, uint256 _amount) external;



    function allowTransfer(address account, bool _status) external;



    function repaid() external view returns (uint256);



    function balance() external view returns (uint256);



    function value(uint256 _balance) external view returns (uint256);

}



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





abstract contract Context {

    function _msgSender() internal view virtual returns (address payable) {

        return msg.sender;

    }



    function _msgData() internal view virtual returns (bytes memory) {

        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691

        return msg.data;

    }

}

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

    using Address for address;



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

    constructor (string memory name, string memory symbol) public {

        _name = name;

        _symbol = symbol;

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

     * required by the EIP. See the note at the beginning of {ERC20};

     *

     * Requirements:

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

     * Requirements

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

     * Requirements

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

 * @title LoanToken

 * @dev A token which represents share of a debt obligation

 *

 * Each LoanToken has:

 * - borrower address

 * - borrow amount

 * - loan term

 * - loan APY

 *

 * Loan progresses through the following states:

 * Awaiting:    Waiting for funding to meet capital requirements

 * Funded:      Capital requireme`nts met, borrower can withdraw

 * Withdrawn:   Borrower withdraws money, loan waiting to be repaid

 * Settled:     Loan has been paid back in full with interest

 * Defaulted:   Loan has not been paid back in full

 *

 * - LoanTokens are non-transferrable except for whitelisted addresses

 * - This version of LoanToken only supports a single funder

 */

contract LoanToken is ILoanToken, ERC20 {

    using SafeMath for uint256;



    address public override borrower;

    uint256 public override amount;

    uint256 public override term;

    uint256 public override apy;



    uint256 public override start;

    address public override lender;

    uint256 public override debt;



    uint256 public redeemed;



    // borrow fee -> 100 = 1%

    uint256 public override borrowerFee = 25;



    // whitelist for transfers

    mapping(address => bool) public canTransfer;



    Status public override status;



    IERC20 public currencyToken;



    /**

     * @dev Emitted when the loan is funded

     * @param lender Address which funded the loan

     */

    event Funded(address lender);



    /**

     * @dev Emitted when transfer whitelist is updated

     * @param account Account to whitelist for transfers

     * @param status New whitelist status

     */

    event TransferAllowanceChanged(address account, bool status);



    /**

     * @dev Emitted when borrower withdraws funds

     * @param beneficiary Account which will receive funds

     */

    event Withdrawn(address beneficiary);



    /**

     * @dev Emitted when term is over

     * @param status Final loan status

     * @param returnedAmount Amount that was retured before expiry

     */

    event Closed(Status status, uint256 returnedAmount);



    /**

     * @dev Emitted when a LoanToken is redeemed for underlying currencyTokens

     * @param receiver Receiver of currencyTokens

     * @param burnedAmount Amount of LoanTokens burned

     * @param redeemedAmound Amount of currencyToken received

     */

    event Redeemed(address receiver, uint256 burnedAmount, uint256 redeemedAmound);



    /**

     * @dev Create a Loan

     * @param _currencyToken Token to lend

     * @param _borrower Borrwer addresss

     * @param _amount Borrow amount of currency tokens

     * @param _term Loan length

     * @param _apy Loan APY

     */

    constructor(

        IERC20 _currencyToken,

        address _borrower,

        uint256 _amount,

        uint256 _term,

        uint256 _apy

    ) public ERC20("Loan Token", "LOAN") {

        currencyToken = _currencyToken;

        borrower = _borrower;

        amount = _amount;

        term = _term;

        apy = _apy;

        debt = interest(amount);

    }



    /**

     * @dev Only borrwer can withdraw & repay loan

     */

    modifier onlyBorrower() {

        require(msg.sender == borrower, "LoanToken: Caller is not the borrower");

        _;

    }



    /**

     * @dev Only when loan is Settled

     */

    modifier onlyClosed() {

        require(status == Status.Settled || status == Status.Defaulted, "LoanToken: Current status should be Settled or Defaulted");

        _;

    }



    /**

     * @dev Only when loan is Funded

     */

    modifier onlyOngoing() {

        require(status == Status.Funded || status == Status.Withdrawn, "LoanToken: Current status should be Funded or Withdrawn");

        _;

    }



    /**

     * @dev Only when loan is Funded

     */

    modifier onlyFunded() {

        require(status == Status.Funded, "LoanToken: Current status should be Funded");

        _;

    }



    /**

     * @dev Only when loan is Withdrawn

     */

    modifier onlyAfterWithdraw() {

        require(status >= Status.Withdrawn, "LoanToken: Only after loan has been withdrawn");

        _;

    }



    /**

     * @dev Only when loan is Awaiting

     */

    modifier onlyAwaiting() {

        require(status == Status.Awaiting, "LoanToken: Current status should be Awaiting");

        _;

    }



    /**

     * @dev Only whitelisted accounts or lender

     */

    modifier onlyWhoCanTransfer(address sender) {

        require(

            sender == lender || canTransfer[sender],

            "LoanToken: This can be performed only by lender or accounts allowed to transfer"

        );

        _;

    }



    /**

     * @dev Only lender can perform certain actions

     */

    modifier onlyLender() {

        require(msg.sender == lender, "LoanToken: This can be performed only by lender");

        _;

    }



    /**

     * @dev Return true if this contract is a LoanToken

     * @return True if this contract is a LoanToken

     */

    function isLoanToken() external override pure returns (bool) {

        return true;

    }



    /**

     * @dev Get loan parameters

     * @return amount, term, apy

     */

    function getParameters()

        external

        override

        view

        returns (

            uint256,

            uint256,

            uint256

        )

    {

        return (amount, apy, term);

    }



    /**

     * @dev Get coupon value of this loan token in currencyToken

     * This assumes the loan will be paid back on time, with interest

     * @param _balance number of LoanTokens to get value for

     * @return coupon value of _balance LoanTokens in currencyTokens

     */

    function value(uint256 _balance) external override view returns (uint256) {

        if (_balance == 0) {

            return 0;

        }



        uint256 passed = block.timestamp.sub(start);

        if (passed > term) {

            passed = term;

        }



        uint256 helper = amount.mul(apy).mul(passed).mul(_balance);

        // assume month is 30 days

        uint256 interest = helper.div(360 days).div(10000).div(totalSupply());



        return amount.add(interest);

    }



    /**

     * @dev Fund a loan

     * Set status, start time, lender

     */

    function fund() external override onlyAwaiting {

        status = Status.Funded;

        start = block.timestamp;

        lender = msg.sender;

        _mint(msg.sender, debt);

        require(currencyToken.transferFrom(msg.sender, address(this), receivedAmount()));



        emit Funded(msg.sender);

    }



    /**

     * @dev Whitelist accounts to transfer

     * @param account address to allow transfers for

     * @param _status true allows transfers, false disables transfers

     */

    function allowTransfer(address account, bool _status) external override onlyLender {

        canTransfer[account] = _status;

        emit TransferAllowanceChanged(account, _status);

    }



    /**

     * @dev Borrower calls this function to withdraw funds

     * Sets the status of the loan to Withdrawn

     * @param _beneficiary address to send funds to

     */

    function withdraw(address _beneficiary) external override onlyBorrower onlyFunded {

        status = Status.Withdrawn;

        require(currencyToken.transfer(_beneficiary, receivedAmount()));



        emit Withdrawn(_beneficiary);

    }



    /**

     * @dev Close the loan and check if it has been repaid

     */

    function close() external override onlyOngoing {

        require(start.add(term) <= block.timestamp, "LoanToken: Loan cannot be closed yet");

        if (_balance() >= debt) {

            status = Status.Settled;

        } else {

            status = Status.Defaulted;

        }



        emit Closed(status, _balance());

    }



    /**

     * @dev Redeem LoanToken balances for underlying currencyToken

     * Can only call this function after the loan is Closed

     * @param _amount amount to redeem

     */

    function redeem(uint256 _amount) external override onlyClosed {

        uint256 amountToReturn = _amount.mul(_balance()).div(totalSupply());

        redeemed = redeemed.add(amountToReturn);

        _burn(msg.sender, _amount);

        require(currencyToken.transfer(msg.sender, amountToReturn));



        emit Redeemed(msg.sender, _amount, amountToReturn);

    }



    /**

     * @dev Function for borrower to repay the loan

     * Borrower can repay at any time

     * @param _sender account sending currencyToken to repay

     * @param _amount amount of currencyToken to repay

     */

    function repay(address _sender, uint256 _amount) external override onlyAfterWithdraw {

        require(currencyToken.transferFrom(_sender, address(this), _amount));

    }



    /**

     * @dev Check if loan has been repaid

     * @return Boolean representing whether the loan has been repaid or not

     */

    function repaid() external override view onlyAfterWithdraw returns (uint256) {

        return _balance().add(redeemed);

    }



    /**

     * @dev Public currency token balance function

     * @return currencyToken balance of this contract

     */

    function balance() external override view returns (uint256) {

        return _balance();

    }



    /**

     * @dev Get currency token balance for this contract

     * @return currencyToken balance of this contract

     */

    function _balance() internal view returns (uint256) {

        return currencyToken.balanceOf(address(this));

    }



    /**

     * @dev Calculate amount borrowed minus fee

     * @return Amount minus fees

     */

    function receivedAmount() public override view returns (uint256) {

        return amount.sub(amount.mul(borrowerFee).div(10000));

    }



    /**

     * @dev Calculate interest that will be paid by this loan for an amount

     * (amount * apy * term) / (360 days / precision)

     * @param _amount amount

     * @return uint256 Amount of interest paid for _amount

     */

    function interest(uint256 _amount) internal view returns (uint256) {

        return _amount.add(_amount.mul(apy).mul(term).div(360 days).div(10000));

    }



    /**

     * @dev get profit for this loan

     * @return profit for this loan

     */

    function profit() external override view returns (uint256) {

        return debt.sub(amount);

    }



    /**

     * @dev Override ERC20 _transfer so only whitelisted addresses can transfer

     * @param sender sender of the transaction

     * @param recipient recipient of the transaction

     * @param _amount amount to send

     */

    function _transfer(

        address sender,

        address recipient,

        uint256 _amount

    ) internal override onlyWhoCanTransfer(sender) {

        return super._transfer(sender, recipient, _amount);

    }

}
