//import data from './ressources/pokemon_local_image.json';
import data from './ressources/pokemon.json';
import collectionData from './ressources/collection.json';
const getAllPokemon = async () => {
    return data;
}


const getPokemonById = async (id: string) => {
    return data.cards.find((pokemon: any) => pokemon.id === id);
}


const getAllCollections = async () => {
    // divide the data.cards into 3 collections
    const collection1 = data.cards.slice(0, 10);
    const collection2 = data.cards.slice(10, 20);
    const collection3 = data.cards.slice(20, 30);
    return [
        {name: "collection 1", collection: collection1},
        {name: "collection 2", collection: collection2},
        {name: "collection 3", collection: collection3}
    ];
}

/** Returns an array of collections labels
 * Do not return the collection items, return only the name.
 * - name: collection name
 * - id: collection id
 * - size: number of items in the collection
 * @returns 
 */
const getAllCollectionsMetadata = async () => {
    return collectionData.sets.map((set: any) => (
        {name: set.name, id: set.code, size: set.totalCards}
    ))
}


const getCollectionById = async (id: string) => {
    console.log("getCollectionById: ", id);
    
    const res = data.cards.filter((pokemon: any) => pokemon.setCode === id );    
    console.log("res ", res);
    
    return res;
}


export {
    getAllPokemon,
    getAllCollections,
    getPokemonById,
    getAllCollectionsMetadata,
    getCollectionById
}