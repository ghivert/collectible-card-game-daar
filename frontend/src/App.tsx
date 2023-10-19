import { useEffect, useMemo, useRef, useState } from 'react'
import styles from './styles.module.css'
import * as ethereum from '@/lib/ethereum'
import * as main from '@/lib/main'
import axios from 'axios';

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

async function fetchUserData() {
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
 

  const wallet = useWallet()
  console.log(wallet)
  if (wallet?.details.account != null){
    let acount =  wallet?.details.account
    console.log(wallet?.contract.getMessage())
  }

  
  return (
    <div className={styles.body}>
      <h1>Welcome to Pokémon TCG</h1>
    </div>
  )
}
