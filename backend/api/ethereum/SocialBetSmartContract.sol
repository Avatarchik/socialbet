pragma solidity ^0.5.1;
contract SocialBetContract {

   address payable public ownerAddress;

    struct Bet {
        address payable user1Address;
        address payable user2Address;
        bool accepted;
        uint256 amount;
        bool completed;
    }
    
    event createBetEvent(
       uint bet_id,
       uint256 amount
    );
    
    event acceptBetEvent(
       uint bet_id,
       uint256 amount
    );
    
    event distributeWinningsEvent(
       uint bet_id,
       uint8 winner
    );
    
    event fallBackEvent(
       string message
    );

    mapping(uint256 => Bet) public betInfo;
    uint256[] public betIds;


    function() external payable {
        emit fallBackEvent("wtf -- callback called");
    }

    // Smart contract constructor
    constructor() public payable {
        ownerAddress = msg.sender;
    }

    // Kill contract function
    function kill() public {
      if(msg.sender == ownerAddress) selfdestruct(ownerAddress);
    }

    // Check that bets exist function
    function checkBetExists(uint256 _betId) public
    returns(bool) {
        for(uint256 i = 0; i < betIds.length; i++ ) {
            if(betIds[i] == _betId) return true;
        }
      return false;

    }


    // Create bet function
    function createBet(uint256 _betId) public payable {

        // Make sure bet does not exist already
        require(!checkBetExists(_betId));

        // Create new bet
        betInfo[_betId].user1Address = msg.sender;
        betInfo[_betId].accepted = false;
        betInfo[_betId].amount = msg.value;
        betInfo[_betId].completed = false;

        betIds.push(_betId);
        
        emit createBetEvent(_betId, msg.value);
    }

    // Accept bet function
    function acceptBet(uint256 _betId) public payable {

        // Make sure bet exists
        require(checkBetExists(_betId));

        // Make sure bet is not yet accepted
        require(!betInfo[_betId].accepted);

        // Make sure bet not yet completed
        require(!betInfo[_betId].completed);

        // Make sure amount sent is right
        require(msg.value == betInfo[_betId].amount);

        // Update bet
        betInfo[_betId].user2Address = msg.sender;
        betInfo[_betId].accepted = true;

        betIds.push(_betId);
        
        emit acceptBetEvent(_betId, msg.value);
    }

    // Cancel bet function
    function cancelBet(uint256 _betId) public {

        // Make sure bet exists
        require(checkBetExists(_betId));

        // Make sure bet not yet completed
        require(!betInfo[_betId].completed);

        // Send money back to user1
        betInfo[_betId].user1Address.transfer(betInfo[_betId].amount * 97 / 100);

        // Send money back to user2
        if(betInfo[_betId].accepted) {
            betInfo[_betId].user2Address.transfer(betInfo[_betId].amount * 97 / 100);
        }

        // Set completed
        betInfo[_betId].completed = true;

    }

    // Distribute winnings function
    function distributeWinnings(uint256 _betId, uint8 _winner) public {

        // Make sure bet exists
        require(checkBetExists(_betId), "bet doesn't exist");

        // Make sure bet is accepted
        require(betInfo[_betId].accepted);

        // Make sure bet not yet completed
        require(!betInfo[_betId].completed);

        // Get winner address
        address payable winnerAddress;
        if(_winner == 1) {
            winnerAddress = betInfo[_betId].user1Address;
        } else {
            winnerAddress = betInfo[_betId].user2Address;
        }

        // Send winner money
        winnerAddress.transfer(betInfo[_betId].amount * 197 / 100);

        // Set completed
        betInfo[_betId].completed = true;

        emit distributeWinningsEvent(_betId, _winner);

    }

}

