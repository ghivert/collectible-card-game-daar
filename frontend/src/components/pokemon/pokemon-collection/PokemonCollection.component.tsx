import React from 'react'
import { PokemonList } from '../pokemon-list/PokemonList.component'

const PokemonCollection = props => {
  return (
    <div>
      <h1>{props.collectionName}</h1>
      <PokemonList cartes={props.pokemons} />
    </div>
  )
}

const PokemonCollectionsPresenter = props => {
  return (
    <div>
      {props.allCollections.map((collection, index) => (
        <PokemonCollection
          key={index}
          collectionName={collection.name}
          pokemons={collection.collection}
        />
      ))}
    </div>
  )
}

export { PokemonCollectionsPresenter }
