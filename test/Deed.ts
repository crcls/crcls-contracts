import { expect } from 'chai'
import { ethers } from 'hardhat'
import { Deed } from '../typechain-types'

const AUTH = '0xC72e1e431F932Ab50113701b3c6b2069311700d6'
let deed: Deed

before(async () => {
  const fee = ethers.parseEther('1')
  deed = await ethers.deployContract('Deed', [fee])
})

describe('Deed - create', () => {
  it('should revert with insufficient funds.', async () => {
    await expect(deed.purchase('test', AUTH)).to.be.revertedWith(
      'Insufficient funds to create a Circle.'
    )
  })

  it('should succeed with sufficient funds', async () => {
    const tx = await deed.purchase(
      'test',
      '0xC72e1e431F932Ab50113701b3c6b2069311700d6',
      {
        value: ethers.parseEther('5'),
      }
    )
    expect(tx).to.not.be.reverted
    expect(tx).to.emit(deed, 'NewCircle')
  })
})

describe('Deed - fee', () => {
  it('should allow the owner to set the fee.', async () => {
    const newFee = ethers.parseEther('3')
    expect(await deed.setFee(newFee)).to.not.be.reverted
    expect(await deed.fee()).to.eq(newFee)
  })
})

describe('Deed - details', () => {
  it('Details from ID', async () => {
    const [slug, authority] = await deed.detailsFromId(1)
    expect(slug).to.eq('test')
    expect(authority).to.eq(AUTH)
  })

  it('Details from slug', async () => {
    const [id, authority] = await deed.detailsFromSlug('test')
    expect(id).to.eq(1)
    expect(authority).to.eq(AUTH)
  })
})
