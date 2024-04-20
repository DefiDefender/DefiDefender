pragma solidity ^0.5.16;



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



// import "../openzeppelin/upgrades/contracts/Initializable.sol";



// import "../openzeppelin/upgrades/contracts/Initializable.sol";



contract OwnableUpgradable is Initializable {

    address payable public owner;

    address payable internal newOwnerCandidate;



    modifier onlyOwner {

        require(msg.sender == owner, "Permission denied");

        _;

    }



    // ** INITIALIZERS \u2013 Constructors for Upgradable contracts **



    function initialize() public initializer {

        owner = msg.sender;

    }



    function initialize(address payable newOwner) public initializer {

        owner = newOwner;

    }



    function changeOwner(address payable newOwner) public onlyOwner {

        newOwnerCandidate = newOwner;

    }



    function acceptOwner() public {

        require(msg.sender == newOwnerCandidate, "Permission denied");

        owner = newOwnerCandidate;

    }



    uint256[50] private ______gap;

}



// import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";

// import "./SafeMath.sol";



// import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";



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



// import "@openzeppelin/contracts-ethereum-package/contracts/utils/Address.sol";



/**

 * @dev Collection of functions related to the address type

 */

library Address {

    /**

     * @dev Returns true if `account` is a contract.

     *

     * This test is non-exhaustive, and there may be false-negatives: during the

     * execution of a contract's constructor, its address will be reported as

     * not containing a contract.

     *

     * IMPORTANT: It is unsafe to assume that an address for which this

     * function returns false is an externally-owned account (EOA) and not a

     * contract.

     */

    function isContract(address account) internal view returns (bool) {

        // This method relies in extcodesize, which returns 0 for contracts in

        // construction, since the code is only stored at the end of the

        // constructor execution.



        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts

        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned

        // for accounts without code, i.e. `keccak256('')`

        bytes32 codehash;

        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;

        // solhint-disable-next-line no-inline-assembly

        assembly { codehash := extcodehash(account) }

        return (codehash != 0x0 && codehash != accountHash);

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



interface IToken {

    function decimals() external view returns (uint);

    function allowance(address owner, address spender) external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function approve(address spender, uint value) external;

    function transfer(address to, uint value) external returns (bool);

    function transferFrom(address from, address to, uint value) external returns (bool);

    function deposit() external payable;

    function withdraw(uint amount) external;

}



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



    function safeTransfer(IToken token, address to, uint256 value) internal {

        callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));

    }



    function safeTransferFrom(IToken token, address from, address to, uint256 value) internal {

        callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));

    }



    function safeApprove(IToken token, address spender, uint256 value) internal {

        // safeApprove should only be called when setting an initial allowance,

        // or when resetting it to zero. To increase and decrease it, use

        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'

        // solhint-disable-next-line max-line-length

        require((value == 0) || (token.allowance(address(this), spender) == 0),

            "SafeERC20: approve from non-zero to non-zero allowance"

        );

        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));

    }



    function safeIncreaseAllowance(IToken token, address spender, uint256 value) internal {

        uint256 newAllowance = token.allowance(address(this), spender).add(value);

        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));

    }



    function safeDecreaseAllowance(IToken token, address spender, uint256 value) internal {

        uint256 newAllowance = token.allowance(address(this), spender).sub(value);

        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));

    }



    /**

     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement

     * on the return value: the return value is optional (but if data is returned, it must not be false).

     * @param token The token targeted by the call.

     * @param data The call data (encoded using abi.encode or one of its variants).

     */

    function callOptionalReturn(IToken token, bytes memory data) private {

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



library UniversalERC20 {



    using SafeMath for uint256;

    using SafeERC20 for IToken;



    IToken private constant ZERO_ADDRESS = IToken(0x0000000000000000000000000000000000000000);

    IToken private constant ETH_ADDRESS = IToken(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);



    function universalTransfer(IToken token, address to, uint256 amount) internal {

        universalTransfer(token, to, amount, false);

    }



    function universalTransfer(IToken token, address to, uint256 amount, bool mayFail) internal returns(bool) {

        if (amount == 0) {

            return true;

        }



        if (token == ZERO_ADDRESS || token == ETH_ADDRESS) {

            if (mayFail) {

                return address(uint160(to)).send(amount);

            } else {

                address(uint160(to)).transfer(amount);

                return true;

            }

        } else {

            token.safeTransfer(to, amount);

            return true;

        }

    }



    function universalApprove(IToken token, address to, uint256 amount) internal {

        if (token != ZERO_ADDRESS && token != ETH_ADDRESS) {

            token.safeApprove(to, amount);

        }

    }



    function universalTransferFrom(IToken token, address from, address to, uint256 amount) internal {

        if (amount == 0) {

            return;

        }



        if (token == ZERO_ADDRESS || token == ETH_ADDRESS) {

            require(from == msg.sender && msg.value >= amount, "msg.value is zero");

            if (to != address(this)) {

                address(uint160(to)).transfer(amount);

            }

            if (msg.value > amount) {

                msg.sender.transfer(uint256(msg.value).sub(amount));

            }

        } else {

            token.safeTransferFrom(from, to, amount);

        }

    }



    function universalBalanceOf(IToken token, address who) internal view returns (uint256) {

        if (token == ZERO_ADDRESS || token == ETH_ADDRESS) {

            return who.balance;

        } else {

            return token.balanceOf(who);

        }

    }

}



contract FundsMgrUpgradable is Initializable, OwnableUpgradable {

    using UniversalERC20 for IToken;



    // Initializer \u2013 Constructor for Upgradable contracts

    function initialize() public initializer {

        OwnableUpgradable.initialize();  // Initialize Parent Contract

    }



    function initialize(address payable newOwner) public initializer {

        OwnableUpgradable.initialize(newOwner);  // Initialize Parent Contract

    }



    function withdraw(address token, uint256 amount) public onlyOwner {

        if (token == address(0x0)) {

            owner.transfer(amount);

        } else {

            IToken(token).universalTransfer(owner, amount);

        }

    }



    function withdrawAll(address[] memory tokens) public onlyOwner {

        for(uint256 i = 0; i < tokens.length;i++) {

            withdraw(tokens[i], IToken(tokens[i]).universalBalanceOf(address(this)));

        }

    }



    uint256[50] private ______gap;

}



contract DSMath {

    function add(uint x, uint y) internal pure returns (uint z) {

        require((z = x + y) >= x);

    }

    function sub(uint x, uint y) internal pure returns (uint z) {

        require((z = x - y) <= x);

    }

    function mul(uint x, uint y) internal pure returns (uint z) {

        require(y == 0 || (z = x * y) / y == x);

    }



    function min(uint x, uint y) internal pure returns (uint z) {

        return x <= y ? x : y;

    }

    function max(uint x, uint y) internal pure returns (uint z) {

        return x >= y ? x : y;

    }

    function imin(int x, int y) internal pure returns (int z) {

        return x <= y ? x : y;

    }

    function imax(int x, int y) internal pure returns (int z) {

        return x >= y ? x : y;

    }



    uint constant WAD = 10 ** 18;

    uint constant RAY = 10 ** 27;



    function wmul(uint x, uint y, uint base) internal pure returns (uint z) {

        z = add(mul(x, y), base / 2) / base;

    }



    function wmul(uint x, uint y) internal pure returns (uint z) {

        z = add(mul(x, y), WAD / 2) / WAD;

    }

    function rmul(uint x, uint y) internal pure returns (uint z) {

        z = add(mul(x, y), RAY / 2) / RAY;

    }

    function wdiv(uint x, uint y) internal pure returns (uint z) {

        z = add(mul(x, WAD), y / 2) / y;

    }

    function rdiv(uint x, uint y) internal pure returns (uint z) {

        z = add(mul(x, RAY), y / 2) / y;

    }



    // This famous algorithm is called "exponentiation by squaring"

    // and calculates x^n with x as fixed-point and n as regular unsigned.

    //

    // It's O(log n), instead of O(n) for naive repeated multiplication.

    //

    // These facts are why it works:

    //

    //  If n is even, then x^n = (x^2)^(n/2).

    //  If n is odd,  then x^n = x * x^(n-1),

    //   and applying the equation for even x gives

    //    x^n = x * (x^2)^((n-1) / 2).

    //

    //  Also, EVM division is flooring and

    //    floor[(n-1) / 2] = floor[n / 2].

    //

    /*function rpow(uint x, uint n) internal pure returns (uint z) {

        z = n % 2 != 0 ? x : RAY;



        for (n /= 2; n != 0; n /= 2) {

            x = rmul(x, x);



            if (n % 2 != 0) {

                z = rmul(z, x);

            }

        }

    }*/

}



contract ConstantAddressesMainnet {

    address public constant COMPTROLLER = 0x3d9819210A31b4961b30EF54bE2aeD79B9c9Cd3B;

    address public constant COMPOUND_ORACLE = 0x1D8aEdc9E924730DD3f9641CDb4D1B92B848b4bd;



    address public constant ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    address public constant CETH_ADDRESS = 0x4Ddc2D193948926D02f9B1fE9e1daa0718270ED5;



    address public constant USDC_ADDRESS = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    address public constant CUSDC_ADDRESS = 0x39AA39c021dfbaE8faC545936693aC917d5E7563;



    address public constant WETH_ADDRESS = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

}



// solhint-disable-next-line no-empty-blocks

contract ConstantAddresses is ConstantAddressesMainnet {}



interface ICompoundOracle {

    function getUnderlyingPrice(address cToken) external view returns (uint);

}



interface IDfFinanceClose {



    // // setup with Compound Oracle eth price

    // function setupStrategy(

    //     address _owner, address _dfWallet, uint256 _deposit, uint8 _profitPercent, uint8 _fee

    // ) external;



    // setup with special eth price

    function setupStrategy(

        address _owner, address _dfWallet, uint256 _deposit, uint256 _priceEth, uint8 _profitPercent, uint8 _fee

    ) external;



    // setup with special eth price and current extraCoef \u2013 for strategy migration

    function setupStrategy(

        address _owner, address _dfWallet, uint256 _deposit, uint256 _priceEth, uint8 _profitPercent, uint8 _fee, uint256 _extraCoef

    ) external;



    // setup empty strategy (without deposit)

    function setupStrategy(

        address _owner, address _dfWallet, uint8 _profitPercent, uint8 _fee

    ) external;



    function getStrategy(

        address _dfWallet

    ) external view

    returns(

        address strategyOwner,

        uint deposit,

        uint extraCoef,

        uint entryEthPrice,

        uint profitPercent,

        uint fee,

        uint ethForRedeem,

        uint usdToWithdraw,

        bool onlyProfitInUsd);



    function migrateStrategies(address[] calldata _dfWallets) external;



    function collectAndCloseByUser(

        address _dfWallet,

        uint256 _ethForRedeem,

        uint256 _minAmountUsd,

        bool _onlyProfitInUsd,

        bytes calldata _exData

    ) external payable;



    function exitAfterLiquidation(

        address _dfWallet,

        uint256 _ethForRedeem,

        uint256 _minAmountUsd,

        bytes calldata _exData

    ) external payable;



    function depositEth(address _dfWallet) external payable;



}



interface IDfTokenizedStrategy {



    function initialize(

        string calldata _tokenName,

        string calldata _tokenSymbol,

        address payable _owner,

        address _issuer,

        bool _onlyWithProfit,

        bool _transferDepositToOwner,

        uint[5] calldata _params,     // extraCoef [0], profitPercent [1], usdcToBuyEth [2], ethType [3], closingType [4]

        bytes calldata _exchangeData

    ) external payable;



    function strategyToken() external view returns(address);



    function dfFinanceClose() external view returns(address);



    function strategy() external view returns (

        uint initialEth,                    // in eth \u2013 max more 1.2 mln eth

        uint entryEthPrice,                 // in usd \u2013 max more 1.2 mln USD for 1 eth

        uint profitPercent,                 // min profit percent

        bool onlyWithProfit,                // strategy can be closed only with profitPercent profit

        bool transferDepositToOwner,        // deposit will be transferred to the owner after closing the strategy

        uint closingType,                   // strategy closing type

        bool isStrategyClosed               // strategy is closed

    );



    function migrateStrategies(address[] calldata _dfWallets) external;



    function collectAndCloseByUser(

        address _dfWallet,

        uint256 _ethForRedeem,

        uint256 _minAmountUsd,

        bool _onlyProfitInUsd,

        bytes calldata _exData

    ) external payable;



    function exitAfterLiquidation(

        address _dfWallet,

        uint256 _ethForRedeem,

        uint256 _minAmountUsd,

        bytes calldata _exData

    ) external payable;



    function depositEth(address _dfWallet) external payable;



}



contract DfTokenMarket is

    Initializable,

    DSMath,

    ConstantAddresses,

    FundsMgrUpgradable

{

    using UniversalERC20 for IToken;



    struct Purchase {

        uint80 tokenPrice;

        uint80 tokenAmount;

    }



    // initialize only once

    address public dfTokenizedStrategy;

    address public dfStrategyToken;

    address public dfWallet;

    uint public exitFeePercent;



    uint public tokenPrice;



    mapping(address => Purchase) public purchases;



    // ** EVENTS **



    event TokensBought(

        address indexed user, uint tokenAmount, uint ethToBuy

    );



    event TokensRefund(

        address indexed user, uint tokenAmount, uint ethForRefund

    );



    // ** MODIFIERS **



    modifier onlyActive {

        require(!isStrategyClosed(), "Strategy is closed");

        _;

    }



    modifier onlyAfterStrategyClosing {

        require(isStrategyClosed(), "Strategy is not closed");

        _;

    }



    // ** INITIALIZER **



    function initialize(

        address payable _owner,

        address _tokenizedStrategy,

        address _dfWallet,          // dfWallet address of TokenizedStrategy \u2013 needs to get extraCoef

        uint _tokenPrice,           // price for 1 token in ETH

        uint _exitFeePercent        // fee (decimals == 1e18) \u2013 ex. 30 * 1e18 == 30%

    ) public initializer {

        // Initialize Parent Contract

        FundsMgrUpgradable.initialize(_owner);



        require(_exitFeePercent <= 100 * WAD, "exitFeePercent cannot be greater than 100%");



        // check dfWallet

        (address strategyOwner,,,,,,,,) = IDfFinanceClose(

            IDfTokenizedStrategy(_tokenizedStrategy).dfFinanceClose()

        ).getStrategy(_dfWallet);

        require(_tokenizedStrategy == strategyOwner, "Incorrect dfWallet address");



        address tokenAddr = IDfTokenizedStrategy(_tokenizedStrategy).strategyToken();



        // Init states

        dfTokenizedStrategy = _tokenizedStrategy;

        dfStrategyToken = tokenAddr;

        dfWallet = _dfWallet;

        exitFeePercent = _exitFeePercent;



        tokenPrice = _tokenPrice;

    }



    // ** PUBLIC VIEW functions **



    function getCurPriceEth() public view returns(uint256) {

        // eth - usdc price call to Compound Oracle contract

        uint price = ICompoundOracle(COMPOUND_ORACLE).getUnderlyingPrice(CUSDC_ADDRESS) / 1e12;   // get 1e18 price * 1e12

        return wdiv(WAD, price);

    }



    function isStrategyClosed() public view returns (bool isStrategyClosed) {

        (,,,,,, isStrategyClosed) = IDfTokenizedStrategy(dfTokenizedStrategy).strategy();

    }



    // calculate refund price for user's address

    function calculateRefundPrice(address _user) public view returns (

        uint tokenRefundPrice

    ) {

        uint userTokenPrice = purchases[_user].tokenPrice;

        uint curTokenPrice = getCurPriceEth();



        // get extraCoef of strategy (ex. 150 == 150%)

        (,, uint extraCoef,,,,,,) = IDfFinanceClose(

            IDfTokenizedStrategy(dfTokenizedStrategy).dfFinanceClose()

        ).getStrategy(dfWallet);



        // current price is higher than entry price

        if (curTokenPrice >= userTokenPrice) {

            return tokenRefundPrice = userTokenPrice;

        }



        uint userLoss = wmul(sub(userTokenPrice, curTokenPrice), wdiv(extraCoef * WAD, 100 * WAD));



        if (userLoss > userTokenPrice) {

            return tokenRefundPrice = 0;

        }



        tokenRefundPrice = sub(userTokenPrice, userLoss);

    }



    // ** PUBLIC functions **



    function buyTokens() public payable

        onlyActive

    {

        _buyTokens(msg.sender);

    }



    function buyTokens(address _user) public payable

        onlyActive

    {

        _buyTokens(_user);

    }



    function refundTokens(uint _tokensToRefund) public

        onlyActive

    {

        _refundTokens(msg.sender, _tokensToRefund);

    }



    // ** ONLY_OWNER functions **



    function addTokensToMarket(uint _amount) public onlyOwner {

        // transfer tokens from owner to this contract

        IToken(dfStrategyToken).universalTransferFrom(msg.sender, address(this), _amount);

    }



    function withdrawTokensFromMarket(uint _amount) public onlyOwner {

        // transfer tokens from this contract to owner

        IToken(dfStrategyToken).universalTransfer(msg.sender, _amount);

    }



    function setTokenPrice(uint _tokenPrice) public onlyOwner {

        require(_tokenPrice > 0, "Token Price cannot be zero");

        tokenPrice = _tokenPrice;

    }



    // withdraw profit after strategy closing

    function withdraw(address _token, uint256 _amount) public

        /** onlyOwner check in super function */

        onlyAfterStrategyClosing

    {

        super.withdraw(_token, _amount);

    }



    // withdraw profit after strategy closing

    function withdrawAll(address[] memory _tokens) public

        /** onlyOwner check in super function */

        onlyAfterStrategyClosing

    {

        super.withdrawAll(_tokens);

    }



    // ** INTERNAL functions **



    function _buyTokens(address _user) internal {

        Purchase memory purchase = purchases[_user];



        uint curTokenPrice = tokenPrice;

        uint tokensToBuy = wmul(msg.value, curTokenPrice);



        // UPD states

        purchases[_user].tokenPrice = uint80(

            wdiv(

                add(wmul(purchase.tokenAmount, purchase.tokenPrice), wmul(tokensToBuy, curTokenPrice)),

                add(purchase.tokenAmount, tokensToBuy)

            )

        );

        purchases[_user].tokenAmount = uint80(add(purchase.tokenAmount, tokensToBuy));



        // transfer tokens from this contract to buyer

        IToken(dfStrategyToken).universalTransfer(_user, tokensToBuy);



        emit TokensBought(_user, tokensToBuy, msg.value);

    }



    function _refundTokens(address _user, uint _tokensToRefund) internal {

        Purchase memory purchase = purchases[_user];



        uint ethToUser = wdiv(_tokensToRefund, purchase.tokenPrice);

        require(ethToUser > 0, "No tokens to refund");



        // UPD states

        purchases[_user].tokenAmount = uint80(sub(purchase.tokenAmount, _tokensToRefund));



        // if user refund all tokens

        if (purchase.tokenAmount == _tokensToRefund) {

            purchases[_user].tokenPrice = 0;

        }



        // transfer tokens from user to this contract

        IToken(dfStrategyToken).universalTransferFrom(_user, address(this), _tokensToRefund);



        // transfer ETH to user

        IToken(ETH_ADDRESS).universalTransfer(_user, ethToUser);



        emit TokensRefund(_user, _tokensToRefund, ethToUser);

    }



}
