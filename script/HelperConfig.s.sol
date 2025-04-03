// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {Script} from "lib/forge-std/src/Script.sol";

contract HelperConfig {
    error HelperConfig__InvalidChainId();

    struct NetworkConfig {
        address entryPoint;
    }

    uint256 constant ETH_SEPOLIA_CHAIN_ID = 1115511144;
    uint256 constant ZSYNC_SEPOLIA_CHAIN_ID = 300;
    uint256 constant LOCAL_CHAIN_ID = 31337;

    NetworkConfig public localNetWorkConfig;
    mapping (uint256 chainId => NetworkConfig) public networkConfigs;

    constructor(){
        networkConfigs[ETH_SEPOLIA_CHAIN_ID] = getEthSepoliaConfig();
    }

    function getConfig() public view returns(NetworkConfig memory){
        getConfigByChainId(block.chainid);
    }
    function getConfigByChainId(uint256 chainId) public view returns(NetworkConfig memory){
        if(chainId == LOCAL_CHAIN_ID){
            return getOrCreateAnvilEthConfig();
        }
        else if(networkConfigs[chainId].entryPoint != address(0)){
            return networkConfigs[chainId];
        }
        else{
            revert HelperConfig__InvalidChainId();
        }
    }

    function getEthSepoliaConfig() public pure returns (NetworkConfig memory){
        return NetworkConfig({
            entryPoint: 0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789
        });
    }

    function getZsyncSepoliaConfig() public pure returns (NetworkConfig memory){
        return NetworkConfig({
            entryPoint: address(0)
        });
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory){
        if(localNetWorkConfig.entryPoint != address(0)){
            return localNetWorkConfig;
        }
        // deploy mock entry point contract
    }
}