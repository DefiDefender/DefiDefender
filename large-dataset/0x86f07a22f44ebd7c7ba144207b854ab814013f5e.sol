pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;


contract ProtocolInterface {
    function deposit(address _user, uint256 _amount) public;

    function withdraw(address _user, uint256 _amount) public;
}

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
}

contract ITokenInterface is ERC20 {
    function assetBalanceOf(address _owner) public view returns (uint256);

    function mint(address receiver, uint256 depositAmount) external returns (uint256 mintAmount);

    function burn(address receiver, uint256 burnAmount) external returns (uint256 loanAmountPaid);

    function balanceOf(address _owner) external view returns (uint256 balance);

    function tokenPrice() public view returns (uint256 price);
}

contract ConstantAddressesMainnet {
    address public constant MAKER_DAI_ADDRESS = 0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359;
    address public constant IDAI_ADDRESS = 0x14094949152EDDBFcd073717200DA82fEd8dC960;
    address public constant SOLO_MARGIN_ADDRESS = 0x1E0447b19BB6EcFdAe1e4AE1694b0C3659614e4e;
    address public constant CDAI_ADDRESS = 0xF5DCe57282A584D2746FaF1593d3121Fcac444dC;
    address public constant KYBER_ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    address public constant MKR_ADDRESS = 0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2;
    address public constant WETH_ADDRESS = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public constant VOX_ADDRESS = 0x9B0F70Df76165442ca6092939132bBAEA77f2d7A;
    address public constant PETH_ADDRESS = 0xf53AD2c6851052A81B42133467480961B2321C09;
    address public constant TUB_ADDRESS = 0x448a5065aeBB8E423F0896E6c5D525C040f59af3;
    address payable public constant WALLET_ID = 0x322d58b9E75a6918f7e7849AEe0fF09369977e08;
    address public constant LOGGER_ADDRESS = 0xeCf88e1ceC2D2894A0295DB3D86Fe7CE4991E6dF;
    address public constant OTC_ADDRESS = 0x794e6e91555438aFc3ccF1c5076A74F42133d08D;
    address public constant DISCOUNT_ADDRESS = 0x1b14E8D511c9A4395425314f849bD737BAF8208F;

    address public constant KYBER_WRAPPER = 0x8F337bD3b7F2b05d9A8dC8Ac518584e833424893;
    address public constant UNISWAP_WRAPPER = 0x1e30124FDE14533231216D95F7798cD0061e5cf8;
    address public constant ETH2DAI_WRAPPER = 0xd7BBB1777E13b6F535Dec414f575b858ed300baF;
    address public constant OASIS_WRAPPER = 0x9aBE2715D2d99246269b8E17e9D1b620E9bf6558;

    address public constant KYBER_INTERFACE = 0x818E6FECD516Ecc3849DAf6845e3EC868087B755;
    address public constant UNISWAP_FACTORY = 0xc0a47dFe034B400B47bDaD5FecDa2621de6c4d95;
    address public constant FACTORY_ADDRESS = 0x5a15566417e6C1c9546523066500bDDBc53F88C7;
    address public constant PIP_INTERFACE_ADDRESS = 0x729D19f657BD0614b4985Cf1D82531c67569197B;

    address public constant PROXY_REGISTRY_INTERFACE_ADDRESS = 0x4678f0a6958e4D2Bc4F1BAF7Bc52E8F3564f3fE4;
    address public constant GAS_TOKEN_INTERFACE_ADDRESS = 0x0000000000b3F879cb30FE243b4Dfee438691c04;

    address public constant SAVINGS_LOGGER_ADDRESS = 0x89b3635BD2bAD145C6f92E82C9e83f06D5654984;
    address public constant AUTOMATIC_LOGGER_ADDRESS = 0xAD32Ce09DE65971fFA8356d7eF0B783B82Fd1a9A;

    address public constant SAVER_EXCHANGE_ADDRESS = 0x6eC6D98e2AF940436348883fAFD5646E9cdE2446;

    
    address public constant COMPOUND_DAI_ADDRESS = 0x25a01a05C188DaCBCf1D61Af55D4a5B4021F7eeD;
    address public constant STUPID_EXCHANGE = 0x863E41FE88288ebf3fcd91d8Dbb679fb83fdfE17;

    
    address public constant MANAGER_ADDRESS = 0x5ef30b9986345249bc32d8928B7ee64DE9435E39;
    address public constant VAT_ADDRESS = 0x35D1b3F3D7966A1DFe207aa4514C12a259A0492B;
    address public constant SPOTTER_ADDRESS = 0x65C79fcB50Ca1594B025960e539eD7A9a6D434A3;
    address public constant PROXY_ACTIONS = 0x82ecD135Dce65Fbc6DbdD0e4237E0AF93FFD5038;

    address public constant JUG_ADDRESS = 0x19c0976f590D67707E62397C87829d896Dc0f1F1;
    address public constant DAI_JOIN_ADDRESS = 0x9759A6Ac90977b93B58547b4A71c78317f391A28;
    address public constant ETH_JOIN_ADDRESS = 0x2F0b23f53734252Bda2277357e97e1517d6B042A;
    address public constant MIGRATION_ACTIONS_PROXY = 0xe4B22D484958E582098A98229A24e8A43801b674;

    address public constant SAI_ADDRESS = 0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359;
    address public constant DAI_ADDRESS = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    address payable public constant SCD_MCD_MIGRATION = 0xc73e0383F3Aff3215E6f04B0331D58CeCf0Ab849;

    
    address public constant SUBSCRIPTION_ADDRESS = 0x83152CAA0d344a2Fd428769529e2d490A88f4393;
    address public constant MONITOR_ADDRESS = 0x3F4339816EDEF8D3d3970DB2993e2e0Ec6010760;

    address public constant NEW_CDAI_ADDRESS = 0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643;
    address public constant NEW_IDAI_ADDRESS = 0x493C57C4763932315A328269E1ADaD09653B9081;

    address public constant ERC20_PROXY_0X = 0x95E6F48254609A6ee006F7D493c8e5fB97094ceF;
}

