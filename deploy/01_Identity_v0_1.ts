import * as dotenv from 'dotenv'
dotenv.config()

import { ethers } from 'hardhat'
import { DeployFunction } from 'hardhat-deploy/types'

const func: DeployFunction = async function() {
  const Contract = await ethers.getContractFactory('Identity')

  const [deployer] = await ethers.getSigners()
  console.log('Using account: ', deployer.address)
  const accountBalance = await deployer.provider.getBalance(deployer.address)
  console.log('Account balance: ', accountBalance.toString())

  const fee = ethers.parseEther('5')
  const contract = await Contract.deploy(fee)
  const tx = contract.deploymentTransaction()

  if (tx === null) {
    console.log('Transaction response was null')
    return
  }

  const receipt = await tx.wait()

  if (receipt === null) {
    console.log('Receipt was null')
    return
  }

  const { gasUsed, hash } = receipt

  console.log('Args', fee.toString())
  console.log('Transaction Hash:', hash)
  console.log('Identity deployed to:', await contract.getAddress())
  console.log('Cost to deploy:', ethers.formatEther(gasUsed))
}

func.tags = ['Identity']

export default func
