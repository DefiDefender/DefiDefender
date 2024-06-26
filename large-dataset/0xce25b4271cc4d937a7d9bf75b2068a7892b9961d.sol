pragma solidity ^0.7.0;





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

// File: browser/IUnipumpDrain.sol









interface IUnipumpDrain

{

    function drain(address token) external;

}



// File: browser/openzeppelin/Context.sol











abstract contract UnipumpErc20Helper

{

    function transferMax(address token, address from, address to) 

        internal

        returns (uint256 amountTransferred)

    {

        uint256 balance = IERC20(token).balanceOf(from);

        if (balance == 0) { return 0; }

        uint256 allowed = IERC20(token).allowance(from, to);

        amountTransferred = allowed > balance ? balance : allowed;

        if (amountTransferred == 0) { return 0; }

        require (IERC20(token).transferFrom(from, to, amountTransferred), "Transfer failed");

    }

}

// File: browser/IUnipumpContest.sol









interface IUnipumpContest

{

}

// File: browser/IUnipump.sol



















interface IUnipump is IERC20 {

    event Sale(bool indexed _saleActive);

    event LiquidityCrisis();



    function WETH() external view returns (address);

    

    function groupManager() external view returns (IUnipumpGroupManager);

    function escrow() external view returns (IUnipumpEscrow);

    function staking() external view returns (IUnipumpStaking);

    function contest() external view returns (IUnipumpContest);



    function init(

        IUnipumpEscrow _escrow,

        IUnipumpStaking _staking) external;

    function startUnipumpSale(uint256 _tokensPerEth, uint256 _maxSoldEth) external;

    function start(

        IUnipumpGroupManager _groupManager,

        IUnipumpContest _contest) external;



    function isSaleActive() external view returns (bool);

    function tokensPerEth() external view returns (uint256);

    function maxSoldEth() external view returns (uint256);

    function soldEth() external view returns (uint256);

    

    function buy() external payable;

    

    function minSecondsUntilLiquidityCrisis() external view returns (uint256);

    function createLiquidityCrisis() external payable;

}

// File: browser/UnipumpDrain.sol















abstract contract UnipumpDrain is IUnipumpDrain

{

    address payable immutable drainTarget;



    constructor()

    {

        drainTarget = msg.sender;

    }



    function drain(address token)

        public

        override

    {

        uint256 amount;

        if (token == address(0))

        {

            require (address(this).balance > 0, "Nothing to send");

            amount = _drainAmount(token, address(this).balance);

            require (amount > 0, "Nothing allowed to send");

            (bool success,) = drainTarget.call{ value: amount }("");

            require (success, "Transfer failed");

            return;

        }

        amount = IERC20(token).balanceOf(address(this));

        require (amount > 0, "Nothing to send");

        amount = _drainAmount(token, amount);

        require (amount > 0, "Nothing allowed to send");

        require (IERC20(token).transfer(drainTarget, amount), "Transfer failed");

    }



    function _drainAmount(address token, uint256 available) internal virtual returns (uint256 amount);

}

// File: browser/IUnipumpStaking.sol









interface IUnipumpStaking

{

    event Stake(address indexed _staker, uint256 _amount, uint256 _epochCount);

    event Reward(address indexed _staker, uint256 _reward);

    event RewardPotIncrease(uint256 _amount);



    function stakingRewardPot() external view returns (uint256);

    function currentEpoch() external view returns (uint256);

    function nextEpochTimestamp() external view returns (uint256);

    function isActivated() external view returns (bool);

    function secondsUntilCanActivate() external view returns (uint256);

    function totalStaked() external view returns (uint256);

    

    function increaseRewardsPot() external;

    function activate() external;

    function claimRewardsAt(uint256 index) external;

    function claimRewards() external;

    function updateEpoch() external returns (bool);

    function stakeForProfit(uint256 epochCount) external;

}

// File: browser/IUnipumpEscrow.sol











interface IUnipumpEscrow is IUnipumpDrain

{

    function start() external;

    function available() external view returns (uint256);

}

// File: browser/IUnipumpTradingGroup.sol













interface IUnipumpTradingGroup

{

    function leader() external view returns (address);

    function close() external;

    function closeWithNonzeroTokenBalances() external;

    function anyNonzeroTokenBalances() external view returns (bool);

    function tokenList() external view returns (IUnipumpTokenList);

    function maxSecondsRemaining() external view returns (uint256);

    function group() external view returns (IUnipumpGroup);

    function externalBalanceChanges(address token) external view returns (bool);



    function startTime() external view returns (uint256);

    function endTime() external view returns (uint256);

    function maxEndTime() external view returns (uint256);



    function startingWethBalance() external view returns (uint256);

