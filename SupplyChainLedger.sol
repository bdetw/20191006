pragma solidity >=0.4.22 <0.6.0;

contract SupplyChainLedger {
    
    event EventRecorded(
        string eventType,
        string eventDescription
    );
    
    struct Event {
        string eventType;
        string eventDescription;
    }
    
    address manager;
    mapping(address => Event[]) events;
    mapping(address => bool) permissionedSources;
    
    /// Create a supply chain
    constructor() public {
        manager = msg.sender;
    }
    
    function permissionSource(address sourceAddress) public {
        if (msg.sender != manager) return;
        permissionedSources[sourceAddress] = true;
    }
    
    function doesSourceHavePermission(address sourceAddress) public view returns (bool) {
        return permissionedSources[sourceAddress];
    }

    function reportEvent(string memory _eventType, string memory _eventDescription) public {
        if (permissionedSources[msg.sender]) return;
        
        events[msg.sender].push(Event({
                eventType: _eventType,
                eventDescription: _eventDescription
            }));
        
        emit EventRecorded(_eventType, _eventDescription);
    } 
}