contract ConstantAddressesKovan {
    address public constant KYBER_ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    address public constant WETH_ADDRESS = 0xd0A1E359811322d97991E03f863a0C30C2cF029C;
    address public constant MAKER_DAI_ADDRESS = 0xC4375B7De8af5a38a93548eb8453a498222C4fF2;
    address public constant MKR_ADDRESS = 0xAaF64BFCC32d0F15873a02163e7E500671a4ffcD;
    address public constant VOX_ADDRESS = 0xBb4339c0aB5B1d9f14Bd6e3426444A1e9d86A1d9;
    address public constant PETH_ADDRESS = 0xf4d791139cE033Ad35DB2B2201435fAd668B1b64;
    address public constant TUB_ADDRESS = 0xa71937147b55Deb8a530C7229C442Fd3F31b7db2;
    address public constant LOGGER_ADDRESS = 0x32d0e18f988F952Eb3524aCE762042381a2c39E5;
    address payable public constant WALLET_ID = 0x54b44C6B18fc0b4A1010B21d524c338D1f8065F6;
    address public constant OTC_ADDRESS = 0x4A6bC4e803c62081ffEbCc8d227B5a87a58f1F8F;
    address public constant COMPOUND_DAI_ADDRESS = 0x25a01a05C188DaCBCf1D61Af55D4a5B4021F7eeD;
    address public constant SOLO_MARGIN_ADDRESS = 0x4EC3570cADaAEE08Ae384779B0f3A45EF85289DE;
    address public constant IDAI_ADDRESS = 0xA1e58F3B1927743393b25f261471E1f2D3D9f0F6;
    address public constant CDAI_ADDRESS = 0xb6b09fBffBa6A5C4631e5F7B2e3Ee183aC259c0d;
    address public constant STUPID_EXCHANGE = 0x863E41FE88288ebf3fcd91d8Dbb679fb83fdfE17;
    address public constant DISCOUNT_ADDRESS = 0x1297c1105FEDf45E0CF6C102934f32C4EB780929;
    address public constant SAI_SAVER_PROXY = 0xADB7c74bCe932fC6C27ddA3Ac2344707d2fBb0E6;

    address public constant KYBER_WRAPPER = 0x68c56FF0E7BBD30AF9Ad68225479449869fC1bA0;
    address public constant UNISWAP_WRAPPER = 0x2A4ee140F05f1Ba9A07A020b07CCFB76CecE4b43;
    address public constant ETH2DAI_WRAPPER = 0x823cde416973a19f98Bb9C96d97F4FE6C9A7238B;
    address public constant OASIS_WRAPPER = 0x0257Ba4876863143bbeDB7847beC583e4deb6fE6;

    address public constant SAVER_EXCHANGE_ADDRESS = 0xACA7d11e3f482418C324aAC8e90AaD0431f692A6;

    address public constant FACTORY_ADDRESS = 0xc72E74E474682680a414b506699bBcA44ab9a930;
    
    address public constant PIP_INTERFACE_ADDRESS = 0xA944bd4b25C9F186A846fd5668941AA3d3B8425F;
    address public constant PROXY_REGISTRY_INTERFACE_ADDRESS = 0x64A436ae831C1672AE81F674CAb8B6775df3475C;
    address public constant GAS_TOKEN_INTERFACE_ADDRESS = 0x0000000000170CcC93903185bE5A2094C870Df62;
    address public constant KYBER_INTERFACE = 0x692f391bCc85cefCe8C237C01e1f636BbD70EA4D;

    address public constant SAVINGS_LOGGER_ADDRESS = 0x2aa889D809B29c608dA99767837D189dAe12a874;

    
    address public constant UNISWAP_FACTORY = 0xf5D915570BC477f9B8D6C0E980aA81757A3AaC36;

    
    address public constant MANAGER_ADDRESS = 0x1476483dD8C35F25e568113C5f70249D3976ba21;
    address public constant VAT_ADDRESS = 0xbA987bDB501d131f766fEe8180Da5d81b34b69d9;
    address public constant SPOTTER_ADDRESS = 0x3a042de6413eDB15F2784f2f97cC68C7E9750b2D;

    address public constant JUG_ADDRESS = 0xcbB7718c9F39d05aEEDE1c472ca8Bf804b2f1EaD;
    address public constant DAI_JOIN_ADDRESS = 0x5AA71a3ae1C0bd6ac27A1f28e1415fFFB6F15B8c;
    address public constant ETH_JOIN_ADDRESS = 0x775787933e92b709f2a3C70aa87999696e74A9F8;
    address public constant MIGRATION_ACTIONS_PROXY = 0x433870076aBd08865f0e038dcC4Ac6450e313Bd8;
    address public constant PROXY_ACTIONS = 0xd1D24637b9109B7f61459176EdcfF9Be56283a7B;

    address public constant SAI_ADDRESS = 0xC4375B7De8af5a38a93548eb8453a498222C4fF2;
    address public constant DAI_ADDRESS = 0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa;

    address payable public constant SCD_MCD_MIGRATION = 0x411B2Faa662C8e3E5cF8f01dFdae0aeE482ca7b0;

    
    address public constant SUBSCRIPTION_ADDRESS = 0xFC41f79776061a396635aD0b9dF7a640A05063C1;
    address public constant MONITOR_ADDRESS = 0xfC1Fc0502e90B7A3766f93344E1eDb906F8A75DD;

    
    address public constant NEW_CDAI_ADDRESS = 0xe7bc397DBd069fC7d0109C0636d06888bb50668c;
    address public constant NEW_IDAI_ADDRESS = 0x6c1E2B0f67e00c06c8e2BE7Dc681Ab785163fF4D;
}