    function finalWethBalance() external view returns (uint256);

    function leaderWethProfitPayout() external view returns (uint256);



    function swapExactTokensForTokens(

        uint256 amountIn,

        uint256 amountOutMin,

        address[] calldata path,

        uint256 deadline

    ) 

        external 

        returns (uint256[] memory amounts);



    function swapTokensForExactTokens(

        uint256 amountOut,

        uint256 amountInMax,

        address[] calldata path,

        uint256 deadline

    ) 

        external 

        returns (uint256[] memory amounts);

        

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(

        uint256 amountIn,

        uint256 amountOutMin,

        address[] calldata path,

        uint256 deadline

    ) 

        external;



    function withdraw(address token) external;

}

// File: browser/IUnipumpTokenList.sol









interface IUnipumpTokenList

{

    function parentList() external view returns (IUnipumpTokenList);

    function isLocked() external view returns (bool);

    function tokens(uint256 index) external view returns (address);

    function exists(address token) external view returns (bool);

    function tokenCount() external view returns (uint256);



    function lock() external;

    function add(address token) external;

    function addMany(address[] calldata _tokens) external;

    function remove(address token) external;    

}

// File: browser/IUnipumpGroup.sol













interface IUnipumpGroup 

{

    function contribute() external payable;

    function abort() external;

    function startPumping() external;

    function isActive() external view returns (bool);

    function withdraw() external;

    function leader() external view returns (address);

    function tokenList() external view returns (IUnipumpTokenList);

    function leaderUppCollateral() external view returns (uint256);

    function requiredMemberUppFee() external view returns (uint256);

    function minEthToJoin() external view returns (uint256);

    function minEthToStart() external view returns (uint256);

    function maxEthAcceptable() external view returns (uint256);

    function maxRunTimeSeconds() external view returns (uint256);

    function leaderProfitShareOutOf10000() external view returns (uint256);

    function memberCount() external view returns (uint256);

    function members(uint256 at) external view returns (address);

    function contributions(address member) external view returns (uint256);

    function totalContributions() external view returns (uint256);

    function aborted() external view returns (bool);

    function tradingGroup() external view returns (IUnipumpTradingGroup);

}

// File: browser/IUnipumpGroupFactory.sol













interface IUnipumpGroupFactory 

{

    function createGroup(

        address leader,

        IUnipumpTokenList unipumpTokenList,

        uint256 uppCollateral,

        uint256 requiredMemberUppFee,

        uint256 minEthToJoin,

        uint256 minEthToStart,

        uint256 startTimeout,

        uint256 maxEthAcceptable,

        uint256 maxRunTimeSeconds,

        uint256 leaderProfitShareOutOf10000

    ) 

        external

        returns (IUnipumpGroup unipumpGroup);

}

// File: browser/IUnipumpGroupManager.sol















interface IUnipumpGroupManager

{

    function groupLeaders(uint256 at) external view returns (address);

    function groupLeaderCount() external view returns (uint256);

    function groups(uint256 at) external view returns (IUnipumpGroup);

    function groupCount() external view returns (uint256);

    function groupCountByLeader(address leader) external view returns (uint256);

    function groupsByLeader(address leader, uint256 at) external view returns (IUnipumpGroup);



    function createGroup(

        IUnipumpTokenList tokenList,

        uint256 uppCollateral,

        uint256 requiredMemberUppFee,

        uint256 minEthToJoin,

        uint256 minEthToStart,

        uint256 startTimeout,

        uint256 maxEthAcceptable,

        uint256 maxRunTimeSeconds,

        uint256 leaderProfitShareOutOf10000

    ) 

        external

        returns (IUnipumpGroup group);

}

// File: browser/uniswap/IWETH.sol



pragma solidity >=0.5.0;





interface IWETH {

    function deposit() external payable;

    function transfer(address to, uint value) external returns (bool);

    function withdraw(uint) external;

}



// File: browser/uniswap/IUniswapV2Router01.sol



pragma solidity >=0.6.2;





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



// File: browser/uniswap/IUniswapV2Router02.sol



pragma solidity >=0.6.2;







interface IUniswapV2Router02 is IUniswapV2Router01 {

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



// File: browser/uniswap/IUniswapV2Pair.sol



pragma solidity >=0.5.0;





interface IUniswapV2Pair {

    event Approval(address indexed owner, address indexed spender, uint value);

    event Transfer(address indexed from, address indexed to, uint value);



    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint);

    function balanceOf(address owner) external view returns (uint);

    function allowance(address owner, address spender) external view returns (uint);



    function approve(address spender, uint value) external returns (bool);

    function transfer(address to, uint value) external returns (bool);

