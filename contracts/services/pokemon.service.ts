import collectionData from "./collection.data.json"
import pokemonData from "./cards.data.json"

const getAllCollections = () => {
    return collectionData.sets.map(set => (
        {name: set.name, size: set.totalCards, code: set.code})
    );
}
const getAllCards = () => {
    return  pokemonData.data.map(data => (
        {id: data.id, set:data.set.id})
    );
}


export {
    getAllCollections, getAllCards
}