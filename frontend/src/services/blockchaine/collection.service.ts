import wallet from "./wallet"

/** retrive all collections from the blockchain.
 * return theirs ids.
 * @param collectionId 
 * @returns 
 */
const getAllCollections = async () => {
    return await wallet?.contract.allCollections();   
}

export {
    getAllCollections
}