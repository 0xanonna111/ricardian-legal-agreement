// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title RicardianContract
 * @dev Connects a legal document hash to executable logic.
 */
contract RicardianContract is Ownable {
    bytes32 public agreementHash;
    string public documentURI;
    
    mapping(address => bool) public hasAccepted;
    address[] public signers;

    event AgreementAccepted(address indexed signer, bytes32 hash);

    constructor(bytes32 _agreementHash, string memory _uri, address[] memory _requiredSigners) Ownable(msg.sender) {
        agreementHash = _agreementHash;
        documentURI = _uri;
        signers = _requiredSigners;
    }

    /**
     * @dev Parties call this to link their identity to the legal hash.
     */
    function acceptAgreement(bytes32 _hash) external {
        require(_hash == agreementHash, "Hash mismatch - document changed");
        bool isRequired = false;
        for(uint i=0; i<signers.length; i++) {
            if(signers[i] == msg.sender) isRequired = true;
        }
        require(isRequired, "Not a required signer");
        
        hasAccepted[msg.sender] = true;
        emit AgreementAccepted(msg.sender, _hash);
    }

    /**
     * @dev Checks if all required parties have accepted the legal terms.
     */
    function isFullySigned() public view returns (bool) {
        for(uint i=0; i<signers.length; i++) {
            if(!hasAccepted[signers[i]]) return false;
        }
        return true;
    }

    /**
     * @dev Example function that is gated by legal acceptance.
     */
    function executeContractAction() external {
        require(isFullySigned(), "Legal agreement not fully signed");
        // Business logic here...
    }
}
