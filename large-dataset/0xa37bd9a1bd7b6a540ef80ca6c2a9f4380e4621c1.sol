pragma solidity ^0.7.0;

//SPDX-License-Identifier: UNLICENSED

//t.me/OnlyForDegens



interface IERC20 {

    function totalSupply() external view returns (uint);

    function balanceOf(address who) external view returns (uint);

    function allowance(address owner, address spender) external view returns (uint);

    function transfer(address to, uint value) external returns (bool);

    function approve(address spender, uint value) external returns (bool);

    function transferFrom(address from, address to, uint value) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);

    event Approval(address indexed owner, address indexed spender, uint value);

}

interface IUNIv2 {

    function addLiquidityETH(address token, uint amountTokenDesired, uint amountTokenMin, uint amountETHMin, address to, uint deadline) 

    external 

    payable 

    returns (uint amountToken, uint amountETH, uint liquidity);

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



contract OFD is IERC20, Context {

    

    using SafeMath for uint;

    using Address for address;

    IUNIv2 uniswap = IUNIv2(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);



    string public _symbol;

    string public _name;

    uint8 public _decimals;

    uint _totalSupply;

    uint public tokensBought;

    bool public isStopped = false;

    bool public canRefund = false;

    bool public devClaimed = false;

    bool public moonMissionStarted = false;

    bool public feeOnTransfer = false;

    uint public canRefundTime;

    uint public tokensForUniswap = 13 ether;

    uint256 tokensForAidrop = 3 ether;

    address payable owner;

    uint256 public ethAmount = 1 ether;

    mapping(address => uint) _balances;

    mapping(address => mapping(address => uint)) _allowances;

    mapping(address => uint) bought;



    modifier onlyWhenRunning {

        require(!isStopped);

        _;

    }



     modifier onlyOwner() {

        require(msg.sender == owner, "You are not the owner");

        _;

    }

    

    constructor() {

        owner = msg.sender; 

        _symbol = "OFD";

        _name = "OnlyForDegens";

        _decimals = 18;

        _totalSupply = 40 ether;

        _balances[address(this)] = _totalSupply;

        emit Transfer(address(0), address(this), _totalSupply);

    }

    

    

    receive() external payable {

        

        buyTokens();

    }

    

    function airDrop(address[] memory recipients) external onlyOwner{

        for (uint256 i = 0; i < recipients.length; i++) {

            if (balanceOf(address(this)) >= 1 ether)

                transfer(recipients[i],1 ether);

        }

    }

    

    function pauseUnpausePresale(bool _isStopped) external onlyOwner{

        isStopped = _isStopped;

    }

    function claimDevFee() external onlyOwner {

       require(!devClaimed);

       uint256 amountETH = address(this).balance.mul(10).div(100);

       uint256 amountOFT = _totalSupply.mul(5).div(100); // 2 tokens 

       uint256 marketingOFT = _totalSupply.mul(5).div(100); // 2 tokens 



       owner.transfer(amountETH);

       _balances[owner] = _balances[owner].add(amountOFT.add(marketingOFT));

       _balances[address(this)] = _balances[address(this)].sub(amountOFT.add(marketingOFT));

       devClaimed = true;

       emit Transfer(address(this), owner, amountOFT.add(marketingOFT));

    }

    function enableRefundAllFucDDEGENS() external onlyOwner {

        canRefund = true;

        canRefundTime = block.timestamp + 2 minutes; 

    } 

    

    function refundCaller() external {

        require(canRefund == true);

        require(block.timestamp >= canRefundTime);

        require(address(this).balance >= ethAmount);

        if (bought[msg.sender] == ethAmount){

            msg.sender.transfer(ethAmount);

            _balances[msg.sender] = _balances[msg.sender].sub(ethAmount);

             bought[msg.sender] = 0;

        }

    }

    



    function buyTokens() onlyWhenRunning public payable {

        require(msg.value == ethAmount, "You did not sent exactly 1 ETH");

        require(tokensBought < 20 ether, "Hard cap reached");

        require(bought[msg.sender] == 0 , "You already bought");

        require(!canRefund);

        uint tokens = msg.value;

        require(_balances[address(this)] >= tokens);

        _balances[msg.sender] = _balances[msg.sender].add(tokens);

        _balances[address(this)] = _balances[address(this)].sub(tokens);

        bought[msg.sender] = bought[msg.sender].add(msg.value);

        tokensBought = tokensBought.add(tokens);

        emit Transfer(address(this), msg.sender, tokens);

    }

    

    function isUserBoughtInPresale(address user) external view returns(bool){

        if (bought[user] == ethAmount)

            return true;

        else

            return false;

    }

    

    function moonMissionStart() external onlyOwner {

        require(devClaimed == true);

        require(!moonMissionStarted);

        uint256 ETH = address(this).balance;

        uint tokensToBurn = balanceOf(address(this)).sub(tokensForUniswap).sub(tokensForAidrop);



        this.approve(address(uniswap), tokensForUniswap);

        uniswap.addLiquidityETH

        { value: ETH }

        (

            address(this),

            tokensForUniswap,

            tokensForUniswap,

            ETH,

            address(0),

            block.timestamp + 5 minutes

        );

        if (tokensToBurn > 0) {

         _balances[address(this)] = _balances[address(this)].sub(tokensToBurn);

          emit Transfer(address(this), address(0), tokensToBurn);

        }

        if(!isStopped)

            isStopped = true;

            

        moonMissionStarted = true;

        feeOnTransfer = true;

   }

    

    function name() public view returns (string memory) {

        return _name;

    }



    function symbol() public view returns (string memory) {

        return _symbol;

    }



    function decimals() public view returns (uint8) {

        return _decimals;

    }



    function totalSupply() public view override returns (uint256) {

        return _totalSupply;

    }



    function balanceOf(address account) public view override returns (uint256) {

        return _balances[account];

    }





    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {

        _transfer(_msgSender(), recipient, amount);

        return true;

    }



    function allowance(address _owner, address spender) public view virtual override returns (uint256) {

        return _allowances[_owner][spender];

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



    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {

        _transfer(sender, recipient, amount);

        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));

        return true;

    }





    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {

        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));

        return true;

    }





    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {

        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));

        return true;

    }



    function _transfer(address sender, address recipient, uint256 amount) internal virtual {

        require(sender != address(0), "ERC20: transfer from the zero address");

        require(recipient != address(0), "ERC20: transfer to the zero address");



        if (feeOnTransfer == true){

        uint256 ToBurn = amount.mul(3).div(100);

        uint256 ToTransfer = amount.sub(ToBurn);

        

        _burn(sender, ToBurn);

        _beforeTokenTransfer(sender, recipient, ToTransfer);



        _balances[sender] = _balances[sender].sub(ToTransfer, "ERC20: transfer amount exceeds balance");

        _balances[recipient] = _balances[recipient].add(ToTransfer);

        emit Transfer(sender, recipient, ToTransfer);

    }

        else {

        _beforeTokenTransfer(sender, recipient, amount);



        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");

        _balances[recipient] = _balances[recipient].add(amount);

        emit Transfer(sender, recipient, amount);

        }

    }





    function _burn(address account, uint256 amount) internal virtual {

        require(account != address(0), "ERC20: burn from the zero address");



        _beforeTokenTransfer(account, address(0), amount);



        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");

        _totalSupply = _totalSupply.sub(amount);

        emit Transfer(account, address(0), amount);

    }



    function _approve(address _owner, address spender, uint256 amount) internal virtual {

        require(_owner != address(0), "ERC20: approve from the zero address");

        require(spender != address(0), "ERC20: approve to the zero address");



        _allowances[_owner][spender] = amount;

        emit Approval(_owner, spender, amount);

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
