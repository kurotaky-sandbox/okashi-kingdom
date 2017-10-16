pragma solidity ^0.4.15;

import "contracts/Owned.sol";
import "contracts/Members.sol";

contract OkashiKingdomCoin is Owned {
  string public name;
  string public symbol;
  uint8 public decimals;
  uint256 public totalSupply;
  mapping (address => uint256) public balanceOf;
  mapping (address => int8) public blacklist;
  mapping (address => Members) public members;

  event Transfered(address indexed from, address indexed to, uint256 value);
  event Blacklisted(address indexed target);
  event Unblacklisted(address indexed target);
  event RejectedTransferToBlacklistedAccount(address indexed from, address indexed to, uint256 value);
  event RejectedTransferFromBlacklistedAccount(address indexed from, address indexed to, uint256 value);
  event Cashbacked(address indexed from, address indexed to, uint256 value);

  function OkashiKingdomCoin(uint256 _supply, string _name, string _symbol, uint8 _decimals) public {
    balanceOf[msg.sender] = _supply;
    name = _name;
    symbol = _symbol;
    decimals = _decimals;
    totalSupply = _supply;
  }

  function addToBlacklist(address _address) onlyOwner public {
    blacklist[_address] = 1;

    Blacklisted(_address);
  }

  function removeFromBlacklist(address _address) onlyOwner public {
    blacklist[_address] = -1;

    Unblacklisted(_address);
  }

  function setMembrers(Members _members) public {
    members[msg.sender] = Members(_members);
  }

  function transfer(address _to, uint256 _value) public {
    if (balanceOf[msg.sender] < _value) revert();
    if (balanceOf[_to] + _value < balanceOf[_to]) revert();

    if (blacklist[msg.sender] > 0) {
      RejectedTransferFromBlacklistedAccount(msg.sender, _to, _value);
      return;
    } else if (blacklist[_to] > 0) {
      RejectedTransferToBlacklistedAccount(msg.sender, _to, _value);
      return;
    }

    uint256 cashback = 0;

    if (members[_to] > address(0)) {
      cashback = _value / 100 * uint256(members[_to].getCashbackRate(msg.sender));
      members[_to].updateHistory(msg.sender, _value);
    }

    balanceOf[msg.sender] -= (_value - cashback);
    balanceOf[_to] += (_value - cashback);

    Transfered(msg.sender, _to, _value);
    Cashbacked(msg.sender, _to, cashback);
  }
}
