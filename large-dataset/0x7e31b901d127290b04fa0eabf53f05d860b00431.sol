pragma solidity ^0.5.16;



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



interface Controller {

    function withdraw(address, uint) external;

    function balanceOf(address) external view returns (uint);

    function earn(address, uint) external;

}



interface AaveCollateralVaultProxy {

    function _borrowerContains(address, address) external view returns (bool);

    function _borrowerVaults(address, uint) external view returns (address);

    function _borrowers(address, uint) external view returns (address);

    function _limits(address, address) external view returns (uint);

    function _ownedVaults(address, uint) external view returns (address);

    function _vaults(address) external view returns (address);





    function limit(address vault, address spender) external view returns (uint);

    function borrowers(address vault) external view returns (address[] memory);

    function borrowerVaults(address spender) external view returns (address[] memory);

    function increaseLimit(address vault, address spender, uint addedValue) external;

    function decreaseLimit(address vault, address spender, uint subtractedValue) external;

    function setModel(address vault, uint model) external;

    function getBorrow(address vault) external view returns (address);

    function isVaultOwner(address vault, address owner) external view returns (bool);

    function isVault(address vault) external view returns (bool);



    function deposit(address vault, address aToken, uint amount) external;

    function withdraw(address vault, address aToken, uint amount) external;

    function borrow(address vault, address reserve, uint amount) external;

    function repay(address vault, address reserve, uint amount) external;

    function getVaults(address owner) external view returns (address[] memory);

    function deployVault(address _asset) external returns (address);



    function getVaultAccountData(address _vault)

    external

    view

    returns (

        uint totalLiquidityUSD,

        uint totalCollateralUSD,

        uint totalBorrowsUSD,

        uint totalFeesUSD,

        uint availableBorrowsUSD,

        uint currentLiquidationThreshold,

        uint ltv,

        uint healthFactor

    );

}



contract FairLaunchCapitalVault is ERC20, ERC20Detailed {

    using SafeERC20 for IERC20;

    using Address for address;

    using SafeMath for uint256;



    IERC20 public token;



    address public governance;



    AaveCollateralVaultProxy constant public vaults = AaveCollateralVaultProxy(0xf0988322B8392245d6232E520BF3Cdf912b043C4);

    address constant public usdc = address(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);

    address public vault;



    constructor (address _token) public ERC20Detailed(

        string(abi.encodePacked("flc ", ERC20Detailed(_token).name())),

        string(abi.encodePacked("flc", ERC20Detailed(_token).symbol())),

        ERC20Detailed(_token).decimals()

    ) {

        vault = vaults.deployVault(usdc);

        vaults.setModel(vault, 1);

        token = IERC20(_token);

        governance = msg.sender;

    }



    function balance() public view returns (uint) {

        return token.balanceOf(address(this))

        .add(token.balanceOf(address(vault)));

    }



    function credit() external {

        token.safeApprove(address(vaults), 0);

        token.safeApprove(address(vaults), token.balanceOf(address(this)));

        vaults.deposit(vault, address(token), token.balanceOf(address(this)));

    }



    function increaseLimit(address recipient, uint value) external {

        require(msg.sender == governance, "!governance");

        vaults.increaseLimit(vault, recipient, value);

    }

    

    function decreaseLimit(address recipient, uint value) external {

        require(msg.sender == governance, "!governance");

        vaults.decreaseLimit(vault, recipient, value);

    }



    function setGovernance(address _governance) public {

        require(msg.sender == governance, "!governance");

        governance = _governance;

    }



    function depositAll() external {

        deposit(token.balanceOf(msg.sender));

    }



    function deposit(uint _amount) public {

        uint _pool = balance();

        uint _before = token.balanceOf(address(this));

        token.safeTransferFrom(msg.sender, address(this), _amount);

        uint _after = token.balanceOf(address(this));

        _amount = _after.sub(_before); // Additional check for deflationary tokens

        uint shares = 0;

        if (totalSupply() == 0) {

            shares = _amount;

        } else {

            shares = (_amount.mul(totalSupply())).div(_pool);

        }

        _mint(msg.sender, shares);

    }



    function withdrawAll() external {

        withdraw(balanceOf(msg.sender));

    }



    function manage(address reserve, uint amount) external {

        require(msg.sender == governance, "!governance");

        vaults.withdraw(vault, reserve, amount);

    }



    function _withdraw(uint _amount) internal {

        vaults.withdraw(vault, address(token), _amount);

    }



    // No rebalance implementation for lower fees and faster swaps

    function withdraw(uint _shares) public {

        uint r = (balance().mul(_shares)).div(totalSupply());

        _burn(msg.sender, _shares);



        // Check balance

        uint b = token.balanceOf(address(this));

        if (b < r) {

            uint _need = r.sub(b);

            _withdraw(_need);

            uint _after = token.balanceOf(address(this));

            uint _diff = _after.sub(b);

            if (_diff < _need) {

                r = b.add(_diff);

            }

        }



        token.safeTransfer(msg.sender, r);

    }



    function getPricePerFullShare() public view returns (uint) {

        return balance().mul(1e18).div(totalSupply());

    }

}
