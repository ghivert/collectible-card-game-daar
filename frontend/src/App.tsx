import { useEffect, useMemo, useRef, useState } from 'react'
//import styles from './styles.module.css'
import * as ethereum from '@/lib/ethereum'
import * as main from '@/lib/main'
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { useWallet } from "./utilities"
import { LoginPage } from "./pages/LoginPage";
import { AdminPage } from "./pages/AdminPage";
import { UserPage } from "./pages/UserPage";
import {BigNumber, utils} from 'ethers'




/*
export const App = () => {
  const wallet = useWallet()


  return (

    <BrowserRouter>
    <Routes>
      <Route path="/" element={<AdminPage />}>

      </Route>
    </Routes>
    </BrowserRouter>

  )
}*/
export const App = () => {
  const wallet = useWallet()
  const adminAccount = '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266';

  useEffect(() => {
    console.log(wallet?.details)
    // return Promise.resolve()
  }, [wallet])
  

  const isEmptyAccount = !wallet?.details.account;
  const isAdmin = wallet?.details.account ===adminAccount ;
  console.log("app")
  //mie modifiche per poter individuare il login in metamask e se non è stato effettuato lo indirizzo alla pagine di login altrimenti se è un admin vado in admin page e se è uno user vado in user page
  //poi nella login page inserisco uno useAffect che controlli che ci siano state modifiche nell'account e se non ci sono state continua a mostrare please login, mentre se ci sono state rimanda alle due pagine admin e user a seconda dell'utente loggato
  //inserire una default page per indirizzi non validi e poi un aggiornamento della pagina nel caso in cui un utente dovesse cambiare account e per esempio passare da admin a user
  return (
    <BrowserRouter>
      <Routes>
        <Route path= "/" element={<LoginPage />}/>
        <Route path="/UserPage" element={<UserPage />} />
        <Route path="/AdminPage" element={<AdminPage />} />
        <Route path="/LoginPage" element={<LoginPage />} />
      </Routes>
    </BrowserRouter>
  );

  /*<Route
          path="/"
          element={
            isEmptyAccount ? (
              <LoginPage />
            ) : isAdmin ? (
              <AdminPage />
            ) : (
              <UserPage />
            )
          }
        */
  /*
  
  const [balance, setBalance] = useState<string>("0")
  const [info, setInfo] = useState<string>("connecting")
  const [contractAddress, setContractAddress] = useState<string>("")

  async function depositEth() {
    wallet?.contract.Deposit({ value: utils.parseEther("1") }).then((trx) => {
      console.log(trx)
    })
  }

  useAffect(() => {
    setInfo(String(wallet?.details.account))
    wallet?.contract.seeBalance().then((num: BigNumber) => {
      setBalance(utils.formatEther(num))
    })
    setContractAddress(String(wallet?.contract.address))

    return Promise.resolve()
  }, [wallet])

  return (
    <div>
      
      <button onClick={depositEth}>Deposit 1 ETH</button>
      <p>Account {info}</p>
      <p>Contract {contractAddress}</p>
      <p>Balance on the contract {balance} ETH</p>
    </div>
  )*/


}
