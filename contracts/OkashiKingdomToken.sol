pragma solidity ^0.4.18;
import "zeppelin-solidity/contracts/token/StandardToken.sol";

contract OkashiKingdomToken is StandardToken {
  string public name = "OkashiKingdomToken";
  string public symbol = "OKT";
  uint public decimals = 18;

  function OkashiKingdomToken(uint initialSupply) public {
    totalSupply = initialSupply;
    balances[msg.sender] = initialSupply;
  }
}
