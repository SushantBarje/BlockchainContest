var Contest = artifacts.require("./Contest.sol");

contract("Contest", function(accounts){

	it("initializes with two contestants", function(){
		return Contest.deployed().then(function(instance){
			return instance.contestantsCount();
		}).then(function(count) {
			assert.equal(count, 2);
		});
	});

	it("initializes the contestants with correct value", function(){
		return Contest.deployed().then(function(instance){
			contestantInstance = instance;
			return contestantInstance.contestants(1);
		}).then(function(contestant){
			assert.equal(contestant[0], 1, "contains the correctid");
			assert.equal(contestant[1], "Tom", "contains correct the name");
			assert.equal(contestant[2], 0, "contains the correct votes count");
			return contestantInstance.contestants(2);
		}).then(function(contestant) {
			assert.equal(contestant[0], 2, "contains the correctid");
			assert.equal(contestant[1], "Jerry", "contains correct the name");
			assert.equal(contestant[2], 0, "contains the correct votes count");
		})
	})

	it("allows a voter to cast a vote", function(){
		return Contest.deployed().then(function(instance){
			contestInstance = instance;
			contestantId = 2;
			return contestInstance.vote(contestantId, { from : accounts[0] });
		}).then(function(receipt) {
			return contestInstance.voters(accounts[0]);
		}).then(function(voted){
			assert(voted, 'the voter was marked as voted');
			return contestInstance.contestants(contestantId);
		}).then(function(contestant){
			var voterCount = contestant[2];
			assert.equal(voterCount, 1, "increments the contestant's vote cound")
		})
	})
});