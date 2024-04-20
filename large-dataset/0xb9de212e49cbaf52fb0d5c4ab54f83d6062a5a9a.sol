/**

 *Submitted for verification at Etherscan.io on 2020-05-10

*/



pragma solidity ^0.4.12;

     

    contract IMigrationContract {

        function migrate(address addr, uint256 nas) returns (bool success);

    }

     

    contract SafeMath {

     

     

        function safeAdd(uint256 x, uint256 y) internal returns(uint256) {

            uint256 z = x + y;

            assert((z >= x) && (z >= y));

            return z;

        }

     

        function safeSubtract(uint256 x, uint256 y) internal returns(uint256) {

            assert(x >= y);

            uint256 z = x - y;

            return z;

        }

     

        function safeMult(uint256 x, uint256 y) internal returns(uint256) {

            uint256 z = x * y;

            assert((x == 0)||(z/x == y));

            return z;

        }

     

    }

     

    contract Token {

        uint256 public totalSupply;

        function balanceOf(address _owner) constant returns (uint256 balance);

        function transfer(address _to, uint256 _value) returns (bool success);

        function transferFrom(address _from, address _to, uint256 _value) returns (bool success);

        function approve(address _spender, uint256 _value) returns (bool success);

        function allowance(address _owner, address _spender) constant returns (uint256 remaining);

        event Transfer(address indexed _from, address indexed _to, uint256 _value);

        event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    }

     

     

    /*  ERC 20 token */

    contract StandardToken is Token {

     

        function transfer(address _to, uint256 _value) returns (bool success) {

            require(!frozenAccount[msg.sender]);

            if (msg.sender != address(0) && balances[msg.sender] >= _value && _value > 0) {

                balances[msg.sender] -= _value;

                balances[_to] += _value;

                Transfer(msg.sender, _to, _value);

                return true;

            } else {

                return false;

            }

        }

     

        function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {

            if (_from != address(0) && _to !=address(0) && balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {

                balances[_to] += _value;

                balances[_from] -= _value;

                allowed[_from][msg.sender] -= _value;

                Transfer(_from, _to, _value);

                return true;

            } else {

                return false;

            }

        }

     

        function balanceOf(address _owner) constant returns (uint256 balance) {

            return balances[_owner];

        }

     

        function approve(address _spender, uint256 _value) returns (bool success) {

            allowed[msg.sender][_spender] = _value;

            Approval(msg.sender, _spender, _value);

            return true;

        }

     

        function allowance(address _owner, address _spender) constant returns (uint256 remaining) {

            return allowed[_owner][_spender];

        }

     

        mapping (address => uint256) balances;

        mapping (address => mapping (address => uint256)) allowed;

        mapping (address => bool) public frozenAccount;

        event FrozenFunds(address target, bool frozen);

    }

     

    contract LbmToken is StandardToken, SafeMath {

     

        // metadata

        string  public constant name = "lb";

        string  public constant symbol = "LB";

        uint256 public constant decimals = 3;

        string  public version = "1.0";

     

        // contracts

        address public ethFundDeposit;          // ETH\u5b58\u653e\u5730\u5740

        address public newContractAddr;         // token\u66f4\u65b0\u5730\u5740

     

        // crowdsale parameters

        bool    public isFunding;                // \u72b6\u6001\u5207\u6362\u5230true

        uint256 public fundingStartBlock;

        uint256 public fundingStopBlock;

     

               // \u6b63\u5728\u552e\u5356\u4e2d\u7684tokens\u6570\u91cf

               // \u603b\u7684\u552e\u5356\u6570\u91cftoken

           // \u603b\u7684\u5df2\u7ecf\u4ea4\u6613\u7684 token

                   

     

        // events

        event AllocateToken(address indexed _to, uint256 _value);   // \u5206\u914d\u7684\u79c1\u6709\u4ea4\u6613token;

        event IssueToken(address indexed _to, uint256 _value);      // \u516c\u5f00\u53d1\u884c\u552e\u5356\u7684token;

        

        

        event Migrate(address indexed _to, uint256 _value);

        event AddSupply(uint amount);

     

        // \u8f6c\u6362

        function formatDecimals(uint256 _value) internal returns (uint256 ) {

            return _value * 10 ** decimals;

        }

     

        // constructor

        function LbmToken(address _ethFundDeposit, uint256 _totalSupply)

            

        {

            ethFundDeposit = _ethFundDeposit;                        //\u521b\u59cb\u4eba 

            fundingStartBlock = 0;

            fundingStopBlock = 0;

     

            

            totalSupply = formatDecimals(_totalSupply);

            balances[msg.sender] = totalSupply;

            

        }

     

        modifier isOwner()  { require(msg.sender == ethFundDeposit); _; }

 

        ///@dev  \u542f\u52a8\u533a\u5757\u68c0\u6d4b \u5f02\u5e38\u7684\u5904\u7406

        function startFunding (uint256 _fundingStartBlock, uint256 _fundingStopBlock) isOwner external {

            if (isFunding) throw;

            if (_fundingStartBlock >= _fundingStopBlock) throw;

            if (block.number >= _fundingStartBlock) throw;

     

            fundingStartBlock = _fundingStartBlock;

            fundingStopBlock = _fundingStopBlock;

            isFunding = true;

        }

     

        ///@dev  \u5173\u95ed\u533a\u5757\u5f02\u5e38\u5904\u7406

        function stopFunding() isOwner external {

            if (!isFunding) throw;

            isFunding = false;

        }

     

        ///@dev \u5f00\u53d1\u4e86\u4e00\u4e2a\u65b0\u7684\u5408\u540c\u6765\u63a5\u6536token\uff08\u6216\u8005\u66f4\u65b0token\uff09

        function setMigrateContract(address _newContractAddr) isOwner external {

            if (_newContractAddr == newContractAddr) throw;

            newContractAddr = _newContractAddr;

        }

     

        ///@dev \u8bbe\u7f6e\u65b0\u7684\u6240\u6709\u8005\u5730\u5740

        function changeOwner(address _newFundDeposit) isOwner() external {

            if (_newFundDeposit == address(0x0)) throw;

            ethFundDeposit = _newFundDeposit;

        }

     

        ///dev\u8f6c\u79fbtoken\u5230\u65b0\u7684\u5408\u7ea6

        function migrate() external {

            if(isFunding) throw;

            if(newContractAddr == address(0x0)) throw;

     

            uint256 tokens = balances[msg.sender];

            if (tokens == 0) throw;

     

            balances[msg.sender] = 0;

           

     

            IMigrationContract newContract = IMigrationContract(newContractAddr);

            if (!newContract.migrate(msg.sender, tokens)) throw;

     

            Migrate(msg.sender, tokens);               // log it

        }

     



     

        ///@dev  \u5c06 token\u5206\u914d\u5230\u9884\u5904\u7406\u5730\u5740\u3002

        function allocateToken (address _addr, uint256 _eth) isOwner() external {

            if (_eth == 0) throw;

            if (_addr == address(0x0)) throw;

     

            uint256 tokens = formatDecimals(_eth);

            if (tokens  > totalSupply) throw;

     

           

            balances[_addr] += tokens;

     

            AllocateToken(_addr, tokens);  // \u8bb0\u5f55token\u65e5\u5fd7

        }

        ///\u589e\u53d1 \u4ee3\u5e01 

        function mine(address target, uint _amount) public isOwner {

         uint256 amount = formatDecimals(_amount);

         totalSupply += amount;

         balances[target] += amount;

         Transfer(address(0), target, amount);

        } 

       /// \u8d44\u4ea7\u51bb\u7ed3 

        function freezeAccount(address target, bool freeze)isOwner {

        frozenAccount[target] = freeze;

        FrozenFunds(target, freeze);

        }

    }