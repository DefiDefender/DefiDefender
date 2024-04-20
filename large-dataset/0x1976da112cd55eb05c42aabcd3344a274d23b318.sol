pragma solidity ^0.5.0;



library SafeMath {

  function mul(uint256 a, uint256 b) internal pure returns (uint256) {

    if (a == 0) {

      return 0;

    }

    uint256 c = a * b;

    require(c / a == b, 'SafeMath.mul');

    return c;

  }



  function div(uint256 a, uint256 b) internal pure returns (uint256) {

    require(b > 0, 'SafeMath.div');

    uint256 c = a / b;

    return c;

  }



  function sub(uint256 a, uint256 b) internal pure returns (uint256) {

    require(b <= a, 'SafeMath.sub');

    uint256 c = a - b;

    return c;

  }



  function add(uint256 a, uint256 b) internal pure returns (uint256) {

    uint256 c = a + b;

    require(c >= a, 'SafeMath.add');

    return c;

  }



  function mod(uint256 a, uint256 b) internal pure returns (uint256) {

    require(b != 0, 'SafeMath.mod');

    return a % b;

  }

}



contract ReentrancyGuard {

  uint256 private _guardCounter;



  constructor() public {

    _guardCounter = 1;

  }



  modifier nonReentrant() {

    _guardCounter += 1;

    uint256 localCounter = _guardCounter;

    _;

    require(localCounter == _guardCounter, 'ReentrancyGuard.nonReentrant');

  }

}



contract Ownable {

  address public owner;



  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);



  constructor () public {

    owner = msg.sender;

  }



  modifier onlyOwner() {

    require(msg.sender == owner, "ONLY_CONTRACT_OWNER");

    _;

  }



  function transferOwnership(address newOwner) public onlyOwner {

    require(newOwner != address(0), "INVALID_OWNER");

    emit OwnershipTransferred(owner, newOwner);

    owner = newOwner;

  }

}



interface IERC165 {

  function supportsInterface(bytes4 interfaceId) external view returns (bool);

}



contract IERC721 is IERC165 {

  event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

  event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

  event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

  function balanceOf(address owner) public view returns (uint256 balance);

  function ownerOf(uint256 tokenId) public view returns (address owner);

  function safeTransferFrom(address from, address to, uint256 tokenId) public;

  function transferFrom(address from, address to, uint256 tokenId) public;

  function approve(address to, uint256 tokenId) public;

  function getApproved(uint256 tokenId) public view returns (address operator);

  function setApprovalForAll(address operator, bool _approved) public;

  function isApprovedForAll(address owner, address operator) public view returns (bool);

  function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public;

}



