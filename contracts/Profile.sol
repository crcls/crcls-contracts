// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.21;


struct Profile {
    address owner;
    string handle;
    string pfp;
    uint256 kudos;
    uint8 status; // 0 = suspended
}
