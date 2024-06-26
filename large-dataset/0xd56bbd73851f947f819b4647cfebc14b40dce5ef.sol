// Dependency file: contracts/libraries/SafeMath.sol



// SPDX-License-Identifier: MIT



// pragma solidity >=0.6.0;



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



// Dependency file: contracts/libraries/TransferHelper.sol





// pragma solidity >=0.6.0;



library TransferHelper {

    function safeApprove(address token, address to, uint value) internal {

        // bytes4(keccak256(bytes('approve(address,uint256)')));

        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));

        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: APPROVE_FAILED');

    }



    function safeTransfer(address token, address to, uint value) internal {

        // bytes4(keccak256(bytes('transfer(address,uint256)')));

        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));

        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FAILED');

    }



    function safeTransferFrom(address token, address from, address to, uint value) internal {

        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));

        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));

        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FROM_FAILED');

    }



    function safeTransferETH(address to, uint value) internal {

        (bool success,) = to.call{value:value}(new bytes(0));

        require(success, 'TransferHelper: ETH_TRANSFER_FAILED');

    }

}





// Dependency file: contracts/modules/Configable.sol



// pragma solidity >=0.5.16;

pragma experimental ABIEncoderV2;



interface IConfig {

    function developer() external view returns (address);

    function platform() external view returns (address);

    function factory() external view returns (address);

    function mint() external view returns (address);

    function token() external view returns (address);

    function developPercent() external view returns (uint);

    function share() external view returns (address);

    function base() external view returns (address); 

    function governor() external view returns (address);

    function getPoolValue(address pool, bytes32 key) external view returns (uint);

    function getValue(bytes32 key) external view returns(uint);

    function getParams(bytes32 key) external view returns(uint, uint, uint, uint); 

    function getPoolParams(address pool, bytes32 key) external view returns(uint, uint, uint, uint); 

    function wallets(bytes32 key) external view returns(address);

    function setValue(bytes32 key, uint value) external;

    function setPoolValue(address pool, bytes32 key, uint value) external;

    function setParams(bytes32 _key, uint _min, uint _max, uint _span, uint _value) external;

    function setPoolParams(bytes32 _key, uint _min, uint _max, uint _span, uint _value) external;

    function initPoolParams(address _pool) external;

    function isMintToken(address _token) external returns (bool);

    function prices(address _token) external returns (uint);

    function convertTokenAmount(address _fromToken, address _toToken, uint _fromAmount) external view returns (uint);

    function DAY() external view returns (uint);

    function WETH() external view returns (address);

}



contract Configable {

    address public config;

    address public owner;



    event OwnerChanged(address indexed _oldOwner, address indexed _newOwner);



    constructor() public {

        owner = msg.sender;

    }

    

    function setupConfig(address _config) external onlyOwner {

        config = _config;

        owner = IConfig(config).developer();

    }



    modifier onlyOwner() {

        require(msg.sender == owner, 'OWNER FORBIDDEN');

        _;

    }

    

    modifier onlyDeveloper() {

        require(msg.sender == IConfig(config).developer(), 'DEVELOPER FORBIDDEN');

        _;

    }

    

    modifier onlyPlatform() {

        require(msg.sender == IConfig(config).platform(), 'PLATFORM FORBIDDEN');

        _;

    }



    modifier onlyFactory() {

        require(msg.sender == IConfig(config).factory(), 'FACTORY FORBIDDEN');

        _;

    }



    modifier onlyGovernor() {

        require(msg.sender == IConfig(config).governor(), 'Governor FORBIDDEN');

        _;

    }

}



// Dependency file: contracts/modules/BaseShareField.sol



// pragma solidity >=0.6.6;

// import 'contracts/libraries/SafeMath.sol';

// import 'contracts/libraries/TransferHelper.sol';



interface IERC20 {

    function approve(address spender, uint value) external returns (bool);

    function balanceOf(address owner) external view returns (uint);

}



