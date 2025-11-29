// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract AntiCounterfeitLuxuryGoodsRegistry {


struct Product {
string brand;
string model;
string serialNumber;
address owner;
bool isAuthentic;
}


mapping(string => Product) public products; // Mapping using Serial Number


event ProductRegistered(string serialNumber, address owner);
event OwnershipTransferred(string serialNumber, address from, address to);


// Register a luxury product
function registerProduct(
string memory _brand,
string memory _model,
string memory _serialNumber
) public {
require(products[_serialNumber].owner == address(0), "Product already registered");


products[_serialNumber] = Product({
brand: _brand,
model: _model,
serialNumber: _serialNumber,
owner: msg.sender,
isAuthentic: true
});


emit ProductRegistered(_serialNumber, msg.sender);
}


// Transfer ownership
function transferOwnership(string memory _serialNumber, address _newOwner) public {
require(products[_serialNumber].owner == msg.sender, "Only owner can transfer");
require(_newOwner != address(0), "Invalid address");


products[_serialNumber].owner = _newOwner;


emit OwnershipTransferred(_serialNumber, msg.sender, _newOwner);
}


// Verify authenticity
function verifyProduct(string memory _serialNumber) public view returns (bool) {
return products[_serialNumber].isAuthentic;
}
}
