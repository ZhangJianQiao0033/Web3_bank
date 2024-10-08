// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Bank合约允许用户存款和合约拥有者提款
contract Bank {
    address public owner; // 合约拥有者地址
    mapping(address => uint256) public balances; // 存储每个地址的余额
    bool private withdrawing; // 用于标识是否正在进行提款

    // 事件：记录转账
    event Transferred(address indexed _from, uint256 _amount);
    // 事件：记录提款
    event Withdrawn(address indexed _to, uint256 _amount);

    // 构造函数：初始化合约时设置拥有者为部署者地址
    constructor() {
        owner = msg.sender;
    }

    // 修饰符：防止重入攻击
    modifier noReentrancy() {
        require(!withdrawing, "Withdraw in progress.");
        withdrawing = true;
        _;
        withdrawing = false;
    }

    // 外部函数：允许用户向合约转账ETH
    function transferToBank() external payable {
        require(msg.value > 0, "Must send some ETH."); // 确保转账金额大于零
        recordTransfer(msg.sender, msg.value); // 记录转账金额
        emit Transferred(msg.sender, msg.value); // 触发转账事件
    }

    // 内部函数：记录用户转账的金额
    function recordTransfer(address _addr, uint256 amount) internal {
        balances[_addr] += amount; // 更新用户的余额
    }

    // 外部函数：允许合约拥有者提取合约中的所有ETH
    function withdraw() external noReentrancy {
        require(msg.sender == owner, "You do not have permission to use this functionality."); // 确保调用者是合约拥有者
        uint256 amount = address(this).balance; // 获取合约当前余额
        require(amount > 0, "No funds available for withdrawal."); // 确保合约中有可提取的资金
        (bool success, ) = payable(msg.sender).call{value: amount}(""); // 向合约拥有者转账ETH
        require(success, "Transaction failed"); // 确保转账成功
        emit Withdrawn(msg.sender, amount); // 触发提款事件
    }
}
