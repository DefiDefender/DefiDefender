/**
 * Source Code first verified at https://etherscan.io on Tuesday, October 30, 2018
 (UTC) */

pragma solidity ^0.4.18;


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;


  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }


  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}



/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */
contract ERC20Basic {
  uint256 public totalSupply;
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}






/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {
  function allowance(address owner, address spender) public view returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}







/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
contract BasicToken is ERC20Basic {
  using SafeMath for uint256;

  mapping(address => uint256) balances;

  /**
  * @dev transfer token for a specified address
  * @param _to The address to transfer to.
  * @param _value The amount to be transferred.
  */
  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
    require(_value <= balances[msg.sender]);

    // SafeMath.sub will throw if there is not enough balance.
    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    Transfer(msg.sender, _to, _value);
    return true;
  }

  /**
  * @dev Gets the balance of the specified address.
  * @param _owner The address to query the the balance of.
  * @return An uint256 representing the amount owned by the passed address.
  */
  function balanceOf(address _owner) public view returns (uint256 balance) {
    return balances[_owner];
  }

}







/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * @dev https://github.com/ethereum/EIPs/issues/20
 * @dev Based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */
contract StandardToken is ERC20, BasicToken {

  mapping (address => mapping (address => uint256)) internal allowed;


  /**
   * @dev Transfer tokens from one address to another
   * @param _from address The address which you want to send tokens from
   * @param _to address The address which you want to transfer to
   * @param _value uint256 the amount of tokens to be transferred
   */
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
    require(_value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);

    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    Transfer(_from, _to, _value);
    return true;
  }

  /**
   * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
   *
   * Beware that changing an allowance with this method brings the risk that someone may use both the old
   * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
   * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   * @param _spender The address which will spend the funds.
   * @param _value The amount of tokens to be spent.
   */
  function approve(address _spender, uint256 _value) public returns (bool) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

  /**
   * @dev Function to check the amount of tokens that an owner allowed to a spender.
   * @param _owner address The address which owns the funds.
   * @param _spender address The address which will spend the funds.
   * @return A uint256 specifying the amount of tokens still available for the spender.
   */
  function allowance(address _owner, address _spender) public view returns (uint256) {
    return allowed[_owner][_spender];
  }

  /**
   * @dev Increase the amount of tokens that an owner allowed to a spender.
   *
   * approve should be called when allowed[_spender] == 0. To increment
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param _spender The address which will spend the funds.
   * @param _addedValue The amount of tokens to increase the allowance by.
   */
  function increaseApproval(address _spender, uint _addedValue) public returns (bool) {
    allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
    Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

  /**
   * @dev Decrease the amount of tokens that an owner allowed to a spender.
   *
   * approve should be called when allowed[_spender] == 0. To decrement
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param _spender The address which will spend the funds.
   * @param _subtractedValue The amount of tokens to decrease the allowance by.
   */
  function decreaseApproval(address _spender, uint _subtractedValue) public returns (bool) {
    uint oldValue = allowed[msg.sender][_spender];
    if (_subtractedValue > oldValue) {
      allowed[msg.sender][_spender] = 0;
    } else {
      allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
    }
    Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

}






/**
 * @title Mintable token
 * @dev Simple ERC20 Token example, with mintable token creation
 * @dev Issue: * https://github.com/OpenZeppelin/zeppelin-solidity/issues/120
 * Based on code by TokenMarketNet: https://github.com/TokenMarketNet/ico/blob/master/contracts/MintableToken.sol
 */

contract MintableToken is StandardToken, Ownable {
  event Mint(address indexed to, uint256 amount);
  event MintFinished();

  bool public mintingFinished = false;


  modifier canMint() {
    require(!mintingFinished);
    _;
  }

  /**
   * @dev Function to mint tokens
   * @param _to The address that will receive the minted tokens.
   * @param _amount The amount of tokens to mint.
   * @return A boolean that indicates if the operation was successful.
   */
  function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {
    totalSupply = totalSupply.add(_amount);
    balances[_to] = balances[_to].add(_amount);
    Mint(_to, _amount);
    Transfer(address(0), _to, _amount);
    return true;
  }

  /**
   * @dev Function to stop minting new tokens.
   * @return True if the operation was successful.
   */
  function finishMinting() onlyOwner canMint public returns (bool) {
    mintingFinished = true;
    MintFinished();
    return true;
  }
}


/**
 * @title Capped token
 * @dev Mintable token with a token cap.
 */

contract CappedToken is MintableToken {

  uint256 public cap;

  function CappedToken(uint256 _cap) public {
    require(_cap > 0);
    cap = _cap;
  }

  /**
   * @dev Function to mint tokens
   * @param _to The address that will receive the minted tokens.
   * @param _amount The amount of tokens to mint.
   * @return A boolean that indicates if the operation was successful.
   */
  function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {
    require(totalSupply.add(_amount) <= cap);

    return super.mint(_to, _amount);
  }

}





/**
 * @title Burnable Token
 * @dev Token that can be irreversibly burned (destroyed).
 */
contract BurnableToken is BasicToken {

    event Burn(address indexed burner, uint256 value);

    /**
     * @dev Burns a specific amount of tokens.
     * @param _value The amount of token to be burned.
     */
    function burn(uint256 _value) public {
        require(_value <= balances[msg.sender]);
        // no need to require value <= totalSupply, since that would imply the
        // sender's balance is greater than the totalSupply, which *should* be an assertion failure

        address burner = msg.sender;
        balances[burner] = balances[burner].sub(_value);
        totalSupply = totalSupply.sub(_value);
        Burn(burner, _value);
    }
}

/**
 * This smart contract code is Copyright 2017 TokenMarket Ltd. For more information see https://tokenmarket.net
 *
 * Licensed under the Apache License, version 2.0: https://github.com/TokenMarketNet/ico/blob/master/LICENSE.txt
 */







/**
 * Define interface for releasing the token transfer after a successful crowdsale.
 */
contract ReleasableToken is ERC20, Ownable {

  /* The finalizer contract that allows unlift the transfer limits on this token */
  address public releaseAgent;

  /** A crowdsale contract can release us to the wild if ICO success. If false we are are in transfer lock up period.*/
  bool public released = false;

  /** Map of agents that are allowed to transfer tokens regardless of the lock down period. These are crowdsale contracts and possible the team multisig itself. */
  mapping (address => bool) public transferAgents;

  /**
   * Limit token transfer until the crowdsale is over.
   *
   */
  modifier canTransfer(address _sender) {
    if (!released) {
      require(transferAgents[_sender]);
    }

    _;
  }

  /**
   * Set the contract that can call release and make the token transferable.
   *
   * Design choice. Allow reset the release agent to fix fat finger mistakes.
   */
  function setReleaseAgent(address addr) onlyOwner inReleaseState(false) public {

    // We don't do interface check here as we might want to a normal wallet address to act as a release agent
    releaseAgent = addr;
  }

  /**
   * Owner can allow a particular address (a crowdsale contract) to transfer tokens despite the lock up period.
   */
  function setTransferAgent(address addr, bool state) onlyOwner inReleaseState(false) public {
    transferAgents[addr] = state;
  }

  /**
   * One way function to release the tokens to the wild.
   *
   * Can be called only from the release agent that is the final ICO contract. It is only called if the crowdsale has been success (first milestone reached).
   */
  function releaseTokenTransfer() public onlyReleaseAgent {
    released = true;
  }

  /** The function can be called only before or after the tokens have been released */
  modifier inReleaseState(bool releaseState) {
    require(releaseState == released);
    _;
  }

  /** The function can be called only by a whitelisted release agent. */
  modifier onlyReleaseAgent() {
    require(msg.sender == releaseAgent);
    _;
  }

  function transfer(address _to, uint _value) public canTransfer(msg.sender) returns (bool success) {
    // Call StandardToken.transfer()
    return super.transfer(_to, _value);
  }

  function transferFrom(address _from, address _to, uint _value) public canTransfer(_from) returns (bool success) {
    // Call StandardToken.transferForm()
    return super.transferFrom(_from, _to, _value);
  }

}


contract BDXCoin is BurnableToken, CappedToken, ReleasableToken {
  string public constant name = "BDXCoin";
  string public constant symbol = "BDX";
  uint8 public constant decimals = 18;

  function BDXCoin() public
    CappedToken(200000000 * (10 ** uint256(decimals)))
  {
    // Allocate For ICO
    mint(msg.sender, 90000000 * (10 ** uint256(decimals)));
    setReleaseAgent(msg.sender);
    setTransferAgent(msg.sender, true);
  }
}



contract RateOracle {

  address public owner;
  uint public rate;
  uint256 public lastUpdateTime;

  function RateOracle() public {
    owner = msg.sender;
  }

  function setRate(uint _rateCents) public {
    require(msg.sender == owner);
    require(_rateCents > 100);
    rate = _rateCents;
    lastUpdateTime = now;
  }

}












/**
 * @title Crowdsale
 * @dev Crowdsale is a base contract for managing a token crowdsale.
 * Crowdsales have a start and end timestamps, where investors can make
 * token purchases and the crowdsale will assign them tokens based
 * on a token per ETH rate. Funds collected are forwarded to a wallet
 * as they arrive.
 */
contract Crowdsale {
  using SafeMath for uint256;

  // The token being sold
  StandardToken public token;

  // start and end timestamps where investments are allowed (both inclusive)
  uint256 public startTime;
  uint256 public endTime;

  // address where funds are collected
  address public wallet;

  // how many token units a buyer gets per wei
  uint256 public rate;

  //Total Sales
  uint256 public totalSalesEurCents;

  /**
   * event for token purchase logging
   * @param purchaser who paid for the tokens
   * @param beneficiary who got the tokens
   * @param value weis paid for purchase
   * @param amount amount of tokens purchased
   */
  event TokenPurchase(address indexed purchaser, address indexed beneficiary, uint256 value, uint256 amount);


  function Crowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet, StandardToken _token) public {
    require(_endTime >= _startTime);
    require(_rate > 0);
    require(_wallet != address(0));
    require(_token != address(0));

    token = _token;
    startTime = _startTime;
    endTime = _endTime;
    rate = _rate;
    wallet = _wallet;
  }


  // fallback function can be used to buy tokens
  function () external payable {
    buyTokens(msg.sender);
  }

  // abstract token purchase function
  function buyTokens(address beneficiary) public payable;

  // send ether to the fund collection wallet
  // override to create custom fund forwarding mechanisms
  function forwardFunds() internal {
    wallet.transfer(msg.value);
  }

  // @return true if the transaction can buy tokens
  function validPurchase() internal view returns (bool) {
    bool withinPeriod = now >= startTime && now <= endTime;
    bool nonZeroPurchase = msg.value != 0;
    return withinPeriod && nonZeroPurchase;
  }

  // @return true if crowdsale event has ended
  function hasEnded() public view returns (bool) {
    return now > endTime;
  }


}













