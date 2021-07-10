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

	//to save the list of voters already voted.
	mapping(address => bool) public voters;
	/**
	* 	Public state variable to keep track of contestant count
	* 	in other language we can find the length of contestants by len(contestants)
	* 	but in blockchain this will return 
	* 	contanstant[?] = "0,"",0
	* 	So we have to keep track of contestants when the are added.
	* */
	uint public contestantsCount;

	event votedEvent(
		uint indexed _contestantId
	);

	/**
	 * Function to add Contestant
	 * */
	function addContestant (string memory _name) private {
		contestantsCount++;
		contestants[contestantsCount] = Contestant(contestantsCount, _name, 0);
	}


	function vote(uint _contestantId) public {

		require(!voters[msg.sender]);

		require(_contestantId > 0 && _contestantId <= contestantsCount);

		//increase the vote count of particular contestant
		contestants[_contestantId].voteCount++;

		//set the voter voted status to true.
		voters[msg.sender] = true;

		emit votedEvent(_contestantId);
	}
}