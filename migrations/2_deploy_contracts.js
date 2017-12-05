var OkashiKingdomToken = artifacts.require("./OkashiKingdomToken.sol");

module.exports = function(deployer) {
  let initialSupply = 50000e18
  deployer.deploy(OkashiKingdomToken, initialSupply);
};
