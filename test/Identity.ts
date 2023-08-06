import { expect } from 'chai'
import { ethers } from 'hardhat'
import { Identity } from '../typechain-types'

let contract: Identity

before(async () => {
  const fee = ethers.parseEther('1')
  contract = await ethers.deployContract('Identity', [fee])
})

describe('Identity - create', () => {
  it('should fail with Insufficient funds.', async () => {
    await expect(contract.create('test', 'pfp')).to.be.revertedWith('Insufficient funds to create a Profile.')
  })

  it('should create an Identity', () => {
    const tx = contract.create('test', 'pfp', { value: ethers.parseEther('5') })
    expect(tx).to.not.be.reverted
    expect(tx).to.emit(contract, 'NewIdentity')
  })

  it('should fail it the sender already has a profile', async () => {
    await expect(contract.create('test', 'pfp', { value: ethers.parseEther('5') })).to.be.revertedWith('Profile already exists for this wallet.')
  })

  it('should fail if the handle is already taken', async () => {
    const [, acc] = await ethers.getSigners()
    await expect(contract.connect(acc).create('test', 'pfp', { value: ethers.parseEther('5') })).to.be.revertedWith('Handle is already taken.')
  })
})

describe('Identity - isHandleAvailable', () => {
  it('should return true when handle is unknown', async () => {
    expect(await contract.isHandleAvailable('test2')).to.be.true
  })
})
