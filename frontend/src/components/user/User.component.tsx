import React, { useEffect, useState } from 'react'

const User = props => {
  const [name, setName] = useState('')

  useEffect(() => {
    const r = props.wallet?.details?.account
    setName(r)
  })
  return (
    <div>
      <h1>Welcome {name}</h1>
    </div>
  )
}

export default User
