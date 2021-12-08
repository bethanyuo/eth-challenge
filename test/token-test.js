const { expect } = require( "chai" );
const { ethers } = require( "hardhat" );
const { time } = require( "@openzeppelin/test-helpers" )

describe( "NEWToken", function () {
    let startTime, endTime;


    // beforeEach(async () => {
    //     startTime = (await time.latest());
    //     endTime = (await time.latest()).add(time.duration.minutes(3));
    // })
   
    it( "Should transfer at starting time", async () => {
        const Token = await ethers.getContractFactory( "NEWToken" );
        const token = await Token.deploy();
        await token.deployed();
        //startTime = (await time.latest());
        // endTime = (await time.latest()).add(time.duration.minutes(3));

        expect( await token._startTime() ).to.equal( null );
        // expect(await token.transferr()).to.equal("Hello, world!");

        // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

        // // wait until the transaction is mined
        // await setGreetingTx.wait();

        // expect(await greeter.greet()).to.equal("Hola, mundo!");
    } );

    it( "Should stop transfer at ending time", async () => {
        const Token = await ethers.getContractFactory( "NEWToken" );
        const token = await Token.deploy();
        await token.deployed();
        // startTime = (await time.latest());
        // endTime = (await time.latest()).add(time.duration.minutes(3));

        // expect( await token._startTime ).to.equal( startTime );
        // expect(await token.transferr()).to.equal("Hello, world!");

        // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

        // // wait until the transaction is mined
        // await setGreetingTx.wait();

        // expect(await greeter.greet()).to.equal("Hola, mundo!");
    } );
} );
