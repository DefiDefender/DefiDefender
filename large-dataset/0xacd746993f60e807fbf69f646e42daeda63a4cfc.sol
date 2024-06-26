pragma solidity ^0.5.0;



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



contract Context {

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



contract Ownable is Context {

    address private _owner;



    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () internal {

        _owner = _msgSender();

        emit OwnershipTransferred(address(0), _owner);

    }

    function owner() public view returns (address) {

        return _owner;

    }

    modifier onlyOwner() {

        require(isOwner(), "Ownable: caller is not the owner");

        _;

    }

    function isOwner() public view returns (bool) {

        return _msgSender() == _owner;

    }

    function renounceOwnership() public onlyOwner {

        emit OwnershipTransferred(_owner, address(0));

        _owner = address(0);

    }

    function transferOwnership(address newOwner) public onlyOwner {

        _transferOwnership(newOwner);

    }

    function _transferOwnership(address newOwner) internal {

        require(newOwner != address(0), "Ownable: new owner is the zero address");

        emit OwnershipTransferred(_owner, newOwner);

        _owner = newOwner;

    }

}



contract ERC20 is Context, IERC20 {

    using SafeMath for uint256;



    mapping (address => uint256) private _balances;



    mapping (address => mapping (address => uint256)) private _allowances;



    uint256 private _totalSupply;

    function totalSupply() public view returns (uint256) {

        return _totalSupply;

    }

    function balanceOf(address account) public view returns (uint256) {

        return _balances[account];

    }

    function transfer(address recipient, uint256 amount) public returns (bool) {

        _transfer(_msgSender(), recipient, amount);

        return true;

    }

    function allowance(address owner, address spender) public view returns (uint256) {

        return _allowances[owner][spender];

    }

    function approve(address spender, uint256 amount) public returns (bool) {

        _approve(_msgSender(), spender, amount);

        return true;

    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {

        _transfer(sender, recipient, amount);

        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));

        return true;

    }

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {

        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));

        return true;

    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {

        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));

        return true;

    }

    function _transfer(address sender, address recipient, uint256 amount) internal {

        require(sender != address(0), "ERC20: transfer from the zero address");

        require(recipient != address(0), "ERC20: transfer to the zero address");



        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");

        _balances[recipient] = _balances[recipient].add(amount);

        emit Transfer(sender, recipient, amount);

    }

    function _mint(address account, uint256 amount) internal {

        require(account != address(0), "ERC20: mint to the zero address");



        _totalSupply = _totalSupply.add(amount);

        _balances[account] = _balances[account].add(amount);

        emit Transfer(address(0), account, amount);

    }

    function _burn(address account, uint256 amount) internal {

        require(account != address(0), "ERC20: burn from the zero address");



        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");

        _totalSupply = _totalSupply.sub(amount);

        emit Transfer(account, address(0), amount);

    }

    function _approve(address owner, address spender, uint256 amount) internal {

        require(owner != address(0), "ERC20: approve from the zero address");

        require(spender != address(0), "ERC20: approve to the zero address");



        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);

    }

    function _burnFrom(address account, uint256 amount) internal {

        _burn(account, amount);

        _approve(account, _msgSender(), _allowances[account][_msgSender()].sub(amount, "ERC20: burn amount exceeds allowance"));

    }

}



contract ERC20Detailed is IERC20 {

    string private _name;

    string private _symbol;

    uint8 private _decimals;



    constructor (string memory name, string memory symbol, uint8 decimals) public {

        _name = name;

        _symbol = symbol;

        _decimals = decimals;

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

}



contract ReentrancyGuard {

    uint256 private _guardCounter;



    constructor () internal {

        _guardCounter = 1;

    }



    modifier nonReentrant() {

        _guardCounter += 1;

        uint256 localCounter = _guardCounter;

        _;

        require(localCounter == _guardCounter, "ReentrancyGuard: reentrant call");

    }

}



library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns (uint256) {

        uint256 c = a + b;

        require(c >= a, "SafeMath: addition overflow");



        return c;

    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

        return sub(a, b, "SafeMath: subtraction overflow");

    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b <= a, errorMessage);

        uint256 c = a - b;



        return c;

    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        if (a == 0) {

            return 0;

        }



        uint256 c = a * b;

        require(c / a == b, "SafeMath: multiplication overflow");



        return c;

    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {

        return div(a, b, "SafeMath: division by zero");

    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        // Solidity only automatically asserts when dividing by 0

        require(b > 0, errorMessage);

        uint256 c = a / b;



        return c;

    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {

        return mod(a, b, "SafeMath: modulo by zero");

    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b != 0, errorMessage);

        return a % b;

    }

}



