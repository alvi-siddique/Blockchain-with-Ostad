const { expect } = require("chai");

describe("MyContract", function () {
    it("Should set and get the state variable", async function () {
        const MyContract = await ethers.getContractFactory("MyContract");
        const myContract = await MyContract.deploy();
        await myContract.deployed();

        // Get initial state
        expect(await myContract.getState()).to.equal(0);

        // Set a new state (onlyOwner)
        await myContract.setState(42);

        // Check if the new state was set correctly
        expect(await myContract.getState()).to.equal(42);
    });
});
