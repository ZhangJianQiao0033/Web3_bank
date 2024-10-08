const { ethers } = require("hardhat");

async function main() {
    // 合约地址，替换为你的合约地址
    const contractAddress = "0x5FC8d32690cc91D4c39d9d3abcBD16989F875707";

    // 获取合约的余额
    const balance = await ethers.provider.getBalance(contractAddress);

    // 打印合约余额
    console.log(`Contract balance: ${ethers.utils.formatEther(balance.toString())} ETH`);
}

// 调用 main 函数并处理错误
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
