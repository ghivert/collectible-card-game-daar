import { useEffect, useState } from 'react'
import PokemonList from './components/pokemon-list/PokemonList.component'
import React from 'react'
import { POKEMON_API_URL } from './const'
import { Router, Link, Route, BrowserRouter, Routes } from 'react-router-dom'
import Home from './components/home/Home.component'
import Layout from './pages/Layout'
import PokemonCollection, {
  PokemonCollectionsPresenter,
} from './components/pokemon-collection/PokemonCollection.component'
import {
  getAllCollections,
  getAllPokemon,
} from './services/api-service/pokemon.service'
import User from './components/user/User.component'

export const App = () => {
  const [pokemonData, setPokemonData] = useState({})
  const [allCollections, setAllCollections] = useState([])
  const [name, setName] = useState('')

  useEffect(() => {
    getAllPokemon().then(data => {
      if (data !== pokemonData) {
        setPokemonData(data)
      }
    })
    getAllCollections().then(data => {
      if (data !== allCollections) {
        setAllCollections(data)
      }
    })
    setName('Aboubacar')
  })

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Home />} />
          <Route path="me" element={<User name={name} />} />
          <Route
            path="collections"
            element={
              <PokemonCollectionsPresenter allCollections={allCollections} />
            }
          />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}
