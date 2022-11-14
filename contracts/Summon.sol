// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import './SummonUtils.sol';

contract Summon is SummonUtils {
    address public immutable owner;

    constructor(address _owner) {
        owner = _owner;
    }

    
    function depositToken external (
        address tokenAddress
        uint256 tokenID
    ) {

    }

   

  function isValidSignature(
    bytes32 _hash,
    bytes calldata _signature
  ) external view returns (bytes4) {
   // Validate signatures
   if ((recoverSigner(_hash, _signature)) == owner) {
     return 0x1626ba7e;
   } else {
     return 0xffffffff;
   }
 }


}