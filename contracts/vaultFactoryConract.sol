// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./vault.sol"

contract factoryVault{
    vault[] public vaultAddresses;

    function createNewVault() external returns(vault NewVault,uint numberOfVaults){
        NewVault = new vault();
        vaultAddresses.push(NewVault);
        numberOfVaults = vaultAddresses.length;
    }

    function vaultsCreated()external view returns(vault[] memory createdVaults) {
    createdVaults = vaultAddresses;
    }

}

