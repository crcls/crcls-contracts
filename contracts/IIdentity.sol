// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.21;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import "./Profile.sol";

interface IIdentity is IERC721 {
    event NewIdentity(Profile profile);
}
