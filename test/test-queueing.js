var Queueing = artifacts.require("Queueing");

contract('Queueing', function(accounts) {

	it("should queue a user", function() {
		console.log(accounts[0])
		return Queueing.deployed().then(function(instance) {
			return instance.queue.call(accounts[0]);
		}).then(function(queueReulst) {
			assert.equal(queueReulst.valueOf(), 1, "Testing the number in queue is 1.");
		});
	});

	it("should dequeue a user immediately", function() {
		var self = this;
		return Queueing.deployed().then(function(instance) {
			self.instance = instance;
			return self.instance.queue.call(accounts[0]);
		}).then(function(queueReulst) {
			return self.instance.deQueue.call(accounts[0]);
		}).then(function(deQueueResult) {
			assert.equal(deQueueResult.valueOf(), 0, "Testing the number in queue is 1.");
		});
	});

	it("should dequeue a user after 5 seconds", function() {
		var self = this;
		return Queueing.deployed().then(function(instance) {
			self.instance = instance;
			console.log(`Account ${accounts[0]}`)
			return self.instance.queue.call(accounts[0]);
		}).then(function(queueReulst) {
			var p = new Promise((resolve, reject) => { 
				setTimeout(() => {
					resolve();
				}, 5000);
			});
			return p;
		}).then(function(result) {
			console.log(`Account ${accounts[0]}`)
			return self.instance.deQueue.call(accounts[0]);
		}).then(function(deQueueResult) {
			console.log(`Account ${accounts[0]}`)
			assert.equal(deQueueResult.valueOf(), 5, "Testing the number in queue is 5.");
		});
	});
});