/**
 *Submitted for verification at Etherscan.io on 2018-03-27
*/

pragma solidity ^0.4.18;

/*
This is the main contract for MyEtherCity. Join us at https://myethercity.com/  
Game Name: MyEtherCity (The first city-building game built on top of the Ethereum Blockchain)
Game Link: https://myethercity.com/
*/

contract MyEtherCityGame {

    address ceoAddress = 0x699dE541253f253a4eFf0D3c006D70c43F2E2DaE;
    address InitiateLandsAddress = 0xa93a135e3c73ab77ea00e194bd080918e65149c3;
    
    modifier onlyCeo() {
        require (
            msg.sender == ceoAddress||
            msg.sender == InitiateLandsAddress
            );
        _;
    }

    uint256 priceMetal = 5000000000000000;     // The developer can update the price of metak to regulate the market

    struct Land {
        address ownerAddress;
        uint256 landPrice;
        bool landForSale;
        bool landForRent;
        uint landOwnerCommission;
        bool isOccupied;
        uint cityRentingId;
    }
    Land[] lands;

    struct City {
        uint landId;
        address ownerAddress;
        uint256 cityPrice;
        uint256 cityGdp; 
        bool cityForSale;
        uint squaresOccupied; // Equals 0 when we create the city
        uint metalStock;
    }
    City[] cities;

    struct Business {
        uint itemToProduce;
        uint256 itemPrice;
        uint cityId;
        uint32 readyTime;
    }
    Business[] businesses;

    /*
    Building type:
    0 = house => Can house 5 citizens
    1 = school => Can educate 30 citizens
    2 = clean energy => Can energize 20 citizens
    3 = fossil energy => Can energize 30 citizens
    4 = hospital => Can heal 30 citizens
    5 = amusement => Can amuse 35 citizens
    6 = businesses
    */

    struct Building {
        uint buildingType;
        uint cityId;
        uint32 readyTime;
    }
    Building[] buildings;

    struct Transaction {
        uint buyerId;
        uint sellerId;
        uint256 transactionValue;
        uint itemId;
        uint blockId;
    }
    Transaction[] transactions;

    mapping (uint => uint) public CityBuildingsCount;        // The amount of buildings owned by this address
    mapping (uint => uint) public BuildingTypeMetalNeeded;   // The amount of metal needed to build all the buildings
    mapping (uint => uint) public BuildingTypeSquaresOccupied;  // The land occupied by each building
    mapping (uint => uint) public CountBusinessesPerType;       // We keep track of the amount of businesses created per type
    mapping (uint => uint) public CityBusinessCount;            // We keep track of the amount of businesses owned by a city
    mapping (uint => uint) public CitySalesTransactionsCount;    // We keep track of the sales generated by a city

    ///
    /// GET
    ///

    // This function will return the details for a land
    function getLand(uint _landId) public view returns (
        address ownerAddress,
        uint256 landPrice,
        bool landForSale,
        bool landForRent,
        uint landOwnerCommission,
        bool isOccupied,
        uint cityRentingId
    ) {
        Land storage _land = lands[_landId];

        ownerAddress = _land.ownerAddress;
        landPrice = _land.landPrice;
        landForSale = _land.landForSale;
        landForRent = _land.landForRent;
        landOwnerCommission = _land.landOwnerCommission;
        isOccupied = _land.isOccupied;
        cityRentingId = _land.cityRentingId;
    }

    // This function will return the details for a city
    function getCity(uint _cityId) public view returns (
        uint landId,
        address landOwner,
        address cityOwner,
        uint256 cityPrice,
        uint256 cityGdp,
        bool cityForSale,
        uint squaresOccupied,
        uint metalStock,
        uint cityPopulation,
        uint healthCitizens,
        uint educationCitizens,
        uint happinessCitizens,
        uint productivityCitizens
    ) {
        City storage _city = cities[_cityId];

        landId = _city.landId;
        landOwner = lands[_city.landId].ownerAddress;
        cityOwner = _city.ownerAddress;
        cityPrice = _city.cityPrice;
        cityGdp = _city.cityGdp;
        cityForSale = _city.cityForSale;
        squaresOccupied = _city.squaresOccupied;
        metalStock = _city.metalStock;
        cityPopulation = getCityPopulation(_cityId);
        healthCitizens = getHealthCitizens(_cityId);
        educationCitizens = getEducationCitizens(_cityId);
        happinessCitizens = getHappinessCitizens(_cityId);
        productivityCitizens = getProductivityCitizens(_cityId);
    }

    // This function will return the details for a business
    function getBusiness(uint _businessId) public view returns (
        uint itemToProduce,
        uint256 itemPrice,
        uint cityId,
        uint cityMetalStock,
        uint readyTime,
        uint productionTime,
        uint cityLandId,
        address cityOwner
    ) {
        Business storage _business = businesses[_businessId];

        itemToProduce = _business.itemToProduce;
        itemPrice = _business.itemPrice;
        cityId = _business.cityId;
        cityMetalStock = cities[_business.cityId].metalStock;
        readyTime = _business.readyTime;
        productionTime = getProductionTimeBusiness(_businessId);
        cityLandId = cities[_business.cityId].landId;
        cityOwner = cities[_business.cityId].ownerAddress;
        
    }

    // This function will return the details for a building
    function getBuilding(uint _buildingId) public view returns (
        uint buildingType,
        uint cityId,
        uint32 readyTime
    ) {
        Building storage _building = buildings[_buildingId];

        buildingType = _building.buildingType;
        cityId = _building.cityId;
        readyTime = _building.readyTime;
    }

    // This function will return the details for a transaction
    function getTransaction(uint _transactionId) public view returns (
        uint buyerId,
        uint sellerId,
        uint256 transactionValue,
        uint itemId,
        uint blockId
    ) {
        Transaction storage _transaction = transactions[_transactionId];

        buyerId = _transaction.buyerId;
        sellerId = _transaction.sellerId;
        transactionValue = _transaction.transactionValue;
        itemId = _transaction.itemId;
        blockId = _transaction.blockId;
    }

    // Returns the count of buildings for a city 
    function getCityBuildings(uint _cityId, bool _active) public view returns (
        uint countBuildings,
        uint countHouses,
        uint countSchools,
        uint countHospital,
        uint countAmusement
    ) {
        countBuildings = getCountAllBuildings(_cityId, _active);
        countHouses = getCountBuildings(_cityId, 0, _active);
        countSchools = getCountBuildings(_cityId, 1, _active);
        countHospital = getCountBuildings(_cityId, 2, _active);
        countAmusement = getCountBuildings(_cityId, 3, _active);
    }
        
    // Get all the lands owned by a city
    function getSenderLands(address _senderAddress) public view returns(uint[]) {
        uint[] memory result = new uint[](getCountSenderLands(_senderAddress));
        uint counter = 0;
        for (uint i = 0; i < lands.length; i++) {
          if (lands[i].ownerAddress == _senderAddress) {
            result[counter] = i;
            counter++;
          }
        }
        return result;
    }
    
    function getCountSenderLands(address _senderAddress) public view returns(uint) {
        uint counter = 0;
        for (uint i = 0; i < lands.length; i++) {
          if (lands[i].ownerAddress == _senderAddress) {
            counter++;
          }
        }
        return(counter);
    }
    
     // Get all the lands owned by a city
    function getSenderCities(address _senderAddress) public view returns(uint[]) {
        uint[] memory result = new uint[](getCountSenderCities(_senderAddress));
        uint counter = 0;
        for (uint i = 0; i < cities.length; i++) {
          if (cities[i].ownerAddress == _senderAddress) {
            result[counter] = i;
            counter++;
          }
        }
        return result;
    }
    
    function getCountSenderCities(address _senderAddress) public view returns(uint) {
        uint counter = 0;
        for (uint i = 0; i < cities.length; i++) {
          if (cities[i].ownerAddress == _senderAddress) {
            counter++;
          }
        }
        return(counter);
    }

    // We use this function to return the population of a city
    function getCityPopulation(uint _cityId) public view returns (uint) {
        // We multiply the number of houses per 5 to get the population of a city
        uint _cityActiveBuildings = getCountBuildings(_cityId, 0, true);
        return(_cityActiveBuildings * 5);
    }

    // Count the number of active or pending buildings
    function getCountAllBuildings(uint _cityId, bool _active) public view returns(uint) {
        uint counter = 0;
        for (uint i = 0; i < buildings.length; i++) {
            if(_active == true) {
                // If active == true we loop through the active buildings
                if(buildings[i].cityId == _cityId && buildings[i].readyTime < now) {
                    counter++;
                }
            } else {
                // If active == false we loop through the pending buildings
                if(buildings[i].cityId == _cityId && buildings[i].readyTime >= now) {
                    counter++;
                }
            }
            
        }
        return counter;
    }
    
    // Count the number of active or pending buildings
    function getCountBuildings(uint _cityId, uint _buildingType, bool _active) public view returns(uint) {
        uint counter = 0;
        for (uint i = 0; i < buildings.length; i++) {
            if(_active == true) {
                // If active == true we loop through the active buildings
                if(buildings[i].buildingType == _buildingType && buildings[i].cityId == _cityId && buildings[i].readyTime < now) {
                    counter++;
                }
            } else {
                // If active == false we loop through the pending buildings
                if(buildings[i].buildingType == _buildingType && buildings[i].cityId == _cityId && buildings[i].readyTime >= now) {
                    counter++;
                }
            }
        }
        return counter;
    }

    // Get the active buildings (by type) owned by a specific city
    function getCityActiveBuildings(uint _cityId, uint _buildingType) public view returns(uint[]) {
        uint[] memory result = new uint[](getCountBuildings(_cityId, _buildingType, true));
        uint counter = 0;
        for (uint i = 0; i < buildings.length; i++) {
            // We add the ready building owned by this user
            if (buildings[i].buildingType == _buildingType && buildings[i].cityId == _cityId && buildings[i].readyTime < now) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    // Get the pending buildings (by type) owned by a specific city
    function getCityPendingBuildings(uint _cityId, uint _buildingType) public view returns(uint[]) {
        uint[] memory result = new uint[](getCountBuildings(_cityId, _buildingType, false));
        uint counter = 0;
        for (uint i = 0; i < buildings.length; i++) {
            // We add the pending building owned by this user
            if (buildings[i].buildingType == _buildingType && buildings[i].cityId == _cityId && buildings[i].readyTime >= now) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    // Get Businesses per type
    function getActiveBusinessesPerType(uint _businessType) public view returns(uint[]) {
        uint[] memory result = new uint[](CountBusinessesPerType[_businessType]);
        uint counter = 0;
        for (uint i = 0; i < businesses.length; i++) {
            // We add the pending building owned by this user
            if (businesses[i].itemToProduce == _businessType) {
                result[counter] = i;
                counter++;
            }
        }
        // returns an array of id for the active businesses
        return result;
    }

    // Get Businesses per city
    function getActiveBusinessesPerCity(uint _cityId) public view returns(uint[]) {
        uint[] memory result = new uint[](CityBusinessCount[_cityId]);
        uint counter = 0;
        for (uint i = 0; i < businesses.length; i++) {
            // We add the pending building owned by this user
            if (businesses[i].cityId == _cityId) {
                result[counter] = i;
                counter++;
            }
        }
        // returns an array of id for the active businesses
        return result;
    }
    
    // Get the sales generated by a city
    function getSalesCity(uint _cityId) public view returns(uint[]) {
        uint[] memory result = new uint[](CitySalesTransactionsCount[_cityId]);
        uint counter = 0;
        uint startId = transactions.length - 1;
        for (uint i = 0; i < transactions.length; i++) {
            uint _tId = startId - i;
            // We add the pending building owned by this user
            if (transactions[_tId].sellerId == _cityId) {
                result[counter] = _tId;
                counter++;
            }
        }
        // returns an array of id for the sales generated by the city (the most recent sales comes in first)
        return result;
    }

    // Return the health of the citizens of a city
    function getHealthCitizens(uint _cityId) public view returns(uint) {
        uint _hospitalsCount = getCountBuildings(_cityId, 2, true);
        uint pointsHealth = (_hospitalsCount * 500) + 50;
        uint _population = getCityPopulation(_cityId);
        uint256 _healthPopulation = 10;
        
        if(_population > 0) {
            _healthPopulation = (pointsHealth / uint256(_population));
        } else {
            _healthPopulation = 0;
        }
        
        // The indicator can't be more than 10
        if(_healthPopulation > 10) {
            _healthPopulation = 10;
        }
        return(_healthPopulation);
    }

    // Return the education of the citizens of a city
    function getEducationCitizens(uint _cityId) public view returns(uint) {
        uint _schoolsCount = getCountBuildings(_cityId, 1, true);
        uint pointsEducation = (_schoolsCount * 250) + 25;
        uint _population = getCityPopulation(_cityId);
        uint256 _educationPopulation = 10;

        if(_population > 0) {
            _educationPopulation = (pointsEducation / uint256(_population));
        } else {
            _educationPopulation = 0;
        }
        
        if(_educationPopulation > 10) {
            _educationPopulation = 10;
        }
        return(_educationPopulation);
    }

    // Return the happiness of the citizens of a city
    function getHappinessCitizens(uint _cityId) public view returns(uint) {
        uint _amusementCount = getCountBuildings(_cityId, 3, true);
        uint pointsAmusement = (_amusementCount * 350) + 35;
        uint _population = getCityPopulation(_cityId);
        uint256 _amusementPopulation = 10;
        
        if(_population > 0) {
            _amusementPopulation = (pointsAmusement / uint256(_population));
        } else {
            _amusementPopulation = 0;
        }
        
        // The indicator can't be more than 10
        if(_amusementPopulation > 10) {
            _amusementPopulation = 10;
        }
        return(_amusementPopulation);
    }

    // Return the productivity of the citizens of a city
    function getProductivityCitizens(uint _cityId) public view returns(uint) {
        return((getEducationCitizens(_cityId) + getHealthCitizens(_cityId) + getHappinessCitizens(_cityId)) / 3);
    }

    // This function returns the maximum businesses a city can build (according to its population)
    function getMaxBusinessesPerCity(uint _cityId) public view returns(uint) {
        uint _citizens = getCityPopulation(_cityId);
        uint _maxBusinesses;

        // Calculate the max amount of businesses available per city
        if(_citizens >= 75) {
            _maxBusinesses = 4;
        } else if(_citizens >= 50) {
            _maxBusinesses = 3;
        } else if(_citizens >= 25) {
            _maxBusinesses = 2;
        } else {
            _maxBusinesses = 1;
        }

        return(_maxBusinesses);
    }
    
    function getCountCities() public view returns(uint) {
        return(cities.length);
    }

    ///
    /// ACTIONS
    ///
    
    // Land owner can use this function to remove a city from their land 
    function removeTenant(uint _landId) public {
        require(lands[_landId].ownerAddress == msg.sender);
        lands[_landId].landForRent = false;
        lands[_landId].isOccupied = false;
        cities[lands[_landId].cityRentingId].landId = 0;
        lands[_landId].cityRentingId = 0;
    }

    // We use this function to purchase a business
    // Businesses are free to create but each city can run only one business.
    function createBusiness(uint _itemId, uint256 _itemPrice, uint _cityId) public {
        // We check if the price of the item sold is enough regarding the current price of the metal
        require(_itemPrice >= BuildingTypeMetalNeeded[_itemId] * priceMetal);

        // We verifiy that the sender is the owner of the city
        require(cities[_cityId].ownerAddress == msg.sender);

        // We check that the city has enough squares to host this new building
        require((cities[_cityId].squaresOccupied + BuildingTypeSquaresOccupied[4]) <= 100);
        
        // We check if the city has enough population to create this business (1 building / 25 citizens)
        require(CityBusinessCount[_cityId] < getMaxBusinessesPerCity(_cityId));

        // We create the business
        businesses.push(Business(_itemId, _itemPrice, _cityId, 0));

        // We increment the businesses count for this type and city
        CountBusinessesPerType[_itemId]++;

        // We increment the count of businesses for this city
        CityBusinessCount[_cityId]++;

        // Increment the squares used in this land
        cities[_cityId].squaresOccupied = cities[_cityId].squaresOccupied + BuildingTypeSquaresOccupied[4];
    }

    // This function can let business owner update the price of the building they are selling
    function updateBusiness(uint _businessId, uint256 _itemPrice) public {
        // We check if the user is the owner of the business
        require(cities[businesses[_businessId].cityId].ownerAddress == msg.sender);

        // We check if the price of the item sold is enough regarding the current price of the metal
        require(_itemPrice >= BuildingTypeMetalNeeded[businesses[_businessId].itemToProduce] * priceMetal);

        businesses[_businessId].itemPrice = _itemPrice;
    }

    // We use this function to purchase metal
    function purchaseMetal(uint _cityId, uint _amount) public payable {
        // We check that the user is paying the correct price 
        require(msg.value == _amount * priceMetal);

        // We verifiy that the sender is the owner of the city
        require(cities[_cityId].ownerAddress == msg.sender);

        // Transfer the amount paid to the ceo
        ceoAddress.transfer(msg.value);

        // Add the metal to the city stock
        cities[_cityId].metalStock = cities[_cityId].metalStock + _amount;
    }
    
    // This function will return the production time for a specific business
    function getProductionTimeBusiness(uint _businessId) public view returns(uint256) {
        uint _productivityIndicator = getProductivityCitizens(businesses[_businessId].cityId);
        uint _countCitizens = getCityPopulation(businesses[_businessId].cityId);
        
        uint256 productivityFinal;
        
        if(_countCitizens == 0) {
            // The min production time with 0 citizens should be 7000
            productionTime = 7000; 
        } else {
            // We calculat the production time
            if(_productivityIndicator <= 1) {
            productivityFinal = _countCitizens;
            } else {
                productivityFinal = _countCitizens * (_productivityIndicator / 2);
            }
            
            uint256 productionTime = 60000 / uint256(productivityFinal);
        }
        return(productionTime);
    }

    // We use this function to purchase a building from a business
    function purchaseBuilding(uint _itemId, uint _businessId, uint _cityId) public payable {
        // We verify that the user is paying the correct price
        require(msg.value == businesses[_businessId].itemPrice);

        // We verifiy that the sender is the owner of the city
        require(cities[_cityId].ownerAddress == msg.sender);

        // We check if this business is authorized to produce this building
        require(_itemId == businesses[_businessId].itemToProduce);

        // We check if the city where the business is located as enough Metal in Stock
        require(cities[businesses[_businessId].cityId].metalStock >= BuildingTypeMetalNeeded[_itemId]);

        // We check that the city has enough squares to host this new building
        require((cities[_cityId].squaresOccupied + BuildingTypeSquaresOccupied[_itemId]) <= 100);

        // We check if the business is ready to produce another building
        require(businesses[_businessId].readyTime < now);

        uint256 onePercent = msg.value / 100;

        // Send commission of the amount paid to land owner of where the business is located
        uint _landId = cities[businesses[_businessId].cityId].landId;
        address landOwner = lands[_landId].ownerAddress;
        uint256 landOwnerCommission = onePercent * lands[cities[businesses[_businessId].cityId].landId].landOwnerCommission;
        landOwner.transfer(landOwnerCommission);

        // Send the rest to the business owner
        cities[businesses[_businessId].cityId].ownerAddress.transfer(msg.value - landOwnerCommission);

        // Reduce the metal stock of the city where the business is located
        cities[businesses[_businessId].cityId].metalStock = cities[businesses[_businessId].cityId].metalStock - BuildingTypeMetalNeeded[_itemId];

        // Calculate production time
        uint productionTime = getProductionTimeBusiness(_businessId);
        uint32 _buildingReadyTime = uint32(now + productionTime);

        // Update production time for the business
        businesses[_businessId].readyTime = uint32(now + productionTime);

        // Create the building
        buildings.push(Building(_itemId, _cityId, _buildingReadyTime));

        // Increment the squares used in this land
        cities[_cityId].squaresOccupied = cities[_cityId].squaresOccupied + BuildingTypeSquaresOccupied[_itemId];

        // Increment the GDP generated by this city
        cities[_cityId].cityGdp = cities[_cityId].cityGdp + msg.value;

        // Increment the buildings count in this city
        CityBuildingsCount[_cityId]++;

        // Save transaction in smart contract
        transactions.push(Transaction(_cityId, businesses[_businessId].cityId, msg.value, _itemId, block.number));
        CitySalesTransactionsCount[businesses[_businessId].cityId]++;
    }

    // We use this function to let the land owner update its land
    function updateLand(uint _landId, uint256 _landPrice, uint _typeUpdate, uint _commission) public {
        require(lands[_landId].ownerAddress == msg.sender);

        /// Types update:
        /// 0: Sell land
        /// 1: Put the land for rent

        if(_typeUpdate == 0) {

            // Land is for sale
            lands[_landId].landForSale = true;
            lands[_landId].landForRent = false;
            lands[_landId].landPrice = _landPrice;
            
        } else if(_typeUpdate == 1) {
            // The owner can't change the commission if the land is occupied
            require(lands[_landId].isOccupied == false);
            
            // Land is for rent
            lands[_landId].landForRent = true;
            lands[_landId].landForSale = false;
            lands[_landId].landOwnerCommission = _commission;

        } else if(_typeUpdate == 2) {
            // The owner cancel the sale of its land
            lands[_landId].landForRent = false;
            lands[_landId].landForSale = false;
        }
    }

    function purchaseLand(uint _landId, uint _typePurchase, uint _commission) public payable {
        require(lands[_landId].landForSale == true);
        require(msg.value == lands[_landId].landPrice);

        // Transfer the amount paid to the previous land owner
        lands[_landId].ownerAddress.transfer(msg.value);

        // Update the land
        lands[_landId].ownerAddress = msg.sender;
        lands[_landId].landForSale = false;

        /// _typePurchase:
        /// 0: Create city
        /// 1: Rent the land
        /// 2: Cancel sale
        
        if(_typePurchase == 0) {
            // The user in purchasing the land to build the city on top of it we create the city directly
            createCity(_landId);
        } else if(_typePurchase == 1) {
            // The user is purchasing the land to rent it to another user
            lands[_landId].landForRent = true;
            lands[_landId].landForSale = false;
            lands[_landId].landOwnerCommission = _commission;
        } 
    }
    
    // We use this function to let users rent lands.
    function rentLand(uint _landId, bool _createCity, uint _cityId) public {
        // The owner can rent the land even if it's not marked forRent
        if(lands[_landId].ownerAddress != msg.sender) {
            require(lands[_landId].landForRent == true);
        }

        // Cities can't rent a land if it's already occupied
        require(lands[_landId].isOccupied == false);
                    
        if(_createCity == true) {
            // We create the city if the user is renting this land for a new city
            createCity(_landId);
        } else {
            // Cities can't rent a land if they are already landing one
            require(cities[_cityId].landId == 0);
        
            // We update the land and city if the user is renting the land for an existing city
            cities[_cityId].landId = _landId;
            lands[_landId].cityRentingId = _cityId;
            lands[_landId].landForSale == false;
            lands[_landId].landForRent == true;
            lands[_landId].isOccupied = true;
        }
    }

    function createCity(uint _landId) public {
        require(lands[_landId].isOccupied == false);

        // Create the city
        uint cityId = cities.push(City(_landId, msg.sender, 0, 0, false, 0, 0)) - 1;

        lands[_landId].landForSale == false;
        lands[_landId].landForRent == false;
        lands[_landId].cityRentingId = cityId;
        lands[_landId].isOccupied = true;
    }
    
    // The dev can use this function to create an innocupied land
    function CreateLand(uint256 _landPrice, address _owner) public onlyCeo {
        // We can't create more than 300 lands.
        if(lands.length < 300) {
            lands.push(Land(_owner, _landPrice, false, false, 0, false, 0));
        }
        
    }
    
    function UpdateInitiateContractAddress(address _newAddress) public onlyCeo { 
        InitiateLandsAddress = _newAddress;
    }
    
    // We initialize some datas with this function
    function Initialize() public onlyCeo {
        // To be able to use the land id in the city struct
        lands.push(Land(ceoAddress, 0, false, false, 5, true, 0)); // Fake Land #0 is created here

        // Save the amount of metal needed to produce the buildings
        BuildingTypeMetalNeeded[0] = 3;
        BuildingTypeMetalNeeded[1] = 4;
        BuildingTypeMetalNeeded[2] = 5;
        BuildingTypeMetalNeeded[3] = 4;

        // Save the squares used by buildings
        BuildingTypeSquaresOccupied[0] = 2;
        BuildingTypeSquaresOccupied[1] = 4;
        BuildingTypeSquaresOccupied[2] = 6;
        BuildingTypeSquaresOccupied[3] = 4;
        BuildingTypeSquaresOccupied[4] = 5; // Businesses
    }
}
