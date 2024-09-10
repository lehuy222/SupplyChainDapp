// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract SupplyChain {
    address public owner;

    struct Product {
        string name;
        uint256 productId;
        string status;
        uint256 timestamp;
    }

    mapping(uint256 => Product) public products;
    uint256 public productCount = 0;

    event ProductAdded(uint256 indexed productId, string name, string status, uint256 timestamp);
    event StatusUpdated(uint256 indexed productId, string status, uint256 timestamp);

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function addProduct(string memory _name, string memory _initialStatus) public onlyOwner {
        productCount++;
        products[productCount] = Product(_name, productCount, _initialStatus, now);
        emit ProductAdded(productCount, _name, _initialStatus, now);
    }

    function updateStatus(uint256 _productId, string memory _status) public onlyOwner {
        require(_productId > 0 && _productId <= productCount, "Product does not exist");
        products[_productId].status = _status;
        products[_productId].timestamp = now;
        emit StatusUpdated(_productId, _status, now);
    }

    function getProduct(uint256 _productId) public view returns (string memory, string memory, uint256) {
        require(_productId > 0 && _productId <= productCount, "Product does not exist");
        Product memory p = products[_productId];
        return (p.name, p.status, p.timestamp);
    }
}
