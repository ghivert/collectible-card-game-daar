import { useEffect, useState } from 'react'
import PokemonList from './components/PokemonList.component'
import React from 'react'
import { POKEMON_API_URL } from './const'
import getAllPokemon from './services/api-service/pokemon.service'

export const App = () => {
  const [pokemonData, setPokemonData] = useState({})

  useEffect(() => {
    getAllPokemon().then(data => {
      if (data !== pokemonData) {
        setPokemonData(data)
      }
    })
  }, [])

  return (
    <div>
      <h1>Welcome to Pokémon TCG</h1>
      <div>
        <PokemonList cartes={pokemonData?.cards} />
      </div>
    </div>
  )
}
