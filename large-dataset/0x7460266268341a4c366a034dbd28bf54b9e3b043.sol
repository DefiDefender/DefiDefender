/**
 * Source Code first verified at https://etherscan.io on Wednesday, February 14, 2018
 (UTC) */

pragma solidity ^0.4.18; // solhint-disable-line



/// @title Interface for contracts conforming to ERC-721: Non-Fungible Tokens
/// @author Dieter Shirley <[email protected]> (https://github.com/dete)
contract ERC721 {
  // Required methods
  function approve(address _to, uint256 _tokenId) public;
  function balanceOf(address _owner) public view returns (uint256 balance);
  function implementsERC721() public pure returns (bool);
  function ownerOf(uint256 _tokenId) public view returns (address addr);
  function takeOwnership(uint256 _tokenId) public;
  function totalSupply() public view returns (uint256 total);
  function transferFrom(address _from, address _to, uint256 _tokenId) public;
  function transfer(address _to, uint256 _tokenId) public;

  event Transfer(address indexed from, address indexed to, uint256 tokenId);
  event Approval(address indexed owner, address indexed approved, uint256 tokenId);

}

contract CryptoAllStars is ERC721 {

  /*** EVENTS ***/

  /// @dev The Birth event is fired whenever a new all stars comes into existence.
  event Birth(uint256 tokenId, string name, address owner);

  /// @dev The TokenSold event is fired whenever a token is sold.
  event TokenSold(uint256 tokenId, uint256 oldPrice, uint256 newPrice, address prevOwner, address winner, string name);

  /// @dev Transfer event as defined in current draft of ERC721. 
  ///  ownership is assigned, including births.
  event Transfer(address from, address to, uint256 tokenId);

  /*** CONSTANTS ***/

  /// @notice Name and symbol of the non fungible token, as defined in ERC721.
  string public constant NAME = "CryptoAllStars"; // solhint-disable-line
  string public constant SYMBOL = "AllStarToken"; // solhint-disable-line

  uint256 private startingPrice = 0.001 ether;
  uint256 private constant PROMO_CREATION_LIMIT = 10000;
  uint256 private firstStepLimit =  0.053613 ether;
  uint256 private secondStepLimit = 0.564957 ether;

  uint public currentGen = 0;

  /*** STORAGE ***/

  /// @dev A mapping from all stars IDs to the address that owns them. All all stars have
  ///  some valid owner address.
  mapping (uint256 => address) public allStarIndexToOwner;

  // @dev A mapping from owner address to count of tokens that address owns.
  //  Used internally inside balanceOf() to resolve ownership count.
  mapping (address => uint256) private ownershipTokenCount;

  /// @dev A mapping from allStarIDs to an address that has been approved to call
  ///  transferFrom(). Each All Star can only have one approved address for transfer
  ///  at any time. A zero value means no approval is outstanding.
  mapping (uint256 => address) public allStarIndexToApproved;

  // @dev A mapping from AllStarIDs to the price of the token.
  mapping (uint256 => uint256) private allStarIndexToPrice;

  // The addresses of the accounts (or contracts) that can execute actions within each roles.
  address public ceo = 0x047F606fD5b2BaA5f5C6c4aB8958E45CB6B054B7;
  address public cfo = 0xed8eFE0C11E7f13Be0B9d2CD5A675095739664d6;

  uint256 public promoCreatedCount;

  /*** DATATYPES ***/
  struct AllStar {
    string name;
    uint gen;
  }

  AllStar[] private allStars;

  /*** ACCESS MODIFIERS ***/
  /// @dev Access modifier for owner only functionality
  modifier onlyCeo() {
    require(msg.sender == ceo);
    _;
  }

  modifier onlyManagement() {
    require(msg.sender == ceo || msg.sender == cfo);
    _;
  }

  //changes the current gen of all stars by importance
  function evolveGeneration(uint _newGen) public onlyManagement {
    currentGen = _newGen;
  }
 
  /*** CONSTRUCTOR ***/
  // function CryptoAllStars() public {
  //   owner = msg.sender;
  // }

  /*** PUBLIC FUNCTIONS ***/
  /// @notice Grant another address the right to transfer token via takeOwnership() and transferFrom().
  /// @param _to The address to be granted transfer approval. Pass address(0) to
  ///  clear all approvals.
  /// @param _tokenId The ID of the Token that can be transferred if this call succeeds.
  /// @dev Required for ERC-721 compliance.
  function approve(
    address _to,
    uint256 _tokenId
  ) public {
    // Caller must own token.
    require(_owns(msg.sender, _tokenId));

    allStarIndexToApproved[_tokenId] = _to;

    Approval(msg.sender, _to, _tokenId);
  }

  /// For querying balance of a particular account
  /// @param _owner The address for balance query
  /// @dev Required for ERC-721 compliance.
  function balanceOf(address _owner) public view returns (uint256 balance) {
    return ownershipTokenCount[_owner];
  }

  /// @dev Creates a new promo AllStar with the given name, with given _price and assignes it to an address.
  function createPromoAllStar(address _owner, string _name, uint256 _price) public onlyCeo {
    require(promoCreatedCount < PROMO_CREATION_LIMIT);

    address allStarOwner = _owner;
    if (allStarOwner == address(0)) {
      allStarOwner = ceo;
    }

    if (_price <= 0) {
      _price = startingPrice;
    }

    promoCreatedCount++;
    _createAllStar(_name, allStarOwner, _price);
  }

  /// @dev Creates a new AllStar with the given name.
  function createContractAllStar(string _name) public onlyCeo {
    _createAllStar(_name, msg.sender, startingPrice );
  }

  /// @notice Returns all the relevant information about a specific AllStar.
  /// @param _tokenId The tokenId of the All Star of interest.
  function getAllStar(uint256 _tokenId) public view returns (
    string allStarName,
    uint allStarGen,
    uint256 sellingPrice,
    address owner
  ) {
    AllStar storage allStar = allStars[_tokenId];
    allStarName = allStar.name;
    allStarGen = allStar.gen;
    sellingPrice = allStarIndexToPrice[_tokenId];
    owner = allStarIndexToOwner[_tokenId];
  }

  function implementsERC721() public pure returns (bool) {
    return true;
  }

  /// @dev Required for ERC-721 compliance.
  function name() public pure returns (string) {
    return NAME;
  }

  /// For querying owner of token
  /// @param _tokenId The tokenID for owner inquiry
  /// @dev Required for ERC-721 compliance.
  function ownerOf(uint256 _tokenId)
    public
    view
    returns (address owner)
  {
    owner = allStarIndexToOwner[_tokenId];
    require(owner != address(0));
  }

  function payout() public onlyManagement {
    _payout();
  }

  // Allows someone to send ether and obtain the token
  function purchase(uint256 _tokenId) public payable {
    address oldOwner = allStarIndexToOwner[_tokenId];
    address newOwner = msg.sender;

    uint256 sellingPrice = allStarIndexToPrice[_tokenId];

    // Making sure token owner is not sending to self
    require(oldOwner != newOwner);

    // Safety check to prevent against an unexpected 0x0 default.
    require(_addressNotNull(newOwner));

    // Making sure sent amount is greater than or equal to the sellingPrice
    require(msg.value >= sellingPrice);

    uint256 payment = uint256(SafeMath.div(SafeMath.mul(sellingPrice, 92), 100));
    uint256 purchaseExcess = SafeMath.sub(msg.value, sellingPrice);

      // Update prices
    if (sellingPrice < firstStepLimit) {
      // first stage
      allStarIndexToPrice[_tokenId] = SafeMath.div(SafeMath.mul(sellingPrice, 200), 100);
    } else if (sellingPrice < secondStepLimit) {
      // second stage
      allStarIndexToPrice[_tokenId] = SafeMath.div(SafeMath.mul(sellingPrice, 125), 100);
    } else {
      // third stage
      allStarIndexToPrice[_tokenId] = SafeMath.div(SafeMath.mul(sellingPrice, 125), 100);
    }

    _transfer(oldOwner, newOwner, _tokenId);

    // Pay previous tokenOwner if owner is not contract
    if (oldOwner != address(this)) {
      oldOwner.transfer(payment); //(1-0.06)
    }

    TokenSold(_tokenId, sellingPrice, allStarIndexToPrice[_tokenId], oldOwner, newOwner, allStars[_tokenId].name);

    msg.sender.transfer(purchaseExcess);
  }

  function priceOf(uint256 _tokenId) public view returns (uint256 price) {
    return allStarIndexToPrice[_tokenId];
  }

  /// @dev Assigns a new address to act as the owner. Only available to the current owner.
  /// @param _newOwner The address of the new owner
  function setOwner(address _newOwner) public onlyCeo {
    require(_newOwner != address(0));

    ceo = _newOwner;
  }

   function setCFO(address _newCFO) public onlyCeo {
    require(_newCFO != address(0));

    cfo = _newCFO;
  }


  /// @dev Required for ERC-721 compliance.
  function symbol() public pure returns (string) {
    return SYMBOL;
  }

  /// @notice Allow pre-approved user to take ownership of a token
  /// @param _tokenId The ID of the Token that can be transferred if this call succeeds.
  /// @dev Required for ERC-721 compliance.
  function takeOwnership(uint256 _tokenId) public {
    address newOwner = msg.sender;
    address oldOwner = allStarIndexToOwner[_tokenId];

    // Safety check to prevent against an unexpected 0x0 default.
    require(_addressNotNull(newOwner));

    // Making sure transfer is approved
    require(_approved(newOwner, _tokenId));

    _transfer(oldOwner, newOwner, _tokenId);
  }


  function tokensOfOwner(address _owner) public view returns(uint256[] ownerTokens) {
    uint256 tokenCount = balanceOf(_owner);
    if (tokenCount == 0) {
        // Return an empty array
      return new uint256[](0);
    } else {
      uint256[] memory result = new uint256[](tokenCount);
      uint256 totalAllStars = totalSupply();
      uint256 resultIndex = 0;

      uint256 allStarId;
      for (allStarId = 0; allStarId <= totalAllStars; allStarId++) {
        if (allStarIndexToOwner[allStarId] == _owner) {
          result[resultIndex] = allStarId;
          resultIndex++;
        }
      }
      return result;
    }
  }

  /// For querying totalSupply of token
  /// @dev Required for ERC-721 compliance.
  function totalSupply() public view returns (uint256 total) {
    return allStars.length;
  }

  /// Owner initates the transfer of the token to another account
  /// @param _to The address for the token to be transferred to.
  /// @param _tokenId The ID of the Token that can be transferred if this call succeeds.
  /// @dev Required for ERC-721 compliance.
  function transfer(
    address _to,
    uint256 _tokenId
  ) public {
    require(_owns(msg.sender, _tokenId));
    require(_addressNotNull(_to));

    _transfer(msg.sender, _to, _tokenId);
  }

  /// Third-party initiates transfer of token from address _from to address _to
  /// @param _from The address for the token to be transferred from.
  /// @param _to The address for the token to be transferred to.
  /// @param _tokenId The ID of the Token that can be transferred if this call succeeds.
  /// @dev Required for ERC-721 compliance.
  function transferFrom(
    address _from,
    address _to,
    uint256 _tokenId
  ) public {
    require(_owns(_from, _tokenId));
    require(_approved(_to, _tokenId));
    require(_addressNotNull(_to));

    _transfer(_from, _to, _tokenId);
  }

  /*** PRIVATE FUNCTIONS ***/
  /// Safety check on _to address to prevent against an unexpected 0x0 default.
  function _addressNotNull(address _to) private pure returns (bool) {
    return _to != address(0);
  }

  /// For checking approval of transfer for address _to
  function _approved(address _to, uint256 _tokenId) private view returns (bool) {
    return allStarIndexToApproved[_tokenId] == _to;
  }

  /// For creating All Stars
  function _createAllStar(string _name, address _owner, uint256 _price) private {
    AllStar memory _allStar = AllStar({
      name: _name,
      gen: currentGen
    });
    uint256 newAllStarId = allStars.push(_allStar) - 1;

    // It's probably never going to happen, 4 billion tokens are A LOT, but
    // let's just be 100% sure we never let this happen.
    require(newAllStarId == uint256(uint32(newAllStarId)));

    Birth(newAllStarId, _name, _owner);

    allStarIndexToPrice[newAllStarId] = _price;

    // This will assign ownership, and also emit the Transfer event as
    // per ERC721 draft
    _transfer(address(0), _owner, newAllStarId);
  }

  /// Check for token ownership
  function _owns(address claimant, uint256 _tokenId) private view returns (bool) {
    return claimant == allStarIndexToOwner[_tokenId];
  }

  /// For paying out balance on contract
  function _payout() private {
      uint blnc = this.balance;
      ceo.transfer(SafeMath.div(SafeMath.mul(blnc, 75), 100));
      cfo.transfer(SafeMath.div(SafeMath.mul(blnc, 25), 100));
    
  }

  /// @dev Assigns ownership of a specific All Star to an address.
  function _transfer(address _from, address _to, uint256 _tokenId) private {
    // Since the number of all stars is capped to 2^32 we can't overflow this
    ownershipTokenCount[_to]++;
    //transfer ownership
    allStarIndexToOwner[_tokenId] = _to;

    // When creating new all stars _from is 0x0, but we can't account that address.
    if (_from != address(0)) {
      ownershipTokenCount[_from]--;
      // clear any previously approved ownership exchange
      delete allStarIndexToApproved[_tokenId];
    }

    // Emit the transfer event.
    Transfer(_from, _to, _tokenId);
  }
}
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  /**
  * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}
