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
    }
  };
  try {
    const response = await fetch('https://api.pokemontcg.io/v1/cards?limit=10');
    const userData = await response.json();
    return {};
  } catch (error) {
    console.error('Erreur lors de la récupération des données:', error);
    throw error;
  }
}

export const App = () => {

  let [pokemonData, setPokemonData] = useState({});

  useEffect(() => {
    fetchPokemon().then(data => setPokemonData(data));
  })


  const wallet = useWallet()
  if (wallet?.details.account != null) {
    let acount = wallet?.details.account
    console.log(wallet?.contract)
    wallet?.contract.getMessage()
   // wallet?.contract.createCollection('col1')  ///fail 
    //retrun adress collection only if super_admin col1= 0: "0xd8058efe0198ae9dD7D563e1b4938Dcbc86A1F81"
    //and col2= "0x6D544390Eb535d61e196c87d6B9c80dCD8628Acd"
    //const value = wallet?.contract.allCollections() 
    //console.log(value)
   // const value2= wallet?.contract.allPokemonsOfCollection(0);  //retturn all adress(url) pokemon of one collection
   // console.log(value2)   // pokemon_url ="xy7-10"
   // wallet?.contract.add_carte_to_collection(1,'dp6-90')  //TRANFERT LA COLLECTION A UN  USER  cela se fait de manière infinie 
    //const value3= wallet?.contract.allPokemonsOfCollection(1);   
    //console.log(value3)
    console.log(wallet?.contract.owner_of_('xy7-10'))
  }


  return (
    <div className={styles.body}>
      <h1>Welcome to Pokémon TCG</h1>
      <div>
        <PokemonList cartes={pokemonData?.cards} />
      </div>
    </div>
  )
}


