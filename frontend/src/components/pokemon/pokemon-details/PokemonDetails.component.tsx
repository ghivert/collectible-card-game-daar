import { getPokemonById } from '@/services/api-service/pokemon.service'
import React, { useEffect, useId, useState } from 'react'
import { useParams, useSearchParams } from 'react-router-dom'
import { PokemonCard } from '../pokemon-list/PokemonList.component'
import './PokemonDetails.style.css'

const PokemonDetails = props => {
  const [pokemonData, setPokemonData] = useState({})
  const { id } = useParams()

  useEffect(() => {
    getPokemonById(id).then(data => {
      setPokemonData(data)
    })
  }, [])

  return (
    <div>
      <PokemonCardDetail data={pokemonData} />
    </div>
  )
}

const PokemonCardDetail = (props: any) => {
  return (
    <div className="pokemon-card-details">
      <img
        src={props.data.imageUrl}
        alt={props.data.name}
        className="pokemon-card-details-img"
      />
      <div className="pokemon-card-details-desc">Description</div>
    </div>
  )
}

const customeStyle = {}

const imageStyle = {}

export default PokemonDetails
