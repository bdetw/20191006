pragma solidity >=0.4.22 <0.6.0;

contract ScavengerHunt {
    
    event LocationUnlocked(
        address hunter,
        string location
    );
    
    struct Hunter {
        mapping (string => bool) unlockedLocations;
    }
    
    mapping(address => Hunter) hunters;
    mapping (address => uint256) private _balances;
    
    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }
    
    function hasUnlockedLocation(address hunterAddress, string memory location) public view returns (bool) {
        return hunters[hunterAddress].unlockedLocations[location];
    }

    function unlockLocation(string memory location) public {
        Hunter storage hunter = hunters[msg.sender];
        if (hunter.unlockedLocations[location]) return;
        
        hunter.unlockedLocations[location] = true;
        _balances[msg.sender] += 1;
        emit LocationUnlocked(msg.sender, location);
    } 
}
