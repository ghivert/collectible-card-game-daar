import { useEffect, useMemo, useRef, useState } from 'react'
import styles from './styles.module.css'
import * as ethereum from '@/lib/ethereum'
import * as main from '@/lib/main'

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

export const App = () => {

  const wallet = useWallet()
  const adminAccount = wallet?.details.account
  console.log('Admin', adminAccount)

  useEffect(() => {
    console.log('Wallet', wallet)
  }, [wallet])


  const addCollection = () => {
    console.log('Add collection', wallet)
    wallet?.contract
      .createCollection('collection1', 100)
      .then((res: any) => {
        console.log(res)
      })
      .catch((e: any) => {
          console.log(e)
        })
        .finally(() => {
          console.log("added collection")
        })
  }

  const getAllCollections = () => {
    console.log('Get all collections')
    wallet?.contract.getAllCollections().then(console.log).catch(console.error)
  }

  const mintAndAssignCards = () => {
    console.log('Mint and assign cards')
    wallet?.contract
      .mintAndAssignCards('collection1', ['card1','card2','card3'])
      .then(console.log)
      .catch(console.error)
  }

  const assignCardToAUser = () => {
    console.log('Assign card to a user')
    wallet?.contract
      .assignCardToUser('card2', adminAccount)
      .then(console.log)
      .catch(console.error)
  }

const getCardsOfACollection = () => {
  console.log('Get cards of a collection')
  wallet?.contract
    .getCardsFromCollection('collection1')
    .then(console.log)
    .catch(console.error)
}

const getCardsOfAUser = () => {
  console.log('Get cards of a user')
  wallet?.contract
    .getCardsOfUser(adminAccount)
    .then(console.log)
    .catch(console.error)
}

const userOwnsCard = () => {
  console.log('User owns card')
  wallet?.contract
    .userOwnsCard(adminAccount, 'card2')
    .then(console.log)
    .catch(console.error)
}

  return (
    <div className={styles.body}>
      <h1>Welcome to Pokémon TCG</h1>
      <div>
        <button type="button" onClick={addCollection}>
          Add collection{' '}
        </button>
        <button type="button" onClick={getAllCollections}>
          collections{' '}
        </button>
        <button type="button" onClick={mintAndAssignCards}>
          Mint and assign cards{' '}
          </button>
          <button type="button" onClick={getCardsOfACollection}>
          Retrieve cards from a collection name{' '}
          </button>
          <button type="button" onClick={assignCardToAUser}>
          Assign a card to a user{' '}
          </button>
          <button type="button" onClick={getCardsOfAUser}>
          Retrieve cards Of a user address{' '}
          </button>
          <button type="button" onClick={userOwnsCard}>
          User owns a card{' '}
          </button>
      </div>
    </div>
  )
}