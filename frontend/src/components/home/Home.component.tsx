import { getAllCollections } from '@/services/blockchaine/collection.service'
import React, { useEffect } from 'react'

const Home = ({ wallet }) => {
  useEffect(() => {
    getAllCollections(wallet).then(console.log)
  }, [])

  return (
    <div>
      <h1>Home</h1>
    </div>
  )
}

export default Home
