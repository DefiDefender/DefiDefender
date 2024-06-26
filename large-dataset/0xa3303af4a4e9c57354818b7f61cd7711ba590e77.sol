// SPDX-License-Identifier: MIT

pragma solidity ^0.6.2;


// 
/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// 
/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transfered from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool _approved) external;

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);

    /**
      * @dev Safely transfers `tokenId` token from `from` to `to`.
      *
      * Requirements:
      *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
      * - `tokenId` token must exist and be owned by `from`.
      * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
      * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
      *
      * Emits a {Transfer} event.
      */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;
}

/**
 * @title IERC721 Non-Fungible Token Creator basic interface
 */
interface IERC721Creator {
    /**
     * @dev Gets the creator of the token
     * @param _tokenId uint256 ID of the token
     * @return address of the creator
     */
    function tokenCreator(uint256 _tokenId) external view returns (address);
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
/**
  * @title Escrow
  * @dev Base escrow contract, holds funds designated for a payee until they
  * withdraw them.
  *
  * Intended usage: This contract (and derived escrow contracts) should be a
  * standalone contract, that only interacts with the contract that instantiated
  * it. That way, it is guaranteed that all Ether will be handled according to
  * the `Escrow` rules, and there is no need to check for payable functions or
  * transfers in the inheritance tree. The contract that uses the escrow as its
  * payment method should be its owner, and provide public methods redirecting
  * to the escrow's deposit and withdraw.
  */
contract Escrow is Ownable {
    using SafeMath for uint256;
    using Address for address payable;

    event Deposited(address indexed payee, uint256 weiAmount);
    event Withdrawn(address indexed payee, uint256 weiAmount);

    mapping(address => uint256) private _deposits;

    function depositsOf(address payee) public view returns (uint256) {
        return _deposits[payee];
    }

    /**
     * @dev Stores the sent amount as credit to be withdrawn.
     * @param payee The destination address of the funds.
     */
    function deposit(address payee) public virtual payable onlyOwner {
        uint256 amount = msg.value;
        _deposits[payee] = _deposits[payee].add(amount);

        emit Deposited(payee, amount);
    }

    /**
     * @dev Withdraw accumulated balance for a payee, forwarding all gas to the
     * recipient.
     *
     * WARNING: Forwarding all gas opens the door to reentrancy vulnerabilities.
     * Make sure you trust the recipient, or are either following the
     * checks-effects-interactions pattern or using {ReentrancyGuard}.
     *
     * @param payee The address whose funds will be withdrawn and transferred to.
     */
    function withdraw(address payable payee) public virtual onlyOwner {
        uint256 payment = _deposits[payee];

        _deposits[payee] = 0;

        payee.sendValue(payment);

        emit Withdrawn(payee, payment);
    }
}

// 
/**
 * @dev Simple implementation of a
 * https://consensys.github.io/smart-contract-best-practices/recommendations/#favor-pull-over-push-for-external-calls[pull-payment]
 * strategy, where the paying contract doesn't interact directly with the
 * receiver account, which must withdraw its payments itself.
 *
 * Pull-payments are often considered the best practice when it comes to sending
 * Ether, security-wise. It prevents recipients from blocking execution, and
 * eliminates reentrancy concerns.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 *
 * To use, derive from the `PullPayment` contract, and use {_asyncTransfer}
 * instead of Solidity's `transfer` function. Payees can query their due
 * payments with {payments}, and retrieve them with {withdrawPayments}.
 */
contract PullPayment {
    Escrow private _escrow;

    constructor () internal {
        _escrow = new Escrow();
    }

    /**
     * @dev Withdraw accumulated payments, forwarding all gas to the recipient.
     *
     * Note that _any_ account can call this function, not just the `payee`.
     * This means that contracts unaware of the `PullPayment` protocol can still
     * receive funds this way, by having a separate account call
     * {withdrawPayments}.
     *
     * WARNING: Forwarding all gas opens the door to reentrancy vulnerabilities.
     * Make sure you trust the recipient, or are either following the
     * checks-effects-interactions pattern or using {ReentrancyGuard}.
     *
     * @param payee Whose payments will be withdrawn.
     */
    function withdrawPayments(address payable payee) public virtual {
        _escrow.withdraw(payee);
    }

    /**
     * @dev Returns the payments owed to an address.
     * @param dest The creditor's address.
     */
    function payments(address dest) public view returns (uint256) {
        return _escrow.depositsOf(dest);
    }

    /**
     * @dev Called by the payer to store the sent amount as credit to be pulled.
     * Funds sent in this way are stored in an intermediate {Escrow} contract, so
     * there is no danger of them being spent before withdrawal.
     *
     * @param dest The destination address of the funds.
     * @param amount The amount to transfer.
     */
    function _asyncTransfer(address dest, uint256 amount) internal virtual {
        _escrow.deposit{ value: amount }(dest);
    }
}

contract EnterpriseWallet721Auction is Ownable {
    using SafeMath for uint256;

    /////////////////////////////////////////////////////////////////////////
    // State Variables
    /////////////////////////////////////////////////////////////////////////
    // Mapping from ERC721 contract to mapping of tokenId to sale price.
    mapping(address => mapping(uint256 => uint256)) private tokenPrices;

    // Mapping from ERC721 contract to mapping of tokenId to token owner that set the sale price.
    mapping(address => mapping(uint256 => address)) private priceSetters;

    // Mapping of ERC721 contract to mapping of token ID to whether the token has been sold before.
    mapping(address => mapping(uint256 => bool)) private tokenSolds;

    // Mapping of ERC721 contract to mapping of token ID to the current bid amount.
    mapping(address => mapping(uint256 => uint256)) private tokenCurrentBids;

    // Mapping of ERC721 contract to mapping of token ID to the current bidder.
    mapping(address => mapping(uint256 => address)) private tokenCurrentBidders;

    // Marketplace fee paid to the owner of the contract.
    uint256 private marketplaceFee = 3; // 3 %

    // Royalty fee paid to the creator of a token on secondary sales.
    uint256 private royaltyFee = 3; // 3 %

    // Primary sale fee split.
    uint256 private primarySaleFee = 15; // 15 %

    /////////////////////////////////////////////////////////////////////////////
    // Events
    /////////////////////////////////////////////////////////////////////////////
    event Sold(
        address indexed _originContract,
        address indexed _buyer,
        address indexed _seller,
        uint256 _amount,
        uint256 _tokenId
    );

    event SetSalePrice(
        address indexed _originContract,
        uint256 _amount,
        uint256 _tokenId
    );

    event Bid(
        address indexed _originContract,
        address indexed _bidder,
        uint256 _amount,
        uint256 _tokenId
    );

    event AcceptBid(
        address indexed _originContract,
        address indexed _bidder,
        address indexed _seller,
        uint256 _amount,
        uint256 _tokenId
    );

    /////////////////////////////////////////////////////////////////////////
    // Modifiers
    /////////////////////////////////////////////////////////////////////////
    /**
   * @dev Checks that the token owner is approved for the ERC721Market
   * @param _originContract address of the contract storing the token.
   * @param _tokenId uint256 ID of the token
   */
    modifier ownerMustHaveMarketplaceApproved(
        address _originContract,
        uint256 _tokenId
    ) {
        IERC721 erc721 = IERC721(_originContract);
        address owner = erc721.ownerOf(_tokenId);
        require(
            erc721.isApprovedForAll(owner, address(this)),
            "owner must have approved contract"
        );
        _;
    }

    /**
   * @dev Checks that the token is owned by the sender
   * @param _originContract address of the contract storing the token.
   * @param _tokenId uint256 ID of the token
   */
    modifier senderMustBeTokenOwner(address _originContract, uint256 _tokenId) {
        IERC721 erc721 = IERC721(_originContract);
        require(
            erc721.ownerOf(_tokenId) == msg.sender,
            "sender must be the token owner"
        );
        _;
    }

    /////////////////////////////////////////////////////////////////////////
    // setSalePrice
    /////////////////////////////////////////////////////////////////////////
    /**
   * @dev Set the token for sale
   * @param _originContract address of the contract storing the token.
   * @param _tokenId uint256 ID of the token
   * @param _amount uint256 wei value that the item is for sale
   */
    function setSalePrice(
        address _originContract,
        uint256 _tokenId,
        uint256 _amount
    )
        public
        ownerMustHaveMarketplaceApproved(_originContract, _tokenId)
        senderMustBeTokenOwner(_originContract, _tokenId)
    {
        tokenPrices[_originContract][_tokenId] = _amount;
        priceSetters[_originContract][_tokenId] = msg.sender;
        emit SetSalePrice(_originContract, _amount, _tokenId);
    }

    /////////////////////////////////////////////////////////////////////////
    // buy
    /////////////////////////////////////////////////////////////////////////
    /**
   * @dev Purchases the token if it is for sale.
   * @param _originContract address of the contract storing the token.
   * @param _tokenId uint256 ID of the token.
   */
    function buy(address _originContract, uint256 _tokenId)
        public
        payable
        ownerMustHaveMarketplaceApproved(_originContract, _tokenId)
    {
        // Check that the person who set the price still owns the token.
        require(
            _priceSetterStillOwnsTheToken(_originContract, _tokenId),
            "Current token owner must be the person to have the latest price."
        );

        // Check that token is for sale.
        uint256 tokenPrice = tokenPrices[_originContract][_tokenId];
        require(tokenPrice > 0, "Tokens priced at 0 are not for sale.");

        // Check that enough ether was sent.
        uint256 requiredCost = tokenPrice + _calcMarketplaceFee(tokenPrice);
        require(
            requiredCost == msg.value,
            "Must purchase the token for the correct price"
        );

        // Get token contract details.
        IERC721 erc721 = IERC721(_originContract);
        address tokenOwner = erc721.ownerOf(_tokenId);

        // Payout all parties.
        _payout(tokenPrice, tokenOwner, _originContract, _tokenId);

        // Transfer token.
        erc721.safeTransferFrom(tokenOwner, msg.sender, _tokenId);

        // Wipe the token price.
        _resetTokenPrice(_originContract, _tokenId);

        // if the buyer had an existing bid, return it
        if (_addressHasBidOnToken(msg.sender, _originContract, _tokenId)) {
            _refundBid(_originContract, _tokenId);
        }

        // set the token as sold
        _setTokenAsSold(_originContract, _tokenId);

        emit Sold(
            _originContract,
            msg.sender,
            tokenOwner,
            tokenPrice,
            _tokenId
        );
    }

    /////////////////////////////////////////////////////////////////////////
    // tokenPrice
    /////////////////////////////////////////////////////////////////////////
    /**
   * @dev Gets the sale price of the token
   * @param _originContract address of the contract storing the token.
   * @param _tokenId uint256 ID of the token
   * @return sale price of the token
   */
    function tokenPrice(address _originContract, uint256 _tokenId)
        public
        view
        returns (uint256)
    {
        if (_priceSetterStillOwnsTheToken(_originContract, _tokenId)) {
            return tokenPrices[_originContract][_tokenId];
        }
        return 0;
    }

    /////////////////////////////////////////////////////////////////////////
    // bid
    /////////////////////////////////////////////////////////////////////////
    /**
   * @dev Bids on the token, replacing the bid if the bid is higher than the current bid. You cannot bid on a token you already own.
   * @param _newBidAmount uint256 value in wei to bid, plus marketplace fee.
   * @param _originContract address of the contract storing the token.
   * @param _tokenId uint256 ID of the token
   */
    function bid(
        uint256 _newBidAmount,
        address _originContract,
        uint256 _tokenId
    ) public payable {
        // Check that bid is greater than 0.
        require(_newBidAmount > 0, "Cannot bid 0 Wei.");

        // Check that bid is higher than previous bid
        uint256 currentBidAmount = tokenCurrentBids[_originContract][_tokenId];
        require(
            _newBidAmount > currentBidAmount,
            "Must place higher bid than existing bid."
        );

        // Check that enough ether was sent.
        uint256 requiredCost = _newBidAmount +
            _calcMarketplaceFee(_newBidAmount);
        require(
            requiredCost == msg.value,
            "Must purchase the token for the correct price."
        );

        // Check that bidder is not owner.
        IERC721 erc721 = IERC721(_originContract);
        address tokenOwner = erc721.ownerOf(_tokenId);
        address bidder = msg.sender;
        require(tokenOwner != bidder, "Bidder cannot be owner.");

        // Refund previous bidder.
        _refundBid(_originContract, _tokenId);

        // Set the new bid.
        _setBid(_newBidAmount, bidder, _originContract, _tokenId);

        emit Bid(_originContract, bidder, _newBidAmount, _tokenId);
    }

    /////////////////////////////////////////////////////////////////////////
    // acceptBid
    /////////////////////////////////////////////////////////////////////////
    /**
   * @dev Accept the bid on the token.
   * @param _originContract address of the contract storing the token.
   * @param _tokenId uint256 ID of the token
   */
    function acceptBid(address _originContract, uint256 _tokenId)
        public
        ownerMustHaveMarketplaceApproved(_originContract, _tokenId)
        senderMustBeTokenOwner(_originContract, _tokenId)
    {
        // Check that a bid exists.
        require(
            _tokenHasBid(_originContract, _tokenId),
            "Cannot accept a bid when there is none."
        );

        // Payout all parties.
        (uint256 bidAmount, address bidder) = currentBidDetailsOfToken(
            _originContract,
            _tokenId
        );
        _payout(bidAmount, msg.sender, _originContract, _tokenId);

        // Transfer token.
        IERC721 erc721 = IERC721(_originContract);
        erc721.safeTransferFrom(msg.sender, bidder, _tokenId);

        // Wipe the token price and bid.
        _resetTokenPrice(_originContract, _tokenId);
        _resetBid(_originContract, _tokenId);

        // set the token as sold
        _setTokenAsSold(_originContract, _tokenId);

        emit AcceptBid(
            _originContract,
            bidder,
            msg.sender,
            bidAmount,
            _tokenId
        );
    }

    /////////////////////////////////////////////////////////////////////////
    // currentBidDetailsOfToken
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Function to get current bid and bidder of a token.
  * @param _originContract address of ERC721 contract.
  * @param _tokenId uin256 id of the token.
  */
    function currentBidDetailsOfToken(address _originContract, uint256 _tokenId)
        public
        view
        returns (uint256, address)
    {
        return (
            tokenCurrentBids[_originContract][_tokenId],
            tokenCurrentBidders[_originContract][_tokenId]
        );
    }

    /////////////////////////////////////////////////////////////////////////
    // setMarketplaceFee
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Function to set the marketplace fee percentage.
  * @param _percentage uint256 fee to take from purchases.
  */
    function setMarketplaceFee(uint256 _percentage) public onlyOwner {
        marketplaceFee = _percentage;
    }

    /////////////////////////////////////////////////////////////////////////
    // setRoyaltyFee
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Function to set the royalty fee percentage.
  * @param _percentage uint256 royalty fee to take split between seller and creator.
  */
    function setRoyaltyFee(uint256 _percentage) public onlyOwner {
        royaltyFee = _percentage;
    }

    /////////////////////////////////////////////////////////////////////////
    // setPrimarySaleFee
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Function to set the primary sale fee percentage.
  * @param _percentage uint256 fee to take from purchases.
  */
    function setPrimarySaleFee(uint256 _percentage) public onlyOwner {
        primarySaleFee = _percentage;
    }

    /////////////////////////////////////////////////////////////////////////
    // _priceSetterStillOwnsTheToken
    /////////////////////////////////////////////////////////////////////////
    /**
   * @dev Checks that the token is owned by the same person who set the sale price.
   * @param _originContract address of the contract storing the token.
   * @param _tokenId address of the contract storing the token.
   */
    function _priceSetterStillOwnsTheToken(
        address _originContract,
        uint256 _tokenId
    ) internal view returns (bool) {
        IERC721 erc721 = IERC721(_originContract);
        address owner = erc721.ownerOf(_tokenId);
        address priceSetter = priceSetters[_originContract][_tokenId];
        return owner == priceSetter;
    }

    /////////////////////////////////////////////////////////////////////////
    // _payout
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Internal function to pay the seller, creator, and maintainer.
  * @param _amount uint256 value to be split.
  * @param _seller address seller of the token.
  * @param _originContract address of the token contract.
  * @param _tokenId uint256 ID of the token.
  */
    function _payout(
        uint256 _amount,
        address _seller,
        address _originContract,
        uint256 _tokenId
    ) private {
        address maintainer = this.owner();
        address creator = IERC721Creator(_originContract).tokenCreator(
            _tokenId
        );

        uint256 marketplacePayment = _calcMarketplacePayment(
            _amount,
            _originContract,
            _tokenId
        );
        uint256 sellerPayment = _calcSellerPayment(
            _amount,
            _originContract,
            _tokenId
        );
        uint256 royaltyPayment = _calcRoyaltyPayment(
            _amount,
            _originContract,
            _tokenId
        );

        if (marketplacePayment > 0) {
            _makePayable(maintainer).transfer(marketplacePayment);
        }
        if (sellerPayment > 0) {
            _makePayable(_seller).transfer(sellerPayment);
        }
        if (royaltyPayment > 0) {
            _makePayable(creator).transfer(royaltyPayment);
        }
    }

    /////////////////////////////////////////////////////////////////////////
    // _calcMarketplacePayment
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Internal function to calculate Marketplace fees.
  *      If primary sale:  fee + split with seller
         otherwise:        just fee.
  * @param _amount uint256 value to be split
  * @param _originContract address of the token contract
  * @param _tokenId id of the token
  */
    function _calcMarketplacePayment(
        uint256 _amount,
        address _originContract,
        uint256 _tokenId
    ) internal view returns (uint256) {
        uint256 marketplaceFeePayment = _calcMarketplaceFee(_amount);
        bool isPrimarySale = !tokenSolds[_originContract][_tokenId];
        if (isPrimarySale) {
            uint256 primarySalePayment = _amount.mul(primarySaleFee).div(100);
            return marketplaceFeePayment + primarySalePayment;
        }
        return marketplaceFeePayment;
    }

    /////////////////////////////////////////////////////////////////////////
    // _calcRoyaltyPayment
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Internal function to calculate royalty payment.
  *      If primary sale: 0
  *      otherwise:       artist royalty.
  * @param _amount uint256 value to be split
  * @param _originContract address of the token contract
  * @param _tokenId id of the token
  */
    function _calcRoyaltyPayment(
        uint256 _amount,
        address _originContract,
        uint256 _tokenId
    ) internal view returns (uint256) {
        bool isPrimarySale = !tokenSolds[_originContract][_tokenId];
        if (isPrimarySale) {
            return 0;
        }
        return _amount.mul(royaltyFee).div(100);
    }

    /////////////////////////////////////////////////////////////////////////
    // _calcSellerPayment
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Internal function to calculate seller payment.
  *      If primary sale: _amount - split with marketplace,
  *      otherwise:       _amount - artist royalty.
  * @param _amount uint256 value to be split
  * @param _originContract address of the token contract
  * @param _tokenId id of the token
  */
    function _calcSellerPayment(
        uint256 _amount,
        address _originContract,
        uint256 _tokenId
    ) internal view returns (uint256) {
        bool isPrimarySale = !tokenSolds[_originContract][_tokenId];
        if (isPrimarySale) {
            uint256 primarySalePayment = _amount.mul(primarySaleFee).div(100);
            return _amount - primarySalePayment;
        }
        uint256 royaltyPayment = _calcRoyaltyPayment(
            _amount,
            _originContract,
            _tokenId
        );
        return _amount - royaltyPayment;
    }

    /////////////////////////////////////////////////////////////////////////
    // _calcMarketplaceFee
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Internal function calculate marketplace fee for a given amount.
  *      f(_amount) =  _amount * (fee % / 100)
  * @param _amount uint256 value to be split.
  */
    function _calcMarketplaceFee(uint256 _amount)
        internal
        view
        returns (uint256)
    {
        return _amount.mul(marketplaceFee).div(100);
    }

    /////////////////////////////////////////////////////////////////////////
    // _setTokenAsSold
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Internal function to set a token as sold.
  * @param _originContract address of ERC721 contract.
  * @param _tokenId uin256 id of the token.
  */
    function _setTokenAsSold(address _originContract, uint256 _tokenId)
        internal
    {
        if (tokenSolds[_originContract][_tokenId]) {
            return;
        }
        tokenSolds[_originContract][_tokenId] = true;
    }

    /////////////////////////////////////////////////////////////////////////
    // _resetTokenPrice
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Internal function to set token price to 0 for a give contract.
  * @param _originContract address of ERC721 contract.
  * @param _tokenId uin256 id of the token.
  */
    function _resetTokenPrice(address _originContract, uint256 _tokenId)
        internal
    {
        tokenPrices[_originContract][_tokenId] = 0;
        priceSetters[_originContract][_tokenId] = address(0);
    }

    /////////////////////////////////////////////////////////////////////////
    // _addressHasBidOnToken
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Internal function see if the given address has an existing bid on a token.
  * @param _bidder address that may have a current bid.
  * @param _originContract address of ERC721 contract.
  * @param _tokenId uin256 id of the token.
  */
    function _addressHasBidOnToken(
        address _bidder,
        address _originContract,
        uint256 _tokenId
    ) internal view returns (bool) {
        return tokenCurrentBidders[_originContract][_tokenId] == _bidder;
    }

    /////////////////////////////////////////////////////////////////////////
    // _tokenHasBid
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Internal function see if the token has an existing bid.
  * @param _originContract address of ERC721 contract.
  * @param _tokenId uin256 id of the token.
  */
    function _tokenHasBid(address _originContract, uint256 _tokenId)
        internal
        view
        returns (bool)
    {
        return tokenCurrentBidders[_originContract][_tokenId] != address(0);
    }

    /////////////////////////////////////////////////////////////////////////
    // _refundBid
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Internal function to return an existing bid on a token to the
  *      bidder and reset bid.
  * @param _originContract address of ERC721 contract.
  * @param _tokenId uin256 id of the token.
  */
    function _refundBid(address _originContract, uint256 _tokenId) internal {
        address currentBidder = tokenCurrentBidders[_originContract][_tokenId];
        uint256 currentBid = tokenCurrentBids[_originContract][_tokenId];
        uint256 valueToReturn = currentBid + _calcMarketplaceFee(currentBid);
        if (currentBidder == address(0)) {
            return;
        }
        _resetBid(_originContract, _tokenId);
        _makePayable(currentBidder).transfer(valueToReturn);
    }

    /////////////////////////////////////////////////////////////////////////
    // _resetBid
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Internal function to reset bid by setting bidder and bid to 0.
  * @param _originContract address of ERC721 contract.
  * @param _tokenId uin256 id of the token.
  */
    function _resetBid(address _originContract, uint256 _tokenId) internal {
        tokenCurrentBidders[_originContract][_tokenId] = address(0);
        tokenCurrentBids[_originContract][_tokenId] = 0;
    }

    /////////////////////////////////////////////////////////////////////////
    // _setBid
    /////////////////////////////////////////////////////////////////////////
    /**
  * @dev Internal function to set a bid.
  * @param _amount uint256 value in wei to bid. Does not include marketplace fee.
  * @param _bidder address of the bidder.
  * @param _originContract address of ERC721 contract.
  * @param _tokenId uin256 id of the token.
  */
    function _setBid(
        uint256 _amount,
        address _bidder,
        address _originContract,
        uint256 _tokenId
    ) internal {
        // Check bidder not 0 address.
        require(_bidder != address(0), "Bidder cannot be 0 address.");

        // Set bid.
        tokenCurrentBidders[_originContract][_tokenId] = _bidder;
        tokenCurrentBids[_originContract][_tokenId] = _amount;
    }

    /////////////////////////////////////////////////////////////////////////
    // _makePayable
    /////////////////////////////////////////////////////////////////////////
    /**
     * @dev Internal function to set a bid.
     * @param _address non-payable address
     * @return payable address
     */
    function _makePayable(address _address)
    internal
    pure
    returns (address payable)
    {
        return address(uint160(_address));
    }
}
