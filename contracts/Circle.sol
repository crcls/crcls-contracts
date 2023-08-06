// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.21;

struct Admin {
    address id;
    uint8 rank;
}

struct Circle {
    string slug;
    address authority;
    Admin[] admins;
}
