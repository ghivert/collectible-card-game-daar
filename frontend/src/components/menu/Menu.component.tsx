import React from 'react'
import { Link } from 'react-router-dom'

export const Menu = () => (
  <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
      <div className="container-fluid">   
        <Link to="/" className="btn btn-outline-light me-2">Home</Link>
        <Link to="/collections" className="btn btn-outline-light me-2">Collections</Link>
        <Link to="/me"  className="btn btn-outline-light me-2">Profil</Link>
      </div>
  </nav>
)
