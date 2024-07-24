// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract CandleAuction {
    struct Auction {
        address payable auctioneer;
        uint256 startBlock;
        uint256 endBlock;
        bool ended;
        address highestBidder;
        uint256 highestBid;
    }

    mapping(uint256 => Auction) public auctions;
    uint256 public auctionCount;
    uint256 public randomnessBlockInterval = 5;

    mapping(uint256 => mapping(address => uint256)) public bids;

    event AuctionCreated(uint256 indexed auctionId, address indexed auctioneer, uint256 endBlock);
    event BidPlaced(uint256 indexed auctionId, address indexed bidder, uint256 amount);
    event AuctionEnded(uint256 indexed auctionId, address indexed winner, uint256 amount);

    function createAuction(uint256 duration) public {
        auctionCount++;
        uint256 endBlock = block.number + duration;
        auctions[auctionCount] = Auction({
            auctioneer: payable(msg.sender),
            startBlock: block.number,
            endBlock: endBlock,
            ended: false,
            highestBidder: address(0),
            highestBid: 0
        });

        emit AuctionCreated(auctionCount, msg.sender, endBlock);
    }

    function placeBid(uint256 auctionId) public payable {
        Auction storage auction = auctions[auctionId];
        require(block.number <= auction.endBlock, "Auction has already ended");
        require(msg.value > auction.highestBid, "Bid is not higher than the current highest bid");

        if (auction.highestBid != 0) {
            bids[auctionId][auction.highestBidder] += auction.highestBid;
        }

        auction.highestBidder = msg.sender;
        auction.highestBid = msg.value;

        emit BidPlaced(auctionId, msg.sender, msg.value);
    }

    function withdrawBid(uint256 auctionId) public {
        uint256 amount = bids[auctionId][msg.sender];
        require(amount > 0, "No funds to withdraw");

        bids[auctionId][msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    function endAuction(uint256 auctionId) public {
        Auction storage auction = auctions[auctionId];
        require(block.number > auction.endBlock, "Auction is still ongoing");
        require(!auction.ended, "Auction has already ended");

        auction.ended = true;
        if (auction.highestBidder != address(0)) {
            auction.auctioneer.transfer(auction.highestBid);
        }

        emit AuctionEnded(auctionId, auction.highestBidder, auction.highestBid);
    }

    function randomEndAuction(uint256 auctionId) public {
        Auction storage auction = auctions[auctionId];
        require(block.number > auction.endBlock, "Auction is still ongoing");
        require(!auction.ended, "Auction has already ended");
        require(block.number >= auction.endBlock + randomnessBlockInterval, "Not enough blocks have passed to determine randomness");

        auction.ended = true;
        if (auction.highestBidder != address(0)) {
            auction.auctioneer.transfer(auction.highestBid);
        }

        emit AuctionEnded(auctionId, auction.highestBidder, auction.highestBid);
    }
}
