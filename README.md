# NFTs – Basic & Dynamic SVG Implementation

### Author
* **Gavin Singh**
* **GitHub:** [@consigli3r3](https://github.com/consigli3r3)
* **LinkedIn:** [Gavin Singh](https://www.linkedin.com/in/gavinsingh)
* **X (Twitter):** [@consigli3re](https://x.com/consigli3re)

---

## 📖 About The Project
This repository contains implementations of **ERC721 Non-Fungible Tokens (NFTs)** deployed using Foundry. It explores two distinct approaches to metadata storage and NFT interactivity:

1. **Basic NFT:** A standard ERC721 token where metadata (images of cute puppies) is stored off-chain using **IPFS**.
2. **Mood NFT:** A fully dynamic, on-chain NFT that stores its image data (SVG) directly within the smart contract. The NFT changes its appearance (Happy 😃 / Sad 😢) based on user interaction.

The project demonstrates advanced Solidity concepts including Base64 encoding, on-chain SVG generation, and IPFS integration.

### Core Technical Logic
* **Standard ERC721:** Built on top of `@openzeppelin/contracts/token/ERC721/ERC721.sol`.
* **IPFS Integration:** The Basic NFT utilizes `tokenURI` pointing to IPFS hashes for decentralized static asset storage.
* **On-Chain SVG:** The Mood NFT constructs SVG strings dynamically in Solidity and encodes them to Base64 to serve the `tokenURI` directly from the blockchain.
* **Dynamic State:** The Mood NFT allows the owner to "flip" the mood, updating the on-chain metadata in real-time.

---

## 🛠 Tech Stack
* **Smart Contracts:** Solidity
* **Framework:** Foundry (Forge, Cast, Anvil)
* **Libraries:** OpenZeppelin Contracts, Base64 (OpenZeppelin)
* **Storage:** IPFS (for Basic NFT), On-chain Storage (for Mood NFT)
* **Automation:** GNU Makefile

---

## 🚀 Getting Started

### Prerequisites
1. **Install Foundry**
2. **An Alchemy or Infura RPC URL** for Sepolia (or another testnet).
3. **A keystore-based deployer account** (no raw private keys in code or `.env`).
4. **IPFS (Optional):** For pinning new images if you modify the Basic NFT.

### Installation
Clone the repo:
```shell
$ git clone https://github.com/consigli3r3/NFTs.git
```

Install dependencies:
```shell
$ make install
``` 

### Environment Setup
Create a `.env` file and add:
SEPOLIA_RPC_URL=your_rpc_url
ACCOUNT=your_keystore_account_name
ETHERSCAN_API_KEY=your_etherscan_api_key

---

## 🧪 Testing & Quality Control
This project uses Foundry’s testing framework to validate minting, URI generation, and state flips.

**Run All Tests:**
```shell
$ make test
```

**Check Coverage:**
```shell
$ forge coverage
```

**Gas Snapshots:**
```shell
$ make snapshot
```

---

## 📦 Deployment Guide
The `Makefile` simplifies deployment for both NFT types.

### Local Deployment (Anvil)
1. Start a local blockchain:
```shell
   $ make anvil
```
2. Deploy the Basic NFT:
```shell
   $ make deploy
```

### Testnet Deployment (Sepolia)
To deploy to Sepolia and verify the contract on Etherscan:

**Deploy Basic NFT:**
```shell
$ make deploy ARGS="--network sepolia"
```

**Deploy Mood NFT (if configured in Makefile):**
```shell
$ make deployMood ARGS="--network sepolia"
```

*Note: Ensure your keystore account is set up and funded with Sepolia ETH.*

---

## 📚 Learning Context
This repository is part of the **Cyfrin Updraft** Advanced Foundry track, focusing on:
* **IPFS vs. On-Chain Storage:** Understanding the trade-offs between cheap off-chain storage and permanent on-chain data.
* **Base64 Encoding:** How to encode data directly in smart contracts.
* **SVG Manipulation:** Generating and modifying graphics using Solidity logic.