    function transferFrom(address from, address to, uint value) external returns (bool);



    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint);



    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;



    event Mint(address indexed sender, uint amount0, uint amount1);

    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);

    event Swap(

        address indexed sender,

        uint amount0In,

        uint amount1In,

        uint amount0Out,

        uint amount1Out,

        address indexed to

    );

    event Sync(uint112 reserve0, uint112 reserve1);



    function MINIMUM_LIQUIDITY() external pure returns (uint);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    function price0CumulativeLast() external view returns (uint);

    function price1CumulativeLast() external view returns (uint);

    function kLast() external view returns (uint);



    function mint(address to) external returns (uint liquidity);

    function burn(address to) external returns (uint amount0, uint amount1);

    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;

    function skim(address to) external;

    function sync() external;



    function initialize(address, address) external;

}



// File: browser/uniswap/IUniswapV2Factory.sol



pragma solidity >=0.5.0;





interface IUniswapV2Factory {

    event PairCreated(address indexed token0, address indexed token1, address pair, uint);



    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);



    function getPair(address tokenA, address tokenB) external view returns (address pair);

    function allPairs(uint) external view returns (address pair);

    function allPairsLength() external view returns (uint);



    function createPair(address tokenA, address tokenB) external returns (address pair);



    function setFeeTo(address) external;

    function setFeeToSetter(address) external;

}



// File: browser/openzeppelin/Address.sol











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



// File: browser/openzeppelin/SafeMath.sol











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



// File: browser/openzeppelin/IERC20.sol















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



