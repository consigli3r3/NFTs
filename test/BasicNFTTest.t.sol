// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;
    address public USER;
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
        USER = makeAddr("user");
    }

    // Test 1: Verify NFT name is correct
    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNFT.name();
        // Compare strings by hashing them (can't use == on strings)
        assertEq(keccak256(abi.encodePacked(expectedName)), keccak256(abi.encodePacked(actualName)));
    }

    // Test 2: Verify NFT symbol is correct
    function testSymbolIsCorrect() public view {
        string memory expectedSymbol = "DOG";
        string memory actualSymbol = basicNFT.symbol();
        assertEq(keccak256(abi.encodePacked(expectedSymbol)), keccak256(abi.encodePacked(actualSymbol)));
    }

    // Test 3: User can mint NFT and balance increases
    function testCanMintAndHaveBalance() public {
        vm.prank(USER); // Next call comes from USER address
        basicNFT.mintNFT(PUG_URI);

        assertEq(basicNFT.balanceOf(USER), 1);
        assertEq(keccak256(abi.encodePacked(PUG_URI)), keccak256(abi.encodePacked(basicNFT.tokenURI(0)))); // First token ID is 0
    }

    // Test 4: Token URI is stored correctly
    function testTokenURIIsCorrect() public {
        vm.prank(USER);
        basicNFT.mintNFT(PUG_URI);

        string memory actualUri = basicNFT.tokenURI(0);
        assertEq(keccak256(abi.encodePacked(PUG_URI)), keccak256(abi.encodePacked(actualUri)));
    }

    // Test 5: Token counter increments after each mint
    function testTokenCounterIncrements() public {
        vm.prank(USER);
        basicNFT.mintNFT(PUG_URI);

        vm.prank(USER);
        basicNFT.mintNFT("ipfs://second-nft");

        assertEq(basicNFT.balanceOf(USER), 2);
        assertEq(basicNFT.ownerOf(1), USER); // Second token ID is 1
    }

    // Test 6: Multiple users can mint their own NFTs
    function testMultipleUsersMinting() public {
        address USER2 = makeAddr("user2");

        vm.prank(USER);
        basicNFT.mintNFT(PUG_URI);

        vm.prank(USER2);
        basicNFT.mintNFT("ipfs://user2-nft");

        assertEq(basicNFT.balanceOf(USER), 1);
        assertEq(basicNFT.balanceOf(USER2), 1);
        assertEq(basicNFT.ownerOf(0), USER);
        assertEq(basicNFT.ownerOf(1), USER2);
    }

    // Test 7: Same user can mint multiple NFTs
    function testUserCanMintMultipleNFTs() public {
        vm.startPrank(USER); // All calls from USER until stopPrank
        basicNFT.mintNFT(PUG_URI);
        basicNFT.mintNFT("ipfs://second");
        basicNFT.mintNFT("ipfs://third");
        vm.stopPrank();

        assertEq(basicNFT.balanceOf(USER), 3);
    }

    // Test 8: Each token has unique URI
    function testEachTokenHasUniqueURI() public {
        string memory uri1 = "ipfs://first";
        string memory uri2 = "ipfs://second";

        vm.startPrank(USER);
        basicNFT.mintNFT(uri1);
        basicNFT.mintNFT(uri2);
        vm.stopPrank();

        assertEq(keccak256(abi.encodePacked(basicNFT.tokenURI(0))), keccak256(abi.encodePacked(uri1)));
        assertEq(keccak256(abi.encodePacked(basicNFT.tokenURI(1))), keccak256(abi.encodePacked(uri2)));
    }
}
