import React from 'react'
import { checkUser } from '@/lib/checkUser';

export default async function Navbar() {
  const user = await checkUser();

  return (
    <div>
      {user ? (
        <p>Welcome back, {user.name}!</p>
      ) : (
        <p>Please log in.</p>
      )}    
    </div>
  ) 
}
