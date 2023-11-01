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

  const addCollection = () => {
    console.log('Add collection', wallet)
    wallet?.contract
      .createCollection('collection1', wallet?.details.account)
      .then((res: any) => {
        console.log(res)
        // wallet?.contract.owner_of_collection_('collection1').then(console.log)
      })
      .catch((e: any) => {
          console.log(e)
          // wallet?.contract.owner_of_collection_('collection1').then(console.log)
        })
        .finally(() => {
          console.log("fine")
          // wallet?.contract.owner_of_collection_('collection1').then(console.log)
        })
  }

  const getAllCollections = () => {
    console.log('Get all collections')
    wallet?.contract.getAllCollections().then(console.log).catch(console.error)
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
      </div>
    </div>
  )
}