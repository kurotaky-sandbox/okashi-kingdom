var OkashiKingdomTokenCrowdsale = artifacts.require("./OkashiKingdomTokenCrowdsale.sol");

module.exports = function(deployer, network, accounts) {
  const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 1
  const endTime = startTime + (86400 * 20)
  const rate = new web3.BigNumber(1000)
  const wallet = accounts[0]

  deployer.deploy(OkashiKingdomTokenCrowdsale, startTime, endTime, rate, wallet)
};
