const CandleAuction = artifacts.require("CandleAuction");


module.exports = async function (deployer, network, accounts) {
  // accounts[0] will be used as the from address
  await deployer.deploy(CandleAuction, { from: accounts[0] });
};
