// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

// This contract works with an NFT contract (ERC721) to make NFT transfer possible.
abstract contract IMarket {
    // ENUMS // 

    // Auction can have these states;
    // - OPEN means the auction accepts bids
    // - CONCLUDED means the auction is concluded and transaction occured
    // - CANCELLED means the auction is cancelled and transaction did not occured
    enum AuctionStatus {NOTOPEN, OPEN, CONCLUDED, CANCELLED}

    // EVENTS // 

    // Event is emitted when it is opened.
    event AuctionOpened(address indexed _by, uint256 indexed _auctionId);

    // Event is emitted when a new bid is placed.
    event AuctionNewOffer(uint256 indexed _auctionId, address indexed _offerer);

    // Event is emitted when it is concluded.
    event AuctionBidAccepted(uint256 indexed _auctionId);

    // Event is emitted when it is concluded.
    event AuctionBidRejected(uint256 indexed _auctionId);

    // Event is emitted when it is cancelled.
    event AuctionCancelled(uint256 indexed _auctionId);

    // FUNCTIONS // 
    // View functions // 

    // Lists all of the auction numbers.
    function list() external view virtual returns(uint256[] memory);

    // Lists all of the auction numbers.
    function listOpenOnly() external view virtual returns(uint256[] memory);

    // Lists all of the auction numbers.
    function listConcludedOnly() external virtual view returns(uint256[] memory);

    // Lists all of the auction numbers.
    function listCancelledOnly() external virtual view returns(uint256[] memory);

    // Gets the status of the auction.
    function statusOf(uint256 _auctionId) virtual external view returns(AuctionStatus);

    // Gets the address of the given auction.
    function sellerOf(uint256 _auctionId) virtual external view returns(address);

    // Returns the ERC271 contract address assiciated with the auction.
    function contractAddressOf(uint256 _auctionId) virtual external view returns(address);

    // Other functions 

    // Creates an auction and returns the auctionId. The nft is transferred into this 
    // contract for locking purposes. 
    function open(address _nftContract, uint256 tokenId) virtual external returns(uint256);

    // Closes the auction giving the NFT to the highest bidder, returning other bids 
    // and giving the bidded amount to the seller.
    function acceptAndExchange(uint256 _auctionId) virtual external;

    // Closes the auction giving NFT to the seller, and bidders their locked amount.
    function reject(uint256 _auctionId) virtual external;

    // Closes the auction giving NFT to the seller, and bidders their locked amount.
    function cancel(uint256 _auctionId) virtual external;

    // Bids the specified amount to the given auctionId.
    function offer(uint256 _auctionId, uint256 _tokenId) virtual external;
}