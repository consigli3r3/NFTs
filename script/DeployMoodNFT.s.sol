// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    function run() external returns (MoodNFT) {
        string memory happySvg = vm.readFile("./img/happy.svg");
        string memory sadSvg = vm.readFile("./img/sad.svg");
        vm.startBroadcast();
        MoodNFT moodNFT = new MoodNFT(
            svgToImageURI(happySvg),
            svgToImageURI(sadSvg)
        );
        vm.stopBroadcast();
        return moodNFT;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        // Prefix for base64 encoded SVGs
        string memory baseURL = "data:image/svg+xml;base64,";
        // Encode the SVG
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        // Concatenate the prefix and the encoded SVG
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