contract ConstantAddresses is ConstantAddressesMainnet {}

library SafeMath {
    
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        
        
        
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        
        require(b > 0);
        uint256 c = a / b;
        

        return c;
    }

    
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

library Require {

    

    uint256 constant ASCII_ZERO = 48; 
    uint256 constant ASCII_RELATIVE_ZERO = 87; 
    uint256 constant ASCII_LOWER_EX = 120; 
    bytes2 constant COLON = 0x3a20; 
    bytes2 constant COMMA = 0x2c20; 
    bytes2 constant LPAREN = 0x203c; 
    byte constant RPAREN = 0x3e; 
    uint256 constant FOUR_BIT_MASK = 0xf;

    

    function that(
        bool must,
        bytes32 file,
        bytes32 reason
    )
        internal
        pure
    {
        if (!must) {
            revert(
                string(
                    abi.encodePacked(
                        stringifyTruncated(file),
                        COLON,
                        stringifyTruncated(reason)
                    )
                )
            );
        }
    }

    function that(
        bool must,
        bytes32 file,
        bytes32 reason,
        uint256 payloadA
    )
        internal
        pure
    {
        if (!must) {
            revert(
                string(
                    abi.encodePacked(
                        stringifyTruncated(file),
                        COLON,
                        stringifyTruncated(reason),
                        LPAREN,
                        stringify(payloadA),
                        RPAREN
                    )
                )
            );
        }
    }

    function that(
        bool must,
        bytes32 file,
        bytes32 reason,
        uint256 payloadA,
        uint256 payloadB
    )
        internal
        pure
    {
        if (!must) {
            revert(
                string(
                    abi.encodePacked(
                        stringifyTruncated(file),
                        COLON,
                        stringifyTruncated(reason),
                        LPAREN,
                        stringify(payloadA),
                        COMMA,
                        stringify(payloadB),
                        RPAREN
                    )
                )
            );
        }
    }

    function that(
        bool must,
        bytes32 file,
        bytes32 reason,
        address payloadA
    )
        internal
        pure
    {
        if (!must) {
            revert(
                string(
                    abi.encodePacked(
                        stringifyTruncated(file),
                        COLON,
                        stringifyTruncated(reason),
                        LPAREN,
                        stringify(payloadA),
                        RPAREN
                    )
                )
            );
        }
    }

    function that(
        bool must,
        bytes32 file,
        bytes32 reason,
        address payloadA,
        uint256 payloadB
    )
        internal
        pure
    {
        if (!must) {
            revert(
                string(
                    abi.encodePacked(
                        stringifyTruncated(file),
                        COLON,
                        stringifyTruncated(reason),
                        LPAREN,
                        stringify(payloadA),
                        COMMA,
                        stringify(payloadB),
                        RPAREN
                    )
                )
            );
        }
    }

    function that(
        bool must,
        bytes32 file,
        bytes32 reason,
        address payloadA,
        uint256 payloadB,
        uint256 payloadC
    )
        internal
        pure
    {
        if (!must) {
            revert(
                string(
                    abi.encodePacked(
                        stringifyTruncated(file),
                        COLON,
                        stringifyTruncated(reason),
                        LPAREN,
                        stringify(payloadA),
                        COMMA,
                        stringify(payloadB),
                        COMMA,
                        stringify(payloadC),
                        RPAREN
                    )
                )
            );
        }
    }

    function that(
        bool must,
        bytes32 file,
        bytes32 reason,
        bytes32 payloadA
    )
        internal
        pure
    {
        if (!must) {
            revert(
                string(
                    abi.encodePacked(
                        stringifyTruncated(file),
                        COLON,
                        stringifyTruncated(reason),
                        LPAREN,
                        stringify(payloadA),
                        RPAREN
                    )
                )
            );
        }
    }

    function that(
        bool must,
        bytes32 file,
        bytes32 reason,
        bytes32 payloadA,
        uint256 payloadB,
        uint256 payloadC
    )
        internal
        pure
    {
        if (!must) {
            revert(
                string(
                    abi.encodePacked(
                        stringifyTruncated(file),
                        COLON,
                        stringifyTruncated(reason),
                        LPAREN,
                        stringify(payloadA),
                        COMMA,
                        stringify(payloadB),
                        COMMA,
                        stringify(payloadC),
                        RPAREN
                    )
                )
            );
        }
    }

    

    function stringifyTruncated(
        bytes32 input
    )
        private
        pure
        returns (bytes memory)
    {
        
        bytes memory result = abi.encodePacked(input);

        
        for (uint256 i = 32; i > 0; ) {
            
            
            i--;

            
            if (result[i] != 0) {
                uint256 length = i + 1;

                
                assembly {
                    mstore(result, length) 
                }

                return result;
            }
        }

        
        return new bytes(0);
    }

    function stringify(
        uint256 input
    )
        private
        pure
        returns (bytes memory)
    {
        if (input == 0) {
            return "0";
        }

        
        uint256 j = input;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }

        
        bytes memory bstr = new bytes(length);

        
        j = input;
        for (uint256 i = length; i > 0; ) {
            
            
            i--;

            
            bstr[i] = byte(uint8(ASCII_ZERO + (j % 10)));

            
            j /= 10;
        }

        return bstr;
    }

    function stringify(
        address input
    )
        private
        pure
        returns (bytes memory)
    {
        uint256 z = uint256(input);

        
        bytes memory result = new bytes(42);

        
        result[0] = byte(uint8(ASCII_ZERO));
        result[1] = byte(uint8(ASCII_LOWER_EX));

        
        for (uint256 i = 0; i < 20; i++) {
            
            uint256 shift = i * 2;

            
            result[41 - shift] = char(z & FOUR_BIT_MASK);
            z = z >> 4;

            
            result[40 - shift] = char(z & FOUR_BIT_MASK);
            z = z >> 4;
        }

        return result;
    }

    function stringify(
        bytes32 input
    )
        private
        pure
        returns (bytes memory)
    {
        uint256 z = uint256(input);

        
        bytes memory result = new bytes(66);

        
        result[0] = byte(uint8(ASCII_ZERO));
        result[1] = byte(uint8(ASCII_LOWER_EX));

        
        for (uint256 i = 0; i < 32; i++) {
            
            uint256 shift = i * 2;

            
            result[65 - shift] = char(z & FOUR_BIT_MASK);
            z = z >> 4;

            
            result[64 - shift] = char(z & FOUR_BIT_MASK);
            z = z >> 4;
        }

        return result;
    }

    function char(
        uint256 input
    )
        private
        pure
        returns (byte)
    {
        
        if (input < 10) {
            return byte(uint8(input + ASCII_ZERO));
        }

        
        return byte(uint8(input + ASCII_RELATIVE_ZERO));
    }
}

