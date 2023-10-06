// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract TokenContract {
    struct Token {
        string name;
        string symbol;
        uint totalSupply;
    }

    Token[] public tokens;
    mapping(string => mapping(address => uint)) public balances;
    mapping(string => bool) public tokenExists;

    event TokenCreated(string name, string symbol, uint totalSupply, address creator);
    event TokenTransferred(string symbol, address from, address to, uint amount);

    function createToken(string memory _name, string memory _symbol, uint _totalSupply) public {
        require(!tokenExists[_symbol], "Token with symbol already exists");
        require(_totalSupply > 0, "Total supply must be greater than 0");

        Token memory newToken = Token(_name, _symbol, _totalSupply);
        tokens.push(newToken);
        tokenExists[_symbol] = true;
        balances[_symbol][msg.sender] = _totalSupply;

        emit TokenCreated(_name, _symbol, _totalSupply, msg.sender);
    }

    function transferToken(string memory _symbol, address _to, uint _amount) public {
        require(tokenExists[_symbol], "Token with symbol does not exist");
        require(balances[_symbol][msg.sender] >= _amount, "Insufficient balance");

        balances[_symbol][msg.sender] -= _amount;
        balances[_symbol][_to] += _amount;

        emit TokenTransferred(_symbol, msg.sender, _to, _amount);
    }

    function getBalanceByToken(string memory _symbol, address _owner) public view returns (uint) {
        require(tokenExists[_symbol], "Token with symbol does not exist");
        return balances[_symbol][_owner];
    }

    function getTotalTokenCount() public view returns (uint) {
        return tokens.length;
    }
}
