    var MyContract = web3.eth.contract( 
        [
            {
                "anonymous": false,
                "inputs": [
                    {
                        "indexed": false,
                        "name": "eCerthash",
                        "type": "bytes32"
                    }
                ],
                "name": "CertificateInfo",
                "type": "event"
            },
            {
                "anonymous": false,
                "inputs": [
                    {
                        "indexed": false,
                        "name": "_IssuerAdr",
                        "type": "address"
                    }
                ],
                "name": "IssuerInfo",
                "type": "event"
            },
            {
                "constant": false,
                "inputs": [
                    {
                        "name": "_IssuerAdr",
                        "type": "address"
                    }
                ],
                "name": "authorizeIssuer",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [
                    {
                        "name": "_hash",
                        "type": "bytes32"
                    }
                ],
                "name": "publishCert",
                "outputs": [
                    {
                        "name": "_noEntries",
                        "type": "uint256"
                    }
                ],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [
                    {
                        "name": "_IssuerName",
                        "type": "bytes32"
                    },
                    {
                        "name": "_IssuerLocation",
                        "type": "bytes32"
                    },
                    {
                        "name": "_IssuerStreet",
                        "type": "bytes32"
                    },
                    {
                        "name": "_IssuerType",
                        "type": "uint8"
                    }
                ],
                "name": "registerIssuer",
                "outputs": [
                    {
                        "name": "retno",
                        "type": "uint256"
                    }
                ],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
            },
            {
                "inputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "constructor"
            },
            {
                "constant": true,
                "inputs": [
                    {
                        "name": "_issuer",
                        "type": "address"
                    },
                    {
                        "name": "_index",
                        "type": "uint256"
                    }
                ],
                "name": "displayCert",
                "outputs": [
                    {
                        "name": "_hash",
                        "type": "bytes32"
                    },
                    {
                        "name": "_timestamp",
                        "type": "uint256"
                    }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
            },
            {
                "constant": true,
                "inputs": [
                    {
                        "name": "_IssuerAdr",
                        "type": "address"
                    }
                ],
                "name": "displayIssuerbyAddress",
                "outputs": [
                    {
                        "name": "",
                        "type": "bytes32"
                    },
                    {
                        "name": "",
                        "type": "bytes32"
                    },
                    {
                        "name": "",
                        "type": "bytes32"
                    },
                    {
                        "name": "",
                        "type": "uint8"
                    },
                    {
                        "name": "",
                        "type": "address"
                    }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
            },
            {
                "constant": true,
                "inputs": [
                    {
                        "name": "_index",
                        "type": "uint256"
                    }
                ],
                "name": "displayIssuerByIndex",
                "outputs": [
                    {
                        "name": "",
                        "type": "bytes32"
                    },
                    {
                        "name": "",
                        "type": "bytes32"
                    },
                    {
                        "name": "",
                        "type": "bytes32"
                    },
                    {
                        "name": "",
                        "type": "uint8"
                    },
                    {
                        "name": "",
                        "type": "address"
                    },
                    {
                        "name": "",
                        "type": "address"
                    }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
            },
            {
                "constant": true,
                "inputs": [
                    {
                        "name": "",
                        "type": "bytes32"
                    }
                ],
                "name": "hashIndex",
                "outputs": [
                    {
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
            },
            {
                "constant": true,
                "inputs": [
                    {
                        "name": "",
                        "type": "bytes32"
                    }
                ],
                "name": "hashIssuer",
                "outputs": [
                    {
                        "name": "",
                        "type": "address"
                    }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
            },
            {
                "constant": true,
                "inputs": [
                    {
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "name": "issuerAccts",
                "outputs": [
                    {
                        "name": "",
                        "type": "address"
                    }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
            },
            {
                "constant": true,
                "inputs": [
                    {
                        "name": "_hash",
                        "type": "bytes32"
                    }
                ],
                "name": "verifyHash",
                "outputs": [
                    {
                        "name": "",
                        "type": "address"
                    },
                    {
                        "name": "",
                        "type": "uint256"
                    },
                    {
                        "name": "",
                        "type": "uint256"
                    }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
            }
    ]
    );