/**
 * @title FinalizableCrowdsale
 * @dev Extension of Crowdsale where an owner can do extra work
 * after finishing.
 */


contract FinalizableCrowdsale is Crowdsale, Ownable {
  using SafeMath for uint256;

  bool public isFinalized = false;

  event Finalized();

  /**
   * @dev Must be called after crowdsale ends, to do some extra finalization
   * work. Calls the contract's finalization function.
   */
  function finalize() onlyOwner public {
    require(!isFinalized);
    require(hasEnded());

    finalization();
    Finalized();

    isFinalized = true;
  }

  /**
   * @dev Can be overridden to add finalization logic. The overriding function
   * should call super.finalization() to ensure the chain of finalization is
   * executed entirely.
   */
  function finalization() internal {
  }
}






/**
 * @title RefundVault
 * @dev This contract is used for storing funds while a crowdsale
 * is in progress. Supports refunding the money if crowdsale fails,
 * and forwarding it if crowdsale is successful.
 */


contract RefundVault is Ownable {
  using SafeMath for uint256;

  enum State { Active, Refunding, Closed }

  mapping (address => uint256) public deposited;
  address public wallet;
  State public state;

  event Closed();
  event RefundsEnabled();
  event Refunded(address indexed beneficiary, uint256 weiAmount);

  function RefundVault(address _wallet) public {
    require(_wallet != address(0));
    wallet = _wallet;
    state = State.Active;
  }

  function deposit(address investor) onlyOwner public payable {
    require(state == State.Active);
    deposited[investor] = deposited[investor].add(msg.value);
  }

  function close() onlyOwner public {
    require(state == State.Active);
    state = State.Closed;
    Closed();
    wallet.transfer(this.balance);
  }

  function enableRefunds() onlyOwner public {
    require(state == State.Active);
    state = State.Refunding;
    RefundsEnabled();
  }

  function refund(address investor) public {
    require(state == State.Refunding);
    uint256 depositedValue = deposited[investor];
    deposited[investor] = 0;
    investor.transfer(depositedValue);
    Refunded(investor, depositedValue);
  }
}



