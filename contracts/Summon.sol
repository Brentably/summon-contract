// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import './SummonUtils.sol';

contract Summon is SummonUtils {
    address public immutable owner;
    mapping(bytes => address) public storedTokens; // lender => (contract,tokenID) 

    constructor(address _owner) {
        owner = _owner;

    }

    
    function depositToken(
        address tokenAddress,
        uint256 tokenId
    ) public returns(bool success, bytes memory data) {
        bytes memory uniqToken = abi.encodePacked(tokenAddress, tokenId);
        storedTokens[uniqToken] = msg.sender;

        (success, data) = tokenAddress.delegatecall(abi.encodeWithSignature("transferFrom(address,address,uint256)",address(msg.sender),address(this),tokenId));
        require(success, "failed");
    }
    

    function withdrawToken(
        address tokenAddress,
        uint256 tokenId
    ) public returns(bool success, bytes memory data) {
        bytes memory uniqToken = abi.encodePacked(tokenAddress, tokenId);
        require(storedTokens[uniqToken] == msg.sender, "withdrawer does not own token");
        return tokenAddress.delegatecall(abi.encodeWithSignature("safeTransferFrom(address,address,uint256)",address(this),msg.sender,tokenId));
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