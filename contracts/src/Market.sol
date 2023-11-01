// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {IERC721} from "./IERC721.sol";
import {IMarket} from "./IMarket.sol";

contract Marketplace is IMarket {
    struct AuctionInfo {
        address _seller;
        address _bidder;
        
        uint256 _sellersTokenId;
        uint256 _biddersTokenId;

        address _contractAddress;
        AuctionStatus _status;
    }

    uint256 private _auctionCounter;
    mapping(uint256 => AuctionInfo) private _auctions;
    uint256[] private _auctionList;

    constructor() {
        _auctionCounter = 0;
    }

    // Lists all of the auction numbers.
    function list() external override view returns(uint256[] memory) {
        uint256[] memory returnList = new uint256[](uint256(_auctionList.length));

        for (uint i = 0; i < _auctionList.length; i++) {
            returnList[i] = _auctionList[i];
        }

        return returnList;
    }

    // Lists all of the auction numbers.
    function listOpenOnly() override external view returns(uint256[] memory) {
        uint256 numberOfOpenOnly = 0;

        for (uint i = 0; i < _auctionList.length; i++) {
            AuctionInfo memory info = _auctions[i];

            if (info._status == AuctionStatus.OPEN) {
                numberOfOpenOnly++;
            }
        }

        uint256[] memory returnList = new uint256[](numberOfOpenOnly);
        uint256 j = 0;

        for (uint i = 0; i < _auctionList.length; i++) {
            AuctionInfo memory info = _auctions[i];

            if (info._status == AuctionStatus.OPEN) {
                returnList[j] = _auctionList[i];
                j++;
            }
        }

        return returnList;
    }

    // Lists all of the auction numbers.
    function listConcludedOnly()override external view returns(uint256[] memory) {
       uint256 numberOfOpenOnly = 0;

        for (uint i = 0; i < _auctionList.length; i++) {
            AuctionInfo memory info = _auctions[i];

            if (info._status == AuctionStatus.CONCLUDED) {
                numberOfOpenOnly++;
            }
        }

        uint256[] memory returnList = new uint256[](numberOfOpenOnly);
        uint256 j = 0;

        for (uint i = 0; i < _auctionList.length; i++) {
            AuctionInfo memory info = _auctions[i];

            if (info._status == AuctionStatus.CONCLUDED) {
                returnList[j] = _auctionList[i];
                j++;
            }
        }

        return returnList;
    }

    // Lists all of the auction numbers.
    function listCancelledOnly()override external view returns(uint256[] memory) {
       uint256 numberOfOpenOnly = 0;

        for (uint i = 0; i < _auctionList.length; i++) {
            AuctionInfo memory info = _auctions[i];

            if (info._status == AuctionStatus.CANCELLED) {
                numberOfOpenOnly++;
            }
        }

        uint256[] memory returnList = new uint256[](numberOfOpenOnly);
        uint256 j = 0;

        for (uint i = 0; i < _auctionList.length; i++) {
            AuctionInfo memory info = _auctions[i];

            if (info._status == AuctionStatus.CANCELLED) {
                returnList[j] = _auctionList[i];
                j++;
            }
        }

        return returnList;
    }

    // Gets the status of the auction.
    function statusOf(uint256 _auctionId) override external view returns(AuctionStatus) {
        return _auctions[_auctionId]._status;
    }

    // Gets the address of the given auction.
    function sellerOf(uint256 _auctionId)override external view returns(address) {
        return _auctions[_auctionId]._seller;
    }

    // Gets the address of the given auction. If not bidded yet then 0x0
    function currentBidderOf(uint256 _auctionId) override external view returns(address) {
        return _auctions[_auctionId]._bidder;
    }

    // Zortzortzort
    function sellersTokenIdOf(uint256 _auctionId) override external view returns(uint256) {
        return _auctions[_auctionId]._sellersTokenId;
    }

    // Gets the addressdwwd 0 if no one offered smt yet
    function currentBiddersTokenIdOf(uint256 _auctionId) override external view returns(uint256) {
        return _auctions[_auctionId]._biddersTokenId;
    }

    // Returns the ERC271 contract address assiciated with the auction.
    function contractAddressOf(uint256 _auctionId) override external view returns(address) {
        return _auctions[_auctionId]._contractAddress;
    }

    // Other functions 

    // Creates an auction and returns the auctionId. The nft is transferred into this 
    // contract for locking purposes. 
    function open(address contractAddress, uint256 tokenId) override external returns(uint256) {
        _auctionList.push(_auctionCounter);
        _auctions[_auctionCounter] = AuctionInfo({
            _seller: msg.sender,
            _contractAddress: contractAddress,
            _status: AuctionStatus.OPEN,
            _bidder: address(0x0),
            _sellersTokenId: tokenId,
            _biddersTokenId: 0
        });

        _auctionCounter++;

        // Emit the message that a new auction is open
        emit AuctionOpened(msg.sender, _auctionCounter - 1);

        return _auctionCounter - 1;
    }

    // Closes the auction giving the NFT to the highest bidder, returning other bids 
    // and giving the bidded amount to the seller.
    function acceptAndExchange(uint256 _auctionId) override external {
        require(_auctions[_auctionId]._status == AuctionStatus.OPEN, "Auction not open");
        require(msg.sender == _auctions[_auctionId]._seller, "Only seller can accept");
        require(_auctions[_auctionId]._bidder != address(0x0), "No bid is placed yet");

        AuctionInfo memory info = _auctions[_auctionId];

        // Do the exchange here!
        // IERC721 contractObject = IERC721(info._contractAddress);
        // contractObject.safeTransferFrom(info._seller, info._bidder, info._sellersTokenId);
        // contractObject.safeTransferFrom(info._bidder, info._seller, info._biddersTokenId);

        info._status = AuctionStatus.CONCLUDED;

        // Override the maping
        _auctions[_auctionId] = info;

        emit AuctionBidAccepted(_auctionId);
    }

    // Closes the auction giving NFT to the seller, and bidders their locked amount.
    function reject(uint256 _auctionId)override external {
        require(_auctions[_auctionId]._status == AuctionStatus.OPEN, "Auction not open");
        require(msg.sender == _auctions[_auctionId]._seller, "Only seller can accept");
        require(_auctions[_auctionId]._bidder != address(0x0), "No bid is placed yet");

        AuctionInfo memory info = _auctions[_auctionId];

        // Reset the info and emit an event
        info._bidder = address(0x0);
        info._biddersTokenId = 0;

        _auctions[_auctionId] = info;

        emit AuctionBidRejected(_auctionId);
    }

    // Closes the auction giving NFT to the seller, and bidders their locked amount.
    function cancel(uint256 _auctionId)override external {
        require(_auctions[_auctionId]._status == AuctionStatus.OPEN, "Auction not open");
        require(msg.sender == _auctions[_auctionId]._seller, "Only seller can accept");

        AuctionInfo memory info = _auctions[_auctionId];

        // Reset the info and emit an event
        info._status = AuctionStatus.CANCELLED;

        _auctions[_auctionId] = info;

        emit AuctionCancelled(_auctionId);
    }

    // Bids the specified amount to the given auctionId.
    function offer(uint256 _auctionId, uint256 _tokenId) override external {
        require(_auctions[_auctionId]._bidder == address(0x0), "There is already an awaiting offer");
        require(_auctions[_auctionId]._status == AuctionStatus.OPEN, "Auction not open");

        AuctionInfo memory info = _auctions[_auctionId];

        // Reset the info and emit an event
        info._bidder = msg.sender;
        info._biddersTokenId = _tokenId;

        _auctions[_auctionId] = info;

        emit AuctionNewOffer(_auctionId, msg.sender);
    }
}