library Address {

    function isContract(address account) internal view returns (bool) {

        bytes32 codehash;

        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;

        // solhint-disable-next-line no-inline-assembly

        assembly { codehash := extcodehash(account) }

        return (codehash != 0x0 && codehash != accountHash);

    }

    function toPayable(address account) internal pure returns (address payable) {

        return address(uint160(account));

    }

    function sendValue(address payable recipient, uint256 amount) internal {

        require(address(this).balance >= amount, "Address: insufficient balance");



        // solhint-disable-next-line avoid-call-value

        (bool success, ) = recipient.call.value(amount)("");

        require(success, "Address: unable to send value, recipient may have reverted");

    }

}



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

    function callOptionalReturn(IERC20 token, bytes memory data) private {

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



interface ILendingPoolAddressesProvider {

    function getLendingPool() external view returns (address);

}



interface Aave {

    function deposit(address _reserve, uint256 _amount, uint16 _referralCode) external;

    function borrow(address _reserve, uint256 _amount, uint256 _interestRateModel, uint16 _referralCode) external;

    function getUserBorrowBalances(address _reserve, address _user) external view returns (uint256, uint256, uint256);

    function repay(address _reserve, uint256 _amount, address payable _onBehalfOf) external payable;

}



interface AToken {

    function redeem(uint256 amount) external;

}



interface LendingPoolAddressesProvider {

    function getLendingPool() external view returns (address);

    function getLendingPoolCore() external view returns (address);

}



contract iCollateral is ERC20, ERC20Detailed, ReentrancyGuard, Ownable {

  using SafeERC20 for IERC20;

  using Address for address;

  using SafeMath for uint256;



  address public collateral;



  address public aave;

  address public aavePool;

  address public yAaveToken;



  uint256 public maxBorrow;

  uint256 public maxBorrowBase;

  address public trader;



  address public constant DAI = address(0x6B175474E89094C44Da98b954EedeAC495271d0F);

  address public constant USDC = address(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);

  address public constant USDT = address(0xdAC17F958D2ee523a2206206994597C13D831ec7);



  modifier onlyTrader() {

      require(trader == msg.sender, "itrade: caller is not the trader");

      _;

  }

  function transferTrader(address newOwner) public onlyOwner {

      _transferTrader(newOwner);

  }

  function _transferTrader(address newOwner) internal {

      require(newOwner != address(0), "itrade: new trader is the zero address");

      trader = newOwner;

  }



  constructor() public ERC20Detailed("itrade y.curve.fi", "y.curve.fi", 18) {

    //TUSD collateral

    collateral = address(0x0000000000085d4780B73119b644AE5ecd22b376);



    aave = address(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);

    aavePool = address(0x3dfd23A6c5E8BbcFc9581d2E864a68feb6a076d3);

    // collateral token aTUSD

    yAaveToken = address(0x4DA9b813057D04BAef4e5800E36083717b4a0341);

    maxBorrow = uint256(50);

    maxBorrowBase = uint256(100);



    approveToken();

  }



  // LP deposit

  function deposit(uint256 _amount)

      external

      nonReentrant

  {

      require(_amount > 0, "deposit must be greater than 0");

      uint256 pool = calcPoolValueInToken();



      IERC20(collateral).safeTransferFrom(msg.sender, address(this), _amount);



      // Calculate collateral pool shares

      uint256 shares = 0;

      if (pool == 0) {

        shares = _amount;

        pool = _amount;

      } else {

        shares = (_amount.mul(totalSupply())).div(pool);

      }

      _mint(msg.sender, shares);

  }



  function withdraw(uint256 _shares)

      external

      nonReentrant

  {

      require(_shares > 0, "withdraw must be greater than 0");



      uint256 ibalance = balanceOf(msg.sender);

      require(_shares <= ibalance, "insufficient balance");



      // Could have over value from cTokens

      uint256 pool = calcPoolValueInToken();

      // Calc to redeem before updating balances

      uint256 r = (pool.mul(_shares)).div(totalSupply());



      _burn(msg.sender, _shares);



      // Check balance

      uint256 b = IERC20(collateral).balanceOf(address(this));

      if (b < r) {

        _withdrawSome(r.sub(b));

      }



      uint maxDebt = balanceAave().mul(maxBorrow).div(maxBorrowBase);

      require(calcSystemDebt() < maxDebt, "itrade: over max collateralization");



      IERC20(collateral).safeTransfer(msg.sender, r);

  }



  function getAave() public view returns (address) {

      return LendingPoolAddressesProvider(aave).getLendingPool();

  }



  function getAaveCore() public view returns (address) {

      return LendingPoolAddressesProvider(aave).getLendingPoolCore();

  }



  function approveToken() public {

      // Collateral to Aave

      IERC20(collateral).safeApprove(getAaveCore(), uint(-1));



      // Repayments to Aave

      IERC20(DAI).safeApprove(getAaveCore(), uint(-1));

      IERC20(USDC).safeApprove(getAaveCore(), uint(-1));

      /*IERC20(TUSD).safeApprove(getAaveCore(), uint(-1));*/



      IERC20(USDT).safeApprove(getAaveCore(), uint(0));

      IERC20(USDT).safeApprove(getAaveCore(), uint(-1));

  }



  function balance() public view returns (uint256) {

      return IERC20(collateral).balanceOf(address(this));

  }



  function balanceAaveAvailable() public view returns (uint256) {

      return IERC20(collateral).balanceOf(aavePool);

  }



  function balanceAave() public view returns (uint256) {

      return IERC20(yAaveToken).balanceOf(address(this));

  }



  function borrowAave(address _reserve, uint256 _amount) external onlyTrader {

      require(isReserve(_reserve) == true, "itrade: invalid reserve");

      //0x2 = VARIABLE InterestRateModel

      Aave(getAave()).borrow(_reserve, _amount, 2, 7);

      uint maxDebt = balanceAave().mul(maxBorrow).div(maxBorrowBase);

      require(calcSystemDebt() < maxDebt, "itrade: over max collateralization");

      IERC20(_reserve).safeTransfer(msg.sender, _amount);

  }



  function calcSystemDebt() public view returns (uint256) {

    return getBorrowDebt(DAI).add(getBorrowDebt(USDC)).add(getBorrowDebt(USDT));

  }



  function getBorrowDebt(address _reserve) public view returns (uint256) {

      (,uint256 compounded,) = Aave(getAaveCore()).getUserBorrowBalances(_reserve, address(this));

      return compounded;

  }



  function getBorrowInterest(address _reserve) public view returns (uint256) {

      (uint256 principal,uint256 compounded,) = Aave(getAaveCore()).getUserBorrowBalances(_reserve, address(this));

      return compounded.sub(principal);

  }



  function supplyAave() public {

      Aave(getAave()).deposit(collateral, IERC20(collateral).balanceOf(address(this)), 7);

  }



  function repayAave(address _reserve, uint256 _amount) public onlyTrader {

      require(isReserve(_reserve) == true, "itrade: invalid reserve");

      IERC20(_reserve).safeTransferFrom(msg.sender, address(this), _amount);

      Aave(getAave()).repay(_reserve, _amount, address(uint160(address(this))));



      uint maxDebt = balanceAave().mul(maxBorrow).div(maxBorrowBase);

      require(calcSystemDebt() < maxDebt, "itrade: over max collateralization");

  }



  function _withdrawSome(uint amount) internal {

      AToken(yAaveToken).redeem(amount);

  }



  function calcPoolValueInToken() public view returns (uint) {

      return balanceAave().add(balance());

  }

  function getPricePerFullShare() public view returns (uint) {

      uint _pool = calcPoolValueInToken();

      return _pool.mul(1e18).div(totalSupply());

  }

  function isReserve(address _reserve) public pure returns (bool) {

      if (_reserve == DAI) {

        return true;

      } else if (_reserve == USDC) {

        return true;

      } else if (_reserve == USDT) {

        return true;

    /*  } else if (_reserve == TUSD) {

        return true;*/

      } else {

        return false;

      }

  }

  // incase of half-way error

  function inCaseTokenGetsStuck(IERC20 _TokenAddress) onlyOwner public {

      uint qty = _TokenAddress.balanceOf(address(this));

      _TokenAddress.safeTransfer(msg.sender, qty);

  }

  // incase of half-way error

  function inCaseETHGetsStuck() onlyOwner public{

      (bool result, ) = msg.sender.call.value(address(this).balance)("");

      require(result, "transfer of ETH failed");

  }

}
