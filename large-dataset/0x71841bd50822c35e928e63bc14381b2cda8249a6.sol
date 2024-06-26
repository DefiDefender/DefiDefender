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



contract OwnableUpgradable is Initializable {

    address payable public owner;

    address payable internal newOwnerCandidate;



    // Initializer \u2013 Constructor for Upgradable contracts

    function initialize() initializer public {

        owner = msg.sender;

    }



    modifier onlyOwner {

        require(msg.sender == owner);

        _;

    }



    function changeOwner(address payable newOwner) public onlyOwner {

        newOwnerCandidate = newOwner;

    }



    function acceptOwner() public {

        require(msg.sender == newOwnerCandidate);

        owner = newOwnerCandidate;

    }



    uint256[50] private ______gap;

}



// File: contracts/utils/SafeMath.sol



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



// File: contracts/utils/Address.sol



pragma solidity ^0.5.5;



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

    function initialize() initializer public {

        OwnableUpgradable.initialize();  // Initialize Parent Contract

    }



    function withdraw(address token, uint256 amount) onlyOwner public  {

        require(msg.sender == owner);



        if (token == address(0x0)) {

            owner.transfer(amount);

        } else {

            IToken(token).universalTransfer(owner, amount);

        }

    }

    function withdrawAll(address[] memory tokens) onlyOwner public  {

        for(uint256 i = 0; i < tokens.length;i++) {

            withdraw(tokens[i], IToken(tokens[i]).universalBalanceOf(address(this)));

        }

    }



    uint256[50] private ______gap;

}



// File: contracts/utils/DSMath.sol



pragma solidity ^0.5.0;



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





contract ConstantAddresses is ConstantAddressesMainnet {}





interface IDfWalletFactory {

    function createDfWallet() external returns (address dfWallet);

}





interface ICompoundOracle {

    function getUnderlyingPrice(address cToken) external view returns (uint);

}





interface IComptroller {

    function enterMarkets(address[] calldata cTokens) external returns (uint256[] memory);



    function exitMarket(address cToken) external returns (uint256);



    function getAssetsIn(address account) external view returns (address[] memory);



    function getAccountLiquidity(address account) external view returns (uint256, uint256, uint256);



    function markets(address cTokenAddress) external view returns (bool, uint);

}





interface IDfWallet {

    function deposit(address _tokenIn, address _cTokenIn, uint _amountIn, address _tokenOut, address _cTokenOut, uint _amountOut) external payable;



    function withdraw(address _tokenIn, address _cTokenIn, address _tokenOut, address _cTokenOut) external payable;

}



interface IDfProxyBetCompound {

    function insure(address beneficiary, address wallet, uint256 amountUsd) external;

}





interface IDfFinanceClose {



    function setupStrategy(

        address _owner, address _dfWallet, uint256 _deposit, uint8 _profitPercent, uint8 _fee

    ) external;



}





interface ICToken {

    function mint(uint256 mintAmount) external returns (uint256);



    function mint() external payable;



    function redeem(uint256 redeemTokens) external returns (uint256);



    function redeemUnderlying(uint256 redeemAmount) external returns (uint256);



    function borrow(uint256 borrowAmount) external returns (uint256);



    function repayBorrow(uint256 repayAmount) external returns (uint256);



    function repayBorrow() external payable;



    function repayBorrowBehalf(address borrower, uint256 repayAmount) external returns (uint256);



    function repayBorrowBehalf(address borrower) external payable;



    function liquidateBorrow(address borrower, uint256 repayAmount, address cTokenCollateral)

        external

        returns (uint256);



    function liquidateBorrow(address borrower, address cTokenCollateral) external payable;



    function exchangeRateCurrent() external returns (uint256);



    function supplyRatePerBlock() external returns (uint256);



    function borrowRatePerBlock() external returns (uint256);



    function totalReserves() external returns (uint256);



    function reserveFactorMantissa() external returns (uint256);



    function borrowBalanceCurrent(address account) external returns (uint256);



    function borrowBalanceStored(address account) external view returns (uint256);



    function totalBorrowsCurrent() external returns (uint256);



    function getCash() external returns (uint256);



    function balanceOfUnderlying(address owner) external returns (uint256);



