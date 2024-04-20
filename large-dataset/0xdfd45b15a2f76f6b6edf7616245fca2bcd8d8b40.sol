pragma solidity ^0.5.17;



library SafeMath {

  function add(uint a, uint b) internal pure returns (uint c) {

    c = a + b;

    require(c >= a);

  }

  function sub(uint a, uint b) internal pure returns (uint c) {

    require(b <= a);

    c = a - b;

  }

  function mul(uint a, uint b) internal pure returns (uint c) {

    c = a * b;

    require(a == 0 || c / a == b);

  }

  function div(uint a, uint b) internal pure returns (uint c) {

    require(b > 0);

    c = a / b;

  }

}



contract ERC20Interface {

    

  function totalSupply() public view returns (uint);

  function balanceOf(address tokenOwner) public view returns (uint balance);

  function allowance(address tokenOwner, address spender) public view returns (uint remaining);

  function transfer(address to, uint tokens) public returns (bool success);

  function approve(address spender, uint tokens) public returns (bool success);

  function transferFrom(address from, address to, uint tokens) public returns (bool success);



  

}





contract ApproveAndCallFallBack {

  function receiveApproval(address from, uint256 tokens, address token, bytes memory data) public;

}



contract Owned {

  address public Admininstrator;





  constructor() public {

    Admininstrator = msg.sender;

    

  }



  modifier onlyAdmin {

    require(msg.sender == Admininstrator, "Only authorized personnels");

    _;

  }



}



contract salescontract is Owned{

    

    

  using SafeMath for uint;

 

  address public token;

  

  uint public minBuy = 1 ether;

  uint public maxBuy = 6 ether;

  address payable public saleswallet;

  

  bool public startSales = false;

  uint public buyvalue;

 

  

  uint public _qtty;

  uint decimal = 10**18;



 

  mapping(address => uint) public buyamount;

  uint256 public price1 = 0.04 ether;

  uint256 public price2 = 0.05 ether;

  uint256 public currentprice = 0.04 ether;

  uint256 public totalSales = 0;

  uint256 public MaxSales = 3500*decimal;

 

  

  

 

  constructor() public { Admininstrator = msg.sender; }

   

 //========================================CONFIGURATIONS======================================

 

 

 function WalletSetup(address payable _salewallet) public onlyAdmin{saleswallet = _salewallet;}

 function setToken(address _tokenaddress) public onlyAdmin{token = _tokenaddress;}

 

 function setMaxSALES(uint _value) public onlyAdmin{MaxSales = _value;}

 

 

 function AllowSales(bool _status) public onlyAdmin{

     require(saleswallet != address(0));

     startSales = _status;}

  

  

 function () external payable {

    

    require(startSales == true, "Sales has not been initialized yet");

    require(msg.value >= minBuy && msg.value <= maxBuy, "Invalid buy amount, confirm the maximum and minimum buy amounts");

    require(token != 0x0000000000000000000000000000000000000000, "Selling token not yet configured");

    require((buyamount[msg.sender] + msg.value) <= maxBuy, "Ensure your total buy is not above maximum allowed per wallet");

    

    buyvalue = msg.value;

    if(totalSales >= MaxSales.div(2)){

        currentprice = price2;

    }

    _qtty = buyvalue.div(currentprice);

    require(ERC20Interface(token).balanceOf(address(this)) >= _qtty*decimal, "Insufficient tokens in the contract");

    

    saleswallet.transfer(msg.value);

    buyamount[msg.sender] += msg.value;

    totalSales += _qtty;

    require(ERC20Interface(token).transfer(msg.sender, _qtty*decimal), "Transaction failed");

      

       

   

    

   

  }

  

    

 function buy() external payable {

    

    

    require(startSales == true, "Sales has not been initialized yet");

    require(msg.value >= minBuy && msg.value <= maxBuy, "Invalid buy amount, confirm the maximum and minimum buy amounts");

    require(token != 0x0000000000000000000000000000000000000000, "Selling token not yet configured");

    require((buyamount[msg.sender] + msg.value) <= maxBuy, "Ensure you total buy is not above maximum allowed per wallet");

    

    buyvalue = msg.value;

    if(totalSales >= MaxSales.div(2)){

        currentprice = price2;

    }

    _qtty = buyvalue.div(currentprice);

    require(ERC20Interface(token).balanceOf(address(this)) >= _qtty*decimal, "Insufficient tokens in the contract");

    

    saleswallet.transfer(msg.value);

    buyamount[msg.sender] += msg.value;

    totalSales += _qtty;

    require(ERC20Interface(token).transfer(msg.sender, _qtty*decimal), "Transaction failed");

      

        

    

   

  }

  





  function withdrawBal() public onlyAdmin returns(bool){

      

      require(saleswallet != address(0));

      uint bal = ERC20Interface(token).balanceOf(address(this));

      require(ERC20Interface(token).transfer(saleswallet, bal), "Transaction failed");

      

  }

 

 

}
