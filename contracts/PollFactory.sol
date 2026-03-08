// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Poll.sol";

contract PollFactory {
    event PollCreated(
        address indexed poll,
        address indexed creator,
        string question
    );

    function createPoll(
        string memory question,
        string[] memory options,
        uint64 startTime,
        uint64 endTime
    ) external returns (address pollAddress) {
        Poll poll = new Poll(
            question,
            options,
            startTime,
            endTime
        );

        pollAddress = address(poll);

        emit PollCreated(
            pollAddress,
            msg.sender,
            question
        );
    }
}