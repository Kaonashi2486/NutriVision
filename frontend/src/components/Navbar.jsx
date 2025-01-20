import React from 'react';
import { Link } from 'react-router-dom'; 
// import './index.css';
import Slide from '@mui/material/Slide';

const Navbar = () => {
  
  const handleLogout = () => {
    localStorage.clear();
    window.location.href='/login'
  }
  const [checked, setChecked] = React.useState(true);

  return (
    <nav className="text-white bg-purple-800 shadow-md">
        <Slide direction="up" in={checked} mountOnEnter unmountOnExit>
        <div className="container mx-auto px-6 py-3 grid">
        <div className="text-3xl font-bold text-center p-4">
          <Link to="/" className="hover:text-green-700 no-underline p-4" >'Nutri<spam className="hover:text-red-700">Vision'</spam></Link>
        </div>
        
        <div className="md:space-x-8 grid justify-center md:flex space-y-4 md:space-y-0 md:justify-center">
          <Link to="/" className=" no-underline p-2 text-center hover:underline rounded-xl">Home</Link>
          <Link to="/foodinput" className="no-underline p-2 text-center hover:underline rounded-xl">Food Input</Link>
          <Link to="/foodupload" className="no-underline p-2 text-center hover:underline rounded-xl">Food Upload</Link>
          <button onClick ={handleLogout} className="p-3 px-4 border rounded-lg bg-red-600 hover:bg-red-500">Logout</button>
        </div>
      </div>
        </Slide>
      
    </nav>
   

  );
};

export default Navbar;