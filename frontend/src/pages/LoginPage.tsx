import { useEffect, useMemo, useRef, useState } from 'react'
import styles from '../styles.module.css'
import * as ethereum from '@/lib/ethereum'
import * as main from '@/lib/main'
import {useWallet} from "../utilities"
import {checkAccount} from "../utilities"
import { useNavigate } from 'react-router-dom';

export const LoginPage = () => {
  
  //const wallet = useWallet()//finire di modificare e controllare se effettivamente funziona l'aggiornamento automatico controllando il wallet e l'account del wallet
   
  //vedere se è il caso di mettere direttamente una funzione intera switch account iniziado il navigate dentro
  const navigate = useNavigate();
  checkAccount(navigate)
  
  return (
      <div className={styles.body}>
        <h1>Please login with Metamask!</h1>
      </div>
      
    )
  }