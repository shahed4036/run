// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EnhancedTransaction {
    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint256 amount);

    // Deposit Ether into the contract
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(balances[msg.sender] >= 80 ether, "Balance must be greater than 80 ether to withdraw");

        // Prevent reentrancy attacks
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

   
    function transfer(address payable to, uint256 amount) external {
        require(amount > 0, "Transfer amount must be greater than zero");
        require(to != address(0), "Cannot transfer to zero address");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Update balances before the transfer to prevent reentrancy
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }


    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    // Check if the balance of the caller is greater than 80 ether
    function isBalanceGreaterThan80() external view returns (bool) {
        return balances[msg.sender] > 80 ether;
    }

    // Get the balance of a specific address
    function getAddressBalance(address user) external view returns (uint256) {
        return balances[user];
    }

    // Check if the balance of a specific address is greater than 80 ether
    function isAddressBalanceGreaterThan80(address user) external view returns (bool) {
        return balances[user] > 80 ether;
    }

    // Fallback function to accept Ether
    receive() external payable {
        deposit();
    }
}
