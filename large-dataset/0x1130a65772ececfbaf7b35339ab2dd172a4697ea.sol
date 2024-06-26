pragma solidity 0.5.16;





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





/**

 * @title Initializable

 *

 * @dev Helper contract to support initializer functions. To use it, replace

 * the constructor with a function that has the `initializer` modifier.

 * WARNING: Unlike constructors, initializer functions must be manually

 * invoked. This applies both to deploying an Initializable contract, as well

 * as extending an Initializable contract via inheritance.

 * WARNING: When used with inheritance, manual care must be taken to not invoke

 * a parent initializer twice, or ensure that all initializers are idempotent,

 * because this is not dealt with automatically as with constructors.

 */

contract Initializable {



  /**

   * @dev Indicates that the contract has been initialized.

   */

  bool private initialized;



  /**

   * @dev Indicates that the contract is in the process of being initialized.

   */

  bool private initializing;



  /**

   * @dev Modifier to use in the initializer function of a contract.

   */

  modifier initializer() {

    require(initializing || isConstructor() || !initialized, "Contract instance has already been initialized");



    bool isTopLevelCall = !initializing;

    if (isTopLevelCall) {

      initializing = true;

      initialized = true;

    }



    _;



    if (isTopLevelCall) {

      initializing = false;

    }

  }



  /// @dev Returns true if and only if the function is running in the constructor

  function isConstructor() private view returns (bool) {

    // extcodesize checks the size of the code stored in an address, and

    // address returns the current address. Since the code is still not

    // deployed when running a constructor, any checks on its code size will

    // yield zero, making it an effective way to detect if a contract is

    // under construction or not.

    address self = address(this);

    uint256 cs;

    assembly { cs := extcodesize(self) }

    return cs == 0;

  }



  // Reserved storage space to allow for layout changes in the future.

  uint256[50] private ______gap;

}





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

contract Context is Initializable {

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





contract PauserRole is Initializable, Context {

    using Roles for Roles.Role;



    event PauserAdded(address indexed account);

    event PauserRemoved(address indexed account);



    Roles.Role private _pausers;



    function initialize(address sender) public initializer {

        if (!isPauser(sender)) {

            _addPauser(sender);

        }

    }



    modifier onlyPauser() {

        require(isPauser(_msgSender()), "PauserRole: caller does not have the Pauser role");

        _;

    }



    function isPauser(address account) public view returns (bool) {

        return _pausers.has(account);

    }



    function addPauser(address account) public onlyPauser {

        _addPauser(account);

    }



    function renouncePauser() public {

        _removePauser(_msgSender());

    }



    function _addPauser(address account) internal {

        _pausers.add(account);

        emit PauserAdded(account);

    }



    function _removePauser(address account) internal {

        _pausers.remove(account);

        emit PauserRemoved(account);

    }



    uint256[50] private ______gap;

}





/**

 * @dev Contract module which allows children to implement an emergency stop

 * mechanism that can be triggered by an authorized account.

 *

 * This module is used through inheritance. It will make available the

 * modifiers `whenNotPaused` and `whenPaused`, which can be applied to

 * the functions of your contract. Note that they will not be pausable by

 * simply including this module, only once the modifiers are put in place.

 */

contract Pausable is Initializable, Context, PauserRole {

    /**

     * @dev Emitted when the pause is triggered by a pauser (`account`).

     */

    event Paused(address account);



    /**

     * @dev Emitted when the pause is lifted by a pauser (`account`).

     */

    event Unpaused(address account);



    bool private _paused;



    /**

     * @dev Initializes the contract in unpaused state. Assigns the Pauser role

     * to the deployer.

     */

    function initialize(address sender) public initializer {

        PauserRole.initialize(sender);



        _paused = false;

    }



    /**

     * @dev Returns true if the contract is paused, and false otherwise.

     */

    function paused() public view returns (bool) {

        return _paused;

    }



    /**

     * @dev Modifier to make a function callable only when the contract is not paused.

     */

    modifier whenNotPaused() {

        require(!_paused, "Pausable: paused");

        _;

    }



    /**

     * @dev Modifier to make a function callable only when the contract is paused.

     */

    modifier whenPaused() {

        require(_paused, "Pausable: not paused");

        _;

    }



    /**

     * @dev Called by a pauser to pause, triggers stopped state.

     */

    function pause() public onlyPauser whenNotPaused {

        _paused = true;

        emit Paused(_msgSender());

    }



    /**

     * @dev Called by a pauser to unpause, returns to normal state.

     */

    function unpause() public onlyPauser whenPaused {

        _paused = false;

        emit Unpaused(_msgSender());

    }



    uint256[50] private ______gap;

}





/**

 * @dev Contract module which provides a basic access control mechanism, where

 * there is an account (an owner) that can be granted exclusive access to

 * specific functions.

 *

 * This module is used through inheritance. It will make available the modifier

 * `onlyOwner`, which can be aplied to your functions to restrict their use to

 * the owner.

 */

contract Ownable is Initializable, Context {

    address private _owner;



    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);



    /**

     * @dev Initializes the contract setting the deployer as the initial owner.

     */

    function initialize(address sender) public initializer {

        _owner = sender;

        emit OwnershipTransferred(address(0), _owner);

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

     * > Note: Renouncing ownership will leave the contract without an owner,

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



    uint256[50] private ______gap;

}





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

 */

contract ReentrancyGuard is Initializable {

    // counter to allow mutex lock with only one SSTORE operation

    uint256 private _guardCounter;



    function initialize() public initializer {

        // The counter starts at one to prevent changing it from zero to a non-zero

        // value, which is a more expensive operation.

        _guardCounter = 1;

    }



    /**

     * @dev Prevents a contract from calling itself, directly or indirectly.

     * Calling a `nonReentrant` function from another `nonReentrant`

     * function is not supported. It is possible to prevent this from happening

     * by making the `nonReentrant` function external, and make it call a

     * `private` function that does the actual work.

     */

    modifier nonReentrant() {

        _guardCounter += 1;

        uint256 localCounter = _guardCounter;

        _;

        require(localCounter == _guardCounter, "ReentrancyGuard: reentrant call");

    }



    uint256[50] private ______gap;

}





interface IUniswapV2Router01 {

    function factory() external pure returns (address);



    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);

    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);

    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);

    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);

    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);



    function WETH() external view returns (address);



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

}





