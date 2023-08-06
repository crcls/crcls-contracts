// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./IDeed.sol";
import "./Circle.sol";

contract Deed is ERC721, Ownable, IDeed {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string VERSION = "0.1";
    uint256 public fee = 5 ether;

    mapping(uint256 => Circle) private _circles;
    mapping(string => uint256) private _slugs;

    constructor(uint256 initialFee) ERC721("CRCLS Deed", "CRCLSDEED") {
        fee = initialFee;
    }

    function withdraw() external onlyOwner {
        uint balance = address(this).balance;
        payable(owner()).transfer(balance);
    }

    function setFee(uint256 newFee) external onlyOwner {
        fee = newFee;
    }

    function purchase(string memory slug, address authority) external payable {
        require(msg.value >= fee, "Insufficient funds to create a Circle.");

        uint256 tokenId = _tokenIds.current();
        _safeMint(msg.sender, tokenId + 1);

        Circle storage circle = _circles[tokenId];
        circle.slug = slug;
        circle.authority = authority;
        circle.admins.push(Admin(msg.sender, 0));

        _tokenIds.increment();
        emit NewCircle(tokenId, slug, authority);
    }

    function detailsFromId(uint256 id) public view returns (string memory slug, address authority) {
        Circle memory circle = _circles[id];

        return (circle.slug, circle.authority);
    }

    function detailsFromSlug(string memory slug) public view returns (uint256 id, address authority) {
        id = _slugs[slug];
        Circle memory circle = _circles[id];

        return (id, circle.authority);
    }
}