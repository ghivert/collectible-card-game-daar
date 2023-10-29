import { useEffect, useMemo, useRef, useState } from 'react'
import styles from './styles.module.css'
import * as ethereum from '@/lib/ethereum'
import * as main from '@/lib/main'
import axios from 'axios'
import PokemonList from './components/PokemonList.component'
import { getAllCollections } from './services/pokemon.service'
import { Wallet } from 'ethers'

type Canceler = () => void
const useAffect = (
  asyncEffect: () => Promise<Canceler | void>,
  dependencies: any[] = []
) => {
  const cancelerRef = useRef<Canceler | void>()
  useEffect(() => {
    asyncEffect()
      .then(canceler => (cancelerRef.current = canceler))
      .catch(error => console.warn('Uncatched error', error))
    return () => {
      if (cancelerRef.current) {
        cancelerRef.current()
        cancelerRef.current = undefined
      }
    }
  }, dependencies)
}

const useWallet = () => {
  const [details, setDetails] = useState<ethereum.Details>()
  const [main_contract, setMainContract] = useState<main.Main>()

  useAffect(async () => {
    const details_ = await ethereum.connect('metamask')
    if (!details_) return
    setDetails(details_)
    const contract_ = await main.init(details_)
    if (!contract_) return
    setMainContract(contract_)
  }, [])
  return useMemo(() => {
    if (!details || !main_contract) return
    return { details, contract: main_contract }
  }, [details, main_contract])
}

async function fetchPokemon() {
  const options = {
    method: 'GET',
    headers: {
      'X-RapidAPI-Key': 'e78be1ff-226e-43e7-98c5-5b57ce01ece7',
    },
  }
  try {
    //const response = await fetch('https://api.pokemontcg.io/v1/cards?limit=10');
    //const userData = await response.json();
    return {}
  } catch (error) {
    console.error('Erreur lors de la récupération des données:', error)
    throw error
  }
}

export const App = () => {
  let [pokemonData, setPokemonData] = useState({})

  useEffect(() => {
    fetchPokemon().then(data => setPokemonData(data))
  }, [])

  const wallet = useWallet()

  const AddCarteToUser = () => {
    console.log('mint card')
    wallet?.contract.mint_(wallet?.details.account, 'carte1').then(() => {
      wallet?.contract.owner_of_('carte1').then(console.log)
      wallet?.contract.balanceOf_(wallet?.details.account).then(console.log)
    })
  }

  const getAllCollections = () => {
    console.log('Get all collections')
    wallet?.contract.allCollections().then(console.log).catch(console.error)
  }

  const collectionCardCount = collectionId => {
    console.log('Get collection 0 card count')
    wallet?.contract.cardCount(collectionId).then(result => {
      let res = result
      if (result._isBigNumber) {
        res = result.toNumber()
      }
      console.log('collection ' + collectionId + ' card count : ' + res)
    })
  }

  const allCollectionCardCount = () => {
    for (let i = 0; i < 4; i++) {
      collectionCardCount(i)
    }
  }

  const TransferCard = () => {
    console.log('Transfer card')
    //Mint first
    wallet?.contract
      .transferFrom_(
        wallet?.details.account,
        '0x70997970C51812dc3A010C7d01b50e0d17dc79C8',
        'carte1'
      )
      .then(() => {
        wallet?.contract.owner_of_('carte1').then(console.log)
      })
  }

  return (
    <div className={styles.body}>
      <h1>Welcome to Pokémon TCG</h1>
      <div>
        <PokemonList cartes={pokemonData?.cards} />
        <button type="button" onClick={AddCarteToUser}>
          Mint card to user{' '}
        </button>
        <button type="button" onClick={TransferCard}>
          Transfer card{' '}
        </button>
        <button type="button" onClick={getAllCollections}>
          collections{' '}
        </button>
        <button type="button" onClick={allCollectionCardCount}>
          cardcount{' '}
        </button>
      </div>
    </div>
  )
}
