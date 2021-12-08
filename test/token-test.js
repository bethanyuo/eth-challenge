const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NEWToken", function () {
  it("Should transfer tokens during set timeframe", async function () {
    const Token = await ethers.getContractFactory("NEWToken");
    const token = await Token.deploy();
    await token.deployed();

    expect(await token._startTime).to.equal(block.timestamp);
    // expect(await token.transferr()).to.equal("Hello, world!");

    // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // // wait until the transaction is mined
    // await setGreetingTx.wait();

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
