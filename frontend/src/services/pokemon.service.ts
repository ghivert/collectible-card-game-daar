import collectionData from "./collection.data.json"

const getAllCollections = () => {
    return collectionData.sets.map(set => (
        {name: set.name, size: set.totalCards})
    );
}


export {
    getAllCollections
}