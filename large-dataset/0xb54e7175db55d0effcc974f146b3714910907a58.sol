// Price Oracle for Stabilize Protocol

// This contract uses Aave Price Oracle

// The main Operator contract can change which Price Oracle it uses



// Gas used for creation: 172,963 gas



pragma solidity ^0.6.0;



/************

IPriceOracleGetter interface

Interface for the Aave price oracle.

*/

interface IPriceOracleGetter {

    function getAssetPrice(address _asset) external view returns (uint256);

    function getAssetsPrices(address[] calldata _assets) external view returns(uint256[] memory);

    function getSourceOfAsset(address _asset) external view returns(address);

    function getFallbackOracle() external view returns(address);

}



interface LendingPoolAddressesProvider {

    function getPriceOracle() external view returns (address);

}



interface Aggregator {

    function latestAnswer() external view returns (int256);

}



contract StabilizePriceOracle {

  function getPrice(address _address) external view returns (uint256) {

      // This version of the price oracle will use Aave contracts

      

      // First get the Ethereum USD price from Chainlink Aggregator

      Aggregator ethOracle = Aggregator(address(0xF79D6aFBb6dA890132F9D7c355e3015f15F3406F)); // Mainlink oracle address

      uint256 ethPrice = uint256(ethOracle.latestAnswer());

      

        // Retrieve PriceOracle address

        LendingPoolAddressesProvider provider = LendingPoolAddressesProvider(address(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8)); // mainnet address, for other addresses: https://docs.aave.com/developers/developing-on-aave/deployed-contract-instances

        address priceOracleAddress = provider.getPriceOracle();

        IPriceOracleGetter priceOracle = IPriceOracleGetter(priceOracleAddress);



        uint256 price = priceOracle.getAssetPrice(_address); // This is relative to Ethereum, need to convert to USD

        ethPrice = ethPrice / 10000; // We only care about 4 decimal places from Chainlink priceOracleAddress

        price = price * ethPrice / 10000; // Convert to Wei format

        return price;

  }

}
