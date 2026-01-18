// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {DeployMoodNFT} from "../script/DeployMoodNFT.s.sol";

contract MoodNFTTest is Test {
    MoodNFT public moodNFT;
    address USER = makeAddr("user");
    string public HAPPY_SVG_URI = vm.readFile("./img/happy.svg");
    string public SAD_SVG_URI = vm.readFile("./img/sad.svg");

    function setUp() public {
        DeployMoodNFT deployer = new DeployMoodNFT();
        moodNFT = deployer.run();

        console.log("USER address:", USER);
        console.logBytes(address(USER).code);

        vm.etch(USER, new bytes(0)); // Ensure USER has no code so it doesnt match an existing contract on Sepolia
    }

    function testViewTokenURIHappy() public {
        vm.prank(USER);
        moodNFT.mintNFT();
        console.log(moodNFT.tokenURI(0));
    }

    function testFlipTokenToSad() public {
        vm.prank(USER);
        moodNFT.mintNFT();

        // Initial mood should be HAPPY
        assertEq(uint256(moodNFT.getMood(0)), uint256(MoodNFT.Mood.HAPPY));

        vm.prank(USER);
        moodNFT.flipMood(0);

        // After flip, mood should be SAD
        assertEq(uint256(moodNFT.getMood(0)), uint256(MoodNFT.Mood.SAD));
    }
}