library Math {
    using SafeMath for uint256;

    

    bytes32 constant FILE = "Math";

    

    
    function getPartial(
        uint256 target,
        uint256 numerator,
        uint256 denominator
    )
        internal
        pure
        returns (uint256)
    {
        return target.mul(numerator).div(denominator);
    }

    
    function getPartialRoundUp(
        uint256 target,
        uint256 numerator,
        uint256 denominator
    )
        internal
        pure
        returns (uint256)
    {
        if (target == 0 || numerator == 0) {
            
            return SafeMath.div(0, denominator);
        }
        return target.mul(numerator).sub(1).div(denominator).add(1);
    }

    function to128(
        uint256 number
    )
        internal
        pure
        returns (uint128)
    {
        uint128 result = uint128(number);
        Require.that(
            result == number,
            FILE,
            "Unsafe cast to uint128"
        );
        return result;
    }

    function to96(
        uint256 number
    )
        internal
        pure
        returns (uint96)
    {
        uint96 result = uint96(number);
        Require.that(
            result == number,
            FILE,
            "Unsafe cast to uint96"
        );
        return result;
    }

    function to32(
        uint256 number
    )
        internal
        pure
        returns (uint32)
    {
        uint32 result = uint32(number);
        Require.that(
            result == number,
            FILE,
            "Unsafe cast to uint32"
        );
        return result;
    }

    function min(
        uint256 a,
        uint256 b
    )
        internal
        pure
        returns (uint256)
    {
        return a < b ? a : b;
    }

    function max(
        uint256 a,
        uint256 b
    )
        internal
        pure
        returns (uint256)
    {
        return a > b ? a : b;
    }
}

