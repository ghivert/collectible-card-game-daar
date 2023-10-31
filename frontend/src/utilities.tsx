import { useEffect, useMemo, useRef, useState } from 'react'
import * as ethereum from '@/lib/ethereum'
import * as main from '@/lib/main'
import { useNavigate } from 'react-router-dom';
import { NavigateFunction } from 'react-router-dom';

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

export const useWallet = () => {
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
  
  export const checkAccount =(navigate: NavigateFunction)=>{
    const checkLogin = async () => {
        const connection = await ethereum.connect('metamask');
        if (!connection)
          return;
    
        const adminAccount = '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266'
        if (connection.account === adminAccount){
          navigate('/AdminPage');
          console.log("A")
        } else if (connection.account){
          navigate('/UserPage')
          console.log("U")
        }
      }

      useEffect(()=>{
        checkLogin();
        console.log("login")
        const interval = setInterval(() => {
          checkLogin();
        }, 5000); // Esegui il controllo ogni 5 secondi (puoi regolare il valore a tuo piacimento)
    
        return () => {
          // Pulisci l'intervallo quando il componente viene smontato
          clearInterval(interval);
        };
      }, [navigate]);
};