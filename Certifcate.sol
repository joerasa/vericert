pragma solidity >=0.4.22 <0.6.0;
contract Certs {
/////////////////////// Description /////////////////////////////// 
// a hash of a certificat or testimony can stored in blockchain  //
// the existence of a hash can be verified                       //
// an issues can store hashes                                    //
// an issuer has to be registered to stpore hashes               //



/////////////////////// Declarations ///////////////////////////////
 
    // // Public variables of the token
    string public name;
    string public symbol;
    uint8 public decimals = 2;
    uint256 public totalSupply;

    // This creates an array with all balances
    mapping (address => uint256) public balanceOf;
 
    // This generates a public event on the blockchain that will notify clients
    event Transfer(address indexed from, address indexed to, uint256 value);

    // This notifies clients about the amount burnt
    event Burn(address indexed from, uint256 value);



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
       bytes32 eName
    );
   

    // dynamic structure of issuers to call an issuer by address
    mapping(address => Issuer) issuers;

    // list of issuers to display registered issuers
    address[] public issuerAccts;
   
    event CertificateInfo(
       address eIssuer,
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


    
  
/////////////////////// Functions ///////////////////////////////
   /**
     * Constructor function
     *
     * Initializes contract with initial supply tokens to the creator of the contract
     */
    constructor (uint256 initialSupply) public {
        totalSupply = initialSupply;
        balanceOf[msg.sender] = totalSupply;                    // Give the creator all initial tokens
        name = "registrationFee";                               // Set the name for display purposes
        symbol = "F€";                                          // Set the symbol for display purposes
        provider = msg.sender;
        registerIssuer("Stiftung für Hochschulzulassung","44137 Dortmund","Sonnenstraße 171",Typeenum.provider);
        authorizeIssuer(msg.sender);
    }



    /**
     *  transfer
     */
    function transfer(address _to, uint _value) public  {
        // Prevent transfer to 0x0 address. Use burn() instead
        require(_value != 0x0);
        // Check if the sender has enough
        require(balanceOf[msg.sender] >= _value);
        // Check for overflows
        require(balanceOf[_to] + _value > balanceOf[_to]);
        // Subtract from the sender
        balanceOf[msg.sender] -= _value;
        // Add the same to the recipient
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
    }

    /**
     * Destroy tokens
     *
     * Remove `_value` tokens from the system irreversibly
     *
     * @param _value the amount of money to burn
     */
    function createCoins(uint256 _value) public returns (bool success) {
        require(msg.sender == provider);       // Check if the sender is the bank
        totalSupply += _value;                 // Updates totalSupply
        balanceOf[msg.sender] += _value;   
        return true;
    }

    /**
     * Destroy tokens
     *
     * Remove `_value` tokens from the system irreversibly
     *
     * @param _value the amount of money to burn
     */
    function burnCoins(uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);   // Check if the sender has enough
        balanceOf[msg.sender] -= _value;            // Subtract from the sender
        totalSupply -= _value;                      // Updates totalSupply
        emit Burn(msg.sender, _value);
        return true;
    }
 

 
    function registerIssuer (bytes32 _IssuerName, bytes32 _IssuerLocation,bytes32 _IssuerStreet, Typeenum _IssuerType) 
        public returns (uint retno) {
        issuers[msg.sender].nameOfIssuer = _IssuerName;
        issuers[msg.sender].city = _IssuerLocation;
        issuers[msg.sender].street = _IssuerStreet;
        issuers[msg.sender].issuerType = _IssuerType;
  
        
        if (issuers[msg.sender].registered != true) {issuerAccts.push(msg.sender);}
        issuers[msg.sender].registered = true;

        return issuerAccts.length;
    }

    function authorizeIssuer(address _IssuerAdr) public {
        if (msg.sender == provider) 
            issuers[_IssuerAdr].authorized = true;
        if (issuers[msg.sender].authorized == true) {
            issuers[_IssuerAdr].authorized = true;
            issuers[_IssuerAdr].authorizedBy = msg.sender;
        }
    }


    function displayIssuerbyAddress (address _IssuerAdr)  public view returns (bytes32, bytes32, bytes32, Typeenum, address){
        return (
            issuers[_IssuerAdr].nameOfIssuer, 
            issuers[_IssuerAdr].city, 
            issuers[_IssuerAdr].street, 
            issuers[msg.sender].issuerType,
            issuers[msg.sender].authorizedBy
        );
    }  


    function displayIssuerByIndex (uint _index)  public view returns (bytes32, bytes32, bytes32, Typeenum, address){
        address _IssuerAdr = issuerAccts [_index];
        return (
            issuers[_IssuerAdr].nameOfIssuer, 
            issuers[_IssuerAdr].city, 
            issuers[_IssuerAdr].street, 
            issuers[msg.sender].issuerType,
            issuers[msg.sender].authorizedBy
        );
    }  



    function publishCert (bytes32 _hash )  public returns (uint _noEntries) {
        uint noOfCerts;
        require (issuers[msg.sender].authorized == true);
        Certificate memory currentCert;
        currentCert.aCertHash = _hash;
        currentCert.timestamp = now;
        issuers[msg.sender].certificates.push (currentCert);

        hashIssuer [_hash] = msg.sender;

        noOfCerts = issuers[msg.sender].certificates.length;
        hashIndex [_hash] = noOfCerts;

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