library Types {
    using Math for uint256;

    

    enum AssetDenomination {
        Wei, 
        Par  
    }

    enum AssetReference {
        Delta, 
        Target 
    }

    struct AssetAmount {
        bool sign; 
        AssetDenomination denomination;
        AssetReference ref;
        uint256 value;
    }

    

    
    struct TotalPar {
        uint128 borrow;
        uint128 supply;
    }

    
    struct Par {
        bool sign; 
        uint128 value;
    }

    function zeroPar()
        internal
        pure
        returns (Par memory)
    {
        return Par({
            sign: false,
            value: 0
        });
    }

    function sub(
        Par memory a,
        Par memory b
    )
        internal
        pure
        returns (Par memory)
    {
        return add(a, negative(b));
    }

    function add(
        Par memory a,
        Par memory b
    )
        internal
        pure
        returns (Par memory)
    {
        Par memory result;
        if (a.sign == b.sign) {
            result.sign = a.sign;
            result.value = SafeMath.add(a.value, b.value).to128();
        } else {
            if (a.value >= b.value) {
                result.sign = a.sign;
                result.value = SafeMath.sub(a.value, b.value).to128();
            } else {
                result.sign = b.sign;
                result.value = SafeMath.sub(b.value, a.value).to128();
            }
        }
        return result;
    }

    function equals(
        Par memory a,
        Par memory b
    )
        internal
        pure
        returns (bool)
    {
        if (a.value == b.value) {
            if (a.value == 0) {
                return true;
            }
            return a.sign == b.sign;
        }
        return false;
    }

    function negative(
        Par memory a
    )
        internal
        pure
        returns (Par memory)
    {
        return Par({
            sign: !a.sign,
            value: a.value
        });
    }

    function isNegative(
        Par memory a
    )
        internal
        pure
        returns (bool)
    {
        return !a.sign && a.value > 0;
    }

    function isPositive(
        Par memory a
    )
        internal
        pure
        returns (bool)
    {
        return a.sign && a.value > 0;
    }

    function isZero(
        Par memory a
    )
        internal
        pure
        returns (bool)
    {
        return a.value == 0;
    }

    

    
    struct Wei {
        bool sign; 
        uint256 value;
    }

    function zeroWei()
        internal
        pure
        returns (Wei memory)
    {
        return Wei({
            sign: false,
            value: 0
        });
    }

    function sub(
        Wei memory a,
        Wei memory b
    )
        internal
        pure
        returns (Wei memory)
    {
        return add(a, negative(b));
    }

    function add(
        Wei memory a,
        Wei memory b
    )
        internal
        pure
        returns (Wei memory)
    {
        Wei memory result;
        if (a.sign == b.sign) {
            result.sign = a.sign;
            result.value = SafeMath.add(a.value, b.value);
        } else {
            if (a.value >= b.value) {
                result.sign = a.sign;
                result.value = SafeMath.sub(a.value, b.value);
            } else {
                result.sign = b.sign;
                result.value = SafeMath.sub(b.value, a.value);
            }
        }
        return result;
    }

    function equals(
        Wei memory a,
        Wei memory b
    )
        internal
        pure
        returns (bool)
    {
        if (a.value == b.value) {
            if (a.value == 0) {
                return true;
            }
            return a.sign == b.sign;
        }
        return false;
    }

    function negative(
        Wei memory a
    )
        internal
        pure
        returns (Wei memory)
    {
        return Wei({
            sign: !a.sign,
            value: a.value
        });
    }

    function isNegative(
        Wei memory a
    )
        internal
        pure
        returns (bool)
    {
        return !a.sign && a.value > 0;
    }

    function isPositive(
        Wei memory a
    )
        internal
        pure
        returns (bool)
    {
        return a.sign && a.value > 0;
    }

    function isZero(
        Wei memory a
    )
        internal
        pure
        returns (bool)
    {
        return a.value == 0;
    }
}

library Account {
    

    
    enum Status {
        Normal,
        Liquid,
        Vapor
    }

    

    
    struct Info {
        address owner;  
        uint256 number; 
    }

    
    struct Storage {
        mapping (uint256 => Types.Par) balances; 
        Status status;
    }

    

    function equals(
        Info memory a,
        Info memory b
    )
        internal
        pure
        returns (bool)
    {
        return a.owner == b.owner && a.number == b.number;
    }
}

