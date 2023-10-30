import React, { useEffect, useState } from 'react'

const User = props => {
  const [userPokemons, setUserPokemons] = useState([]) //["id1", "id2", "id3]
  const [name, setName] = useState('')

  useEffect(() => {
    const user_adress = props.wallet?.details?.account
    setName(user_adress)
    props.wallet?.contract.allCardsUser(user_adress).then(data => {
      console.log(data)
      setUserPokemons(data)
    })
  }, [])

  return (
    <div>
      <h1>Welcome {name}</h1>
      <h2>Your Pokemons</h2>
      <div>
        {userPokemons.map((pokemon, index) => (
          <div key={index}>
            <h3>Single pokemon</h3>
            <p>{pokemon}</p>
          </div>
        ))}
      </div>
    </div>
  )
}

export default User
