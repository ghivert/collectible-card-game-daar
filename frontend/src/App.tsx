import { useEffect, useState } from 'react'
import PokemonList from './components/PokemonList.component'
import React from 'react'
import { POKEMON_API_URL } from './const'
import getAllPokemon from './services/api-service/pokemon.service'
import { Router, Link, Route, BrowserRouter, Routes } from 'react-router-dom'
import Home from './components/home/Home.component'
import Layout from './pages/Layout'

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
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Home />} />
          <Route
            path="collections"
            element={<PokemonList cartes={pokemonData.cards} />}
          />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}