library Actions {

    

    bytes32 constant FILE = "Actions";

    

    enum ActionType {
        Deposit,   
        Withdraw,  
        Transfer,  
        Buy,       
        Sell,      
        Trade,     
        Liquidate, 
        Vaporize,  
        Call       
    }

    enum AccountLayout {
        OnePrimary,
        TwoPrimary,
        PrimaryAndSecondary
    }

    enum MarketLayout {
        ZeroMarkets,
        OneMarket,
        TwoMarkets
    }

    

    
    struct ActionArgs {
        ActionType actionType;
        uint256 accountId;
        Types.AssetAmount amount;
        uint256 primaryMarketId;
        uint256 secondaryMarketId;
        address otherAddress;
        uint256 otherAccountId;
        bytes data;
    }

    

    
    struct DepositArgs {
        Types.AssetAmount amount;
        Account.Info account;
        uint256 market;
        address from;
    }

    
    struct WithdrawArgs {
        Types.AssetAmount amount;
        Account.Info account;
        uint256 market;
        address to;
    }

    
    struct TransferArgs {
        Types.AssetAmount amount;
        Account.Info accountOne;
        Account.Info accountTwo;
        uint256 market;
    }

    
    struct BuyArgs {
        Types.AssetAmount amount;
        Account.Info account;
        uint256 makerMarket;
        uint256 takerMarket;
        address exchangeWrapper;
        bytes orderData;
    }

    
    struct SellArgs {
        Types.AssetAmount amount;
        Account.Info account;
        uint256 takerMarket;
        uint256 makerMarket;
        address exchangeWrapper;
        bytes orderData;
    }

    
    struct TradeArgs {
        Types.AssetAmount amount;
        Account.Info takerAccount;
        Account.Info makerAccount;
        uint256 inputMarket;
        uint256 outputMarket;
        address autoTrader;
        bytes tradeData;
    }

    
    struct LiquidateArgs {
        Types.AssetAmount amount;
        Account.Info solidAccount;
        Account.Info liquidAccount;
        uint256 owedMarket;
        uint256 heldMarket;
    }

    
    struct VaporizeArgs {
        Types.AssetAmount amount;
        Account.Info solidAccount;
        Account.Info vaporAccount;
        uint256 owedMarket;
        uint256 heldMarket;
    }

    
    struct CallArgs {
        Account.Info account;
        address callee;
        bytes data;
    }

    

    function getMarketLayout(
        ActionType actionType
    )
        internal
        pure
        returns (MarketLayout)
    {
        if (
            actionType == Actions.ActionType.Deposit
            || actionType == Actions.ActionType.Withdraw
            || actionType == Actions.ActionType.Transfer
        ) {
            return MarketLayout.OneMarket;
        }
        else if (actionType == Actions.ActionType.Call) {
            return MarketLayout.ZeroMarkets;
        }
        return MarketLayout.TwoMarkets;
    }

    function getAccountLayout(
        ActionType actionType
    )
        internal
        pure
        returns (AccountLayout)
    {
        if (
            actionType == Actions.ActionType.Transfer
            || actionType == Actions.ActionType.Trade
        ) {
            return AccountLayout.TwoPrimary;
        } else if (
            actionType == Actions.ActionType.Liquidate
            || actionType == Actions.ActionType.Vaporize
        ) {
            return AccountLayout.PrimaryAndSecondary;
        }
        return AccountLayout.OnePrimary;
    }

    

    function parseDepositArgs(
        Account.Info[] memory accounts,
        ActionArgs memory args
    )
        internal
        pure
        returns (DepositArgs memory)
    {
        assert(args.actionType == ActionType.Deposit);
        return DepositArgs({
            amount: args.amount,
            account: accounts[args.accountId],
            market: args.primaryMarketId,
            from: args.otherAddress
        });
    }

    function parseWithdrawArgs(
        Account.Info[] memory accounts,
        ActionArgs memory args
    )
        internal
        pure
        returns (WithdrawArgs memory)
    {
        assert(args.actionType == ActionType.Withdraw);
        return WithdrawArgs({
            amount: args.amount,
            account: accounts[args.accountId],
            market: args.primaryMarketId,
            to: args.otherAddress
        });
    }

    function parseTransferArgs(
        Account.Info[] memory accounts,
        ActionArgs memory args
    )
        internal
        pure
        returns (TransferArgs memory)
    {
        assert(args.actionType == ActionType.Transfer);
        return TransferArgs({
            amount: args.amount,
            accountOne: accounts[args.accountId],
            accountTwo: accounts[args.otherAccountId],
            market: args.primaryMarketId
        });
    }

    function parseBuyArgs(
        Account.Info[] memory accounts,
        ActionArgs memory args
    )
        internal
        pure
        returns (BuyArgs memory)
    {
        assert(args.actionType == ActionType.Buy);
        return BuyArgs({
            amount: args.amount,
            account: accounts[args.accountId],
            makerMarket: args.primaryMarketId,
            takerMarket: args.secondaryMarketId,
            exchangeWrapper: args.otherAddress,
            orderData: args.data
        });
    }

    function parseSellArgs(
        Account.Info[] memory accounts,
        ActionArgs memory args
    )
        internal
        pure
        returns (SellArgs memory)
    {
        assert(args.actionType == ActionType.Sell);
        return SellArgs({
            amount: args.amount,
            account: accounts[args.accountId],
            takerMarket: args.primaryMarketId,
            makerMarket: args.secondaryMarketId,
            exchangeWrapper: args.otherAddress,
            orderData: args.data
        });
    }

    function parseTradeArgs(
        Account.Info[] memory accounts,
        ActionArgs memory args
    )
        internal
        pure
        returns (TradeArgs memory)
    {
        assert(args.actionType == ActionType.Trade);
        return TradeArgs({
            amount: args.amount,
            takerAccount: accounts[args.accountId],
            makerAccount: accounts[args.otherAccountId],
            inputMarket: args.primaryMarketId,
            outputMarket: args.secondaryMarketId,
            autoTrader: args.otherAddress,
            tradeData: args.data
        });
    }

    function parseLiquidateArgs(
        Account.Info[] memory accounts,
        ActionArgs memory args
    )
        internal
        pure
        returns (LiquidateArgs memory)
    {
        assert(args.actionType == ActionType.Liquidate);
        return LiquidateArgs({
            amount: args.amount,
            solidAccount: accounts[args.accountId],
            liquidAccount: accounts[args.otherAccountId],
            owedMarket: args.primaryMarketId,
            heldMarket: args.secondaryMarketId
        });
    }

    function parseVaporizeArgs(
        Account.Info[] memory accounts,
        ActionArgs memory args
    )
        internal
        pure
        returns (VaporizeArgs memory)
    {
        assert(args.actionType == ActionType.Vaporize);
        return VaporizeArgs({
            amount: args.amount,
            solidAccount: accounts[args.accountId],
            vaporAccount: accounts[args.otherAccountId],
            owedMarket: args.primaryMarketId,
            heldMarket: args.secondaryMarketId
        });
    }

    function parseCallArgs(
        Account.Info[] memory accounts,
        ActionArgs memory args
    )
        internal
        pure
        returns (CallArgs memory)
    {
        assert(args.actionType == ActionType.Call);
        return CallArgs({
            account: accounts[args.accountId],
            callee: args.otherAddress,
            data: args.data
        });
    }
}

contract ISoloMargin {
    struct OperatorArg {
        address operator;
        bool trusted;
    }

    function operate(
        Account.Info[] memory accounts,
        Actions.ActionArgs[] memory actions
    ) public;

    function getAccountBalances(
        Account.Info memory account
    ) public view returns (
        address[] memory,
        Types.Par[] memory,
        Types.Wei[] memory
    );

    function setOperators(
        OperatorArg[] memory args
    ) public;
}

