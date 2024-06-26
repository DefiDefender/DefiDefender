/**

 *Submitted for verification at Etherscan.io on 2019-09-26

*/



/**

 *Submitted for verification at Etherscan.io on 2019-08-30

*/



/**

 *  @authors: [@mtsalenc]

 *  @reviewers: []

 *  @auditors: []

 *  @bounties: []

 *  @deployments: []

 */



pragma solidity 0.5.11;

pragma experimental ABIEncoderV2;



interface IArbitrableTokenList {

    

    enum TokenStatus {

        Absent, // The token is not in the registry.

        Registered, // The token is in the registry.

        RegistrationRequested, // The token has a request to be added to the registry.

        ClearingRequested // The token has a request to be removed from the registry.

    }

    

    function getTokenInfo(bytes32) external view returns (string memory, string memory, address, string memory, TokenStatus, uint);

    function queryTokens(bytes32 _cursor, uint _count, bool[8] calldata _filter, bool _oldestFirst, address _tokenAddr)

        external

        view

        returns (bytes32[] memory values, bool hasMore);

    function tokenCount() external view returns (uint);

    function addressToSubmissions(address _addr) external view returns (bytes32[] memory);

}



/** @title TokensView

 *  Utility view contract to fetch multiple token information at once.

 */

contract TokensView {

    

    struct Token {

        bytes32 ID;

        string name;

        string ticker;

        address addr;

        string symbolMultihash;

        IArbitrableTokenList.TokenStatus status;

        uint decimals;

    }

    

    /** @dev Fetch token IDs of the first tokens present on the tcr for the addresses.

     *  @param _t2crAddress The address of the t2cr contract from where to fetch token information.

     *  @param _tokenAddresses The address of each token.

     */

    function getTokensIDsForAddresses(

        address _t2crAddress, 

        address[] calldata _tokenAddresses

    ) external view returns (bytes32[] memory result) {

        IArbitrableTokenList t2cr = IArbitrableTokenList(_t2crAddress);

        result = new bytes32[](_tokenAddresses.length);

        bytes32 ZERO_ID = 0x0000000000000000000000000000000000000000000000000000000000000000;

        for (uint i = 0; i < _tokenAddresses.length;  i++){

            bytes32[] memory tokenIDs = t2cr.addressToSubmissions(_tokenAddresses[i]);

            for(uint j = 0; j < tokenIDs.length; j++) {

                (,,,,IArbitrableTokenList.TokenStatus status,) = t2cr.getTokenInfo(tokenIDs[j]);

                if (status == IArbitrableTokenList.TokenStatus.Registered || status == IArbitrableTokenList.TokenStatus.ClearingRequested) 

                {

                    result[i] = tokenIDs[j];

                    break;

                }

            }

        }

    }

    

    /** @dev Fetch up token information with token IDs. If a token contract does not implement the decimals() function, its decimals field will be 0.

     *  @param _t2crAddress The address of the t2cr contract from where to fetch token information.

     *  @param _tokenIDs The IDs of the tokens we want to query.

     *  @return tokens The tokens information.

     */

    function getTokens(address _t2crAddress, bytes32[] calldata _tokenIDs) 

        external 

        view 

        returns (Token[] memory tokens)

    {

        IArbitrableTokenList t2cr = IArbitrableTokenList(_t2crAddress);

        tokens = new Token[](_tokenIDs.length);

        for (uint i = 0; i < _tokenIDs.length ; i++){

            string[] memory strings = new string[](3); // name, ticker and symbolMultihash respectively.

            address tokenAddress;

            IArbitrableTokenList.TokenStatus status;

            (

                strings[0], 

                strings[1], 

                tokenAddress, 

                strings[2], 

                status, 

            ) = t2cr.getTokenInfo(_tokenIDs[i]);

            

            tokens[i] = Token(

                _tokenIDs[i],

                strings[0],

                strings[1],

                tokenAddress,

                strings[2],

                status,

                0

            );

            

            // Call the contract's decimals() function without reverting when

            // the contract does not implement it.

            // 

            // Two things should be noted: if the contract does not implement the function

            // and does not implement the contract fallback function, `success` will be set to

            // false and decimals won't be set. However, in some cases (such as old contracts) 

            // the fallback function is implemented, and so staticcall will return true

            // even though the value returned will not be correct (the number below):

            // 

            // 22270923699561257074107342068491755213283769984150504402684791726686939079929

            //

            // We handle that edge case by also checking against this value.

            uint decimals;

            bool success;

            bytes4 sig = bytes4(keccak256("decimals()"));

            assembly {

                let x := mload(0x40)   // Find empty storage location using "free memory pointer"

                mstore(x, sig)          // Set the signature to the first call parameter. 0x313ce567 === bytes4(keccak256("decimals()")

                success := staticcall(

                    30000,              // 30k gas

                    tokenAddress,       // The call target.

                    x,                  // Inputs are stored at location x

                    0x04,               // Input is 4 bytes long

                    x,                  // Overwrite x with output

                    0x20                // The output length

                )

                

                decimals := mload(x)   

            }

            if (success && decimals != 22270923699561257074107342068491755213283769984150504402684791726686939079929) {

                tokens[i].decimals = decimals;

            }

        }

    }

}
