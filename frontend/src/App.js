import './App.css';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Home from './components/Home';
import Login from './components/Login';
import Signup from './components/Signup';
import Dashboard from './components/Dashboard';
import UserInfo from './components/UserInfo';
import ProductScanner from './components/ProductScanner';
import ChatBot from './components/ChatBot';
import RadarChart from './components/RadarChart';
import PieChart from './components/PieChart';

function App() {
  return (<>
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} /> 
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Signup />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/user-info" element={<UserInfo />}/>
        <Route path="/scan" element={<ProductScanner />}/>
        <Route path="/ask-expert" element={<ChatBot/>} />
        <Route path="/radar" element={<RadarChart/>} />
        <Route path="/pie" element={<PieChart/>} />
      </Routes>
    </BrowserRouter>
    </>
  );
}

export default App;