/**
 * @title RefundableCrowdsale
 * @dev Extension of Crowdsale contract that adds a funding goal, and
 * the possibility of users getting a refund if goal is not met.
 * Uses a RefundVault as the crowdsale's vault.
 */


contract RefundableCrowdsale is FinalizableCrowdsale {
  using SafeMath for uint256;

  // minimum amount of funds to be raised in weis
  uint256 public goal;

  // refund vault used to hold funds while crowdsale is running
  RefundVault public vault;

  function RefundableCrowdsale(uint256 _goal) public {
    require(_goal > 0);
    vault = new RefundVault(wallet);
    goal = _goal;
  }

  // We're overriding the fund forwarding from Crowdsale.
  // In addition to sending the funds, we want to call
  // the RefundVault deposit function
  function forwardFunds() internal {
    vault.deposit.value(msg.value)(msg.sender);
  }

  // if crowdsale is unsuccessful, investors can claim refunds here
  function claimRefund() public {
    require(isFinalized);
    require(!goalReached());

    vault.refund(msg.sender);
  }

  // vault finalization task, called when owner calls finalize()
  function finalization() internal {
    if (goalReached()) {
      vault.close();
    } else {
      vault.enableRefunds();
    }

    super.finalization();
  }

  function goalReached() public view returns (bool) {
    return totalSalesEurCents >= goal;
  }

}







