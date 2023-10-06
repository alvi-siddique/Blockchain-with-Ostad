// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title VotingContract
 * @dev A simple voting contract that allows users to vote for candidates.
 */
contract VotingContract {
    // Struct to represent a candidate
    struct Candidate {
        string name;        // Name of the candidate
        uint voteCount;     // Number of votes received by the candidate
    }

    // Mapping to store candidates
    mapping(string => Candidate) public candidates;

    // Event to log donations
    event DonationReceived(address indexed sender, uint amount);

    // Constructor to initialize candidates
    constructor() {
        candidates["John"] = Candidate("John", 0);
        candidates["Paul"] = Candidate("Paul", 0);
    }

    /**
     * @dev Function to allow users to cast a vote for a candidate.
     * @param _name Name of the candidate to vote for.
     */
    function vote(string memory _name) public onlyValidCandidate(_name) {
        candidates[_name].voteCount++;
    }

    /**
     * @dev Modifier to ensure that the candidate name provided is valid.
     * Valid names are "John" & "Paul".
     */
    modifier onlyValidCandidate(string memory _name) {
        require(
            keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("John")) ||
            keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Paul")),
            "You are not allowed to vote"
        );
        _;
    }

    /**
     * @dev Function to get the current vote count for a candidate.
     * @param _name Name of the candidate to query.
     * @return Current vote count of the candidate.
     */
    function getCandidateVoteCount(string memory _name) public view returns (uint) {
        return candidates[_name].voteCount;
    }

    /**
     * @dev Function to allow users to send Ether as a donation.
     */
    function donate() public payable {
        emit DonationReceived(msg.sender, msg.value);
    }
}
