// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
import "hardhat/console.sol";

// contract deployed to 0x4385B18589eaFcA91A5E396baFA98db0e8a4aEA7

contract Donation {
    address payable private accountManager;
    // mapping(address => uint256) public donor;

    struct Donors {
        uint256 amountDonated;
        address donorAddress;
    }

    Donors[] public donors;

    constructor() {
        accountManager = payable(msg.sender);
    }

    function depositMatic() public payable {
        require(msg.value != 0, "You need to deposit some amount MATIC!");
        // donor[msg.sender] += msg.value;
        donors.push(Donors(msg.value, msg.sender));
    }

    function withdrawMatic() public payable {
        require(
            msg.sender == accountManager,
            "You don't have the permission to withdraw funds"
        );
        accountManager.transfer(address(this).balance);
    }

    function getAccountBalance() public view returns (uint256) {
        require(
            msg.sender == accountManager,
            "You don't have the permission to check the balance"
        );
        return address(this).balance;
    }

    function getDonors() public view returns (Donors[] memory) {
        require(
            msg.sender == accountManager,
            "You don't have the permission to check the balance"
        );
        return donors;
    }
}
