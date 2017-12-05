pragma solidity ^0.4.18;

import './OkashiKingdomToken.sol';
import 'zeppelin-solidity/contracts/crowdsale/Crowdsale.sol';

contract OkashiKingdomTokenCrowdsale is Crowdsale {

  function OkashiKingdomTokenCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet)
    Crowdsale(_startTime, _endTime, _rate, _wallet) {
  }

  // creates the token to be sold.
  // override this method to have crowdsale of a specific MintableToken token.
  function createTokenContract() internal returns (MintableToken) {
    return new OkashiKingdomToken();
  }
}
