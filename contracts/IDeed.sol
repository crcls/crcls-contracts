// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.21;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IDeed is IERC721 {
    event NewCircle(uint256 id, string slug, address authority);
}
