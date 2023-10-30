import collectionData from "./collection.data.json"
import pokemonData from "./cards.data.json"

const getAllCollectionsFromPokemonApi = () => {
    return collectionData.sets.map(set => (
        {name: set.name, size: set.totalCards, code: set.code})
    );
}

const getAllCollectionsFromBlockChain = () => {
     ///allcolelction ()==> renvoie un tbelau de id-collection ?  [collection1, collection2, ..... ]

}

const getAllCollections = () => {
    return getAllCollectionsFromPokemonApi();
}

const getAllCards = () => {
    return  pokemonData.data.map(data => (
        {id: data.id, set:data.set.id})
    );
}


export {
    getAllCollections, getAllCards
}