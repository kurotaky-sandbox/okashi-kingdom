pragma solidity ^0.4.18;
import "zeppelin-solidity/contracts/token/MintableToken.sol";

contract OkashiKingdomToken is MintableToken {
  string public name = "OkashiKingdomToken";
  string public symbol = "OKT";
  uint256 public decimals = 18;
}
