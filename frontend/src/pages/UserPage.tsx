import { useEffect, useMemo, useRef, useState } from 'react'
import styles from '../styles.module.css'
import * as ethereum from '@/lib/ethereum'
import * as main from '@/lib/main'
import { useNavigate } from 'react-router-dom';
import { checkAccount } from '@/utilities'


export const UserPage = () => {
    const [number, setNumber] = useState<number>(0)
    console.log("ciao")
    
    const navigate = useNavigate();
    checkAccount(navigate)

    function buttonClick() {
      console.log("1 click")
      setNumber(number+1)
    }
    return (
      <div className={styles.body}>
        <h1>User Page</h1>
        <button onClick={buttonClick}>click me time={number}!</button>
      </div>
      //go to the admin page if the user logged in as an admin
      //go to the user page once the user has logged into Metamask not as an admin
    )
  }