contract SavingsLogger {
    event Deposit(address indexed sender, uint8 protocol, uint256 amount);
    event Withdraw(address indexed sender, uint8 protocol, uint256 amount);
    event Swap(address indexed sender, uint8 fromProtocol, uint8 toProtocol, uint256 amount);

    function logDeposit(address _sender, uint8 _protocol, uint256 _amount) external {
        emit Deposit(_sender, _protocol, _amount);
    }

    function logWithdraw(address _sender, uint8 _protocol, uint256 _amount) external {
        emit Withdraw(_sender, _protocol, _amount);
    }

    function logSwap(address _sender, uint8 _protocolFrom, uint8 _protocolTo, uint256 _amount)
        external
    {
        emit Swap(_sender, _protocolFrom, _protocolTo, _amount);
    }
}

contract Gem {
    function dec() public returns (uint);
    function gem() public returns (Gem);
    function join(address, uint) public payable;
    function exit(address, uint) public;

    function approve(address, uint) public;
    function transfer(address, uint) public returns (bool);
    function transferFrom(address, address, uint) public returns (bool);
    function deposit() public payable;
    function withdraw(uint) public;
    function allowance(address, address) public returns (uint);
}

contract Join {
    bytes32 public ilk;

    function dec() public returns (uint);
    function gem() public returns (Gem);
    function join(address, uint) public payable;
    function exit(address, uint) public;
}

contract DSMath {
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

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    function rpow(uint256 x, uint256 n) internal pure returns (uint256 z) {
        z = n % 2 != 0 ? x : RAY;

        for (n /= 2; n != 0; n /= 2) {
            x = rmul(x, x);

            if (n % 2 != 0) {
                z = rmul(z, x);
            }
        }
    }
}

contract VatLike {
    function can(address, address) public view returns (uint);
    function ilks(bytes32) public view returns (uint, uint, uint, uint, uint);
    function dai(address) public view returns (uint);
    function urns(bytes32, address) public view returns (uint, uint);
    function frob(bytes32, address, address, address, int, int) public;
    function hope(address) public;
    function move(address, address, uint) public;
}

contract PotLike {
    function pie(address) public view returns (uint);
    function drip() public returns (uint);
    function join(uint) public;
    function exit(uint) public;
}

contract GemLike {
    function approve(address, uint) public;
    function transfer(address, uint) public;
    function transferFrom(address, address, uint) public;
    function deposit() public payable;
    function withdraw(uint) public;
}

contract DaiJoinLike {
    function vat() public returns (VatLike);
    function dai() public returns (GemLike);
    function join(address, uint) public payable;
    function exit(address, uint) public;
}

contract DSRSavingsProtocol is DSMath {

    
    
    

    
    address public constant DAI_JOIN_ADDRESS = 0x9759A6Ac90977b93B58547b4A71c78317f391A28;
    address public constant POT_ADDRESS = 0x197E90f9FAD81970bA7976f33CbD77088E5D7cf7;

    function dsrDeposit(uint _amount, bool _fromUser) internal {
        VatLike vat = DaiJoinLike(DAI_JOIN_ADDRESS).vat();

        uint chi = PotLike(POT_ADDRESS).drip();

        daiJoin_join(DAI_JOIN_ADDRESS, address(this), _amount, _fromUser);

        if (vat.can(address(this), address(POT_ADDRESS)) == 0) {
            vat.hope(POT_ADDRESS);
        }

        PotLike(POT_ADDRESS).join(mul(_amount, RAY) / chi);
    }

    function dsrWithdraw(uint _amount, bool _toUser) internal {
        VatLike vat = DaiJoinLike(DAI_JOIN_ADDRESS).vat();

        uint chi = PotLike(POT_ADDRESS).drip();
        uint pie = mul(_amount, RAY) / chi;

        PotLike(POT_ADDRESS).exit(pie);
        uint balance = DaiJoinLike(DAI_JOIN_ADDRESS).vat().dai(address(this));

        if (vat.can(address(this), address(DAI_JOIN_ADDRESS)) == 0) {
            vat.hope(DAI_JOIN_ADDRESS);
        }

        address to;
        if (_toUser) {
            to = msg.sender;
        } else {
            to = address(this);
        }

        if (_amount == uint(-1)) {
            DaiJoinLike(DAI_JOIN_ADDRESS).exit(to, mul(chi, pie) / RAY);
        } else {
            DaiJoinLike(DAI_JOIN_ADDRESS).exit(
                to,
                balance >= mul(_amount, RAY) ? _amount : balance / RAY
            );
        }
    }

    function daiJoin_join(address apt, address urn, uint wad, bool _fromUser) internal {
        if (_fromUser) {
            DaiJoinLike(apt).dai().transferFrom(msg.sender, address(this), wad);
        }

        DaiJoinLike(apt).dai().approve(apt, wad);

        DaiJoinLike(apt).join(urn, wad);
    }
}

