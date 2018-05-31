pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';
import './MirailaDiamondBase.sol';
import './MirailaCoreBase.sol';

contract MirailaDiamond is MirailaDataAccess{
    
    MirailaEnergyBase mirailaEnergyBase;
    MirailaDiamondBase mirailaDiamondBase;
    MirailaCoreBase mirailaCoreBase;
    
    function MirailaDiamond(address energy_add, address user_add, address diamond_add){
        mirailaEnergyBase = MirailaEnergyBase(energy_add);
        mirailaCoreBase = MirailaCoreBase(user_add);
        mirailaDiamondBase = MirailaDiamondBase(diamond_add);
    }
    
    // get all user
    // function lookUser() public returns (uint256) {
    //   return mirailaCoreBase.getUser();
    // }
    
    // // get all energy
    // function lookEnergy() public returns (uint256) {
    //   return mirailaEnergyBase.getEnergy();
    // }
    

    // user first login
    function firstLogin(address _useradd) onlyOperator {
       mirailaDiamondBase.setLastTime(_useradd, now);
    }

    // load Diamond
    function loadDiamond(address _useradd) onlyOperator returns (uint256){
        uint lastTime = mirailaDiamondBase.lastTimeOf(_useradd);
        uint count = (now - lastime)/ 7200;
        uint lastDiamond = mirailaDiamondBase.lastDiamondOf(_useradd);
        if (count > 24){
          return lastDiamond*24;
        }
        return lastDiamond*count;
    }
    
    // process user diamond
    function inDiamond(address _useradd) onlyOperator {
       if (mirailaCoreBase.getUser() < 66666){
           uint256 _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*mirailaCoreBase.getUser()/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _userDiamond);
           mirailaDiamondBase.setLastTime(_useradd, now);
           mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
       }
       if (mirailaCoreBase.getUser() >= 66666){
           uint256 _userDiamond =  10**18*mirailaEnergyBase.balanceOf(_useradd)*66666/mirailaEnergyBase.getEnergy();
           mirailaDiamondBase.setdiamond(_useradd, mirailaDiamondBase.diamondOf(_useradd) + _userDiamond);
           mirailaDiamondBase.setLastTime(_useradd, now);
           mirailaDiamondBase.setLastDiamond(_useradd, _userDiamond);
       }
    }

}