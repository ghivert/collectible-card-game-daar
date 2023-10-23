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
    //const response = await fetch('https://api.pokemontcg.io/v1/cards?limit=10');
    //const userData = await response.json();
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
  }, [])

  const wallet = useWallet();
  const handleClick = () => {
   console.log('Le bouton a été cliqué !');
   if (wallet?.details.account != null) {
        console.log(wallet?.contract.getMessage());
        (wallet?.contract.createCollection("col1")).then((result : any) => {
            console.log(result);
            const value3 = wallet?.contract.allPokemonsOfCollection(0);  
            console.log(value3)
        }).catch((error : any) => {
            console.log(error)
        });
        //wallet?.contract.add_carte_to_collection(0,'carte2')
        //console.log(">>> carte ajoutée ");
        //const value3 = wallet?.contract.allPokemonsOfCollection(0);   
        //value3.then(console.log)
        //console.log(wallet?.contract.owner_of_('xy7-10')) // retourne le resultat adresss(0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266)
  }
  }
  return (
    <div className={styles.body}>
      <h1>Welcome to Pokémon TCG</h1>
      <div>
        <PokemonList cartes={pokemonData?.cards} />
        <button  type="button"  onClick={handleClick}>Create collection</button>
      </div>
    </div>
  )
}