contract SavingsProxy is ConstantAddresses, DSRSavingsProtocol {
    address public constant ADAI_ADDRESS = 0xfC1E690f61EFd961294b3e1Ce3313fBD8aa4f85d;
    
    address public constant SAVINGS_COMPOUND_ADDRESS = 0x72c5a18D651DA5568EFfE731a98484dE62C9F347;
    address public constant SAVINGS_DYDX_ADDRESS = 0x03b1565e070df392e48e7a8e01798C4B00E534A5;
    address public constant SAVINGS_FULCRUM_ADDRESS = 0xe9ea575d2d8Ca26b0E026a2146994592e0Ee1Dd9;
    address public constant SAVINGS_AAVE_ADDRESS = 0x535B9035E9bA8D7efe0FeAEac885fb65b303E37C;

    enum SavingsProtocol {Compound, Dydx, Fulcrum, Dsr, Aave}

    function deposit(SavingsProtocol _protocol, uint256 _amount) public {
        if (_protocol == SavingsProtocol.Dsr) {
            dsrDeposit(_amount, true);
        } else {
            _deposit(_protocol, _amount, true);
        }

        SavingsLogger(SAVINGS_LOGGER_ADDRESS).logDeposit(msg.sender, uint8(_protocol), _amount);
    }

    function withdraw(SavingsProtocol _protocol, uint256 _amount) public {
        if (_protocol == SavingsProtocol.Dsr) {
            dsrWithdraw(_amount, true);
        } else {
            _withdraw(_protocol, _amount, true);
        }

        SavingsLogger(SAVINGS_LOGGER_ADDRESS).logWithdraw(msg.sender, uint8(_protocol), _amount);
    }

    function swap(SavingsProtocol _from, SavingsProtocol _to, uint256 _amount) public {
        if (_from == SavingsProtocol.Dsr) {
            dsrWithdraw(_amount, false);
        } else {
            _withdraw(_from, _amount, false);
        }

        
        
        uint256 amountToDeposit = ERC20(DAI_ADDRESS).balanceOf(address(this));

        if (_to == SavingsProtocol.Dsr) {
            dsrDeposit(amountToDeposit, false);
        } else {
            _deposit(_to, amountToDeposit, false);
        }

        SavingsLogger(SAVINGS_LOGGER_ADDRESS).logSwap(
            msg.sender,
            uint8(_from),
            uint8(_to),
            _amount
        );
    }

    function withdrawDai() public {
        ERC20(DAI_ADDRESS).transfer(msg.sender, ERC20(DAI_ADDRESS).balanceOf(address(this)));
    }

    function getAddress(SavingsProtocol _protocol) public pure returns (address) {
        if (_protocol == SavingsProtocol.Compound) {
            return SAVINGS_COMPOUND_ADDRESS;
        }

        if (_protocol == SavingsProtocol.Dydx) {
            return SAVINGS_DYDX_ADDRESS;
        }

        if (_protocol == SavingsProtocol.Fulcrum) {
            return SAVINGS_FULCRUM_ADDRESS;
        }

        if (_protocol == SavingsProtocol.Aave) {
            return SAVINGS_AAVE_ADDRESS;
        }
    }

    function _deposit(SavingsProtocol _protocol, uint256 _amount, bool _fromUser) internal {
        if (_fromUser) {
            ERC20(DAI_ADDRESS).transferFrom(msg.sender, address(this), _amount);
        }

        approveDeposit(_protocol);

        ProtocolInterface(getAddress(_protocol)).deposit(address(this), _amount);

        endAction(_protocol);
    }

    function _withdraw(SavingsProtocol _protocol, uint256 _amount, bool _toUser) public {
        approveWithdraw(_protocol);

        ProtocolInterface(getAddress(_protocol)).withdraw(address(this), _amount);

        endAction(_protocol);

        if (_toUser) {
            withdrawDai();
        }
    }

    function endAction(SavingsProtocol _protocol) internal {
        if (_protocol == SavingsProtocol.Dydx) {
            setDydxOperator(false);
        }
    }

    function approveDeposit(SavingsProtocol _protocol) internal {
        if (_protocol == SavingsProtocol.Compound || _protocol == SavingsProtocol.Fulcrum || _protocol == SavingsProtocol.Aave) {
            ERC20(DAI_ADDRESS).approve(getAddress(_protocol), uint256(-1));
        }

        if (_protocol == SavingsProtocol.Dydx) {
            ERC20(DAI_ADDRESS).approve(SOLO_MARGIN_ADDRESS, uint256(-1));
            setDydxOperator(true);
        }
    }

    function approveWithdraw(SavingsProtocol _protocol) internal {
        if (_protocol == SavingsProtocol.Compound) {
            ERC20(NEW_CDAI_ADDRESS).approve(getAddress(_protocol), uint256(-1));
        }

        if (_protocol == SavingsProtocol.Dydx) {
            setDydxOperator(true);
        }

        if (_protocol == SavingsProtocol.Fulcrum) {
            ERC20(NEW_IDAI_ADDRESS).approve(getAddress(_protocol), uint256(-1));
        }

        if (_protocol == SavingsProtocol.Aave) {
            ERC20(ADAI_ADDRESS).approve(getAddress(_protocol), uint256(-1));
        }
    }

    function setDydxOperator(bool _trusted) internal {
        ISoloMargin.OperatorArg[] memory operatorArgs = new ISoloMargin.OperatorArg[](1);
        operatorArgs[0] = ISoloMargin.OperatorArg({
            operator: getAddress(SavingsProtocol.Dydx),
            trusted: _trusted
        });

        ISoloMargin(SOLO_MARGIN_ADDRESS).setOperators(operatorArgs);
    }
}
