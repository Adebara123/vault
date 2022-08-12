// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;


contract vault {
    // A contract where the owner creates grant for a beneficiary ;
    // Allows beneficiary to withdraw only when time elapse
    // Allows owner to withdraw before the elapse
    // information of a beneficiary
    // amount of ethers in the smart contract 

    //******************** state variables ************/

    address owner;

    struct BeneficiaryProperties{
        uint amountAllowcated;
        address beneficiary;
        uint time;
        bool status;
    }
    uint ID = 1;
    
    modifier onlyOwner () {
        require(msg.sender == owner, "not owner");
        _;
   
    }

    modifier hasTimeElapse (uint _id) {
         BeneficiaryProperties memory BP = _beneficiaryProperties[_id];
         require(BP.time <= block.timestamp, "Chill, not yet time");
          _;
    }

    uint[] id;
    BeneficiaryProperties[] public bp;
    
    mapping (uint => BeneficiaryProperties) _beneficiaryProperties;

    constructor (){
        owner = msg.sender;
    }



    function createGrant(address _beneficiary, uint _time) external payable  returns (uint){
          // assigning a struct to a veriable in mapping
        BeneficiaryProperties storage BP = _beneficiaryProperties[ID];
        require(msg.value > 0, "Zero ether not allowed");
        BP.amountAllowcated = msg.value;
        BP.beneficiary = _beneficiary;
        BP.time = _time + block.timestamp;
        // this is to keep track of the diffferent people that already recieved the grant
        uint _id = ID;  
        id.push(_id);
        bp.push(BP);
        ID++;

        return _id;
        
    }


    function withdraw(uint _id, uint withdrawAmount) external hasTimeElapse(_id) {
      
        BeneficiaryProperties storage BP = _beneficiaryProperties[_id];
        address user = BP.beneficiary;
        uint _amount = BP.amountAllowcated;
        require(user == msg.sender, "Not a beneficiary for a grant");
        require(_amount > 0, "You can withdra less than 0");
        require(_amount >= withdrawAmount, "You have less than you want to withdraw");
        
        uint getbal = getBalance();
        require(getbal >= _amount, "you dnt have money");
        BP.amountAllowcated = _amount - withdrawAmount;
        payable(user).transfer(withdrawAmount);
    }


    function RevertGrant(uint _id) external onlyOwner {
    
        BeneficiaryProperties storage BP = _beneficiaryProperties[_id];
        uint _amount = BP.amountAllowcated;
         BP.amountAllowcated = 0;
      //  payable(owner).transfer(_amount);   
        (bool sent,) = payable(owner).call{value: _amount}("");   
        require(sent, "eth not sent");
    }

     
    function returnBeneficiaryInfo(uint _id) external view returns(BeneficiaryProperties memory) {      
        return _beneficiaryProperties[_id];
    
    }

    function getBalance() public view returns (uint256 bal) {
        //checking the balance in the contract
        bal = address(this).balance;
    }


    function getAllBeneficiary() external view returns(BeneficiaryProperties[] memory _bp){
    uint[] memory all = id;
    _bp = new BeneficiaryProperties[](all.length);

    for(uint i = 0; i < all.length; i++){
        _bp[i]=_beneficiaryProperties[all[i]];
      }
    }


}