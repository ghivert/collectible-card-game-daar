import POKEMON_IMG_SAMPLE from '@/const'
import React from 'react'
import './PokemonList.css' // Import your CSS file

const PokemonCard = (props: any) => {
  return (
    <div className="pokemon-card">
      <img
        src={props.data.imageUrl ?? POKEMON_IMG_SAMPLE}
        alt={props.data.name}
        className="pokemon-image"
      />
      <div className="pokemon-name">{props.data.name}</div>
    </div>
  )
}

const PokemonList = (props: any) => {
  // Check if props.cartes is defined before trying to access its properties
  const listeDeCartes = props.cartes ?? []
  const cartes = Object.values(listeDeCartes)

  return (
    <div className="pokemon-list-container">
      <ul className="pokemon-list">
        {cartes.map((data, index) => (
          <li key={index}>
            <PokemonCard data={data} />
          </li>
        ))}
      </ul>
    </div>
  )
}

export default PokemonList