// File: browser/openzeppelin/ERC20.sol



















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

    constructor (string memory name, string memory symbol) {

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



// File: browser/Unipump.sol



































contract Unipump is ERC20, UnipumpDrain, IUnipump, UnipumpErc20Helper

{

    address payable immutable owner;

    IUniswapV2Factory immutable uniswapV2Factory;

    IUniswapV2Router02 immutable uniswapV2Router;

    address immutable public override WETH;

    

    IUniswapV2Pair public uniswapEthUppPair;



    IUnipumpGroupManager public override groupManager;

    IUnipumpEscrow public override escrow;

    IUnipumpStaking public override staking;

    IUnipumpContest public override contest;



    uint256 public override tokensPerEth;

    uint256 public override maxSoldEth;

    uint256 public override soldEth;



    uint256 initialLiquidityTokens;

    uint256 minLiquidityCrisisTime;

    

    constructor(

        IUniswapV2Factory _uniswapV2Factory,          // 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f

        IUniswapV2Router02 _uniswapV2Router            // 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D

    ) 

        ERC20("Unipump", "UPP") 

    {

        require (address(_uniswapV2Factory) != address(0));

        require (address(_uniswapV2Router) != address(0));

        owner = msg.sender;



        uniswapV2Factory = _uniswapV2Factory;

        uniswapV2Router = _uniswapV2Router;



        address weth = _uniswapV2Router.WETH();

        WETH = weth;

    }



    modifier ownerOnly() { require(msg.sender == owner, "Owner only"); _; }



    function init(

        IUnipumpEscrow _escrow,

        IUnipumpStaking _staking

    )

        public 

        override

        ownerOnly()

    {

        require (address(_escrow) != address(0));

        require (address(_staking) != address(0));

        if (address(uniswapEthUppPair) == address(0)) {

            uniswapEthUppPair = IUniswapV2Pair(uniswapV2Factory.createPair(WETH, address(this)));

        }

        else {

            require (address(this).balance == 0 && IERC20(WETH).balanceOf(address(this)) == 0, "Already initialized");

        }

        escrow = _escrow;

        staking = _staking;

    }



    function startUnipumpSale(uint256 _tokensPerEth, uint256 _maxSoldEth)

        public

        override

        ownerOnly()

    {

        require (address(groupManager) == address(0), "Operations have already begun");

        require (tokensPerEth == 0 || _tokensPerEth <= tokensPerEth, "The price can only be pumped higher");

        require (_tokensPerEth > 0 || _maxSoldEth == 0);

        soldEth = 0;

        maxSoldEth = _maxSoldEth;

        if (_tokensPerEth > 0) { tokensPerEth = _tokensPerEth; }

        emit Sale(true);

    }



    function isSaleActive()

        public

        override

        view

        returns (bool)

    {

        return tokensPerEth > 0 && soldEth < maxSoldEth;

    }

    

    function start(

        IUnipumpGroupManager _groupManager,

        IUnipumpContest _contest)

        public

        override

        ownerOnly()

    {

        require (address(_groupManager) != address(0));

        require (address(groupManager) == address(0), "Operations cannot be stopped after having been started");

        require (address(_contest) != address(0));

                

        maxSoldEth = 0;

        groupManager = _groupManager;

        contest = _contest;

                

        uint256 sold = totalSupply(); // 'sold' represents 40% of the total supply

        require (sold > 0);



        uint256 wethBalance = IERC20(WETH).balanceOf(address(this));



        uint256 totalLiquidityEth = address(this).balance / 2 + wethBalance / 2;

        uint256 totalLiquidityUpp = totalLiquidityEth * tokensPerEth * 9 / 10; // pump price by 10% when uniswap is funded



        _mint(address(escrow), sold / 2); // 20% for marketing, team

        _mint(address(contest), sold / 4); // 10% for public pump contests

        _mint(address(this), totalLiquidityUpp + sold / 4); // liquidity (~20%) for uniswap + 10%

        _approve(address(this), address(staking), sold / 4); // 10%

        _approve(address(this), address(uniswapV2Router), totalLiquidityUpp);



        staking.increaseRewardsPot();

        escrow.start();



        if (wethBalance < totalLiquidityEth) {

            IWETH(WETH).deposit{ value: totalLiquidityEth - wethBalance }();

        }



        IERC20(WETH).approve(address(uniswapV2Router), totalLiquidityEth);



        (,,initialLiquidityTokens) = uniswapV2Router.addLiquidity(

            address(this),

            WETH,

            totalLiquidityUpp,

            totalLiquidityEth,

            totalLiquidityUpp,

            totalLiquidityEth,

            address(this),

            block.timestamp);



        minLiquidityCrisisTime = block.timestamp + 60 * 60 * 24 * 30; // Creating a liquidity crisis isn't available for the first month



        emit Sale(false);

    }



    receive() 

        external

        payable

    {

        uint256 tokens = tokensPerEth * msg.value;

        uint256 sold = soldEth;

        require (address(groupManager) == address(0) && tokens > 0 && sold < maxSoldEth, "Tokens are not for sale or you did not send any ETH/WETH");

        _mint(msg.sender, tokens);

        soldEth = sold + msg.value;

    }



    function buy()

        public

        payable

        override

    {       

        uint256 wethAmount = transferMax(WETH, msg.sender, address(this));

        uint256 totalAmount = wethAmount + msg.value;

        uint256 tokens = tokensPerEth * totalAmount;

        uint256 sold = soldEth;

        require (address(groupManager) == address(0) && tokens > 0 && sold < maxSoldEth, "Tokens are not for sale or you did not send any ETH/WETH");

        _mint(msg.sender, tokens);

        soldEth = sold + totalAmount;

    }



    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override { 

        require (from == address(0) || address(groupManager) != address(0), "The contract has not yet become operational");

        super._beforeTokenTransfer(from, to, amount);

    }



    function minSecondsUntilLiquidityCrisis()

        public

        view

        override

        returns (uint256)

    {

        uint256 min = minLiquidityCrisisTime;

        if (min <= block.timestamp) { return 0; }

        return min - block.timestamp;

    }



    // Reduce some liquidity - use to enhance pump effectiveness during bull run!

    function createLiquidityCrisis()

        external

        payable

        override

    {

        require (block.timestamp >= minLiquidityCrisisTime, "It's too early to create a liquidity crisis");

        require (msg.sender == owner || msg.value >= 100 ether, "This can only be called by paying 100 ETH");



        minLiquidityCrisisTime = block.timestamp + 60 * 60 * 24 * 90; // No more for 3 months;



        uint256 liquidity = initialLiquidityTokens / 4;

        uint256 balance = uniswapEthUppPair.balanceOf(address(this));

        if (liquidity > balance) { liquidity = balance; }

        if (liquidity == 0) { return; }



        uniswapEthUppPair.approve(address(uniswapV2Router), liquidity);

        (uint256 amountToken,) = uniswapV2Router.removeLiquidityETH(

            address(this),

            liquidity,

            0,

            0,

            owner,

            block.timestamp);



        _transfer(owner, address(this), amountToken);

        _approve(address(this), address(staking), amountToken);

        staking.increaseRewardsPot();



        emit LiquidityCrisis();

    }



    function _drainAmount(

        address token, 

        uint256 available

    ) 

        internal 

        override

        view

        returns (uint256 amount)

    {

        amount = available;

        

        if (address(groupManager) == address(0) || // Don't allow any drainage until the contract is operational and liquidity funding has been provided

            token == address(uniswapEthUppPair)) // Don't allow drainage of liquidity

        {            

            amount = 0;

        }

    }

}



// File: browser/UnipumpDefaults.sol















contract UnipumpDefaults is Unipump 

{

    constructor() 

        Unipump(

            IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f), // uniswap v2 factory on ethereum mainnet

            IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D) // uniswap v2 router on ethereum mainnet

        ) 

    { }

}
