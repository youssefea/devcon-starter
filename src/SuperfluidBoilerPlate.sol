// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import {SuperTokenV1Library} from "@superfluid-finance/ethereum-contracts/contracts/apps/SuperTokenV1Library.sol";
import {ISuperToken} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
import {ISETH} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/tokens/ISETH.sol";
import {ISuperfluidPool, PoolConfig} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol";

contract SuperfluidBoilerPlate {
    address public owner;
    uint256 public constant FEE = 5;
    using SuperTokenV1Library for ISETH;
    ISuperfluidPool public pool;
    ISETH public acceptedToken;
    PoolConfig private poolConfig;

    modifier onlyOwner(){
        require(owner==msg.sender,"Only Owner");
        _;
    }
    
    constructor(address _acceptedToken) {
        owner = msg.sender;
        acceptedToken = ISETH(_acceptedToken);
        poolConfig.transferabilityForUnitsOwner = false;
        poolConfig.distributionFromAnyAddress = false;
        pool = acceptedToken.createPool(address(this), poolConfig);
    }

    function createUpdateDeleteFlow(address _receiver, uint256 _flowRate) external onlyOwner {
        acceptedToken.createFlow(address(this), _receiver, _flowRate, new bytes(0));
        acceptedToken.updateFlow(address(this), _receiver, _flowRate, new bytes(0));
        acceptedToken.deleteFlow(address(this), _receiver, _flowRate, new bytes(0));
    }
    
    function instantlyDistribute() external payable onlyOwner  {
        uint256 _amount = msg.value;
        uint256 _amountDistribute = (_amount*95)/100;
        acceptedToken.upgradeByETH{value:_amountDistribute}();
        acceptedToken.distribute(address(this),pool,_amountDistribute);
    }
  
    function giveUnits(address[] memory _members,uint128[] memory _giveUnits) external onlyOwner {
        for(uint256 i=0;i<_members.length;i++){
            pool.updateMemberUnits(_members[i],_giveUnits[i]);
        }
    }

    function deleteMemberFromPool(address[] memory _members) external onlyOwner {
        for(uint256 i=0;i<_members.length;i++){
            pool.updateMemberUnits(_members[i],0);
        }
    }
 
}