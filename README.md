# Decentralized Legal Agreement (Ricardian)

A professional-grade framework for "Smart Legal Contracts." This repository implements the Ricardian model, where a legally binding document is hashed and stored within the contract state. This ensures that the code (the "Smart" part) and the prose (the "Legal" part) are cryptographically linked, making the intent of the contract indisputable in both code and a court of law.

## Core Features
* **Prose-to-Code Mapping:** Links specific legal clauses to smart contract functions.
* **Document Hashing:** Stores the `sha256` hash of the external PDF/Markdown agreement to prevent tampering.
* **Digital Signatures:** Requires all parties to "Accept" the specific hash of the document before the contract becomes active.
* **Flat Architecture:** Single-directory layout for the Agreement Registry and the Acceptance logic.

## Workflow
1. **Draft:** Parties agree on a legal document (e.g., a Consulting Agreement).
2. **Hash:** The document is hashed, and the hash is stored in the contract.
3. **Sign:** Both parties call `acceptAgreement(hash)`.
4. **Execute:** The contract allows payments or actions only if the agreement is signed.

## Setup
1. `npm install`
2. Deploy `RicardianContract.sol`.
