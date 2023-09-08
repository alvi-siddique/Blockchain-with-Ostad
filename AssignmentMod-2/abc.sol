// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HelloWorldContract {
    // State variable to store the greeting message
    string public message = "Hello, World!";

    // Event to log when the message is updated
    event MessageUpdated(string newMessage);

    // Function to get the current greeting message
    function getMessage() public view returns (string memory) {
        return message;
    }

    // Function to set a new greeting message
    function setMessage(string memory newMessage) public {
        message = newMessage;
        
        // Emit the MessageUpdated event to log the change
        emit MessageUpdated(newMessage);
    }
}
