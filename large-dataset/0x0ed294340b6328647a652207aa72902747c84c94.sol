/**

 *Submitted for verification at Etherscan.io on 2020-08-18

*/



pragma solidity ^0.6.0; 

pragma experimental ABIEncoderV2;



interface ERC20 {

    function totalSupply() external view returns (uint256 supply);



    function balanceOf(address _owner) external view returns (uint256 balance);



    function transfer(address _to, uint256 _value) external returns (bool success);



    function transferFrom(address _from, address _to, uint256 _value)

        external

        returns (bool success);



    function approve(address _spender, uint256 _value) external returns (bool success);



    function allowance(address _owner, address _spender) external view returns (uint256 remaining);



    function decimals() external view returns (uint256 digits);



    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

} library Address {

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



    function sendValue(address payable recipient, uint256 amount) internal {

        require(address(this).balance >= amount, "Address: insufficient balance");



        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value

        (bool success, ) = recipient.call{ value: amount }("");

        require(success, "Address: unable to send value, recipient may have reverted");

    }



    function functionCall(address target, bytes memory data) internal returns (bytes memory) {

      return functionCall(target, data, "Address: low-level call failed");

    }



    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {

        return _functionCallWithValue(target, data, 0, errorMessage);

    }



    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {

        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");

    }



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



    function div(uint256 a, uint256 b) internal pure returns (uint256) {

        return div(a, b, "SafeMath: division by zero");

    }



    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {

        require(b > 0, errorMessage);

        uint256 c = a / b;

        // assert(a == b * c + a % b); // There is no case in which this doesn't hold



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















library SafeERC20 {

    using SafeMath for uint256;

    using Address for address;



    function safeTransfer(ERC20 token, address to, uint256 value) internal {

        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));

    }



    function safeTransferFrom(ERC20 token, address from, address to, uint256 value) internal {

        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));

    }



    /**

     * @dev Deprecated. This function has issues similar to the ones found in

     * {IERC20-approve}, and its usage is discouraged.

     */

    function safeApprove(ERC20 token, address spender, uint256 value) internal {

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));

    }



    function safeIncreaseAllowance(ERC20 token, address spender, uint256 value) internal {

        uint256 newAllowance = token.allowance(address(this), spender).add(value);

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));

    }



    function safeDecreaseAllowance(ERC20 token, address spender, uint256 value) internal {

        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");

        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));

    }



    function _callOptionalReturn(ERC20 token, bytes memory data) private {



        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");

        if (returndata.length > 0) { // Return data is optional

            // solhint-disable-next-line max-line-length

            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");

        }

    }

} interface IFlashLoanReceiver {

    function executeOperation(address _reserve, uint256 _amount, uint256 _fee, bytes calldata _params) external;

}



abstract contract ILendingPoolAddressesProvider {



    function getLendingPool() public view virtual returns (address);

    function setLendingPoolImpl(address _pool) public virtual;



    function getLendingPoolCore() public virtual view returns (address payable);

    function setLendingPoolCoreImpl(address _lendingPoolCore) public virtual;



    function getLendingPoolConfigurator() public virtual view returns (address);

    function setLendingPoolConfiguratorImpl(address _configurator) public virtual;



    function getLendingPoolDataProvider() public virtual view returns (address);

    function setLendingPoolDataProviderImpl(address _provider) public virtual;



    function getLendingPoolParametersProvider() public virtual view returns (address);

    function setLendingPoolParametersProviderImpl(address _parametersProvider) public virtual;



    function getTokenDistributor() public virtual view returns (address);

    function setTokenDistributor(address _tokenDistributor) public virtual;





    function getFeeProvider() public virtual view returns (address);

    function setFeeProviderImpl(address _feeProvider) public virtual;



    function getLendingPoolLiquidationManager() public virtual view returns (address);

    function setLendingPoolLiquidationManager(address _manager) public virtual;



    function getLendingPoolManager() public virtual view returns (address);

    function setLendingPoolManager(address _lendingPoolManager) public virtual;



    function getPriceOracle() public virtual view returns (address);

    function setPriceOracle(address _priceOracle) public virtual;



    function getLendingRateOracle() public view virtual returns (address);

    function setLendingRateOracle(address _lendingRateOracle) public virtual;

}



library EthAddressLib {



    function ethAddress() internal pure returns(address) {

        return 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    }

}



