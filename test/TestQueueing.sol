pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Queueing.sol";

contract TestQueueing {
  Queueing queueing = Queueing(DeployedAddresses.Queueing());

	function testUserCanQueue() public {
		uint expected = 1;
		address userAddress = this;

		uint returnedLength = queueing.queue(userAddress);

		Assert.equal(returnedLength, expected, "The length of the queue should be 1.");
	}

	function testCanGetNumberInQueue() public {
		uint expected = 1;
		address userAddress = this;

		queueing.queue(userAddress);
		uint returnedLength = queueing.getNumberinQueue();

		Assert.equal(returnedLength, expected, "The length of the queue should be 1.");
	}

	function testCanGetUserAddress() public {
		address expectedAddress = this;
		address userAddress = this;

		queueing.queue(userAddress);
		address returnedAddress = queueing.getUserAddress(userAddress);

		Assert.equal(returnedAddress, expectedAddress, "The address should be part of the user.");
	}

	function testCanGetUserStartTime() public {
		uint notExpectedStartTime = 0;
		address userAddress = this;

		queueing.queue(userAddress);
		uint returnedStartTime = queueing.getUserStartTime(userAddress);

		Assert.notEqual(returnedStartTime, notExpectedStartTime, "The Start Time should be part of the user.");
	}

	function testCanGetUserEndTime() public {
		uint expectedEndTime = 0;
		address userAddress = this;

		queueing.queue(userAddress);
		uint returnedEndTime = queueing.getUserEndTime(userAddress);

		Assert.equal(returnedEndTime, expectedEndTime, "The End Time should be 0 before dequeued.");
	}

	function testUsreCanDequeue() public {
		uint expectedWaitTime = 0;
		address userAddress = this;
	
		queueing.queue(userAddress);
		uint actualWaitTime = queueing.deQueue(userAddress);
	
		Assert.equal(actualWaitTime, expectedWaitTime, "Dequeueing should return the time waited.");
	}

}