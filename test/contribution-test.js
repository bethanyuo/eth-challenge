const { expect } = require( "chai" );
const { ethers } = require( "hardhat" );
const { time, BN } = require( "@openzeppelin/test-helpers" )
const { deployContract, MockProvider, solidity } = require( 'ethereum-waffle' );


describe( "Contribution", function () {
    const [wallet, walletTo] = new MockProvider().getWallets();

    // beforeEach(async () => {
    //     startTime = (await time.latest());
    //     endTime = (await time.latest()).add(time.duration.minutes(3));
    // })

    it( "Should exchange ETH for tokens else revert", async () => {
        const Contract = await ethers.getContractFactory( "Contribution" );
        const contract = await Contract.deploy();
        await contract.deployed();
        const overrides = {
            gasLimit: 1000000000000000,
            value: (ethers.utils.parseEther("0.00001")).toNumber(),
          }
        //const val = 100000000000000;
         //await contract.exchange( walletTo.address, 1 ).value(val).gas(100000000000000)(0);
        //expect( await contract.exchange(walletTo.address, 10 [overrides.gasLimit, overrides.value])).to.equal(true);
        expect( await contract.exchange(walletTo.address, 10, {value: overrides.value })).to.equal(true);
        //  await expect(contract.exchange(walletTo.address, 10)).to.be.revertedWith('Insufficient funds');
        // await expect(() => contract.exchange( walletTo.address, 1 ).sendTransaction({to: walletTo.address, value: 200}))
        //     .to.changeEtherBalance(walletTo, 200);
        //expect( await contract.balanceOf( walletTo.address ) ).to.gte( 1 );
       //  expect (await transfer.wait()).to.equal( true );
    } );

    it( "Should get all ETH sent by address", async () => {
        const Contract = await ethers.getContractFactory( "Contribution" );
        const contract = await Contract.deploy();
        await contract.deployed();
        expect( await contract.getBalance(walletTo.address) ).to.gt(0);
    } );

} );
