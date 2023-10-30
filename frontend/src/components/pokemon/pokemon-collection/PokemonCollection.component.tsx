import React from 'react'
import { useEffect, useState } from 'react'
import { PokemonCard, PokemonList } from '../pokemon-list/PokemonList.component'
import {
  getAllCollectionsMetadata,
  getCollectionById,
} from '@/services/api-service/pokemon.service'
import { Link, useParams } from 'react-router-dom'
import './PokemonCollectionPresenter.style.css'
const PokemonCollection = props => {
  const name: string = props.data.name
  const size: number = props.data.size
  const id: string = props.data.id
  const [imgUrl, setImgUrl] = useState('')

  useEffect(() => {
    fetch('https://api.pokemontcg.io/v1/sets/' + props.data.id).then(
      async response => {
        const res = await response.json()
        setImgUrl(res.set.logoUrl)
      }
    )
  }, [])

  return (
    <div className="pokemon-collection">
      <h3>
        {name} ({size})
      </h3>
      <img src={imgUrl} />
    </div>
  )
}

const PokemonCollectionsPresenter = props => {
  const [collectionsMetadata, setCollectionsMetadata] = useState([])

  useEffect(() => {
    getAllCollectionsMetadata().then(data => {
      setCollectionsMetadata(data)
    })
  }, [])

  return (
    <div>
      <h2>Collections</h2>
      <div className="pokemon-collections-presenter">
        {collectionsMetadata.map((collectionMetaData, index) => (
          <Link key={index} to={`/collection/${collectionMetaData.id}`}>
            <PokemonCollection key={index} data={collectionMetaData} />
          </Link>
        ))}
      </div>
    </div>
  )
}

const PokemonCollectionPresenter = props => {
  const [cards, setCards] = useState([])
  const { id } = useParams()

  useEffect(() => {
    getCollectionById(id).then(data => {
      setCards(data)
    })
  }, [id])

  console.log(cards)

  return (
    <div className="pokemon-collection-presenter">
      <PokemonList cards={cards} />
    </div>
  )
}

export { PokemonCollectionsPresenter, PokemonCollectionPresenter }
