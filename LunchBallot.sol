pragma solidity >=0.4.22 <0.6.0;

contract LunchBallot {
    
    event VoteCast(
        uint8 vote
    );

    struct Voter {
        bool voted;
        uint8 vote;
    }
    
    struct Proposal {
        uint voteCount;
    }

    address ballotCreator;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    /// Create a new lunch ballot with $(_numProposals) different proposals.
    constructor(uint8 _numProposals) public {
        ballotCreator = msg.sender;
        proposals.length = _numProposals;
    }

    /// Give a single vote to proposal $(toProposal).
    function vote(uint8 toProposal) public {
        Voter storage sender = voters[msg.sender];
        if (sender.voted || toProposal >= proposals.length) return;
        sender.voted = true;
        sender.vote = toProposal;
        emit VoteCast(toProposal);
        proposals[toProposal].voteCount += 1;
    } 

    function winningProposal() public view returns (uint8 _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++)
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
    }
}