    function underlying() external returns (address);

}





interface ILoanPool {

    function loan(uint _amount) external;

}





interface IProxyOneInchExchange {

    function exchange(IToken fromToken, uint256 amountFromToken, bytes calldata _data) external;

}





contract DfFinanceOpenCompound is Initializable, DSMath, ConstantAddresses, FundsMgrUpgradable {



    // Fees

    uint256 public inFee;

    uint256 public currentFeeForBonusEther;



    // Insurance

    IDfProxyBetCompound public proxyInsuranceBet;

    uint256 public insuranceCoef;  // in percent



    ILoanPool public loanPool;



    // mapping(address => bool) public admins;



    IDfWalletFactory public dfWalletFactory;

    IDfFinanceClose public dfFinanceClose;





    // Initializer \u2013 Constructor for Upgradable contracts

    function initialize() public initializer {

        FundsMgrUpgradable.initialize();  // Initialize Parent Contract



        inFee = 0;

        currentFeeForBonusEther = 30;



        loanPool = ILoanPool(0x9EdAe6aAb4B0f0f8146051ab353593209982d6B6);

        proxyInsuranceBet = IDfProxyBetCompound(0);

        insuranceCoef = 0;

    }





    // **PUBLIC VIEW functions**



    /// @notice Returns the maximum amount of borrow amount available

    /// @dev Due to rounding errors the result is - 100 wei from the exact amount

    function getMaxBorrow(address _cBorrowToken, address _wallet) public view returns (uint) {

        (, uint liquidityInEth, ) = IComptroller(COMPTROLLER).getAccountLiquidity(_wallet);



        if (_cBorrowToken == CETH_ADDRESS) {

            return liquidityInEth;

        }



        uint ethPrice = ICompoundOracle(COMPOUND_ORACLE).getUnderlyingPrice(_cBorrowToken);

        uint liquidityInToken = wdiv(liquidityInEth, ethPrice);



        return sub(liquidityInToken, 100); // cut off 100 wei to handle rounding issues

    }



    function getBorrowUsdcBalance(address _dfWallet) public view returns(uint amount) {

        amount = ICToken(CUSDC_ADDRESS).borrowBalanceStored(_dfWallet);

    }





    // **PUBLIC functions**



    function deal(

        address _walletOwner, uint _coef, uint _profitPercent, bytes memory _data, uint _usdcToBuyEth, uint _ethType

    ) public payable returns(address dfWallet) {

        dfWallet = dealInternal(_walletOwner == address(0) ? msg.sender : _walletOwner,

                                    _profitPercent, _coef, msg.value, _data, _usdcToBuyEth, _ethType);

    }





    // **ONLY_OWNER functions**



    // function setAdmin(address _newAdmin, bool _active) public onlyOwner {

    //     admins[_newAdmin] = _active;

    // }



    function setLoanPool(address _loanAddr) public onlyOwner {

        require(_loanAddr != address(0), "Address must not be zero");

        loanPool = ILoanPool(_loanAddr);

    }



    function setDfWalletFactory(address _dfWalletFactory) public onlyOwner {

        require(_dfWalletFactory != address(0), "Address must not be zero");

        dfWalletFactory = IDfWalletFactory(_dfWalletFactory);

    }



    function setDfFinanceClose(address _dfFinanceClose) public onlyOwner {

        require(_dfFinanceClose != address(0), "Address must not be zero");

        dfFinanceClose = IDfFinanceClose(_dfFinanceClose);

    }



    function setDfProxyBetAddress(IDfProxyBetCompound _proxyBet, uint256 _insuranceCoef) public onlyOwner {

        require(address(_proxyBet) != address(0) && _insuranceCoef > 0 ||

                address(_proxyBet) == address(0) && _insuranceCoef == 0, "Incorrect proxy address or insurance coefficient");



        proxyInsuranceBet = _proxyBet;

        insuranceCoef = _insuranceCoef;  // in percent (5 == 5%)



        // all USDC of this contract approved to BetEthUsdcPrice Contract

        IToken(USDC_ADDRESS).approve(address(_proxyBet), uint(-1));

    }



    function setFees(uint _inFee, uint _currentFeeForBonusEther) public onlyOwner {

        require(_inFee <= 5 && _currentFeeForBonusEther < 100, "Invalid fees");

        inFee = _inFee;

        currentFeeForBonusEther = _currentFeeForBonusEther;

    }





    // **INTERNAL functions**



    function dealInternal(

        address _walletOwner, uint _profitPercent, uint _coef, uint _valueEth, bytes memory _data, uint _usdcToBuyEth, uint _ethType

    ) internal returns(address dfWallet) {

        require(_coef >= 150 && _coef <= 300, "Invalid _coefficient");



        uint extraEth = _valueEth * (_coef - 100) / 100;

        uint extractUsdc = _usdcToBuyEth * (100 + inFee + insuranceCoef) / 100;



        // take an extra eth loan

        loanPool.loan(extraEth);



        // create new dfWallet for user

        dfWallet = dfWalletFactory.createDfWallet();



        // mint cEther and borrow cUSDC

        IDfWallet(dfWallet).deposit.value(_valueEth + extraEth)(ETH_ADDRESS, CETH_ADDRESS, _valueEth + extraEth, USDC_ADDRESS, CUSDC_ADDRESS, extractUsdc);



        // Needs more 15 percent in collateral

        uint maxBorrowUsdc = getMaxBorrow(CUSDC_ADDRESS, dfWallet);

        require(maxBorrowUsdc > 0 && (maxBorrowUsdc * 100 / (maxBorrowUsdc + extractUsdc) >= 15), "Needs more eth in collateral");



        // call DfProxyBet contract (and transferFrom USDC)

        if (address(proxyInsuranceBet) != address(0)) {

            proxyInsuranceBet.insure(_walletOwner, dfWallet, _usdcToBuyEth * insuranceCoef / 100);

        }



        exchangeInternal(IToken(USDC_ADDRESS), _usdcToBuyEth, _ethType == 0 ? IToken(WETH_ADDRESS) : IToken(ETH_ADDRESS), extraEth, _data);



        if (_ethType == 0) {

            IToken(WETH_ADDRESS).withdraw(IToken(WETH_ADDRESS).balanceOf(address(this)));

        }



        // Setup strategy

        dfFinanceClose.setupStrategy(_walletOwner, dfWallet, _valueEth, uint8(_profitPercent), uint8(currentFeeForBonusEther));



        // return an extra eth loan \u2013 all eth

        uint balanceEth = address(this).balance;

        require(balanceEth >= extraEth, "Not enough eth to repay the loan");

        transferEthInternal(address(loanPool), balanceEth);

    }





    function exchangeInternal(

        IToken _fromToken, uint _maxFromTokenAmount, IToken _toToken, uint _minToTokenAmount, bytes memory _data

    ) internal returns(uint) {

        // Proxy call for avoid out of gas in fallback (because of .transfer())

        IProxyOneInchExchange proxyEx = IProxyOneInchExchange(0x3fF9Cc22ef2bF6de5Fd2E78f511EDdF0813f6B36);



        // warning: eth to token not supported by ProxyOneInchExchange

        if (_fromToken.allowance(address(this), address(proxyEx)) != uint256(-1)) {

            _fromToken.approve(address(proxyEx), uint256(-1));

        }



        uint fromTokenBalance = _fromToken.universalBalanceOf(address(this));

        uint toTokenBalance = _toToken.universalBalanceOf(address(this));



        // Proxy call for avoid out of gas in fallback (because of .transfer())

        proxyEx.exchange(_fromToken, _maxFromTokenAmount, _data);



        require(_fromToken.universalBalanceOf(address(this)) + _maxFromTokenAmount >= fromTokenBalance, "Exchange error");



        uint newBalanceToToken = _toToken.universalBalanceOf(address(this));

        require(newBalanceToToken >= toTokenBalance + _minToTokenAmount, "Exchange error");



        return sub(newBalanceToToken, toTokenBalance); // how many tokens received

    }



    function transferEthInternal(address _receiver, uint _amount) internal {

        address payable receiverPayable = address(uint160(_receiver));

        (bool result, ) = receiverPayable.call.value(_amount)("");

        require(result, "Transfer of ETH failed");

    }





    // **FALLBACK functions**

    function() external payable {}



}
