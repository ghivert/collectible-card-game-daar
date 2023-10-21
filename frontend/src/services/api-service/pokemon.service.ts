//import data from './ressources/pokemon_local_image.json';
import data from './ressources/pokemon.json';
const getAllPokemon = async () => {
    return data;
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


export {
    getAllPokemon,
    getAllCollections
}