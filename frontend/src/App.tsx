import { useEffect, useState } from 'react'
import React from 'react'
import { POKEMON_API_URL } from './const'
import { Router, Link, Route, BrowserRouter, Routes } from 'react-router-dom'
import Home from './components/home/Home.component'
import Layout from './pages/Layout'
import {
  getAllCollections,
  getAllPokemon,
} from './services/api-service/pokemon.service'
import User from './components/user/User.component'
import PokemonDetails from './components/pokemon/pokemon-details/PokemonDetails.component'
import {
  PokemonCollectionPresenter,
  PokemonCollectionsPresenter,
} from './components/pokemon/pokemon-collection/PokemonCollection.component'

export const App = () => {
  const [pokemonData, setPokemonData] = useState({})
  const [name, setName] = useState('')

  useEffect(() => {
    getAllPokemon().then(data => {
      if (data !== pokemonData) {
        setPokemonData(data)
      }
    })
    setName('Aboubacar')
  }, [])

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Home />} />
          <Route path="me" element={<User name={name} />} />
          <Route path="collections" element={<PokemonCollectionsPresenter />} />
          <Route path="/pokemon/:id" element={<PokemonDetails />} />
          <Route
            path="/collection/:id"
            element={<PokemonCollectionPresenter />}
          />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}
