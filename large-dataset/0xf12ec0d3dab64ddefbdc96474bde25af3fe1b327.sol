pragma solidity 0.6.12;





// 

/**

 * @dev Interface of the ERC20 standard as defined in the EIP.

 */

interface INBUNIERC20 {

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





    event Log(string log);



}



// 

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



// 

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



// 

interface IFeeApprover {



    function check(

        address sender,

        address recipient,

        uint256 amount

    ) external returns (bool);



    function setFeeMultiplier(uint _feeMultiplier) external;

    function feePercentX100() external view returns (uint);



    function setTokenUniswapPair(address _tokenUniswapPair) external;

   

    function setCoreTokenAddress(address _coreTokenAddress) external;

    function updateTxState() external;

    function calculateAmountsAfterFee(        

        address sender, 

        address recipient, 

        uint256 amount

    ) external  returns (uint256 transferToAmount, uint256 transferToFeeBearerAmount);



    function setPaused() external;

 



}



interface ICoreVault {

    function addPendingRewards(uint _amount) external;

}



// 

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



interface IUniswapV2Factory {

    event PairCreated(address indexed token0, address indexed token1, address pair, uint);



    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function migrator() external view returns (address);



    function getPair(address tokenA, address tokenB) external view returns (address pair);

    function allPairs(uint) external view returns (address pair);

    function allPairsLength() external view returns (uint);



    function createPair(address tokenA, address tokenB) external returns (address pair);



    function setFeeTo(address) external;

    function setFeeToSetter(address) external;

    function setMigrator(address) external;

}



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



interface IWETH {

    function deposit() external payable;

    function transfer(address to, uint value) external returns (bool);

    function withdraw(uint) external;

}



// 

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



// 

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



// 

// import "@nomiclabs/buidler/console.sol";

// for WETH

// interface factorys

// interface factorys

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**

 * @dev Implementation of the {IERC20} interface.

 */

