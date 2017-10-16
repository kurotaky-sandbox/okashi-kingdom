var OkashiKingdomCoin = artifacts.require("./OkashiKingdomCoin.sol");
var Members = artifacts.require("./Members.sol");
var Owned = artifacts.require("./Owned.sol");

module.exports = function(deployer) {
  deployer.deploy(Owned);
  deployer.deploy(Members);
  deployer.deploy(OkashiKingdomCoin);
};