library BasisPoints {

    using SafeMath for uint;



    uint constant private BASIS_POINTS = 10000;



    function mulBP(uint amt, uint bp) internal pure returns (uint) {

        if (amt == 0) return 0;

        return amt.mul(bp).div(BASIS_POINTS);

    }



    function divBP(uint amt, uint bp) internal pure returns (uint) {

        require(bp > 0, "Cannot divide by zero.");

        if (amt == 0) return 0;

        return amt.mul(BASIS_POINTS).div(bp);

    }



    function addBP(uint amt, uint bp) internal pure returns (uint) {

        if (amt == 0) return 0;

        if (bp == 0) return amt;

        return amt.add(mulBP(amt, bp));

    }



    function subBP(uint amt, uint bp) internal pure returns (uint) {

        if (amt == 0) return 0;

        if (bp == 0) return amt;

        return amt.sub(mulBP(amt, bp));

    }

}





contract LidSimplifiedPresaleTimer is Initializable, Ownable {

    using SafeMath for uint;



    uint public startTime;

    uint public endTime;

    uint public hardCapTimer;

    uint public softCap;

    address public presale;



    function initialize(

        uint _startTime,

        uint _hardCapTimer,

        uint _softCap,

        address _presale,

        address owner

    ) external initializer {

        Ownable.initialize(msg.sender);

        startTime = _startTime;

        hardCapTimer = _hardCapTimer;

        softCap = _softCap;

        presale = _presale;

        //Due to issue in oz testing suite, the msg.sender might not be owner

        _transferOwnership(owner);

    }



    function setStartTime(uint time) external onlyOwner {

        startTime = time;

    }



    function setEndTime(uint time) external onlyOwner {

        endTime = time;

    }



    function updateEndTime() external returns (uint) {

        if (endTime != 0) return endTime;

        if (presale.balance >= softCap) {

            endTime = now.add(hardCapTimer);

            return endTime;

        }

        return 0;

    }



    function isStarted() external view returns (bool) {

        return (startTime != 0 && now > startTime);

    }



}





