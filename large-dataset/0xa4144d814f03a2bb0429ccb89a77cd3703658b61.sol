/*
 * Origin Protocol
 * https://originprotocol.com
 *
 * Released under the MIT license
 * https://github.com/OriginProtocol/origin-dollar
 *
 * Copyright 2020 Origin Protocol, Inc
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
// File: contracts/strategies/IAave.sol

pragma solidity 0.5.11;

/**
 * @dev Interface for Aaves A Token
 * Documentation: https://developers.aave.com/#atokens
 */
interface IAaveAToken {
    /**
     * @notice Non-standard ERC20 function to redeem an _amount of aTokens for the underlying
     * asset, burning the aTokens during the process.
     * @param _amount Amount of aTokens
     */
    function redeem(uint256 _amount) external;

    /**
     * @notice returns the current total aToken balance of _user all interest collected included.
     * To obtain the user asset principal balance with interests excluded , ERC20 non-standard
     * method principalBalanceOf() can be used.
     */
    function balanceOf(address _user) external view returns (uint256);
}

/**
 * @dev Interface for Aaves Lending Pool
 * Documentation: https://developers.aave.com/#lendingpool
 */
interface IAaveLendingPool {
    /**
     * @notice Deposits a certain _amount of an asset specified by the _reserve parameter.
     * @dev The caller receives a certain amount of corresponding aTokens in exchange.
     * The amount of aTokens received depends on the corresponding aToken exchange rate.
     * LendingPoolCore must be approved to spend this reserve
     */
    function deposit(
        address _reserve,
        uint256 _amount,
        uint16 _referralCode
    ) external;
}

/**
 * @dev Interface for Aaves Lending Pool
 * Documentation: https://developers.aave.com/#lendingpooladdressesprovider
 */
interface ILendingPoolAddressesProvider {
    /**
     * @notice Get the current address for Aave LendingPool
     * @dev Lending pool is the core contract on which to call deposit
     */
    function getLendingPool() external view returns (address);

    /**
     * @notice Get the address for lendingPoolCore
     * @dev IMPORTANT - this is where _reserve must be approved before deposit
     */
    function getLendingPoolCore() external view returns (address payable);
}

// File: @openzeppelin/upgrades/contracts/Initializable.sol

pragma solidity >=0.4.24 <0.7.0;


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

// File: contracts/governance/Governable.sol

pragma solidity 0.5.11;

/**
 * @title OUSD Governable Contract
 * @dev Copy of the openzeppelin Ownable.sol contract with nomenclature change
 *      from owner to governor and renounce methods removed. Does not use
 *      Context.sol like Ownable.sol does for simplification.
 * @author Origin Protocol Inc
 */
