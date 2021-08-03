
pragma solidity >=0.5.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor ()  { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

pragma solidity ^0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor ()  {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

pragma solidity ^0.8.0;

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented, decremented or reset. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 */
library Counters {
    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1;
        }
    }

    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1;
        }
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}

// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract devtrust is Ownable{
    using Counters for Counters.Counter;
     Counters.Counter private _dealIDs;
    enum dealStatus {
        pending,
        processing,
        submitted,
        reverted,
        closed,
        confirmed,
        rejected,
        validation,
        excalated,
        completed
    }
    struct deal {
      uint256 dealID;
      uint256 stackedAmount;
      bool devAccepted;
      address client;
      address dev;
      string contractUrl;
      dealStatus status;
      uint256 activeSubmission;
    }
    struct dealdata {
      uint256 extentionTime;
      uint256 maxExtention;
      uint256 dealTime;
      uint256 dealEndTime;
      uint256  extentionCount;
      uint256 categoryID;
    }
    struct submission{
        string submissionUrl;
        address submitter;
        bool accept;
        bool isSet;
    }
    struct category {
        string name;
        bool active;
        uint256 requiredValidators;
        
    }
    struct dealValidation {
        uint256 devVotes;
        uint256 clientVotes;
        uint256 votes;
    }
    
    mapping(address => bool) public isGovernance;
    
    uint256[] public categoryIDs;
    mapping(uint256 => category) public categories;
    uint256 public fees = 50;
    uint256 public collectedFees;
    uint256 minStake = 100000000000000000;
    mapping(bytes32 => address[]) public dealValidators;
    mapping(bytes32 => uint256[] ) public submitionIDs;
    mapping(bytes32 => deal) public deals;
    mapping(bytes32 => dealdata) public dealdatas;
    mapping(bytes32 => mapping(uint256 => submission)) public dealSubmissions;
    mapping(bytes32 => mapping(address => bool)) public isDealValidator;
    
    mapping(uint256 => address[]) public categoryValidators;
    mapping(address => bool) public isValidator;
    mapping(bytes32 => mapping(address => bool)) hasVoted;
    uint256 public nounce;
    modifier onlyDev(bytes32 dealID) {
        require(deals[dealID].dev == msg.sender , "only deal dev can call this function");
        _;
    }
    modifier onlyClient(bytes32 dealID) {
        require(deals[dealID].client == msg.sender , "only deal client can call this function");
        _;
    }
    function addCategory(string memory name , uint256 requiredValidators  ) public onlyOwner returns(uint256){
        uint256 categoryID = categoryIDs.length;
        categoryIDs.push(categoryID);
        categories[categoryID] = category(name , true, requiredValidators);
        return categoryID;
    }
    function addValidators(uint256 categoryID , address[] memory validators) public onlyOwner {
        for(uint256 index; index < validators.length ; index++){
            if(!isValidator[validators[index]]){
                isValidator[validators[index]] = true;
                categoryValidators[categoryID].push(validators[index]);
            }
        }
    }
    function registerDeal(
    string memory _contractUrl,
    address dev,
    uint256 categoryID,
    uint256 amount, 
    uint256 dealTime, 
    uint256 extentionTime,
    uint256 maxExtention ) public payable  returns(bytes32){
       _dealIDs.increment(); 
       require(processedPayment(amount) , "insuficient funds");
       require(categories[categoryID].active , "not active category");
       
       amount = deductFees(amount);
       bytes32 currentDealID = keccak256(
                                        abi.encodePacked(_dealIDs.current(), msg.sender)
                                    );
       deal storage newDeal = deals[currentDealID];
       dealdata storage newDealData = dealdatas[currentDealID];
       newDeal.dealID = _dealIDs.current();
       newDealData.extentionTime = extentionTime;
       newDealData.maxExtention = maxExtention;
       newDealData.dealTime = dealTime;
       newDealData.categoryID = categoryID;
       newDeal.stackedAmount = amount;
       newDeal.client = msg.sender;
       newDeal.dev = dev;
       newDeal.contractUrl = _contractUrl;
       newDeal.status = dealStatus.pending;
        return currentDealID;
        
}
function acceptDeal(bytes32 dealID) public onlyDev(dealID) {
    require(!deals[dealID].devAccepted , "deal already accepted");
    deals[dealID].devAccepted = true;
   dealdatas[dealID].dealEndTime = block.timestamp + (dealdatas[dealID].dealTime * 1 hours);
   deals[dealID].status = dealStatus.processing;
  
}
function cancelDeal(bytes32 dealID) public onlyClient(dealID){
  require(deals[dealID].status == dealStatus.pending,"deal not pending");  
  payable(deals[dealID].client).transfer(deals[dealID].stackedAmount);
    deals[dealID].status = dealStatus.reverted;
}
function withdrawDeal(bytes32 dealID) public onlyClient(dealID) {
    require(deals[dealID].status == dealStatus.processing,"deal not processing");
    require(dealdatas[dealID].dealEndTime >= block.timestamp , "deal time not exceeded");
    
    payable(deals[dealID].client).transfer(deals[dealID].stackedAmount);
    deals[dealID].status = dealStatus.reverted;
     
}
function addSubmition(bytes32 dealID ,string memory submisionUrl) public onlyDev(dealID){
      require(deals[dealID].status == dealStatus.processing ,"deal not processing");
      uint256 submitionID  = submitionIDs[dealID].length;
   
      submission storage newSubmission = dealSubmissions[dealID][submitionID];
      newSubmission.submissionUrl = submisionUrl;
      newSubmission.isSet = true;
      newSubmission.submitter = deals[dealID].dev;
      deals[dealID].activeSubmission = submitionID;
      submitionIDs[dealID].push(submitionID);
      deals[dealID].status = dealStatus.submitted;
      if(dealdatas[dealID].dealEndTime > block.timestamp){
      dealdatas[dealID].dealEndTime = (dealdatas[dealID].dealEndTime - block.timestamp) + (block.timestamp + (dealdatas[dealID].extentionTime * 1 hours));
      }else{
       dealdatas[dealID].dealEndTime =  block.timestamp + (dealdatas[dealID].extentionTime * 1 hours);
      }
      
      
}
function devCloseDeal(bytes32 dealID ) public onlyDev(dealID) {
      require(deals[dealID].status == dealStatus.submitted ,"not in submitted state");
      require(dealdatas[dealID].dealEndTime >= block.timestamp , "deal time not exceeded");
       payable(deals[dealID].dev).transfer(deals[dealID].stackedAmount);
       deals[dealID].status = dealStatus.closed;
}
function confirmSubmission(bytes32 dealID) public onlyClient(dealID) {
   require(deals[dealID].status == dealStatus.submitted ,"not in submitted state");
   payable(deals[dealID].dev).transfer(deals[dealID].stackedAmount);
   deals[dealID].status = dealStatus.confirmed;
}

