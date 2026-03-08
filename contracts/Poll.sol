// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Poll {
    string public question;

    string[] public options;
    uint32[] private votes;

    uint64 public startTime;
    uint64 public endTime;

    mapping(address => bool) public hasVoted;

    event VoteCast(address indexed voter, uint256 option);

    constructor(
        string memory _question,
        string[] memory _options,
        uint64 _startTime,
        uint64 _endTime
    ) {
        require(_options.length >= 2, "Need >=2 options");
        require(_endTime > _startTime, "Invalid time");

        question = _question;
        options = _options;

        startTime = _startTime;
        endTime = _endTime;

        votes = new uint32[](_options.length);
    }

    function vote(uint256 optionId) external {
        require(block.timestamp >= startTime, "Voting not started");
        require(block.timestamp <= endTime, "Voting ended");

        require(!hasVoted[msg.sender], "Already voted");

        require(optionId < votes.length, "Invalid option");

        hasVoted[msg.sender] = true;

        votes[optionId]++;

        emit VoteCast(msg.sender, optionId);
    }

    function getOptions() external view returns (string[] memory) {
        return options;
    }

    function getResults() external view returns (uint32[] memory) {
        return votes;
    }

    function getOptionVotes(uint256 optionId) external view returns (uint32) {
        require(optionId < votes.length, "Invalid option");
        return votes[optionId];
    }

    function isActive() external view returns (bool) {
        return block.timestamp >= startTime && block.timestamp <= endTime;
    }

    function hasUserVoted(address user) external view returns (bool) {
        return hasVoted[user];
    }
}