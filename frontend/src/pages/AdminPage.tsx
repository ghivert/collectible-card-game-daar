import { useEffect, useMemo, useRef, useState } from 'react'
import styles from '../styles.module.css'
import * as ethereum from '@/lib/ethereum'
import * as main from '@/lib/main'
import { useNavigate } from 'react-router-dom';
import { checkAccount } from '@/utilities'
import axios from 'axios'

export const AdminPage = () => {
  const [number, setNumber] = useState<number>(0)
  console.log("ciao")

  const navigate = useNavigate();
  checkAccount(navigate)

  function buttonClick() {
    // console.log("1 click")
    axios.defaults.headers[""]
    axios.get("http://localhost:5657", {}).then((r) => {
      console.log(r.data)
    })
    setNumber(number+1)
  }
  return (
    <div className={styles.body}>
      <h1>Admin Page</h1>
      <button onClick={buttonClick}>click me time={number}!</button>
    </div>
    
  )
}