abstract contract FlashLoanReceiverBase is IFlashLoanReceiver {



    using SafeERC20 for ERC20;

    using SafeMath for uint256;



    ILendingPoolAddressesProvider public addressesProvider;



    constructor(ILendingPoolAddressesProvider _provider) public {

        addressesProvider = _provider;

    }



    receive () external virtual payable {}



    function transferFundsBackToPoolInternal(address _reserve, uint256 _amount) internal {



        address payable core = addressesProvider.getLendingPoolCore();



        transferInternal(core,_reserve, _amount);

    }



    function transferInternal(address payable _destination, address _reserve, uint256  _amount) internal {

        if(_reserve == EthAddressLib.ethAddress()) {

            //solium-disable-next-line

            _destination.call{value: _amount}("");

            return;

        }



        ERC20(_reserve).safeTransfer(_destination, _amount);





    }



    function getBalanceInternal(address _target, address _reserve) internal view returns(uint256) {

        if(_reserve == EthAddressLib.ethAddress()) {



            return _target.balance;

        }



        return ERC20(_reserve).balanceOf(_target);



    }

} abstract contract DSProxyInterface {



    /// Truffle wont compile if this isn't commented

    // function execute(bytes memory _code, bytes memory _data)

    //     public virtual

    //     payable

    //     returns (address, bytes32);



    function execute(address _target, bytes memory _data) public virtual payable returns (bytes32);



    function setCache(address _cacheAddr) public virtual payable returns (bool);



    function owner() public virtual returns (address);

} contract DSMath {

    function add(uint256 x, uint256 y) internal pure returns (uint256 z) {

        require((z = x + y) >= x);

    }



    function sub(uint256 x, uint256 y) internal pure returns (uint256 z) {

        require((z = x - y) <= x);

    }



    function mul(uint256 x, uint256 y) internal pure returns (uint256 z) {

        require(y == 0 || (z = x * y) / y == x);

    }



    function div(uint256 x, uint256 y) internal pure returns (uint256 z) {

        return x / y;

    }



    function min(uint256 x, uint256 y) internal pure returns (uint256 z) {

        return x <= y ? x : y;

    }



    function max(uint256 x, uint256 y) internal pure returns (uint256 z) {

        return x >= y ? x : y;

    }



    function imin(int256 x, int256 y) internal pure returns (int256 z) {

        return x <= y ? x : y;

    }



    function imax(int256 x, int256 y) internal pure returns (int256 z) {

        return x >= y ? x : y;

    }



    uint256 constant WAD = 10**18;

    uint256 constant RAY = 10**27;



    function wmul(uint256 x, uint256 y) internal pure returns (uint256 z) {

        z = add(mul(x, y), WAD / 2) / WAD;

    }



    function rmul(uint256 x, uint256 y) internal pure returns (uint256 z) {

        z = add(mul(x, y), RAY / 2) / RAY;

    }



    function wdiv(uint256 x, uint256 y) internal pure returns (uint256 z) {

        z = add(mul(x, WAD), y / 2) / y;

    }



    function rdiv(uint256 x, uint256 y) internal pure returns (uint256 z) {

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

    function rpow(uint256 x, uint256 n) internal pure returns (uint256 z) {

        z = n % 2 != 0 ? x : RAY;



        for (n /= 2; n != 0; n /= 2) {

            x = rmul(x, x);



            if (n % 2 != 0) {

                z = rmul(z, x);

            }

        }

    }

} abstract contract TokenInterface {

    function allowance(address, address) public virtual returns (uint256);



    function balanceOf(address) public virtual returns (uint256);



    function approve(address, uint256) public virtual;



    function transfer(address, uint256) public virtual returns (bool);



    function transferFrom(address, address, uint256) public virtual returns (bool);



    function deposit() public virtual payable;



    function withdraw(uint256) public virtual;

} interface ExchangeInterfaceV2 {

    function sell(address _srcAddr, address _destAddr, uint _srcAmount) external payable returns (uint);



    function buy(address _srcAddr, address _destAddr, uint _destAmount) external payable returns(uint);



    function getSellRate(address _srcAddr, address _destAddr, uint _srcAmount) external view returns (uint);



    function getBuyRate(address _srcAddr, address _destAddr, uint _srcAmount) external view returns (uint);

} contract AdminAuth {



    using SafeERC20 for ERC20;



    address public owner;

    address public admin;



    modifier onlyOwner() {

        require(owner == msg.sender);

        _;

    }



    constructor() public {

        owner = msg.sender;

    }



    /// @notice Admin is set by owner first time, after that admin is super role and has permission to change owner

    /// @param _admin Address of multisig that becomes admin

    function setAdminByOwner(address _admin) public {

        require(msg.sender == owner);

        require(admin == address(0));



        admin = _admin;

    }



    /// @notice Admin is able to set new admin

    /// @param _admin Address of multisig that becomes new admin

    function setAdminByAdmin(address _admin) public {

        require(msg.sender == admin);



        admin = _admin;

    }



    /// @notice Admin is able to change owner

    /// @param _owner Address of new owner

    function setOwnerByAdmin(address _owner) public {

        require(msg.sender == admin);



        owner = _owner;

    }



    /// @notice Destroy the contract

    function kill() public onlyOwner {

        selfdestruct(payable(owner));

    }



    /// @notice  withdraw stuck funds

    function withdrawStuckFunds(address _token, uint _amount) public onlyOwner {

        if (_token == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE) {

            payable(owner).transfer(_amount);

        } else {

            ERC20(_token).safeTransfer(owner, _amount);

        }

    }

} contract ZrxAllowlist is AdminAuth {



    mapping (address => bool) public zrxAllowlist;



    function setAllowlistAddr(address _zrxAddr, bool _state) public onlyOwner {

        zrxAllowlist[_zrxAddr] = _state;

    }



    function isZrxAddr(address _zrxAddr) public view returns (bool) {

        return zrxAllowlist[_zrxAddr];

    }

} contract Discount {

    address public owner;

    mapping(address => CustomServiceFee) public serviceFees;



    uint256 constant MAX_SERVICE_FEE = 400;



    struct CustomServiceFee {

        bool active;

        uint256 amount;

    }



    constructor() public {

        owner = msg.sender;

    }



    function isCustomFeeSet(address _user) public view returns (bool) {

        return serviceFees[_user].active;

    }



    function getCustomServiceFee(address _user) public view returns (uint256) {

        return serviceFees[_user].amount;

    }



    function setServiceFee(address _user, uint256 _fee) public {

        require(msg.sender == owner, "Only owner");

        require(_fee >= MAX_SERVICE_FEE || _fee == 0);



        serviceFees[_user] = CustomServiceFee({active: true, amount: _fee});

    }



    function disableServiceFee(address _user) public {

        require(msg.sender == owner, "Only owner");



        serviceFees[_user] = CustomServiceFee({active: false, amount: 0});

    }

} contract SaverExchangeHelper {



    using SafeERC20 for ERC20;



    address public constant KYBER_ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    address public constant WETH_ADDRESS = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;



    address payable public constant WALLET_ID = 0x322d58b9E75a6918f7e7849AEe0fF09369977e08;

    address public constant DISCOUNT_ADDRESS = 0x1b14E8D511c9A4395425314f849bD737BAF8208F;

    address public constant SAVER_EXCHANGE_REGISTRY = 0x25dd3F51e0C3c3Ff164DDC02A8E4D65Bb9cBB12D;



    address public constant ERC20_PROXY_0X = 0x95E6F48254609A6ee006F7D493c8e5fB97094ceF;

    address public constant ZRX_ALLOWLIST_ADDR = 0x019739e288973F92bDD3c1d87178E206E51fd911;





    function getDecimals(address _token) internal view returns (uint256) {

        if (_token == KYBER_ETH_ADDRESS) return 18;



        return ERC20(_token).decimals();

    }



    function getBalance(address _tokenAddr) internal view returns (uint balance) {

        if (_tokenAddr == KYBER_ETH_ADDRESS) {

            balance = address(this).balance;

        } else {

            balance = ERC20(_tokenAddr).balanceOf(address(this));

        }

    }



    function approve0xProxy(address _tokenAddr, uint _amount) internal {

        if (_tokenAddr != KYBER_ETH_ADDRESS) {

            ERC20(_tokenAddr).safeApprove(address(ERC20_PROXY_0X), _amount);

        }

    }



    function sendLeftover(address _srcAddr, address _destAddr, address payable _to) internal {

        // send back any leftover ether or tokens

        if (address(this).balance > 0) {

            _to.transfer(address(this).balance);

        }



        if (getBalance(_srcAddr) > 0) {

            ERC20(_srcAddr).safeTransfer(_to, getBalance(_srcAddr));

        }



        if (getBalance(_destAddr) > 0) {

            ERC20(_destAddr).safeTransfer(_to, getBalance(_destAddr));

        }

    }



    function sliceUint(bytes memory bs, uint256 start) internal pure returns (uint256) {

        require(bs.length >= start + 32, "slicing out of range");



        uint256 x;

        assembly {

            x := mload(add(bs, add(0x20, start)))

        }



        return x;

    }

} contract SaverExchangeRegistry is AdminAuth {



  mapping(address => bool) private wrappers;



  constructor() public {

    wrappers[0x880A845A85F843a5c67DB2061623c6Fc3bB4c511] = true;

    wrappers[0x4c9B55f2083629A1F7aDa257ae984E03096eCD25] = true;

    wrappers[0x42A9237b872368E1bec4Ca8D26A928D7d39d338C] = true;

  }



  function addWrapper(address _wrapper) public onlyOwner {

    wrappers[_wrapper] = true;

  }



  function removeWrapper(address _wrapper) public onlyOwner {

    wrappers[_wrapper] = false;

  }



  function isWrapper(address _wrapper) public view returns(bool) {

    return wrappers[_wrapper];

  }

}

















contract SaverExchangeCore is SaverExchangeHelper, DSMath {



    // first is empty to keep the legacy order in place

    enum ExchangeType { _, OASIS, KYBER, UNISWAP, ZEROX }



    enum ActionType { SELL, BUY }



    struct ExchangeData {

        address srcAddr;

        address destAddr;

        uint srcAmount;

        uint destAmount;

        uint minPrice;

        address wrapper;

        address exchangeAddr;

        bytes callData;

        uint256 price0x;

    }



    



    function unpackExchangeData(bytes memory _data) public pure returns(ExchangeData memory _exData) {

        (

            bytes memory part1,

            bytes memory part2

        ) = abi.decode(_data, (bytes,bytes));



        (

            _exData.srcAddr,

            _exData.destAddr,

            _exData.srcAmount,

            _exData.destAmount

        ) = abi.decode(part1, (address,address,uint256,uint256));

        

        (

            _exData.minPrice,

            _exData.wrapper,

            _exData.exchangeAddr,

            _exData.callData,

            _exData.price0x  

        )

        = abi.decode(part2, (uint256,address,address,bytes,uint256));

    }



    // solhint-disable-next-line no-empty-blocks

    receive() external virtual payable {}

}











/// @title Contract that receives the FL from Aave for Repays/Boost

contract CompoundSaverFlashLoan is FlashLoanReceiverBase, SaverExchangeCore {

    ILendingPoolAddressesProvider public LENDING_POOL_ADDRESS_PROVIDER = ILendingPoolAddressesProvider(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);



    address payable public COMPOUND_SAVER_FLASH_PROXY = 0xBcEAb469CbBA225E9dc9Cbd898808A4742687096;

    address public constant ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;



    address public owner;



    using SafeERC20 for ERC20;



    constructor()

        FlashLoanReceiverBase(LENDING_POOL_ADDRESS_PROVIDER)

        public {

            owner = msg.sender;

    }



    /// @notice Called by Aave when sending back the FL amount

    /// @param _reserve The address of the borrowed token

    /// @param _amount Amount of FL tokens received

    /// @param _fee FL Aave fee

    /// @param _params The params that are sent from the original FL caller contract

   function executeOperation(

        address _reserve,

        uint256 _amount,

        uint256 _fee,

        bytes calldata _params)

    external override {

        // Format the call data for DSProxy

        (bytes memory proxyData, address payable proxyAddr) = packFunctionCall(_amount, _fee, _params);



        // Send Flash loan amount to DSProxy

        sendLoanToProxy(proxyAddr, _reserve, _amount);



        // Execute the DSProxy call

        DSProxyInterface(proxyAddr).execute(COMPOUND_SAVER_FLASH_PROXY, proxyData);



        // Repay the loan with the money DSProxy sent back

        transferFundsBackToPoolInternal(_reserve, _amount.add(_fee));



        // if there is some eth left (0x fee), return it to user

        if (address(this).balance > 0) {

            tx.origin.transfer(address(this).balance);

        }

    }



    /// @notice Formats function data call so we can call it through DSProxy

    /// @param _amount Amount of FL

    /// @param _fee Fee of the FL

    /// @param _params Saver proxy params

    /// @return proxyData Formated function call data

    function packFunctionCall(uint _amount, uint _fee, bytes memory _params) internal pure returns (bytes memory proxyData, address payable) {

        (

            bytes memory exDataBytes,

            address[2] memory cAddresses, // cCollAddress, cBorrowAddress

            uint256 gasCost,

            bool isRepay,

            address payable proxyAddr

        )

        = abi.decode(_params, (bytes,address[2],uint256,bool,address));



        ExchangeData memory _exData = unpackExchangeData(exDataBytes);



        uint[2] memory flashLoanData = [_amount, _fee];



        if (isRepay) {

            proxyData = abi.encodeWithSignature("flashRepay((address,address,uint256,uint256,uint256,address,address,bytes,uint256),address[2],uint256,uint256[2])", _exData, cAddresses, gasCost, flashLoanData);

        } else {

            proxyData = abi.encodeWithSignature("flashBoost((address,address,uint256,uint256,uint256,address,address,bytes,uint256),address[2],uint256,uint256[2])", _exData, cAddresses, gasCost, flashLoanData);

        }



        return (proxyData, proxyAddr);

    }



    /// @notice Send the FL funds received to DSProxy

    /// @param _proxy DSProxy address

    /// @param _reserve Token address

    /// @param _amount Amount of tokens

    function sendLoanToProxy(address payable _proxy, address _reserve, uint _amount) internal {

        if (_reserve != ETH_ADDRESS) {

            ERC20(_reserve).safeTransfer(_proxy, _amount);

        }



        _proxy.transfer(address(this).balance);

    }



    receive() external override(SaverExchangeCore, FlashLoanReceiverBase) payable {}

}
