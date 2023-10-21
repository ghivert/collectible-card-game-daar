import React from 'react'
import { Link } from 'react-router-dom'

export const Menu = () => (
  <nav>
    <ul>
      <li>
        <Link to="/">Home</Link>
      </li>
      <li>
        <Link to="/collections">Collections</Link>
      </li>
      <li>
        <Link to="/me">Profil</Link>
      </li>
    </ul>
  </nav>
)
