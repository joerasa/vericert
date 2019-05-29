///////////////////////  Description   ///////////////////////////////
// a hash of a certificat or testimony can be stored in blockchain  //
// the existence of a hash can be verified                          //
// an issuer can store hashes                                       //
// an issuer has to be registered and authorized to store hashes    //

pragma solidity >=0.4.22 <0.6.0;
contract Certs {

    /////////////////////// Declarations ///////////////////////////////



    // Data of a single issuer like school university authority
    address provider; //provider of the whole contract

    // Type of a single issuer
    enum Typeenum {unknown, provider, school, university, authority}

    struct Issuer {
        bytes32 nameOfIssuer;
        bytes32 city;
        bytes32 street;
        address authorizedBy;
        Typeenum issuerType;
        bool registered;
        bool authorized;
        Certificate[] certificates;
    }

    event IssuerInfo(
        address _IssuerAdr
    );


    // dynamic structure of issuers to call an issuer by address
    mapping(address => Issuer) issuers;

    // list of issuers to display registered issuers
    address[] public issuerAccts;

    event CertificateInfo(
       bytes32 eCerthash
    );

    bytes32 certHash;

    // Data of a single certificate entry
    struct Certificate {
        bytes32 aCertHash;
        uint timestamp;
        bytes32 certType;
    }

    // array with all certhashs to map to issuers
    mapping (bytes32 => address) public hashIssuer;

    // array with all certhashs to map to index of issuer
    mapping (bytes32 => uint) public hashIndex;

    //end of declarations


    /////////////////////// Functions ///////////////////////////////
    constructor () public {
        provider = msg.sender;
        registerIssuer("Bundesministerium fur Bildung ","11055 Berlin","Kapelle-Ufer 1",Typeenum.provider);
        authorizeIssuer(msg.sender);
    }


    function registerIssuer (bytes32 _IssuerName, bytes32 _IssuerLocation,bytes32 _IssuerStreet, Typeenum _IssuerType)
        public returns (uint retno) {
        issuers[msg.sender].nameOfIssuer = _IssuerName;
        issuers[msg.sender].city = _IssuerLocation;
        issuers[msg.sender].street = _IssuerStreet;
        issuers[msg.sender].issuerType = _IssuerType;

        if (issuers[msg.sender].registered != true) {issuerAccts.push(msg.sender);}
        issuers[msg.sender].registered = true;

        emit IssuerInfo (msg.sender);
        return issuerAccts.length;
    }


    function authorizeIssuer(address _IssuerAdr) public {
        if (msg.sender == provider) {
            issuers[_IssuerAdr].authorized = true;
            emit IssuerInfo (_IssuerAdr);
        }

        if (issuers[msg.sender].authorized == true) {
            issuers[_IssuerAdr].authorized = true;
            issuers[_IssuerAdr].authorizedBy = msg.sender;
            emit IssuerInfo (_IssuerAdr);

        }
    }


    function displayIssuerbyAddress (address _IssuerAdr)  public view returns (bytes32, bytes32, bytes32, Typeenum, address){
        return (
            issuers[_IssuerAdr].nameOfIssuer,
            issuers[_IssuerAdr].city,
            issuers[_IssuerAdr].street,
            issuers[_IssuerAdr].issuerType,
            issuers[_IssuerAdr].authorizedBy
        );
    }


    function displayIssuerByIndex (uint _index)  public view returns (bytes32, bytes32, bytes32, Typeenum, address ,address){
        address _IssuerAdr = issuerAccts [_index];
        return (
            issuers[_IssuerAdr].nameOfIssuer,
            issuers[_IssuerAdr].city,
            issuers[_IssuerAdr].street,
            issuers[_IssuerAdr].issuerType,
            _IssuerAdr,
            issuers[_IssuerAdr].authorizedBy
        );
    }



    function publishCert (bytes32 _hash )  public returns (uint _noEntries) {
        uint noOfCerts;
        require (issuers[msg.sender].authorized == true,"publisher not yet authorized");
        Certificate memory currentCert;
        currentCert.aCertHash = _hash;
        currentCert.timestamp = block.timestamp;
        issuers[msg.sender].certificates.push (currentCert);

        hashIssuer [_hash] = msg.sender;

        noOfCerts = issuers[msg.sender].certificates.length;
        hashIndex [_hash] = noOfCerts-1; // first cert is index 0

        emit CertificateInfo (_hash);

        return noOfCerts;
    }


    function displayCert (address _issuer, uint _index) public view returns (bytes32 _hash, uint _timestamp) {
        _hash = issuers[_issuer].certificates[_index].aCertHash;
        _timestamp = issuers[_issuer].certificates[_index].timestamp;
        return (_hash, _timestamp);
    }

    function verifyHash (bytes32 _hash) public view returns (address, uint, uint) {
        address _issuer;
        uint _index;
        uint _timeStamp;
        _issuer = hashIssuer [_hash];
        _index = hashIndex [_hash];
        _timeStamp = issuers[_issuer].certificates[_index].timestamp;

        return (_issuer, _index, _timeStamp);
    }
    // end of functions

}
// end of contract