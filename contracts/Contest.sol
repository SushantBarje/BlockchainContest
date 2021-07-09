pragma solidity >=0.4.0;

contract Contest {

	//Creating structure to model the contestant
	struct Contestant {
		uint id;
		string name;
		uint voteCount;
	}

	constructor () public {
		addContestant("Tom");
		addContestant("Jerry");
	}

	/**
	 * use mapping to get or fetch the contestant details
	 * this is like 
	 * contestant[1] => 1,tom,0
	 * contestant[2] => 2,jerry,0
	 * */
	mapping(uint => Contestant) public contestants;

	/**
	* 	Public state variable to keep track of contestant count
	* 	in other language we can find the length of contestants by len(contestants)
	* 	but in blockchain this will return 
	* 	contanstant[?] = "0,"",0
	* 	So we have to keep track of contestants when the are added.
	* */
	uint public contestantsCount;

	/**
	 * Function to add Contestant
	 * */
	function addContestant (string memory _name) private {
		contestantsCount++;
		contestants[contestantsCount] = Contestant(contestantsCount, _name, 0);
	}
}