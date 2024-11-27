(async () => {
    const publicAddress = "0xB3cBe758790b40027779CB6BAA287aF189268Fa6"; // Replace with your MetaMask wallet address
    const provider = new ethers.JsonRpcProvider("https://sepolia.infura.io/v3/9611ce7b15a1461ba495ee102f7fdb1e"); // Replace with your Infura project ID or another Sepolia RPC URL
  
    try {
      // Fetch balance from the blockchain
      const balance = await provider.getBalance(publicAddress);
  
      // Format balance from Wei to ETH
      const balanceInEth = ethers.formatEther(balance);
  
      // Display the balance on the webpage
      document.getElementById("balance").textContent = `Balance: ${balanceInEth} Sepolia ETH`;
    } catch (error) {
      console.error("Error fetching balance:", error);
      document.getElementById("balance").textContent = "Error fetching balance.";
    }
  })();
  