contract NBUNIERC20 is INBUNIERC20, Ownable {

    using SafeMath for uint256;

    using Address for address;



    mapping(address => uint256) private _balances;



    mapping(address => mapping(address => uint256)) private _allowances;



    event LiquidityAddition(address indexed dst, uint value);

    event LPTokenClaimed(address dst, uint value);



    uint256 private _totalSupply;



    string private _name;

    string private _symbol;

    uint8 private _decimals;

    uint256 public constant initialSupply = 1_000_000_000 * 1e18; // 1 billion STACY



    function initialSetup(address router, address factory) internal {

        _name = "Stacy";

        _symbol = "STACY";

        _decimals = 18;

        _mint(address(this), initialSupply);

        uniswapRouterV2 = IUniswapV2Router02(router != address(0) ? router : 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D); // For testing

        uniswapFactory = IUniswapV2Factory(factory != address(0) ? factory : 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f); // For testing

        createUniswapPairMainnet();

    }



    IUniswapV2Router02 public uniswapRouterV2;

    IUniswapV2Factory public uniswapFactory;

    address public tokenUniswapPair;



    uint256 public constant FCFS_START_TIME = 1604073600; // Fri Oct 30 2020 16:00:00 UTC

    uint256 public constant FCFS_END_TIME = 1604073600 + 1 hours; // Fri Oct 30 2020 17:00:00 UTC



    function createUniswapPairMainnet() public returns (address) {

        require(tokenUniswapPair == address(0), "Token: pool already created");

        tokenUniswapPair = uniswapFactory.createPair(

            address(uniswapRouterV2.WETH()),

            address(this)

        );

        return tokenUniswapPair;

    }



    function liquidityGenerationOngoing() public view returns (bool) {

        return FCFS_END_TIME > block.timestamp && !hardCapReached();

    }



    function hardCapReached() public view returns (bool) {

        return totalETHContributed > HARDCAP;

    }



    function isWithinCappedSaleWindow() public view returns (bool) {

        return block.timestamp < FCFS_START_TIME; 

    }



    // Emergency drain in case of a bug

    // Adds all funds to owner to refund people

    // Designed to be as simple as possible

    function emergencyDrain24hAfterLiquidityGenerationEventIsDone() public onlyOwner {

        require(block.timestamp > (FCFS_END_TIME + 24 hours), "Liquidity generation grace period still ongoing"); // About 24h after liquidity generation happens        

        (bool success, ) = msg.sender.call.value(address(this).balance)("");

        require(success, "Transfer failed.");

        _balances[msg.sender] = _balances[address(this)];

        _balances[address(this)] = 0;

    }



    uint256 public totalLPTokensMinted;

    uint256 public totalETHContributed;

    uint256 public LPperETHUnit;



    bool public LPGenerationCompleted;

    // Sends all avaibile balances and mints LP tokens

    // Possible ways this could break addressed 

    // 1) Multiple calls and resetting amounts - addressed with boolean

    // 2) Failed WETH wrapping/unwrapping addressed with checks

    // 3) Failure to create LP tokens, addressed with checks

    // 4) Unacceptable division errors . Addressed with multiplications by 1e18

    // 5) Pair not set - impossible since its set in constructor

    function addLiquidityToUniswapSTACYxWETHPair() public onlyOwner {

        require(liquidityGenerationOngoing() == false, "Liquidity generation onging");

        require(LPGenerationCompleted == false, "Liquidity generation already finished");

        totalETHContributed = address(this).balance;

        IUniswapV2Pair pair = IUniswapV2Pair(tokenUniswapPair);

        // console.log("Balance of this", totalETHContributed / 1e18);

        //Wrap eth

        address WETH = uniswapRouterV2.WETH();

        IWETH(WETH).deposit{value : totalETHContributed}();

        require(address(this).balance == 0 , "Transfer Failed");

        IWETH(WETH).transfer(address(pair),totalETHContributed);

        _balances[address(pair)] = _balances[address(this)];

        _balances[address(this)] = 0;

        pair.mint(address(this));

        totalLPTokensMinted = pair.balanceOf(address(this));

        // console.log("Total tokens minted",totalLPTokensMinted);

        require(totalLPTokensMinted != 0 , "LP creation failed");

        LPperETHUnit = totalLPTokensMinted.mul(1e18).div(totalETHContributed); // 1e18x for  change

        // console.log("Total per LP token", LPperETHUnit);

        require(LPperETHUnit != 0 , "LP creation failed");

        LPGenerationCompleted = true;

        lastPopTime = block.timestamp;

    }



    mapping (address => uint) public whitelists;



    function addWhitelists(address[] calldata _addresses, uint[] calldata _caps) external onlyOwner {

        require(_addresses.length == _caps.length, "diff arrays");

        for (uint256 i = 0; i < _addresses.length; i++) {

            addWhitelist(_addresses[i], _caps[i]);

        }

    }



    function addWhitelist(address _address, uint _cap) public onlyOwner {

        whitelists[_address] = _cap;

    }



    mapping (address => uint) public ethContributed;



    uint public constant HARDCAP = 690 ether;



    receive() payable external {

        addLiquidity();

    }



    // Possible ways this could break addressed

    // 1) Adding liquidity after generaion is over - added require

    // 2) Overflow from uint - impossible there isnt that much ETH aviable 

    // 3) Depositing 0 - not an issue it will just add 0 to tally

    function addLiquidity() public payable {

        require(liquidityGenerationOngoing(), "Liquidity Generation Event over");

        require(ethContributed[msg.sender].add(msg.value) <= HARDCAP, "harcap reached");

        require(

            !isWithinCappedSaleWindow() || (ethContributed[msg.sender].add(msg.value) <= whitelists[msg.sender]),

            "individual cap exceeded or not whitelisted"

        );



        ethContributed[msg.sender] += msg.value; // Overflow protection from safemath is not neded here 

        totalETHContributed = totalETHContributed.add(msg.value); // for front end display during LGE. This resets with definietly correct balance while calling pair.

        emit LiquidityAddition(msg.sender, msg.value);

    }

    

    // Possible ways this could break addressed

    // 1) Accessing before event is over and resetting eth contributed -- added require

    // 2) No uniswap pair - impossible at this moment because of the LPGenerationCompleted bool

    // 3) LP per unit is 0 - impossible checked at generation function

    function claimLPTokens() public {

        require(LPGenerationCompleted, "Event not over yet");

        require(ethContributed[msg.sender] > 0 , "Nothing to claim, move along");

        IUniswapV2Pair pair = IUniswapV2Pair(tokenUniswapPair);

        uint256 amountLPToTransfer = ethContributed[msg.sender].mul(LPperETHUnit).div(1e18);

        pair.transfer(msg.sender, amountLPToTransfer); // stored as 1e18x value for change

        ethContributed[msg.sender] = 0;

        emit LPTokenClaimed(msg.sender, amountLPToTransfer);

    }



    // POP THE CHERRY



    INBUNIERC20 internal constant CHADS = INBUNIERC20(0x69692D3345010a207b759a7D1af6fc7F38b35c5E);



    INBUNIERC20 internal constant EMTRG = INBUNIERC20(0xBd2949F67DcdC549c6Ebe98696449Fa79D988A9F);



    uint256 public lastPopTime;



    uint256 public totalPopped;



    bool public burnCherryPopRewards = false;



    uint256 public cherryPopBurnPct = 1;



    function setCherryPopBurnPct(uint _cherryPopBurnPct) external onlyOwner {

        cherryPopBurnPct = _cherryPopBurnPct;

    }



    uint256 public cherryPopBurnCallerRewardPct = 1;



    function setCherryPopBurnCallerRewardPct(uint _cherryPopBurnCallerRewardPct) external onlyOwner {

        cherryPopBurnCallerRewardPct = _cherryPopBurnCallerRewardPct;

    }



    function setBurnCherryPopRewards(bool _burnCherryPopRewards) external onlyOwner {

        burnCherryPopRewards = _burnCherryPopRewards;

    }



    event CherryPopped(address chad, uint256 cherryPopAmount);



    /*

     * Every 24 hours, 1% of the STACY in the STACY/ETH liquidity pool is burnt and redistributed to LP token stakers.

     */

    function cherryPop() external {

        require(LPGenerationCompleted, "Liquidity generation is not finished");

        require(CHADS.balanceOf(msg.sender) >= 10000e18 || EMTRG.balanceOf(msg.sender) >= 1000e18, "must hold 10,000 CHADS or 1,000 EMTR");

        uint256 cherryPopAmount = getCherryPopAmount();

        require(cherryPopAmount >= 1e18, "min cherry pop amount not reached");



        lastPopTime = block.timestamp;



        uint256 userReward = cherryPopAmount.mul(cherryPopBurnCallerRewardPct).div(100);

        _transfer(tokenUniswapPair, msg.sender, userReward);



        uint256 cherryPopFeeDistributionAmount = cherryPopAmount.sub(userReward);



        if (burnCherryPopRewards) {

            _burn(tokenUniswapPair, cherryPopFeeDistributionAmount);        

        } else if (cherryPopFeeDistributionAmount > 0 && feeDistributor != address(0)) {

            _balances[feeDistributor] = _balances[feeDistributor].add(cherryPopFeeDistributionAmount);

            emit Transfer(tokenUniswapPair, feeDistributor, cherryPopFeeDistributionAmount);

            ICoreVault(feeDistributor).addPendingRewards(cherryPopFeeDistributionAmount);

        }



        totalPopped = totalPopped.add(cherryPopFeeDistributionAmount);



        IUniswapV2Pair pair = IUniswapV2Pair(tokenUniswapPair);

        pair.sync();



        emit CherryPopped(msg.sender, cherryPopAmount);

    }



    function getCherryPopAmount() public view returns (uint256) {

        uint256 timeBetweenLastPop = block.timestamp - lastPopTime;

        uint256 tokensInUniswapPair = balanceOf(tokenUniswapPair);

        return (tokensInUniswapPair.mul(cherryPopBurnPct)

            .mul(timeBetweenLastPop))

            .div(1 days)

            .div(100);

    }



    // ERC20



    function name() public view returns (string memory) {

        return _name;

    }



    function symbol() public view returns (string memory) {

        return _symbol;

    }



    function decimals() public view returns (uint8) {

        return _decimals;

    }



    function totalSupply() public override view returns (uint256) {

        return _totalSupply;

    }



    function balanceOf(address _owner) public override view returns (uint256) {

        return _balances[_owner];

    }    



    /**

     * @dev See {IERC20-transfer}.

     *

     * Requirements:

     *

     * - `recipient` cannot be the zero address.

     * - the caller must have a balance of at least `amount`.

     */

    function transfer(address recipient, uint256 amount)

        public

        virtual

        override

        returns (bool)

    {

        _transfer(_msgSender(), recipient, amount);

        return true;

    }



    /**

     * @dev See {IERC20-allowance}.

     */

    function allowance(address owner, address spender)

        public

        virtual

        override

        view

        returns (uint256)

    {

        return _allowances[owner][spender];

    }



    /**

     * @dev See {IERC20-approve}.

     *

     * Requirements:

     *

     * - `spender` cannot be the zero address.

     */

    function approve(address spender, uint256 amount)

        public

        virtual

        override

        returns (bool)

    {

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

    function transferFrom(

        address sender,

        address recipient,

        uint256 amount

    ) public virtual override returns (bool) {

        _transfer(sender, recipient, amount);

        _approve(

            sender,

            _msgSender(),

            _allowances[sender][_msgSender()].sub(

                amount,

                "ERC20: transfer amount exceeds allowance"

            )

        );

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

    function increaseAllowance(address spender, uint256 addedValue)

        public

        virtual

        returns (bool)

    {

        _approve(

            _msgSender(),

            spender,

            _allowances[_msgSender()][spender].add(addedValue)

        );

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

    function decreaseAllowance(address spender, uint256 subtractedValue)

        public

        virtual

        returns (bool)

    {

        _approve(

            _msgSender(),

            spender,

            _allowances[_msgSender()][spender].sub(

                subtractedValue,

                "ERC20: decreased allowance below zero"

            )

        );

        return true;

    }



    function setShouldTransferChecker(address _transferCheckerAddress)

        public

        onlyOwner

    {

        transferCheckerAddress = _transferCheckerAddress;

    }



    address public transferCheckerAddress;



    function setFeeDistributor(address _feeDistributor)

        public

        onlyOwner

    {

        feeDistributor = _feeDistributor;

    }



    address public feeDistributor;





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

    function _transfer(

        address sender,

        address recipient,

        uint256 amount

    ) internal virtual {

        require(sender != address(0), "ERC20: transfer from the zero address");

        require(recipient != address(0), "ERC20: transfer to the zero address");

        

        _beforeTokenTransfer(sender, recipient, amount);



        _balances[sender] = _balances[sender].sub(

            amount,

            "ERC20: transfer amount exceeds balance"

        );

        

        (uint256 transferToAmount, uint256 transferToFeeDistributorAmount) = IFeeApprover(transferCheckerAddress).calculateAmountsAfterFee(sender, recipient, amount);

        // console.log("Sender is :" , sender, "Recipent is :", recipient);

        // console.log("amount is ", amount);



        // Addressing a broken checker contract

        require(transferToAmount.add(transferToFeeDistributorAmount) == amount, "Math broke, does gravity still work?");



        _balances[recipient] = _balances[recipient].add(transferToAmount);

        emit Transfer(sender, recipient, transferToAmount);



        if (transferToFeeDistributorAmount > 0 && feeDistributor != address(0)) {

            _balances[feeDistributor] = _balances[feeDistributor].add(transferToFeeDistributorAmount);

            emit Transfer(sender, feeDistributor, transferToFeeDistributorAmount);

            ICoreVault(feeDistributor).addPendingRewards(transferToFeeDistributorAmount);

        }

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



        _balances[account] = _balances[account].sub(

            amount,

            "ERC20: burn amount exceeds balance"

        );

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

    function _approve(

        address owner,

        address spender,

        uint256 amount

    ) internal virtual {

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

    function _beforeTokenTransfer(

        address from,

        address to,

        uint256 amount

    ) internal virtual {}

}



contract Stacy is NBUNIERC20 {



    uint256 private _totalLock;



    uint256 public lockFromBlock;

    uint256 public lockToBlock;

    

    mapping(address => uint256) private _locks;

    mapping(address => uint256) private _lastUnlockBlock;



    event Lock(address indexed to, uint256 value);



    constructor(address router, address factory) public {

        initialSetup(router, factory);

    }



    function totalBalanceOf(address _holder) public view returns (uint256) {

        return _locks[_holder].add(balanceOf(_holder));

    }



    function lockOf(address _holder) public view returns (uint256) {

        return _locks[_holder];

    }



    function lastUnlockBlock(address _holder) public view returns (uint256) {

        return _lastUnlockBlock[_holder];

    }



    function setLockFromBlock(uint256 _lockFromBlock) public onlyOwner {

        require(_lockFromBlock > lockFromBlock);

        lockFromBlock = _lockFromBlock;

    }    



    function setLockToBlock(uint256 _lockToBlock) public onlyOwner {

        require(_lockToBlock > lockToBlock);

        lockToBlock = _lockToBlock;

    }



    function lock(address _holder, uint256 _amount) public onlyOwner {

        require(_holder != address(0), "ERC20: lock to the zero address");

        require(_amount <= balanceOf(_holder), "ERC20: lock amount over blance");



        _transfer(_holder, address(this), _amount);



        _locks[_holder] = _locks[_holder].add(_amount);

        _totalLock = _totalLock.add(_amount);

        if (_lastUnlockBlock[_holder] < lockFromBlock) {

            _lastUnlockBlock[_holder] = lockFromBlock;

        }

        emit Lock(_holder, _amount);

    }



    function canUnlockAmount(address _holder) public view returns (uint256) {

        if (block.number < lockFromBlock) {

            return 0;

        }

        else if (block.number >= lockToBlock) {

            return _locks[_holder];

        }

        else {

            uint256 releaseBlock = block.number.sub(_lastUnlockBlock[_holder]);

            uint256 numberLockBlock = lockToBlock.sub(_lastUnlockBlock[_holder]);

            return _locks[_holder].mul(releaseBlock).div(numberLockBlock);

        }

    }



    function unlock() public {

        require(_locks[msg.sender] > 0, "ERC20: cannot unlock");

        

        uint256 amount = canUnlockAmount(msg.sender);

        // just for sure

        if (amount > balanceOf(address(this))) {

            amount = balanceOf(address(this));

        }

        _transfer(address(this), msg.sender, amount);

        _locks[msg.sender] = _locks[msg.sender].sub(amount);

        _lastUnlockBlock[msg.sender] = block.number;

        _totalLock = _totalLock.sub(amount);

    }



    // This function is for dev address migrate all balance to a multi sig address

    function transferAll(address _to) public {

        _locks[_to] = _locks[_to].add(_locks[msg.sender]);



        if (_lastUnlockBlock[_to] < lockFromBlock) {

            _lastUnlockBlock[_to] = lockFromBlock;

        }



        if (_lastUnlockBlock[_to] < _lastUnlockBlock[msg.sender]) {

            _lastUnlockBlock[_to] = _lastUnlockBlock[msg.sender];

        }



        _locks[msg.sender] = 0;

        _lastUnlockBlock[msg.sender] = 0;



        _transfer(msg.sender, _to, balanceOf(msg.sender));

    }

}
