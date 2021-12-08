const { expect } = require( "chai" );
const { ethers } = require( "hardhat" );
// const { time } = require( "@openzeppelin/test-helpers" )
const {deployContract, MockProvider, solidity} = require('ethereum-waffle');

describe( "NEWToken", function () {
    const [wallet, walletTo] = new MockProvider().getWallets();

    // beforeEach(async () => {
    //     startTime = (await time.latest());
    //     endTime = (await time.latest()).add(time.duration.minutes(3));
    // })
   
    it( "Should transfer at starting time", async () => {
        const Token = await ethers.getContractFactory( "NEWToken" );
        const token = await Token.deploy();
        await token.deployed();
        expect( await token.hasStarted() ).to.equal( true );
        expect( await token.hasEnded() ).to.equal( false );

        const transferTkns = await token.transferr(walletTo.address, 1);
        await transferTkns.wait();
    
        expect(await token.balanceOf(walletTo.address)).to.gte(1);
        expect(await token.balanceOf(token.owner())).to.equal(999);
    } );

    it( "Should stop transfer at ending time", async () => {
        const Token = await ethers.getContractFactory( "NEWToken" );
        const token = await Token.deploy();
        await token.deployed();
        const _closed = await token.hasEnded();

        if (_closed) {
            await expect(token.transferr(walletTo.address, 5)).to.be.revertedWith('Contribution Time is now closed');
        }
    } );
} );
