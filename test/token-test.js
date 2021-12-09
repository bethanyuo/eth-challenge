const { expect } = require( "chai" );
const { ethers } = require( "hardhat" );
const { time, BN } = require( "@openzeppelin/test-helpers" )
const { deployContract, MockProvider, solidity } = require( 'ethereum-waffle' );
//const { BN } = require( "bn.js" );

describe( "NEWToken", function () {
    // let currTime = Math.floor(Date.now() / 1000)
    let token, currTime;
    const [wallet, walletTo] = new MockProvider().getWallets();

    beforeEach(async () => {
        const Token = await ethers.getContractFactory( "NEWToken" );
        token = await Token.deploy();
        await token.deployed();
        currTime = new BN( await time.latest() );
    })

    it( "Should transfer tokens at starting time", async () => {
        expect( await token.hasStarted() ).to.equal( true );
        expect( await token.hasEnded() ).to.equal( false );
        expect( await token._endTime() ).to.gte( currTime.toNumber() );
        const transferTkns = await token.transferr( walletTo.address, 1 );
        await transferTkns.wait();

        expect( await token.balanceOf( walletTo.address ) ).to.gte( 1 );
        expect( await token.balanceOf( token.owner() ) ).to.equal( 999 );
    } );

    //const delay = ms => new Promise( res => setTimeout( res, ms ) );
    it( "Should stop token transfers at ending time", async () => {
//        setTimeout( 180000 );
        // const _closed = await token.timeCheck();
        // expect( _closed ).to.equal( true );
        //const currTime = new BN( await time.latest() );
        expect( await token._endTime() ).to.lte( currTime.toNumber() );
        await expect( token.transferr( walletTo.address, 5 ) ).to.be.revertedWith( 'Contribution Time is now closed' );
    } );

    it( "Should emit successful Transfers event", async () => {
        await expect( token.transferr( walletTo.address, 10 ) )
            .to.emit( token, 'Transfers' )
            .withArgs( walletTo.address, 10 );
    } );

} );
