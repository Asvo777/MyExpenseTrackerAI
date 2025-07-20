// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Crowdfunding {
    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string img;
        address[] donators;
        uint256[] donations;
    } 

    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0;

    function createCampaign(address _owner, stirng memeory _title, stirng memory _description, uint256 _target, uint256 _deadline, string memory _img) public returns (uint256) {
        Campaign storage campaign = campaigns[numberOfCampaigns];

        //Is everything good ?
        require(campaign.deadline < block.timestamp, "Deadline passed");

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.img = _img

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }
    
    function donateToCampaign(uint256 _id) public payable {
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];

        campaign.donators.push(msg.sender);
        campaigns.donations.push(amount);

        (bool sent, ) = payable(campaign.owner).call{value: amount}("");

        if(sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    }
    
    function getDonators(uint256 _id) view public returns (address[] memory, uint256) {
        
    }
    
    function getCampaigns() {}
}