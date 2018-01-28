var Queueing = artifacts.require("Queueing");

module.exports = function(deployer) {
  deployer.deploy(Queueing);
};