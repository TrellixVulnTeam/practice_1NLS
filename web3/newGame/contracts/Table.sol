pragma solidity ^0.4.0;

contract Table {
    struct Player {
        address player;
        uint value;
    }
    
    Player[] public players;
    uint public minimumBet;
    uint public maxPlayers = 2;
    mapping(address => bool) public availablePlayers;
    
    function Table(uint minimum) public payable {
        minimumBet = minimum;
        enterTable();
    }
    
    modifier restricted() {
        require(players.length < maxPlayers);
        _;
    }
    
    function getTotalPlayers() public view returns(uint) {
        return players.length;
    }
    
    function enterTable() public restricted payable {
        require(msg.value >= minimumBet);
        require(!availablePlayers[msg.sender]);
        
        availablePlayers[msg.sender] = true;
        Player memory newPlayer = Player({
            player: msg.sender,
            value: msg.value
        });
        
        players.push(newPlayer);
    }
}