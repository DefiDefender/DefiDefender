/**
 *Submitted for verification at Etherscan.io on 2018-12-10
*/

pragma solidity^0.4.21;

library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
        if (a == 0) {
            return 0;
        }
        c = a * b;
        assert(c / a == b);
        return c;
    }
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }
    function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a + b;
        assert(c >= a);
        return c;
    }
}

contract Ownable {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

}

contract ERC20 {
    function totalSupply() public view returns (uint256);
    function balanceOf(address who) public view returns (uint256);
    function transfer(address to, uint256 value) public;
    function allowance(address owner, address spender) public view returns (uint256);
    function transferFrom(address from, address to, uint256 value) public returns (bool);
    function approve(address spender, uint256 value) public returns (bool);

    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract HXPBaseToken is ERC20 {
    using SafeMath for uint256;
    
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 totalSupply_;

    mapping(address => uint256) balances;
    mapping (address => mapping (address => uint256)) internal allowed;

    constructor(string _name, string _symbol, uint8 _decimals, uint256 _totalSupply) public{
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply_ = _totalSupply;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != address(0));
        require(balances[_from] >= _value);
        require(balances[_to].add(_value) > balances[_to]);


        uint256 previousBalances = balances[_from].add(balances[_to]);
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(_from, _to, _value);

        assert(balances[_from].add(balances[_to]) == previousBalances);
    }

    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_value <= allowed[_from][msg.sender]);     // Check allowance
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        _transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }
}

contract HXP is HXPBaseToken("HUBEX PRO", "HXP", 18, 2000000000000000000000000000), Ownable {

    uint256 internal privateToken;
    uint256 internal preSaleToken;
    uint256 internal crowdSaleToken;
    uint256 internal bountyToken;
    uint256 internal foundationToken;
    address public founderAddress;
    bool public unlockAllTokens;

    mapping (address => bool) public approvedAccount;

    event UnFrozenFunds(address target, bool unfrozen);
    event UnLockAllTokens(bool unlock);

    constructor() public {
        founderAddress = address(0x655515cc9845343EC5A38da9bCf8A9F615eaC276);
        balances[founderAddress] = totalSupply_;
        emit Transfer(address(0), founderAddress, totalSupply_);
    }

    function _transfer(address _from, address _to, uint _value) internal {
        require (_to != address(0));                               
        require (balances[_from] >= _value);               
        require (balances[_to].add(_value) >= balances[_to]); 
        require(approvedAccount[_from] || unlockAllTokens);

        balances[_from] = balances[_from].sub(_value);                  
        balances[_to] = balances[_to].add(_value);                  
        emit Transfer(_from, _to, _value);
    }

    function unlockAllTokens(bool _unlock) public onlyOwner {
        unlockAllTokens = _unlock;
        emit UnLockAllTokens(_unlock);
    }

    function approvedAccount(address target, bool approval) public onlyOwner {
        approvedAccount[target] = approval;
        emit UnFrozenFunds(target, approval);
    }
}
