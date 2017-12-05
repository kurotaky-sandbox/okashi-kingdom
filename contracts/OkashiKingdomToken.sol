pragma solidity ^0.4.18;
import "zeppelin-solidity/contracts/token/MintableToken.sol";

contract OkashiKingdomToken is MintableToken {
  string public name = "OkashiKingdomToken";
  string public symbol = "OKT";
  uint public decimals = 18;

  function OkashiKingdomToken(uint initialSupply) public {
    totalSupply = initialSupply;
    balances[msg.sender] = initialSupply;
  }
}
