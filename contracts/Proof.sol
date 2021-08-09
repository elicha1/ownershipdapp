/* proof ownership without revieling the actual file (the hash of the file an; the owner's name)/
/* proof that the file existed ( the hash of the file ; the block
timestamp) at specific time and proof the integrity( hash itself proves the file integrity) P.S:if the file was modified, then its hash will change and the contract won't be able to find any such file,therefore proving that the file was modified */
pragma solidity ^0.5.0;

contract Proof{
      struct FileDetails{
            uint timestamp;
            string owner;
       }
      mapping(string=>FileDetails)files;
      event logFileAddedStatus(bool status, uint timestamp, string owner,string fleHash);
      //store the owner of file at the block timestamp 
      function set( string memory owner, string memory fileHash)public{
                if (files[fileHash].timestamp==0){
                // needs more reflexion to check if a key is already taken 
                   files[fileHash]= FileDetails(block.timestamp,owner);
                   // trigger event so the frontend knows about it
                   emit logFileAddedStatus(true,block.timestamp,owner,fileHash);
                }else{
                //tell frontend that file exists and owned already 
                   emit logFileAddedStatus(false,block.timestamp,owner,fileHash);
                }
       }
       // get file informations
       function get(string memory fileHash)public view returns(uint timestamp, string memory owner){
                return(files[fileHash].timestamp, files[fileHash].owner);
        }
}