contract LidSimplifiedPresaleRedeemer is Initializable, Ownable {

    using BasisPoints for uint;

    using SafeMath for uint;



    uint public redeemBP;

    uint public redeemInterval;



    uint[] public bonusRangeStart;

    uint[] public bonusRangeBP;

    uint public currentBonusIndex;



    uint public totalShares;

    uint public totalDepositors;

    mapping(address => uint) public accountDeposits;

    mapping(address => uint) public accountShares;

    mapping(address => uint) public accountClaimedTokens;



    address private presale;



    modifier onlyPresaleContract {

        require(msg.sender == presale, "Only callable by presale contract.");

        _;

    }



    function initialize(

        uint _redeemBP,

        uint _redeemInterval,

        uint[] calldata _bonusRangeStart,

        uint[] calldata _bonusRangeBP,

        address _presale,

        address owner

    ) external initializer {

        Ownable.initialize(msg.sender);



        redeemBP = _redeemBP;

        redeemInterval = _redeemInterval;

        presale = _presale;



        require(

            _bonusRangeStart.length == _bonusRangeBP.length,

            "Must have equal values for bonus range start and BP"

        );

        require(_bonusRangeStart.length <= 10, "Cannot have more than 10 items in bonusRange");

        for (uint i = 0; i < _bonusRangeStart.length; ++i) {

            bonusRangeStart.push(_bonusRangeStart[i]);

        }

        for (uint i = 0; i < _bonusRangeBP.length; ++i) {

            bonusRangeBP.push(_bonusRangeBP[i]);

        }



        //Due to issue in oz testing suite, the msg.sender might not be owner

        _transferOwnership(owner);

    }



    function setClaimed(address account, uint amount) external onlyPresaleContract {

        accountClaimedTokens[account] = accountClaimedTokens[account].add(amount);

    }



    function setDeposit(address account, uint deposit, uint postDepositEth) external onlyPresaleContract {

        if (accountDeposits[account] == 0) totalDepositors = totalDepositors.add(1);

        accountDeposits[account] = accountDeposits[account].add(deposit);

        uint sharesToAdd;

        if (currentBonusIndex.add(1) >= bonusRangeBP.length) {

            //final bonus rate

            sharesToAdd = deposit.addBP(bonusRangeBP[currentBonusIndex]);

        } else if (postDepositEth < bonusRangeStart[currentBonusIndex.add(1)]) {

            //Purchase doesnt push to next start

            sharesToAdd = deposit.addBP(bonusRangeBP[currentBonusIndex]);

        } else {

            //purchase straddles next start

            uint previousBonusBP = bonusRangeBP[currentBonusIndex];

            uint newBonusBP = bonusRangeBP[currentBonusIndex.add(1)];

            uint newBonusDeposit = postDepositEth.sub(bonusRangeStart[currentBonusIndex.add(1)]);

            uint previousBonusDeposit = deposit.sub(newBonusDeposit);

            sharesToAdd = newBonusDeposit.addBP(newBonusBP).add(

                previousBonusDeposit.addBP(previousBonusBP));

            currentBonusIndex = currentBonusIndex.add(1);

        }

        accountShares[account] = accountShares[account].add(sharesToAdd);

        totalShares = totalShares.add(sharesToAdd);

    }



    function calculateRatePerEth(uint totalPresaleTokens, uint depositEth, uint hardCap) external view returns (uint) {



        uint tokensPerEtherShare = totalPresaleTokens

        .mul(1 ether)

        .div(

            getMaxShares(hardCap)

        );



        uint bp;

        if (depositEth >= bonusRangeStart[bonusRangeStart.length.sub(1)]) {

            bp = bonusRangeBP[bonusRangeBP.length.sub(1)];

        } else {

            for (uint i = 1; i < bonusRangeStart.length; ++i) {

                if (bp == 0) {

                    if (depositEth < bonusRangeStart[i]) {

                        bp = bonusRangeBP[i.sub(1)];

                    }

                }

            }

        }

        return tokensPerEtherShare.addBP(bp);

    }



    function calculateReedemable(

        address account,

        uint finalEndTime,

        uint totalPresaleTokens

    ) external view returns (uint) {

        if (finalEndTime == 0) return 0;

        if (finalEndTime >= now) return 0;

        uint earnedTokens = accountShares[account].mul(totalPresaleTokens).div(totalShares);

        uint claimedTokens = accountClaimedTokens[account];

        uint cycles = now.sub(finalEndTime).div(redeemInterval).add(1);

        uint totalRedeemable = earnedTokens.mulBP(redeemBP).mul(cycles);

        uint claimable;

        if (totalRedeemable >= earnedTokens) {

            claimable = earnedTokens.sub(claimedTokens);

        } else {

            claimable = totalRedeemable.sub(claimedTokens);

        }

        return claimable;

    }



    function getMaxShares(uint hardCap) public view returns (uint) {

        uint maxShares;

        for (uint i = 0; i < bonusRangeStart.length; ++i) {

            uint amt;

            if (i < bonusRangeStart.length.sub(1)) {

                amt = bonusRangeStart[i.add(1)].sub(bonusRangeStart[i]);

            } else {

                amt = hardCap.sub(bonusRangeStart[i]);

            }

            maxShares = maxShares.add(amt.addBP(bonusRangeBP[i]));

        }

        return maxShares;

    }

}





