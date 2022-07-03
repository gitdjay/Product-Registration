// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Production {

     struct Product {
        bytes32[] serialNo;
        bytes32[] registered;
        uint regNo;
    }

    Product product;

    function setProduct(string memory a) private {
        bytes32 hash = keccak256(abi.encodePacked(a));
        product.serialNo.push(hash);

        for (uint i = 1; i<10; i++) {
            bytes32 serial = keccak256(abi.encodePacked(product.serialNo[i-1]));
            product.serialNo.push(serial);
        }
    }

    function launch() public {
        string memory first = "generate serial numbers for first product of brand";
        setProduct(first);

    }
    
    function checkSerial(uint n, bytes32 sn) public view returns(bool) {
        if (sn == product.serialNo[n]) {
            return true;
        } else {
            return false;
        }
    }

    function bytes32ToString(bytes32 _bytes32) private pure returns (string memory) {
        uint8 i = 0;
        while(i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }

    function regWarranty(uint Num, bytes32 regSer) public returns(string memory) {
        if (product.serialNo[Num] == regSer) {
            product.registered.push(regSer);
            product.regNo++;
            return "Registration SUCCESSFUL";
        } else {
            return "Registration UNSUCCESSFUL";
        }
    }
}