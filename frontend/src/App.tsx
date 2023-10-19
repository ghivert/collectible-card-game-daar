import { useEffect, useMemo, useRef, useState } from 'react'
import styles from './styles.module.css'
import * as ethereum from '@/lib/ethereum'
import * as main from '@/lib/main'
import axios from 'axios';
import PokemonList from './components/PokemonList.component';

interface DonneesAPI {
  propriete1: string;
  propriete2: number;
}
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
  const [contract, setContract] = useState<main.Main>()
  useAffect(async () => {
    const details_ = await ethereum.connect('metamask')
    if (!details_) return
    setDetails(details_)
    const contract_ = await main.init(details_)
    if (!contract_) return
    setContract(contract_)
  }, [])
  return useMemo(() => {
    if (!details || !contract) return
    return { details, contract }
  }, [details, contract])
}

async function fetchPokemon() {
  const options = {
    method: 'GET',
    headers: {
      'X-RapidAPI-Key': 'e78be1ff-226e-43e7-98c5-5b57ce01ece7',
    }
  };
  
  try {
    const response = await fetch('https://api.pokemontcg.io/v1/cards?');
    const userData = await response.json();
    return userData;
  } catch (error) {
    console.error('Erreur lors de la récupération des données :', error);
    throw error;
  }
}

export const App = () => {

  let [pokemonData, setPokemonData] = useState({});

  useEffect(() => {
    fetchPokemon().then(data => setPokemonData(data));
  })
  

  const wallet = useWallet()
  if (wallet?.details.account != null){
    let acount =  wallet?.details.account
  }

  
  return (
    <div className={styles.body}>
      <h1>Welcome to Pokémon TCG</h1>
      <div>
        <PokemonList cartes={pokemonData?.cards}/>
      </div>
    </div>
  )
}
