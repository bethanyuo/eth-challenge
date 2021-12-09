const { expect } = require( "chai" );
const { ethers } = require( "hardhat" );
const { MockProvider } = require( 'ethereum-waffle' );


describe( "Contribution", function () {
    let contract;

    const [wallet, walletTo] = new MockProvider().getWallets();

    const overrides = {
        gasLimit: 1000000000000000,
        value: ( ethers.utils.parseEther( "0" ) ).toNumber(),
    }

    beforeEach( async () => {
        const Contract = await ethers.getContractFactory( "Contribution" );
        contract = await Contract.deploy();
        await contract.deployed();
    } )

    it( "Should exchange ETH for tokens else revert", async () => {
        await expect( contract.exchange( walletTo.address, 10 ) ).to.be.reverted;
    } );

    it( "Should get all ETH sent by address", async () => {
        //expect( await contract.getBalance(walletTo.address) ).to.gt(0);
        expect( await contract.getBalance( walletTo.address ) ).to.equal( overrides.value );
    } );

    it( "Should  emit successful Auction event", async () => {
        await expect( contract.exchange( walletTo.address, 10) )
            .to.emit( contract, 'Auction' )
            .withArgs( wallet.address, overrides.value, 10 );
    } );

} );
