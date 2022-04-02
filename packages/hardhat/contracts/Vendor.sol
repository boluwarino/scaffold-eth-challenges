pragma solidity ^0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {
  uint256 public constant tokensPerEth = 100;

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    uint256 amountOfTokens = msg.value * tokensPerEth;
    yourToken.transfer(msg.sender, amountOfTokens);
    emit BuyTokens(msg.sender, msg.value, amountOfTokens);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() public onlyOwner {
    uint256 amount = address(this).balance;
    payable(msg.sender).transfer(amount);
  }


  // ToDo: create a sellTokens() function:
  function sellTokens(uint256 amountOfTokens) public {
    yourToken.transferFrom(msg.sender,address(this), amountOfTokens);
    uint256 amountOfETH = amountOfTokens / tokensPerEth;
    payable(msg.sender).transfer(amountOfETH);
  }

}