contract CryptoLuckyBags is ReentrancyGuard, Ownable {

  using SafeMath for uint256;



  event Create(

    uint256 indexed id,

    address indexed creator,

    uint256 total,

    uint256 price,

    uint256 unsealingTimestamp,

    bool sellingAfterUnsealingFlag,

    bool codeFlag,

    uint256 feePercentage

  );



  event Draw(

    uint256 indexed id,

    address indexed drawer,

    uint256 indexed code

  );



  // TODO: 1\u56de\u3042\u305f\u308a\u306e\u500b\u6570\u3092\u8a2d\u5b9a\u3067\u304d\u308b\u3088\u3046\u306b\u3059\u308b

  struct LuckyBag {

    uint256 id;

    address payable creator;

    address[] contractAddresses;

    uint256[] tokenIds;

    uint256 price;

    uint256 total;

    uint256 inventory;

    uint256 unsealingTimestamp;

    bool sellingAfterUnsealingFlag;

    bool codeFlag;

    bytes32[] hashedCodes;

    address[] drawers;

    uint256 feePercentage;

  }



  uint256 public feePercentage = 3;

  uint256 public feePerCode = 100000000000000; // 0.0001 ETH

  uint256 public balance;



  uint8 public CODE_STATUS_NOT_EXIST = 0;

  uint8 public CODE_STATUS_NOT_USED = 1;

  uint8 public CODE_STATUS_USED = 2;



  mapping (uint256 => LuckyBag) public luckyBags;

  mapping (uint256 => mapping (address => uint256)) public drawerToNotYetSendNum;

  mapping (uint256 => mapping (bytes32 => uint8)) public codeStatus;

  mapping (uint256 => uint256) public deposit;

  mapping (address => uint256[]) private creatorToIds;

  mapping (address => uint256[]) private drawerToIds;



  // TODO: \u524a\u9664\u3059\u308b

  function temp_transferFrom(address contractAddress, uint256 tokenId, address to) public onlyOwner {

    IERC721 token = IERC721(contractAddress);

    token.transferFrom(address(this), to, tokenId);

  }



  // TODO: \u524a\u9664\u3059\u308b

  function temp_transfer(address payable to) public onlyOwner {

    to.transfer(address(this).balance);

  }



  // \u3053\u306e\u95a2\u6570\u3092\u547c\u3073\u51fa\u3059\u524d\u306b\u3001\u3053\u306e\u30b3\u30f3\u30c8\u30e9\u30af\u30c8\u306b approval \u3092\u4e0e\u3048\u3066\u304a\u304f\u5fc5\u8981\u304c\u3042\u308b

  function create(uint256 id, address[] calldata contractAddresses, uint256[] calldata tokenIds, uint256 price,

    uint256 unsealingTimestamp, bool sellingAfterUnsealingFlag, bytes32[] calldata hashedCodes) external payable nonReentrant {

    if (hashedCodes.length > 0) {

      require(msg.value == feePerCode * hashedCodes.length, 'insufficient code fee');

      balance = balance.add(msg.value);

    }

    for (uint i = 0; i < tokenIds.length; i++) {

      IERC721 token = IERC721(contractAddresses[i]);

      require(msg.sender == token.ownerOf(tokenIds[i]), 'not owner');

      token.transferFrom(msg.sender, address(this), tokenIds[i]);

    }

    createInner(id, contractAddresses, tokenIds, price, unsealingTimestamp, sellingAfterUnsealingFlag, hashedCodes);

  }



  function draw(uint256 id, uint256 code, bool withUnsealFlag) external payable nonReentrant {

    LuckyBag storage luckyBag = luckyBags[id];

    require(luckyBag.creator != address(0), 'not exist lucky bag');

    require(luckyBag.inventory >= 1, 'sold out');

    require(luckyBag.price == msg.value || luckyBag.codeFlag, 'not match price');

    require(useCode(luckyBag, code), 'invalid code');

    luckyBag.inventory = luckyBag.inventory.sub(1);

    drawerToIds[msg.sender].push(id);



    if (!luckyBag.codeFlag) {

      deposit[id] = deposit[id].add(msg.value);

    }

    drawerToNotYetSendNum[id][msg.sender] = drawerToNotYetSendNum[id][msg.sender].add(1);

    emit Draw(id, msg.sender, code);



    if (block.timestamp >= luckyBag.unsealingTimestamp) {

      require(luckyBag.sellingAfterUnsealingFlag, 'sale period has passed');

      if (withUnsealFlag) {

        decideAndSendItem(luckyBag);

        sendEther(luckyBag);

      }

    }

  }



  function unseal(uint256 id) external nonReentrant {

    LuckyBag storage luckyBag = luckyBags[id];

    require(luckyBag.creator != address(0), 'not exist lucky bag');

    require(drawerToNotYetSendNum[id][msg.sender] >= 1, 'no items to unseal');

    require(block.timestamp >= luckyBag.unsealingTimestamp, 'can not unseal yet');

    drawerToNotYetSendNum[id][msg.sender] = drawerToNotYetSendNum[id][msg.sender].sub(1);

    decideAndSendItem(luckyBag);

    if (!luckyBag.codeFlag) {

      deposit[id] = deposit[id].sub(luckyBag.price);

      sendEther(luckyBag);

    }

  }



  function withdrawInventory(uint256 id) external nonReentrant {

    LuckyBag storage luckyBag = luckyBags[id];

    require(luckyBag.creator != address(0), 'not exist lucky bag');

    require(luckyBag.creator == msg.sender, 'not creator');

    require(luckyBag.inventory >= 1, 'sold out');

    require(block.timestamp >= luckyBag.unsealingTimestamp, 'can not withdraw inventory yet');

    luckyBag.inventory = luckyBag.inventory.sub(1);

    drawerToIds[msg.sender].push(id);

    decideAndSendItem(luckyBag);

  }



  function withdraw(uint256 id) external nonReentrant {

    require(luckyBags[id].creator == msg.sender, 'not creator');

    require(deposit[id] > 0, 'insufficient deposit');

    uint256 amount = deposit[id];

    deposit[id] = 0;

    msg.sender.transfer(amount);

  }



  function get(uint256 id) external view returns (address, address[] memory, uint256[] memory, uint256, uint256, uint256, uint256, bool, bool, address[] memory, uint256) {

    LuckyBag memory luckyBag = luckyBags[id];

    require(luckyBag.creator != address(0), 'not exist lucky bag');

    return (

      luckyBag.creator,

      luckyBag.contractAddresses,

      luckyBag.tokenIds,

      luckyBag.price,

      luckyBag.total,

      luckyBag.inventory,

      luckyBag.unsealingTimestamp,

      luckyBag.sellingAfterUnsealingFlag,

      luckyBag.codeFlag,

      luckyBag.drawers,

      luckyBag.feePercentage

    );

  }



  function getCreatedIds(address creator) external view returns (uint256[] memory) {

    return creatorToIds[creator];

  }



  function getDrawnIds(address drawer) external view returns (uint256[] memory) {

    return drawerToIds[drawer];

  }



  function getInventories(uint256 id1, uint256 id2, uint256 id3, uint256 id4, uint256 id5)

    external view returns (uint256, uint256, uint256, uint256, uint256) {

    return(luckyBags[id1].inventory, luckyBags[id2].inventory, luckyBags[id3].inventory, luckyBags[id4].inventory, luckyBags[id5].inventory);

  }



  function addCodes(uint256 id, bytes32[] memory hashedCodes) public {

    require(msg.sender == luckyBags[id].creator, 'not creator');

    uint32 totalCount = uint32(hashedCodes.length);

    for (uint32 i = 0; i < totalCount; i++) {

      codeStatus[id][hashedCodes[i]] = CODE_STATUS_NOT_USED;

    }

  }



  function transfer(address payable to, uint256 amount) public onlyOwner {

    require(balance >= amount, 'insufficient balance');

    require(to != address(0), 'invalid to address');

    balance = balance.sub(amount);

    to.transfer(amount);

  }



  function setFeePercentage(uint256 newFeePercentage) public onlyOwner {

    feePercentage = newFeePercentage;

  }



  function setFeePerCode(uint256 newFeePerCode) public onlyOwner {

    feePerCode = newFeePerCode;

  }



  // ---



  function createInner(uint256 id, address[] memory contractAddresses, uint256[] memory tokenIds,

    uint256 price, uint256 unsealingTimestamp, bool sellingAfterUnsealingFlag, bytes32[] memory hashedCodes) internal {

    require(luckyBags[id].creator == address(0), 'already exist id');

    address[] memory drawers = new address[](tokenIds.length);

    bool codeFlag = false;

    if (hashedCodes.length > 0) {

      codeFlag = true;

      addCodes(id, hashedCodes);

    }

    luckyBags[id] = LuckyBag(

      id, msg.sender, contractAddresses, tokenIds,

      price, tokenIds.length, tokenIds.length, unsealingTimestamp,

      sellingAfterUnsealingFlag, codeFlag, hashedCodes, drawers, feePercentage

    );

    creatorToIds[msg.sender].push(id);

    emit Create(

      id, msg.sender, tokenIds.length,

      price, unsealingTimestamp, codeFlag, sellingAfterUnsealingFlag, feePercentage);

  }



  function useCode(LuckyBag memory luckyBag, uint256 code) internal returns (bool) {

    if (!luckyBag.codeFlag) {

      return true;

    }

    bytes32 hashedCode = keccak256(abi.encodePacked(code));

    if (codeStatus[luckyBag.id][hashedCode] == CODE_STATUS_NOT_USED) {

      codeStatus[luckyBag.id][hashedCode] = CODE_STATUS_USED;

      return true;

    }

    return false;

  }



  function decideAndSendItem(LuckyBag storage luckyBag) internal {

    uint32 totalCount = uint32(luckyBag.tokenIds.length);

    uint32 index = getRandomNum(totalCount);

    for (uint32 i = 0; i < totalCount; i++) {

      if (luckyBag.drawers[index] != address(0)) {

        index = (index + 1) % totalCount;

        continue;

      }

      luckyBag.drawers[index] = msg.sender;

      break;

    }

    IERC721(luckyBag.contractAddresses[index]).transferFrom(address(this), msg.sender, luckyBag.tokenIds[index]);

  }



  function getRandomNum(uint32 max) internal view returns (uint32) {

    return uint32(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % max);

  }



  function sendEther(LuckyBag memory luckyBag) internal {

    uint256 fee = getFee(luckyBag.price, luckyBag.feePercentage);

    luckyBag.creator.transfer(luckyBag.price.sub(fee));

    balance = balance.add(fee);

  }



  function getFee(uint256 amount, uint256 _feePercentage) internal pure returns (uint256) {

    return amount.div(100).mul(_feePercentage);

  }

}
