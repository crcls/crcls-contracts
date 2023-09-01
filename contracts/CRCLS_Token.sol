// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.21;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./ICRCLS.sol";

/**
 * Release Schedule:
 * -------------------------
 * 1_000_000_000_000 Max Supply
 * Initial Supply: 0 to 99_999 active peers
 * Stage 2: 100_000 to 99_999_999 active peers
 * Stage 3: 100_000_000+ active peers
*/

contract CRCLS is ICRCLS, ERC20Capped, Ownable {
    uint256 private INITIAL_SUPPLY = 1_000_000_000;
    uint256 private STAGE_2_RELEASE = 99_000_000_000;
    uint256 private STAGE_3_RELEASE = 999_000_000_000;

    constructor(uint256 cap_) ERC20("CRCLS", "CRCLS") ERC20Capped(cap_) {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function release(uint8 stage) public onlyOwner {
        if (stage == 2) {
            _mint(msg.sender, STAGE_2_RELEASE);
            emit Stage2ReleasedEvent();
        } else if (stage == 3) {
            _mint(msg.sender, STAGE_3_RELEASE);
            emit Stage3ReleasedEvent();
        }
    }
}