/**
 * @title BDXVault For holding Tokens Distribution To Pre-Investors
 */


contract BDXVault is Ownable {
  using SafeMath for uint256;

  address public tokenAddress;
  mapping (address => uint256) public creditedList;
  event Credited(address indexed investor, uint256 tokens);

  function BDXVault(address _tokenAddress) public {
    tokenAddress = _tokenAddress;
  }

  function credit(address investor, uint256 tokens) onlyOwner public {
    require(creditedList[investor] == 0);
    creditedList[investor] = creditedList[investor].add(tokens);
    BDXCoin token = BDXCoin(tokenAddress);
    token.transfer(investor, tokens);
    Credited(investor, tokens);
  }

}



contract BDXCrowdsale is RefundableCrowdsale {

  uint256[3] public icoStartTimes;
  uint256[3] public icoEndTimes;
  uint256[3] public icoRates;
  uint256[3] public icoCaps;
  uint256[2] public icoVestingTimes;
  uint256[2] public icoVestingTokens;
  uint256 public nextVestingStage = 0;
  uint256 public bizDevTokenAllocation;
  address public bizDevWalletAddress;
  uint256 public marketingTokenAllocation;
  address public marketingWalletAddress;
  bool public contractInitialized = false;
  uint public constant MINIMUM_PURCHASE_EUR_CENT = 1900;
  mapping(uint256 => uint256) public totalTokensByStage;
  mapping(address => uint256) public unsoldTokensBeneficiaries;
  bool public refundingComplete = false;
  uint256 public refundingIndex = 0;
  mapping(address => uint256) public directInvestors;
  address[] private directInvestorsCollection;
  address public rateOracleAddress;
  address public preInvestorsTokenVaultAddress;
  uint256 public preInvestorsTokenAllocation;

  function BDXCrowdsale(
    uint256[3] _icoStartTimes,
    uint256[3] _icoEndTimes,
    uint256[3] _icoRates,
    uint256[3] _icoCaps,
    uint256[2] _icoVestingTimes,
    uint256[2] _icoVestingTokens,
    address _wallet,
    uint256 _goal,
    uint256 _bizDevTokenAllocation,
    address _bizDevWalletAddress,
    uint256 _marketingTokenAllocation,
    address _marketingWalletAddress,
    address _rateOracleAddress,
    uint256 _preInvestorsTokenAllocation
    ) public
    Crowdsale(_icoStartTimes[0], _icoEndTimes[2], _icoRates[0], _wallet, new BDXCoin())
    RefundableCrowdsale(_goal)
  {
    require((_icoCaps[0] > 0) && (_icoCaps[1] > 0) && (_icoCaps[2] > 0));
    require((_icoRates[0] > 0) && (_icoRates[1] > 0) && (_icoRates[2] > 0));
    require((_icoEndTimes[0] > _icoStartTimes[0]) && (_icoEndTimes[1] > _icoStartTimes[1]) && (_icoEndTimes[2] > _icoStartTimes[2]));
    require((_icoStartTimes[1] >= _icoEndTimes[0]) && (_icoStartTimes[2] >= _icoEndTimes[1]));
    require(_bizDevWalletAddress != owner && _wallet != _bizDevWalletAddress);
    require(_marketingWalletAddress != owner && _wallet != _marketingWalletAddress);
    icoStartTimes = _icoStartTimes;
    icoEndTimes = _icoEndTimes;
    icoRates = _icoRates;
    icoCaps = _icoCaps;
    icoVestingTimes = _icoVestingTimes;
    icoVestingTokens = _icoVestingTokens;
    bizDevTokenAllocation = _bizDevTokenAllocation;
    bizDevWalletAddress = _bizDevWalletAddress;
    marketingTokenAllocation = _marketingTokenAllocation;
    marketingWalletAddress = _marketingWalletAddress;
    rateOracleAddress = _rateOracleAddress;
    preInvestorsTokenAllocation = _preInvestorsTokenAllocation;
  }

  // fallback function can be used to buy tokens
  function () external payable {
    require(contractInitialized);
    buyTokens(msg.sender);
  }

  function initializeContract() public onlyOwner {
    require(!contractInitialized);
    preInvestorsTokenVaultAddress = new BDXVault(token);
    BDXCoin bdxcoin = BDXCoin(token);
    bdxcoin.mint(bizDevWalletAddress, toBDXWEI(bizDevTokenAllocation));
    bdxcoin.mint(marketingWalletAddress, toBDXWEI(marketingTokenAllocation));
    bdxcoin.mint(preInvestorsTokenVaultAddress, toBDXWEI(preInvestorsTokenAllocation));
    bdxcoin.setTransferAgent(bizDevWalletAddress, true);
    bdxcoin.setTransferAgent(marketingWalletAddress, true);
    bdxcoin.setTransferAgent(preInvestorsTokenVaultAddress, true);
    contractInitialized = true;
  }


  function vestTokens() public onlyOwner {
    require(isFinalized);
    require(goalReached());
    require(nextVestingStage <= 1);
    require(now > icoVestingTimes[nextVestingStage]);
    BDXCoin bdxcoin = BDXCoin(token);
    bdxcoin.mint(bizDevWalletAddress, toBDXWEI(icoVestingTokens[nextVestingStage]));
    nextVestingStage = nextVestingStage + 1;
  }

  // For Allocating Presold and Sale Via Fiat Deposits
  function allocateTokens(address beneficiary, uint256 tokensWithDecimals, uint256 stage, uint256 rateEurCents, bool isPreSold) public onlyOwner {
    require(stage <= 2);
    uint256 saleAmountEurCents = (tokensWithDecimals.mul(rateEurCents)).div(10**18);
    totalSalesEurCents = totalSalesEurCents.add(saleAmountEurCents);
    if (!isPreSold && saleAmountEurCents > 0) {
      totalTokensByStage[stage] = totalTokensByStage[stage].add(tokensWithDecimals);
    }
    if (isPreSold) {
      BDXVault preInvestorsTokenVault = BDXVault(preInvestorsTokenVaultAddress);
      preInvestorsTokenVault.credit(beneficiary, tokensWithDecimals);
    } else {
      token.transfer(beneficiary, tokensWithDecimals);
    }
  }

  function allocateUnsoldTokens(address beneficiary, uint256 tokensWithDecimals) public onlyOwner {
    require(isFinalized);
    require(goalReached());
    require(unsoldTokensBeneficiaries[beneficiary] == 0);
    unsoldTokensBeneficiaries[beneficiary] = unsoldTokensBeneficiaries[beneficiary].add(tokensWithDecimals);
    token.transfer(beneficiary, tokensWithDecimals);
  }

  //Override
  function buyTokens(address beneficiary) public payable {
    require(contractInitialized);
    require(beneficiary != address(0));
    require(validPurchase());
    RateOracle rateOracle = RateOracle(rateOracleAddress);
    uint ethEurXRate = rateOracle.rate();
    require(ethEurXRate > 0);
    uint256 currTime = now;
    uint256 stageCap = getStageCap(currTime);
    rate = getTokenRate(currTime);
    uint256 stage = getStage(currTime);
    uint256 weiAmount = msg.value;
    uint256 eurCentAmount = (weiAmount.mul(ethEurXRate)).div(10**18);

    require(eurCentAmount > MINIMUM_PURCHASE_EUR_CENT);

    uint256 tokenToGet = (weiAmount.mul(ethEurXRate)).div(rate);

    if (totalTokensByStage[stage].add(tokenToGet) > stageCap) {
      stage = stage + 1;
      rate = getRateByStage(stage);
      tokenToGet = (weiAmount.mul(ethEurXRate)).div(rate);
    }

    totalTokensByStage[stage] = totalTokensByStage[stage].add(tokenToGet);

    if (directInvestors[beneficiary] == 0) {
      directInvestorsCollection.push(beneficiary);
    }

    directInvestors[beneficiary] = directInvestors[beneficiary].add(tokenToGet);
    totalSalesEurCents = totalSalesEurCents.add(eurCentAmount);
    token.transfer(beneficiary, tokenToGet);
    TokenPurchase(msg.sender, beneficiary, weiAmount, tokenToGet);
    forwardFunds();
  }

  function ethToEurXRate() public view returns (uint) {
    RateOracle rateOracle = RateOracle(rateOracleAddress);
    return rateOracle.rate();
  }

  //Override
  function goalReached() public view returns (bool) {
    return totalSalesEurCents >= goal;
  }

  function refundInvestors() public onlyOwner {
    require(isFinalized);
    require(!goalReached());
    require(!refundingComplete);
    for (uint256 i = 0; i < 20; i++) {
      if (refundingIndex >= directInvestorsCollection.length) {
        refundingComplete = true;
        break;
      }
      vault.refund(directInvestorsCollection[refundingIndex]);
      refundingIndex = refundingIndex.add(1);
    }
  }

  function advanceEndTime(uint256 newEndTime) public onlyOwner {
    require(!isFinalized);
    require(newEndTime > endTime);
    endTime = newEndTime;
  }

  function getTokenRate(uint256 currTime) public view returns (uint256) {
    return getRateByStage(getStage(currTime));
  }

  function getStageCap(uint256 currTime) public view returns (uint256) {
    uint256 additionalTokensFromPreviousStage = 0;
    if (getStage(currTime) == 2) {
      additionalTokensFromPreviousStage = additionalTokensFromPreviousStage.add(getCapByStage(1) - totalTokensByStage[1]);
      additionalTokensFromPreviousStage = additionalTokensFromPreviousStage.add(getCapByStage(0) - totalTokensByStage[0]);
    } else if (getStage(currTime) == 1) {
      additionalTokensFromPreviousStage = additionalTokensFromPreviousStage.add(getCapByStage(0) - totalTokensByStage[0]);
    }
    return additionalTokensFromPreviousStage.add(getCapByStage(getStage(currTime)));
  }

  function getStage(uint256 currTime) public view returns (uint256) {
    if (currTime < icoEndTimes[0]) {
      return 0;
    } else if ((currTime > icoEndTimes[0]) && (currTime <= icoEndTimes[1])) {
      return 1;
    } else {
      return 2;
    }
  }

  function getCapByStage(uint256 stage) public view returns (uint256) {
    return icoCaps[stage];
  }

  function getRateByStage(uint256 stage) public view returns (uint256) {
    return icoRates[stage];
  }


  function toBDXWEI(uint256 value) internal view returns (uint256) {
    BDXCoin bdxcoin = BDXCoin(token);
    return (value * (10 ** uint256(bdxcoin.decimals())));
  }

  function finalization() internal {
    super.finalization();
    if (goalReached()) {
      BDXCoin bdxcoin = BDXCoin(token);
      bdxcoin.releaseTokenTransfer();
    }
  }

}
