import { Menu } from '@/components/menu/Menu.component'
import React from 'react'
import { Outlet } from 'react-router-dom'

const Layout = () => {
  return (
    <>
      <Menu />

      <Outlet />
    </>
  )
}

export default Layout
