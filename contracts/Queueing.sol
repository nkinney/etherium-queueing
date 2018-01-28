pragma solidity ^0.4.17;

contract Queueing {

	struct Person {
		address personAddress;
		uint startTime;
		uint endTime;
    }

    uint numberInQueue = 0;
	mapping (address => Person) public people;

	function queue(address _address) public returns (uint) {
		var person = people[msg.sender];
		person.personAddress = _address;
		person.startTime = block.timestamp;
		numberInQueue += 1;
		return numberInQueue;
	}

	function getUserAddress(address _address) public returns (address) {
		var person = people[_address];
		return person.personAddress;
	}

	function getUserStartTime(address _address) public returns (uint) {
		var person = people[_address];
		return person.startTime;
	}

	function getUserEndTime(address _address) public returns (uint) {
		var person = people[_address];
		return person.endTime;
	}

	function getNumberinQueue() public returns (uint) {
		return numberInQueue;
	}

	function deQueue(address _address) public returns (uint) {
		var person = people[_address];
		person.endTime = block.timestamp;
		uint waitTime = person.endTime - person.startTime;
		return waitTime;
	}
}