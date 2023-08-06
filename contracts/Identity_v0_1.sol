// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./Profile.sol";
import "./IIdentity.sol";

contract Identity is ERC721, Ownable, IIdentity {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string VERSION = "0.1";
    uint256 fee = 5 ether;

    mapping(address => Profile) private _profiles;
    mapping(string => address) private _handles;

    constructor(uint256 initialFee) ERC721("CRCLS Identity", "CRCLSID") {
        fee = initialFee;
    }

    function withdraw() external onlyOwner() {
        uint balance = address(this).balance;
        payable(owner()).transfer(balance);
    }

    function setFee(uint256 newFee) external onlyOwner {
        fee = newFee;
    }

    function create(string memory handle, string memory pfp) external payable {
        Profile storage profile = _profiles[msg.sender];

        require(msg.value >= fee, "Insufficient funds to create a Profile.");
        require(profile.owner == address(0), "Profile already exists for this wallet.");
        require(isHandleAvailable(handle), "Handle is already taken.");

        uint256 tokenId = _tokenIds.current();
        _safeMint(msg.sender, tokenId + 1);

        _handles[handle] = msg.sender;
        profile.owner = payable(msg.sender);
        profile.handle = handle;
        profile.pfp = pfp;
        profile.kudos = 100;
        profile.status = 1;

        _tokenIds.increment();

        emit NewIdentity(profile);
    }

    function isHandleAvailable(string memory handle) public view returns (bool) {
        return _handles[handle] == address(0);
    }
}
