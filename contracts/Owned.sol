pragma solidity ^0.4.15;

contract Owned {
  address public owner;

  event OwnershipTransfered(address old_owner, address new_owner);

  modifier onlyOwner() { if (msg.sender != owner) revert(); _; }

  function Owned() public {
    owner = msg.sender;
  }

  function transferOwnership(address _new_owner) onlyOwner public {
    address old_owner = owner;
    owner = _new_owner;

    OwnershipTransfered(old_owner, _new_owner);
  }
}