function rejectSubmission(bytes32 dealID , string memory submisionUrl ) public onlyClient(dealID) {
    require(deals[dealID].status == dealStatus.submitted ,"not in submitted state");
      uint256 submitionID  =  submitionIDs[dealID].length;
      submission storage newSubmission = dealSubmissions[dealID][submitionID];
      newSubmission.submissionUrl = submisionUrl;
      newSubmission.isSet = true;
      newSubmission.submitter = deals[dealID].client;
      deals[dealID].activeSubmission = submitionID;
      submitionIDs[dealID].push(submitionID);
      deals[dealID].status = dealStatus.submitted;
    if( dealdatas[dealID].extentionCount >= dealdatas[dealID].maxExtention){
      deals[dealID].status = dealStatus.rejected;  
     involveValidators(dealID);
    }
    else{
        dealdatas[dealID].extentionCount ++;
        deals[dealID].status = dealStatus.processing;
        if(dealdatas[dealID].dealEndTime > block.timestamp){
         dealdatas[dealID].dealEndTime = (dealdatas[dealID].dealEndTime - block.timestamp) + (block.timestamp + (dealdatas[dealID].extentionTime * 1 hours));
          }else{
           dealdatas[dealID].dealEndTime =  block.timestamp + (dealdatas[dealID].extentionTime * 1 hours);
          }
    }
   
}
function involveValidators(bytes32 dealID) private {
   uint256 dealCategoryID = dealdatas[dealID].categoryID;
   uint256 RequiredValidatorCount =  categories[dealCategoryID].requiredValidators;
   uint256 availableValidator =  categoryValidators[dealCategoryID].length;
 
   if(availableValidator >= RequiredValidatorCount){
    
            for(uint256 index ; index < dealValidators[dealID].length ; index++){
            dealValidators[dealID].pop();
           }     
       
         while(dealValidators[dealID].length < RequiredValidatorCount){
             nounce++;
              uint256  randomnumber  = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender , nounce ))) % categoryValidators[dealCategoryID].length;
                  
                if(!inarray( dealValidators[dealID]  , categoryValidators[dealCategoryID][randomnumber])){
                  dealValidators[dealID].push(categoryValidators[dealCategoryID][randomnumber]);  
                }
             }
       deals[dealID].status = dealStatus.validation;
        if(dealdatas[dealID].dealEndTime > block.timestamp){
         dealdatas[dealID].dealEndTime = (dealdatas[dealID].dealEndTime - block.timestamp) + (block.timestamp + (dealdatas[dealID].extentionTime * 1 hours));
          }else{
           dealdatas[dealID].dealEndTime =  block.timestamp + (dealdatas[dealID].extentionTime * 1 hours);
          }   
   }
else{
    deals[dealID].status = dealStatus.excalated;
}



}
 function inarray( address[] memory vals , address value) private pure returns(bool){
    
        for(uint256 index ; index < vals.length ; index++){
            if(vals[index] == value){
                return true;
            }
        }
        return false;
    }
function excalateDeal(bytes32 dealID) public {
 require(deals[dealID].status == dealStatus.validation ,"not in validation state");
 require(_msgSender() == deals[dealID].dev || _msgSender() == deals[dealID].client , "only client or dev can make this call");
 require(dealdatas[dealID].dealEndTime < block.timestamp , "validitors still has time");
 deals[dealID].status = dealStatus.excalated; 
}
// internal fxn used to process incoming payments 
    function processedPayment( uint256 amount ) internal returns (bool) {
        require(amount > minStake ,"amount bellow minimum allow amount");
            if(msg.value >= amount) return true;
            return false; 
    }
// internal fxn for deducting and remitting fees after a sale
    function deductFees( uint256 amount) internal returns (uint256) {
       
         if(fees > 0){
          uint256 fees_to_deduct = amount * fees / 1000;
          collectedFees += fees_to_deduct;
       
          return amount - fees_to_deduct;
          
         }else {
             return amount;
         }
    }
}

// ["0xdD870fA1b7C4700F2BD7f44238821C26f7392148" , "0x583031D1113aD414F02576BD6afaBfb302140225" , "0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB" , "0x0A098Eda01Ce92ff4A4CCb7A4fFFb5A43EBC70DC" , "0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7" ,"0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C"]
    