contract BaseShareField {

    using SafeMath for uint;

    

    uint public totalProductivity;

    uint public accAmountPerShare;

    

    uint public totalShare;

    uint public mintedShare;

    uint public mintCumulation;

    

    uint private unlocked = 1;

    address public shareToken;

    

    modifier lock() {

        require(unlocked == 1, 'Locked');

        unlocked = 0;

        _;

        unlocked = 1;

    }

    

    struct UserInfo {

        uint amount;     // How many tokens the user has provided.

        uint rewardDebt; // Reward debt. 

        uint rewardEarn; // Reward earn and not minted

        bool initialize; // already setup.

    }



    mapping(address => UserInfo) public users;

    

    function _setShareToken(address _shareToken) internal {

        shareToken = _shareToken;

    }



    // Update reward variables of the given pool to be up-to-date.

    function _update() internal virtual {

        if (totalProductivity == 0) {

            totalShare = totalShare.add(_currentReward());

            return;

        }

        

        uint256 reward = _currentReward();

        accAmountPerShare = accAmountPerShare.add(reward.mul(1e12).div(totalProductivity));

        totalShare += reward;

    }

    

    function _currentReward() internal virtual view returns (uint) {

        return mintedShare.add(IERC20(shareToken).balanceOf(address(this))).sub(totalShare);

    }

    

    // Audit user's reward to be up-to-date

    function _audit(address user) internal virtual {

        UserInfo storage userInfo = users[user];

        if (userInfo.amount > 0) {

            uint pending = userInfo.amount.mul(accAmountPerShare).div(1e12).sub(userInfo.rewardDebt);

            userInfo.rewardEarn = userInfo.rewardEarn.add(pending);

            mintCumulation = mintCumulation.add(pending);

            userInfo.rewardDebt = userInfo.amount.mul(accAmountPerShare).div(1e12);

        }

    }



    // External function call

    // This function increase user's productivity and updates the global productivity.

    // the users' actual share percentage will calculated by:

    // Formula:     user_productivity / global_productivity

    function _increaseProductivity(address user, uint value) internal virtual returns (bool) {

        require(value > 0, 'PRODUCTIVITY_VALUE_MUST_BE_GREATER_THAN_ZERO');



        UserInfo storage userInfo = users[user];

        _update();

        _audit(user);



        totalProductivity = totalProductivity.add(value);



        userInfo.amount = userInfo.amount.add(value);

        userInfo.rewardDebt = userInfo.amount.mul(accAmountPerShare).div(1e12);

        return true;

    }



    // External function call 

    // This function will decreases user's productivity by value, and updates the global productivity

    // it will record which block this is happenning and accumulates the area of (productivity * time)

    function _decreaseProductivity(address user, uint value) internal virtual returns (bool) {

        UserInfo storage userInfo = users[user];

        require(value > 0 && userInfo.amount >= value, 'INSUFFICIENT_PRODUCTIVITY');

        

        _update();

        _audit(user);

        

        userInfo.amount = userInfo.amount.sub(value);

        userInfo.rewardDebt = userInfo.amount.mul(accAmountPerShare).div(1e12);

        totalProductivity = totalProductivity.sub(value);

        

        return true;

    }



    function _transferTo(address user, address to, uint value) internal virtual returns (bool) {

        UserInfo storage userInfo = users[user];

        require(value > 0 && userInfo.amount >= value, 'INSUFFICIENT_PRODUCTIVITY');

        

        _update();

        _audit(user);



        uint transferAmount = value.mul(userInfo.rewardEarn).div(userInfo.amount);

        userInfo.rewardEarn = userInfo.rewardEarn.sub(transferAmount);

        users[to].rewardEarn = users[to].rewardEarn.add(transferAmount);

        

        userInfo.amount = userInfo.amount.sub(value);

        userInfo.rewardDebt = userInfo.amount.mul(accAmountPerShare).div(1e12);

        totalProductivity = totalProductivity.sub(value);

        

        return true;

    }

    

    function _takeWithAddress(address user) internal view returns (uint) {

        UserInfo storage userInfo = users[user];

        uint _accAmountPerShare = accAmountPerShare;

        if (totalProductivity != 0) {

            uint reward = _currentReward();

            _accAmountPerShare = _accAmountPerShare.add(reward.mul(1e12).div(totalProductivity));

        }

        return userInfo.amount.mul(_accAmountPerShare).div(1e12).add(userInfo.rewardEarn).sub(userInfo.rewardDebt);

    }



    // External function call

    // When user calls this function, it will calculate how many token will mint to user from his productivity * time

    // Also it calculates global token supply from last time the user mint to this time.

    function _mint(address user) internal virtual lock returns (uint) {

        _update();

        _audit(user);

        require(users[user].rewardEarn > 0, "NOTHING TO MINT SHARE");

        uint amount = users[user].rewardEarn;

        TransferHelper.safeTransfer(shareToken, user, amount);

        users[user].rewardEarn = 0;

        mintedShare += amount;

        return amount;

    }



    function _mintTo(address user, address to) internal virtual lock returns (uint) {

        _update();

        _audit(user);

        uint amount = users[user].rewardEarn;

        if(amount > 0) {

            TransferHelper.safeTransfer(shareToken, to, amount);

        }

        

        users[user].rewardEarn = 0;

        mintedShare += amount;

        return amount;

    }



    // Returns how many productivity a user has and global has.

    function getProductivity(address user) public virtual view returns (uint, uint) {

        return (users[user].amount, totalProductivity);

    }



    // Returns the current gorss product rate.

    function interestsPerBlock() public virtual view returns (uint) {

        return accAmountPerShare;

    }

    

}



// Dependency file: contracts/modules/ConfigNames.sol



// pragma solidity >=0.5.16;



