# Candle Auction DApp

This is a decentralized application (DApp) for a Candle Auction, where users can create auctions, place bids, end auctions, check auction details, and withdraw their bids. The project uses Solidity for smart contracts and a simple HTML/JavaScript frontend with Web3.js for interaction with the Ethereum blockchain.

## Features

- Create a new auction with a specified duration.
- Place bids on ongoing auctions.
- End auctions and determine the winner.
- Check details of an auction.
- Withdraw bids.

## Prerequisites

To run this project, you need to have the following installed:

- [Node.js](https://nodejs.org/) (v14.x or later)
- [npm](https://www.npmjs.com/) (v6.x or later)
- [MetaMask](https://metamask.io/) (browser extension for Ethereum)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/candle-auction.git
   cd candle-auction
   ```
2. Install the dependencies:
   ```bash
   npm install
   npm install -g truffle
   truffle init
   ```
3. Compile and depoly the smart contract:
   ```bash
    npx truffle compile
    npx truffle migrate --network development
   ```
4. Update the contractAddress (will be present in terminal after depolying contract) and contractABI (a new file name CandleAuction.json will be created) in the index.html file with the deployed contract address and ABI .

5. Start a local blockchain using Ganache (or use any Ethereum testnet).