contract LidSimplifiedPresale is Initializable, Ownable, ReentrancyGuard, Pausable {

    using BasisPoints for uint;

    using SafeMath for uint;



    uint public maxBuyPerAddress;

    uint public maxBuyWithoutWhitelisting;



    uint public referralBP;



    uint public uniswapEthBP;

    uint public lidEthBP;



    uint public uniswapTokenBP;

    uint public presaleTokenBP;

    address[] public tokenPools;

    uint[] public tokenPoolBPs;



    uint public hardcap;

    uint public totalTokens;



    bool public hasSentToUniswap;

    bool public hasIssuedTokens;



    uint public finalEndTime;

    uint public finalEth;



    IERC20 private token;

    IUniswapV2Router01 private uniswapRouter;

    LidSimplifiedPresaleTimer private timer;

    LidSimplifiedPresaleRedeemer private redeemer;

    address payable private lidFund;



    mapping(address => uint) public accountEthDeposit;

    mapping(address => bool) public whitelist;

    mapping(address => uint) public earnedReferrals;



    mapping(address => uint) public referralCounts;



    modifier whenPresaleActive {

        require(timer.isStarted(), "Presale not yet started.");

        require(!isPresaleEnded(), "Presale has ended.");

        _;

    }



    modifier whenPresaleFinished {

        require(timer.isStarted(), "Presale not yet started.");

        require(isPresaleEnded(), "Presale has not yet ended.");

        _;

    }



    function initialize(

        uint _maxBuyPerAddress,

        uint _maxBuyWithoutWhitelisting,

        uint _uniswapEthBP,

        uint _lidEthBP,

        uint _referralBP,

        uint _hardcap,

        address owner,

        LidSimplifiedPresaleTimer _timer,

        LidSimplifiedPresaleRedeemer _redeemer,

        IERC20 _token,

        IUniswapV2Router01 _uniswapRouter,

        address payable _lidFund

    ) external initializer {

        Ownable.initialize(msg.sender);

        Pausable.initialize(msg.sender);

        ReentrancyGuard.initialize();



        token = _token;

        timer = _timer;

        redeemer = _redeemer;

        lidFund = _lidFund;



        maxBuyPerAddress = _maxBuyPerAddress;

        maxBuyWithoutWhitelisting = _maxBuyWithoutWhitelisting;



        uniswapEthBP = _uniswapEthBP;

        lidEthBP = _lidEthBP;



        referralBP = _referralBP;

        hardcap = _hardcap;



        uniswapRouter = _uniswapRouter;

        totalTokens = token.totalSupply();

        token.approve(address(uniswapRouter), token.totalSupply());



        //Due to issue in oz testing suite, the msg.sender might not be owner

        _transferOwnership(owner);

    }



    function deposit() external payable whenNotPaused {

        deposit(address(0x0));

    }



    function setTokenPools(

        uint _uniswapTokenBP,

        uint _presaleTokenBP,

        address[] calldata _tokenPools,

        uint[] calldata _tokenPoolBPs

    ) external onlyOwner whenNotPaused {

        require(_tokenPools.length == _tokenPoolBPs.length, "Must have exactly one tokenPool addresses for each BP.");

        delete tokenPools;

        delete tokenPoolBPs;

        uniswapTokenBP = _uniswapTokenBP;

        presaleTokenBP = _presaleTokenBP;

        for (uint i = 0; i < _tokenPools.length; ++i) {

            tokenPools.push(_tokenPools[i]);

        }

        uint totalTokenPoolBPs = uniswapTokenBP.add(presaleTokenBP);

        for (uint i = 0; i < _tokenPoolBPs.length; ++i) {

            tokenPoolBPs.push(_tokenPoolBPs[i]);

            totalTokenPoolBPs = totalTokenPoolBPs.add(_tokenPoolBPs[i]);

        }

        require(totalTokenPoolBPs == 10000, "Must allocate exactly 100% (10000 BP) of tokens to pools");

    }



    function sendToUniswap() external whenPresaleFinished nonReentrant whenNotPaused {

        require(tokenPools.length > 0, "Must have set token pools");

        require(!hasSentToUniswap, "Has already sent to Uniswap.");

        finalEndTime = now;

        finalEth = address(this).balance;

        hasSentToUniswap = true;

        uint uniswapTokens = totalTokens.mulBP(uniswapTokenBP);

        uint uniswapEth = finalEth.mulBP(uniswapEthBP);

        uniswapRouter.addLiquidityETH.value(uniswapEth)(

            address(token),

            uniswapTokens,

            uniswapTokens,

            uniswapEth,

            address(0x000000000000000000000000000000000000dEaD),

            now

        );

    }



    function issueTokens() external whenPresaleFinished whenNotPaused {

        require(hasSentToUniswap, "Has not yet sent to Uniswap.");

        require(!hasIssuedTokens, "Has already issued tokens.");

        hasIssuedTokens = true;

        for (uint i = 0; i < tokenPools.length; ++i) {

            token.transfer(

                tokenPools[i],

                totalTokens.mulBP(tokenPoolBPs[i])

            );

        }

    }



    function releaseEthToAddress(address payable receiver, uint amount) external onlyOwner whenNotPaused returns(uint) {

        require(hasSentToUniswap, "Has not yet sent to Uniswap.");

        receiver.transfer(amount);

    }



    function setWhitelist(address account, bool value) external onlyOwner whenNotPaused {

        whitelist[account] = value;

    }



    function setWhitelistForAll(address[] calldata account, bool value) external onlyOwner whenNotPaused {

        for (uint i=0; i < account.length; i++) {

            whitelist[account[i]] = value;

        }

    }



    function redeem() external whenPresaleFinished whenNotPaused {

        require(hasSentToUniswap, "Must have sent to Uniswap before any redeems.");

        uint claimable = redeemer.calculateReedemable(msg.sender, finalEndTime, totalTokens.mulBP(presaleTokenBP));

        redeemer.setClaimed(msg.sender, claimable);

        token.transfer(msg.sender, claimable);

    }



    function deposit(address payable referrer) public payable whenPresaleActive nonReentrant whenNotPaused {

        uint endTime = timer.updateEndTime();

        require(endTime == 0 || endTime >= now, "Endtime past.");

        require(msg.sender != referrer, "Sender cannot be referrer.");

        uint accountCurrentDeposit = redeemer.accountDeposits(msg.sender);

        uint fee = msg.value.mulBP(referralBP);

        //Remove fee in case final purchase needed to end sale without dust errors

        if (msg.value < 0.01 ether) fee = 0;

        if (whitelist[msg.sender]) {

            require(

                accountCurrentDeposit.add(msg.value) <= getMaxWhitelistedDeposit(),

                "Deposit exceeds max buy per address for whitelisted addresses."

            );

        } else {

            require(

                accountCurrentDeposit.add(msg.value) <= maxBuyWithoutWhitelisting,

                "Deposit exceeds max buy per address for non-whitelisted addresses."

            );

        }

        require(address(this).balance.sub(fee) <= hardcap, "Cannot deposit more than hardcap.");



        redeemer.setDeposit(msg.sender, msg.value.sub(fee), address(this).balance.sub(fee));



        if (referrer != address(0x0) && referrer != msg.sender) {

            earnedReferrals[referrer] = earnedReferrals[referrer].add(fee);

            referralCounts[referrer] = referralCounts[referrer].add(1);

            referrer.transfer(fee);

        } else {

            lidFund.transfer(fee);

        }

    }



    function getMaxWhitelistedDeposit() public view returns (uint) {

        return maxBuyPerAddress;

    }



    function isPresaleEnded() public view returns (bool) {

        uint endTime =  timer.endTime();

        if (hasSentToUniswap) return true;

        return (

            (address(this).balance >= hardcap) ||

            (timer.isStarted() && (now > endTime && endTime != 0))

        );

    }



}
