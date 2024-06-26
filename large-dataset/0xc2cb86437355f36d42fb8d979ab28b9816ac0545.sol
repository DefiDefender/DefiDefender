pragma solidity ^0.6.12;





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

     */

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b != 0, errorMessage);

        return a % b;

    }

}



// SPDX-License-Identifier: GPL-3.0-only

//@1AndOnlyPika, EnCore

//

// Cloning this and using for your own purposes is a-ok, but could you at least be a

// decent human and leave the credits at the top? Thanks in advance.

interface IERC20 {

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

}



interface IEncoreVault {

    function stakedTokens(uint256 _pid, address _user) external view returns (uint256);

    function deposit(uint256 _pid, uint256 _amount) external;

    function withdraw(uint256 _pid, uint256 _amount) external;

    function massUpdatePools() external;

}



interface ITokenLockWithRelease {

    function releaseTokens() external returns (uint256);

}



contract TimelockVault is Ownable{

    using SafeMath for uint256;

    address public lockedToken;

    uint256 public contractStartTime;

    address public encoreVaultAddress;

    uint256 internal poolID;

    address public encoreAddress;

    uint256 public totalLPContributed;

    mapping(address => uint256) public LPContributed;

    bool public lockingCompleted = false;

    address public tokenLock;



    constructor(address _token, address _vault, uint256 _pid, address _encore) public {

        lockedToken = _token;

        encoreVaultAddress = _vault;

        contractStartTime = block.timestamp;

        poolID = _pid;

        encoreAddress = _encore;

        IERC20 token = IERC20(lockedToken);

        token.approve(encoreVaultAddress, 9999999999999999999999999999999999999999);

    }



    function withdrawExtraTokens(address _token) public onlyOwner {

        require(_token != lockedToken, "Cannot withdraw locked token");

        require(_token != encoreAddress, "Cannot withdraw ENCORE unless grace period is over");

        IERC20 token = IERC20(_token);

        require(token.balanceOf(address(this))>0, "No balance");

        token.transfer(address(msg.sender), token.balanceOf(address(this)));

    }



    function timelockOngoing() public view returns (bool) { // If the timelock deposit period is going on ot not

        return contractStartTime.add(3 days) > block.timestamp;

    }



    function setLockAddress(address _lock) public onlyOwner {

        tokenLock = _lock;

    }



    function lockperiodOngoing() public view returns (bool) { // If the locking period is going on or not

        return contractStartTime.add(48 days) > block.timestamp;

    }



    function emergencyDrainPeriod() public view returns (bool) { // 24 hours after the lock period ends, in the case rewards weren't able to be withdrawn

        return contractStartTime.add(49 days) < block.timestamp;

    }



    function lockTokens(uint256 _amount) public {

        require(timelockOngoing() == true, "Lock period over");

        IERC20 token = IERC20(lockedToken);

        token.transferFrom(msg.sender, address(this), _amount);

        totalLPContributed += _amount;

        LPContributed[msg.sender] += _amount;

    }



    function stakeLPTokens() public {

        require(timelockOngoing() == false, "Lock period not over");

        IEncoreVault vault = IEncoreVault(encoreVaultAddress);

        vault.deposit(poolID, totalLPContributed);

    }



    uint256 public totalLP;

    uint256 public LPPerUnit;

    uint256 public totalENCORE;

    uint256 public ENCOREPerUnit;

    function claimLPAndRewards() public {

        require(lockperiodOngoing() == false, "Timelock period not over");

        IERC20 token = IERC20(lockedToken);

        ITokenLockWithRelease locker = ITokenLockWithRelease(tokenLock);

        require(locker.releaseTokens() > 0, "No locked rewards");

        IEncoreVault vault = IEncoreVault(encoreVaultAddress);

        vault.massUpdatePools();

        vault.withdraw(poolID, totalLPContributed);

        totalLP = token.balanceOf(address(this));

        LPPerUnit  = totalLP.mul(1e18).div(totalLPContributed);

        IERC20 encore = IERC20(encoreAddress);

        totalENCORE = encore.balanceOf(address(this));

        ENCOREPerUnit = totalENCORE.mul(1e18).div(totalLPContributed);

        lockingCompleted = true;

    }



    function emergencyDrain() public onlyOwner {

        require(emergencyDrainPeriod() == true, "Emergency drain period not completed");

        require(lockingCompleted == false, "Locking has completed");

        IERC20(lockedToken).transfer(msg.sender, IERC20(lockedToken).balanceOf(address(this)));

        IERC20(encoreAddress).transfer(msg.sender, IERC20(encoreAddress).balanceOf(address(this)));

    }



    function claim() public {

        require(lockingCompleted == true, "Locking period not over");

        require(LPContributed[msg.sender] != 0, "Nothing to claim, move along");

        IERC20 token = IERC20(lockedToken);

        IERC20 encore = IERC20(encoreAddress);

        token.transfer(msg.sender, LPContributed[msg.sender].mul(LPPerUnit).div(1e18));

        encore.transfer(msg.sender, LPContributed[msg.sender].mul(ENCOREPerUnit).div(1e18));

        LPContributed[msg.sender] = 0;

    }

}