library ConfigNames {

    //GOVERNANCE

    bytes32 public constant PROPOSAL_VOTE_DURATION = bytes32('PROPOSAL_VOTE_DURATION');

    bytes32 public constant PROPOSAL_EXECUTE_DURATION = bytes32('PROPOSAL_EXECUTE_DURATION');

    bytes32 public constant PROPOSAL_CREATE_COST = bytes32('PROPOSAL_CREATE_COST');

    bytes32 public constant STAKE_LOCK_TIME = bytes32('STAKE_LOCK_TIME');

    bytes32 public constant MINT_AMOUNT_PER_BLOCK =  bytes32('MINT_AMOUNT_PER_BLOCK');

    bytes32 public constant INTEREST_PLATFORM_SHARE =  bytes32('INTEREST_PLATFORM_SHARE');

    bytes32 public constant CHANGE_PRICE_DURATION =  bytes32('CHANGE_PRICE_DURATION');

    bytes32 public constant CHANGE_PRICE_PERCENT =  bytes32('CHANGE_PRICE_PERCENT');



    // POOL

    bytes32 public constant POOL_BASE_INTERESTS = bytes32('POOL_BASE_INTERESTS');

    bytes32 public constant POOL_MARKET_FRENZY = bytes32('POOL_MARKET_FRENZY');

    bytes32 public constant POOL_PLEDGE_RATE = bytes32('POOL_PLEDGE_RATE');

    bytes32 public constant POOL_LIQUIDATION_RATE = bytes32('POOL_LIQUIDATION_RATE');

    bytes32 public constant POOL_MINT_BORROW_PERCENT = bytes32('POOL_MINT_BORROW_PERCENT');

    bytes32 public constant POOL_MINT_POWER = bytes32('POOL_MINT_POWER');

    

    //NOT GOVERNANCE

    bytes32 public constant AAAA_USER_MINT = bytes32('AAAA_USER_MINT');

    bytes32 public constant AAAA_TEAM_MINT = bytes32('AAAA_TEAM_MINT');

    bytes32 public constant AAAA_REWAED_MINT = bytes32('AAAA_REWAED_MINT');

    bytes32 public constant DEPOSIT_ENABLE = bytes32('DEPOSIT_ENABLE');

    bytes32 public constant WITHDRAW_ENABLE = bytes32('WITHDRAW_ENABLE');

    bytes32 public constant BORROW_ENABLE = bytes32('BORROW_ENABLE');

    bytes32 public constant REPAY_ENABLE = bytes32('REPAY_ENABLE');

    bytes32 public constant LIQUIDATION_ENABLE = bytes32('LIQUIDATION_ENABLE');

    bytes32 public constant REINVEST_ENABLE = bytes32('REINVEST_ENABLE');

    bytes32 public constant INTEREST_BUYBACK_SHARE =  bytes32('INTEREST_BUYBACK_SHARE');



    //POOL

    bytes32 public constant POOL_PRICE = bytes32('POOL_PRICE');



    //wallet

    bytes32 public constant TEAM = bytes32('team'); 

    bytes32 public constant SPARE = bytes32('spare');

    bytes32 public constant REWARD = bytes32('reward');

}



// Root file: contracts/AAAAShare.sol



pragma solidity >=0.5.16;

// import 'contracts/libraries/SafeMath.sol';

// import 'contracts/libraries/TransferHelper.sol';

// import 'contracts/modules/Configable.sol';

// import 'contracts/modules/BaseShareField.sol';

// import 'contracts/modules/ConfigNames.sol';



contract AAAAShare is Configable, BaseShareField {

    mapping (address => uint) public locks;

    

    event ProductivityIncreased (address indexed user, uint value);

    event ProductivityDecreased (address indexed user, uint value);

    event Mint(address indexed user, uint amount);

    

    function setShareToken(address _shareToken) external onlyDeveloper {

        shareToken = _shareToken;

    }

    

    function stake(uint _amount) external {

        TransferHelper.safeTransferFrom(IConfig(config).token(), msg.sender, address(this), _amount);

        _increaseProductivity(msg.sender, _amount);

        locks[msg.sender] = block.number;

        emit ProductivityIncreased(msg.sender, _amount);

    }

    

    function lockStake(address _user) onlyGovernor external {

        locks[_user] = block.number;

    }

    

    function withdraw(uint _amount) external {

        require(block.number > locks[msg.sender].add(IConfig(config).getValue(ConfigNames.STAKE_LOCK_TIME)), "STAKE LOCKED NOW");

        _decreaseProductivity(msg.sender, _amount);

        TransferHelper.safeTransfer(IConfig(config).token(), msg.sender, _amount);

        emit ProductivityDecreased(msg.sender, _amount);

    }

    

    function queryReward() external view returns (uint){

        return _takeWithAddress(msg.sender);

    }

    

    function mintReward() external {

        uint amount = _mint(msg.sender);

        emit Mint(msg.sender, amount);

    }

}