contract Governable {
    // Storage position of the owner and pendingOwner of the contract
    // keccak256("OUSD.governor");
    bytes32
        private constant governorPosition = 0x7bea13895fa79d2831e0a9e28edede30099005a50d652d8957cf8a607ee6ca4a;

    // keccak256("OUSD.pending.governor");
    bytes32
        private constant pendingGovernorPosition = 0x44c4d30b2eaad5130ad70c3ba6972730566f3e6359ab83e800d905c61b1c51db;

    // keccak256("OUSD.reentry.status");
    bytes32
        private constant reentryStatusPosition = 0x53bf423e48ed90e97d02ab0ebab13b2a235a6bfbe9c321847d5c175333ac4535;

    // See OpenZeppelin ReentrancyGuard implementation
    uint256 constant _NOT_ENTERED = 1;
    uint256 constant _ENTERED = 2;

    event PendingGovernorshipTransfer(
        address indexed previousGovernor,
        address indexed newGovernor
    );

    event GovernorshipTransferred(
        address indexed previousGovernor,
        address indexed newGovernor
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial Governor.
     */
    constructor() internal {
        _setGovernor(msg.sender);
        emit GovernorshipTransferred(address(0), _governor());
    }

    /**
     * @dev Returns the address of the current Governor.
     */
    function governor() public view returns (address) {
        return _governor();
    }

    /**
     * @dev Returns the address of the current Governor.
     */
    function _governor() internal view returns (address governorOut) {
        bytes32 position = governorPosition;
        assembly {
            governorOut := sload(position)
        }
    }

    /**
     * @dev Returns the address of the pending Governor.
     */
    function _pendingGovernor()
        internal
        view
        returns (address pendingGovernor)
    {
        bytes32 position = pendingGovernorPosition;
        assembly {
            pendingGovernor := sload(position)
        }
    }

    /**
     * @dev Throws if called by any account other than the Governor.
     */
    modifier onlyGovernor() {
        require(isGovernor(), "Caller is not the Governor");
        _;
    }

    /**
     * @dev Returns true if the caller is the current Governor.
     */
    function isGovernor() public view returns (bool) {
        return msg.sender == _governor();
    }

    function _setGovernor(address newGovernor) internal {
        bytes32 position = governorPosition;
        assembly {
            sstore(position, newGovernor)
        }
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        bytes32 position = reentryStatusPosition;
        uint256 _reentry_status;
        assembly {
            _reentry_status := sload(position)
        }

        // On the first call to nonReentrant, _notEntered will be true
        require(_reentry_status != _ENTERED, "Reentrant call");

        // Any calls to nonReentrant after this point will fail
        assembly {
            sstore(position, _ENTERED)
        }

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        assembly {
            sstore(position, _NOT_ENTERED)
        }
    }

    function _setPendingGovernor(address newGovernor) internal {
        bytes32 position = pendingGovernorPosition;
        assembly {
            sstore(position, newGovernor)
        }
    }

    /**
     * @dev Transfers Governance of the contract to a new account (`newGovernor`).
     * Can only be called by the current Governor. Must be claimed for this to complete
     * @param _newGovernor Address of the new Governor
     */
    function transferGovernance(address _newGovernor) external onlyGovernor {
        _setPendingGovernor(_newGovernor);
        emit PendingGovernorshipTransfer(_governor(), _newGovernor);
    }

    /**
     * @dev Claim Governance of the contract to a new account (`newGovernor`).
     * Can only be called by the new Governor.
     */
    function claimGovernance() external {
        require(
            msg.sender == _pendingGovernor(),
            "Only the pending Governor can complete the claim"
        );
        _changeGovernor(msg.sender);
    }

    /**
     * @dev Change Governance of the contract to a new account (`newGovernor`).
     * @param _newGovernor Address of the new Governor
     */
    function _changeGovernor(address _newGovernor) internal {
        require(_newGovernor != address(0), "New Governor is address(0)");
        emit GovernorshipTransferred(_governor(), _newGovernor);
        _setGovernor(_newGovernor);
    }
}

// File: contracts/utils/InitializableAbstractStrategy.sol

pragma solidity 0.5.11;




contract InitializableAbstractStrategy is Initializable, Governable {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    event PTokenAdded(address indexed _asset, address _pToken);
    event PTokenRemoved(address indexed _asset, address _pToken);
    event Deposit(address indexed _asset, address _pToken, uint256 _amount);
    event Withdrawal(address indexed _asset, address _pToken, uint256 _amount);
    event RewardTokenCollected(address recipient, uint256 amount);

    // Core address for the given platform
    address public platformAddress;

    address public vaultAddress;

    // asset => pToken (Platform Specific Token Address)
    mapping(address => address) public assetToPToken;

    // Full list of all assets supported here
    address[] internal assetsMapped;

    // Reward token address
    address public rewardTokenAddress;
    uint256 public rewardLiquidationThreshold;

    /**
     * @dev Internal initialize function, to set up initial internal state
     * @param _platformAddress jGeneric platform address
     * @param _vaultAddress Address of the Vault
     * @param _rewardTokenAddress Address of reward token for platform
     * @param _assets Addresses of initial supported assets
     * @param _pTokens Platform Token corresponding addresses
     */
    function initialize(
        address _platformAddress,
        address _vaultAddress,
        address _rewardTokenAddress,
        address[] calldata _assets,
        address[] calldata _pTokens
    ) external onlyGovernor initializer {
        InitializableAbstractStrategy._initialize(
            _platformAddress,
            _vaultAddress,
            _rewardTokenAddress,
            _assets,
            _pTokens
        );
    }

    /**
     * @dev Collect accumulated reward token (COMP) and send to Vault.
     */
    function collectRewardToken() external onlyVault nonReentrant {
        IERC20 rewardToken = IERC20(rewardTokenAddress);
        uint256 balance = rewardToken.balanceOf(address(this));
        emit RewardTokenCollected(vaultAddress, balance);
        rewardToken.safeTransfer(vaultAddress, balance);
    }

    function _initialize(
        address _platformAddress,
        address _vaultAddress,
        address _rewardTokenAddress,
        address[] memory _assets,
        address[] memory _pTokens
    ) internal {
        platformAddress = _platformAddress;
        vaultAddress = _vaultAddress;
        rewardTokenAddress = _rewardTokenAddress;
        uint256 assetCount = _assets.length;
        require(assetCount == _pTokens.length, "Invalid input arrays");
        for (uint256 i = 0; i < assetCount; i++) {
            _setPTokenAddress(_assets[i], _pTokens[i]);
        }
    }

    /**
     * @dev Single asset variant of the internal initialize.
     */
    function _initialize(
        address _platformAddress,
        address _vaultAddress,
        address _rewardTokenAddress,
        address _asset,
        address _pToken
    ) internal {
        platformAddress = _platformAddress;
        vaultAddress = _vaultAddress;
        rewardTokenAddress = _rewardTokenAddress;
        _setPTokenAddress(_asset, _pToken);
    }

    /**
     * @dev Verifies that the caller is the Vault.
     */
    modifier onlyVault() {
        require(msg.sender == vaultAddress, "Caller is not the Vault");
        _;
    }

    /**
     * @dev Verifies that the caller is the Vault or Governor.
     */
    modifier onlyVaultOrGovernor() {
        require(
            msg.sender == vaultAddress || msg.sender == governor(),
            "Caller is not the Vault or Governor"
        );
        _;
    }

    /**
     * @dev Set the reward token address.
     * @param _rewardTokenAddress Address of the reward token
     */
    function setRewardTokenAddress(address _rewardTokenAddress)
        external
        onlyGovernor
    {
        rewardTokenAddress = _rewardTokenAddress;
    }

    /**
     * @dev Set the reward token liquidation threshold.
     * @param _threshold Threshold amount in decimals of reward token that will
     * cause the Vault to claim and withdrawAll on allocate() calls.
     */
    function setRewardLiquidationThreshold(uint256 _threshold)
        external
        onlyGovernor
    {
        rewardLiquidationThreshold = _threshold;
    }

    /**
     * @dev Provide support for asset by passing its pToken address.
     *      This method can only be called by the system Governor
     * @param _asset    Address for the asset
     * @param _pToken   Address for the corresponding platform token
     */
    function setPTokenAddress(address _asset, address _pToken)
        external
        onlyGovernor
    {
        _setPTokenAddress(_asset, _pToken);
    }

    /**
     * @dev Remove a supported asset by passing its index.
     *      This method can only be called by the system Governor
     * @param _assetIndex Index of the asset to be removed
     */
    function removePToken(uint256 _assetIndex) external onlyGovernor {
        require(_assetIndex < assetsMapped.length, "Invalid index");
        address asset = assetsMapped[_assetIndex];
        address pToken = assetToPToken[asset];

        if (_assetIndex < assetsMapped.length - 1) {
            assetsMapped[_assetIndex] = assetsMapped[assetsMapped.length - 1];
        }
        assetsMapped.pop();
        assetToPToken[asset] = address(0);

        emit PTokenRemoved(asset, pToken);
    }

    /**
     * @dev Provide support for asset by passing its pToken address.
     *      Add to internal mappings and execute the platform specific,
     * abstract method `_abstractSetPToken`
     * @param _asset    Address for the asset
     * @param _pToken   Address for the corresponding platform token
     */
    function _setPTokenAddress(address _asset, address _pToken) internal {
        require(assetToPToken[_asset] == address(0), "pToken already set");
        require(
            _asset != address(0) && _pToken != address(0),
            "Invalid addresses"
        );

        assetToPToken[_asset] = _pToken;
        assetsMapped.push(_asset);

        emit PTokenAdded(_asset, _pToken);

        _abstractSetPToken(_asset, _pToken);
    }

    /**
     * @dev Transfer token to governor. Intended for recovering tokens stuck in
     *      strategy contracts, i.e. mistaken sends.
     * @param _asset Address for the asset
     * @param _amount Amount of the asset to transfer
     */
    function transferToken(address _asset, uint256 _amount)
        public
        onlyGovernor
    {
        IERC20(_asset).safeTransfer(governor(), _amount);
    }

    /***************************************
                 Abstract
    ****************************************/

    function _abstractSetPToken(address _asset, address _pToken) internal;

    function safeApproveAllTokens() external;

    /**
     * @dev Deposit a amount of asset into the platform
     * @param _asset               Address for the asset
     * @param _amount              Units of asset to deposit
     */
    function deposit(address _asset, uint256 _amount) external;

    /**
     * @dev Withdraw an amount of asset from the platform.
     * @param _recipient         Address to which the asset should be sent
     * @param _asset             Address of the asset
     * @param _amount            Units of asset to withdraw
     */
    function withdraw(
        address _recipient,
        address _asset,
        uint256 _amount
    ) external;

    /**
     * @dev Withdraw all assets from strategy sending assets to Vault.
     */
    function withdrawAll() external;

    /**
     * @dev Get the total asset value held in the platform.
     *      This includes any interest that was generated since depositing.
     * @param _asset      Address of the asset
     * @return balance    Total value of the asset in the platform
     */
    function checkBalance(address _asset)
        external
        view
        returns (uint256 balance);

    /**
     * @dev Check if an asset is supported.
     * @param _asset    Address of the asset
     * @return bool     Whether asset is supported
     */
    function supportsAsset(address _asset) external view returns (bool);
}

// File: contracts/strategies/AaveStrategy.sol

pragma solidity 0.5.11;

/**
 * @title OUSD Aave Strategy
 * @notice Investment strategy for investing stablecoins via Aave
 * @author Origin Protocol Inc
 */


contract AaveStrategy is InitializableAbstractStrategy {
    uint16 constant referralCode = 92;

    /**
     * @dev Deposit asset into Aave
     * @param _asset Address of asset to deposit
     * @param _amount Amount of asset to deposit
     * @return amountDeposited Amount of asset that was deposited
     */
    function deposit(address _asset, uint256 _amount)
        external
        onlyVault
        nonReentrant
    {
        require(_amount > 0, "Must deposit something");

        IAaveAToken aToken = _getATokenFor(_asset);
        emit Deposit(_asset, address(aToken), _amount);
        _getLendingPool().deposit(_asset, _amount, referralCode);
    }

    /**
     * @dev Withdraw asset from Aave
     * @param _recipient Address to receive withdrawn asset
     * @param _asset Address of asset to withdraw
     * @param _amount Amount of asset to withdraw
     * @return amountWithdrawn Amount of asset that was withdrawn
     */
    function withdraw(
        address _recipient,
        address _asset,
        uint256 _amount
    ) external onlyVault nonReentrant {
        require(_amount > 0, "Must withdraw something");
        require(_recipient != address(0), "Must specify recipient");

        IAaveAToken aToken = _getATokenFor(_asset);
        emit Withdrawal(_asset, address(aToken), _amount);
        aToken.redeem(_amount);
        IERC20(_asset).safeTransfer(_recipient, _amount);
    }

    /**
     * @dev Remove all assets from platform and send them to Vault contract.
     */
    function withdrawAll() external onlyVaultOrGovernor nonReentrant {
        for (uint256 i = 0; i < assetsMapped.length; i++) {
            // Redeem entire balance of aToken
            IAaveAToken aToken = _getATokenFor(assetsMapped[i]);
            uint256 balance = aToken.balanceOf(address(this));
            if (balance > 0) {
                aToken.redeem(balance);
                // Transfer entire balance to Vault
                IERC20 asset = IERC20(assetsMapped[i]);
                asset.safeTransfer(
                    vaultAddress,
                    asset.balanceOf(address(this))
                );
            }
        }
    }

    /**
     * @dev Get the total asset value held in the platform
     * @param _asset      Address of the asset
     * @return balance    Total value of the asset in the platform
     */
    function checkBalance(address _asset)
        external
        view
        returns (uint256 balance)
    {
        // Balance is always with token aToken decimals
        IAaveAToken aToken = _getATokenFor(_asset);
        balance = aToken.balanceOf(address(this));
    }

    /**
     * @dev Retuns bool indicating whether asset is supported by strategy
     * @param _asset Address of the asset
     */
    function supportsAsset(address _asset) external view returns (bool) {
        return assetToPToken[_asset] != address(0);
    }

    /**
     * @dev Approve the spending of all assets by their corresponding aToken,
     *      if for some reason is it necessary.
     */
    function safeApproveAllTokens() external onlyGovernor nonReentrant {
        uint256 assetCount = assetsMapped.length;
        address lendingPoolVault = _getLendingPoolCore();
        // approve the pool to spend the bAsset
        for (uint256 i = 0; i < assetCount; i++) {
            address asset = assetsMapped[i];
            // Safe approval
            IERC20(asset).safeApprove(lendingPoolVault, 0);
            IERC20(asset).safeApprove(lendingPoolVault, uint256(-1));
        }
    }

    /**
     * @dev Internal method to respond to the addition of new asset / aTokens
     *      We need to approve the aToken and give it permission to spend the asset
     * @param _asset Address of the asset to approve
     * @param _aToken This aToken has the approval approval
     */
    function _abstractSetPToken(address _asset, address _aToken) internal {
        address lendingPoolVault = _getLendingPoolCore();
        IERC20(_asset).safeApprove(lendingPoolVault, 0);
        IERC20(_asset).safeApprove(lendingPoolVault, uint256(-1));
    }

    /**
     * @dev Get the aToken wrapped in the ICERC20 interface for this asset.
     *      Fails if the pToken doesn't exist in our mappings.
     * @param _asset Address of the asset
     * @return Corresponding aToken to this asset
     */
    function _getATokenFor(address _asset) internal view returns (IAaveAToken) {
        address aToken = assetToPToken[_asset];
        require(aToken != address(0), "aToken does not exist");
        return IAaveAToken(aToken);
    }

    /**
     * @dev Get the current address of the Aave lending pool, which is the gateway to
     *      depositing.
     * @return Current lending pool implementation
     */
    function _getLendingPool() internal view returns (IAaveLendingPool) {
        address lendingPool = ILendingPoolAddressesProvider(platformAddress)
            .getLendingPool();
        require(lendingPool != address(0), "Lending pool does not exist");
        return IAaveLendingPool(lendingPool);
    }

    /**
     * @dev Get the current address of the Aave lending pool core, which stores all the
     *      reserve tokens in its vault.
     * @return Current lending pool core address
     */
    function _getLendingPoolCore() internal view returns (address payable) {
        address payable lendingPoolCore = ILendingPoolAddressesProvider(
            platformAddress
        )
            .getLendingPoolCore();
        require(
            lendingPoolCore != address(uint160(address(0))),
            "Lending pool core does not exist"
        );
        return lendingPoolCore;
    }
}
