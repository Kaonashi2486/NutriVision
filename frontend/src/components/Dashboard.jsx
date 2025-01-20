import React, { useState } from 'react';
import HistoryIcon from '@mui/icons-material/History';
import BarChartIcon from '@mui/icons-material/BarChart';
import FoodInputManual from './FoodInputManual';
import FoodUploadImage from './FoodUploadImage';
import { useNavigate } from 'react-router-dom';
import Slide from '@mui/material/Slide';
import Navbar from './Navbar';

const Dashboard = () => {
  const [isHistoryPanelOpen, setHistoryPanelOpen] = useState(false);
  const [isPopupOpen, setPopupOpen] = useState(false);
  const [inputManually, setInputManually] = useState(false);
  const [uploadFoodImage, setUploadFoodImage] = useState(false);
  
  const navigate = useNavigate();

  const toggleHistoryPanel = () => {
    setHistoryPanelOpen(!isHistoryPanelOpen);
  };

  const togglePopup = () => {
    setPopupOpen(!isPopupOpen);
  };

  const inputFoodManually = () => {
    setInputManually(true);
    setPopupOpen(false);
  };

  const uploadFoodImageFunction = () => {
    setUploadFoodImage(true);
    setPopupOpen(false);
  }

  const closeUploadPopup = () => {
    setUploadFoodImage(false);
  }
  const closeInputPopup = () => {
    setInputManually(false);
  };

  const scanIngridient = () => {
    navigate("/scan")
  }
  const askExpert = () => {
    navigate("/ask-expert")
  }
  const [checked, setChecked] = React.useState(true);

  return (
    <div className="h-screen flex overflow-x-hidden flex-col">
      <Navbar/>
      <div className="flex flex-grow">
        
        <Slide direction="up" in={checked} mountOnEnter unmountOnExit>
        <div id="left" className="w-[30%] bg-yellow-200 p-10 pt-20">
          <div className="space-y-3 text-center">
            <div className="border-b pb-3 border-b-black/40 border">
              <button onClick={scanIngridient} className="text-center w-full py-3 font-semibold hover:bg-yellow-300 p-2 rounded-lg transition-colors duration-200">Scan for Nutritional Value</button>
            </div>
            <div className="border-b pb-3 border-b-black/40 border">
              <button onClick={askExpert} className="text-center w-full py-3 font-semibold hover:bg-yellow-300 p-2 rounded-lg transition-colors duration-200">Ask Our Expert</button>
            </div>
            <div className="border-b pb-3 border-b-black/40 border">
              <button className="text-center w-full py-3 font-semibold hover:bg-yellow-300 p-2 rounded-lg transition-colors duration-200">Quick Exercises</button>
            </div>
            <div className="border-b pb-3 border-b-black/40 border">
              <button className="text-center w-full py-3 font-semibold hover:bg-yellow-300 p-2 rounded-lg transition-colors duration-200">Get Quick Recipes</button>
            </div>
            <div className="border-b pb-3 border-b-black/40 border">
              <button className="text-center w-full py-3 font-semibold hover:bg-yellow-300 p-2 rounded-lg transition-colors duration-200">Nutrition for Pets</button>
            </div>
          </div>
        </div>
        </Slide>

        <div id="right" className="w-[70%] bg-white border border-black rounded-l-3xl p-10"
        style={{ boxShadow: '4px 0px 10px rgba(0, 0, 0, 1)' }}
        >
          <div className="bg-green-600 text-white border-none rounded-3xl p-4 shadow-lg px-10 mb-4">
            <div className="flex justify-between items-center">
              <div className="text-lg font-semibold">Check Your Food</div>
              <div className="space-x-10">
                <button className='hover:opacity-70 duration-300 text-yellow-300'>Analysis<BarChartIcon className='opacity-70 ml-1 scale-90'/></button>
                <button onClick={toggleHistoryPanel} className='hover:opacity-70 duration-300 text-yellow-300'>History<HistoryIcon className='opacity-70 ml-1 scale-90' /></button>
              </div>
            </div>
          </div>

          <div className='flex justify-center items-center gap-10'>
            <h3 className="text-xl font-bold relative text-blue-600">What's on your plate today?</h3>
            <button onClick={togglePopup} className="bg-blue-500 text-white py-2 px-6 rounded-xl mt-3 mb-3 hover:bg-blue-600">Share</button>
          </div>

          <div className="mt-6">
            <table className="min-w-full table-auto border-collapse">
              <thead>
                <tr className="border-b">
                  <th className="py-2 px-4 text-left">Meals You Had Today</th>
                  <th className="py-2 px-4 text-left">Nutrients Fulfilled</th>
                </tr>
              </thead>
              <tbody>
                <tr className="border-b">
                  <td className="py-2 px-4">---</td>
                  <td className="py-2 px-4">---</td>
                </tr>
                <tr className="border-b">
                  <td className="py-2 px-4">---</td>
                  <td className="py-2 px-4">---</td>
                </tr>
              </tbody>
            </table>
          </div>

          <div className="mt-10 border h-[50%] rounded-3xl overflow-x-hidden overflow-y-scroll border-gray-400">
            <div className=" ml-10 flex w-full bg-white">
              <div className='flex p-6 border border-l-gray-500 h-14vh mt-4 w-[50%]'>
                Detailed Information about the chart
              </div>
            </div>
          </div>
        </div>
      </div>

 {/* History Panel */}
      {isHistoryPanelOpen && (
        <div className="fixed top-0 right-0 w-[30%] overflow-y-scroll h-full duration-500 bg-white border-l border-black shadow-xl z-50 p-4">
          <div className="flex justify-between items-center">
            <h3 className="text-lg font-bold text-green-600">History</h3>
            <button onClick={toggleHistoryPanel} className="text-xl font-bold text-gray-500">X</button>
          </div>
          
          <table className="mt-6 min-w-full table-auto border-collapse">
            <thead>
              <tr className="border-b">
                <th className="py-2 px-4 text-left font-semibold">Nutrients Consumed</th>
                <th className="py-2 px-4 text-left font-semibold">Nutrients Goal</th>
              </tr>
            </thead>
            <tbody>
              {Array(7).fill(null).map((_, index) => (
                <tr key={index} className="border-b">
                  <td className="py-2 px-4">---</td>
                  <td className="py-2 px-4">---</td>
                </tr>
              ))}
            </tbody>
          </table>

          <div className="mt-6">
            <table className="min-w-full table-auto border-collapse">
              <thead>
                <tr className="border-b">
                  <th className="py-2 px-4 text-left">Nutrients Consumed</th>
                  <th className="py-2 px-4 text-left">Nutrients Goal</th>
                </tr>
              </thead>
              <tbody>
                {Array(7).fill(null).map((_, index) => (
                  <tr key={index + 7} className="border-b">
                    <td className="py-2 px-4">---</td>
                    <td className="py-2 px-4">---</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Dark Background Overlay for History Panel */}
      {isHistoryPanelOpen && (
        <div 
          className="fixed top-0 left-0 right-0 bottom-0 bg-black opacity-50 z-40"
          onClick={toggleHistoryPanel}
        ></div>
      )}

      {/* Share Popup */}
      {isPopupOpen && (
        <div className="fixed top-0 left-0 right-0 bottom-0 bg-black/50 opacity-100 z-40"
             onClick={togglePopup}>
          <div 
            className="fixed top-1/4 left-1/2 transform -translate-x-1/2 bg-white p-6 rounded-lg shadow-lg w-[30%]"
            onClick={(e) => e.stopPropagation()} 
          >
            <div className="flex justify-between pb-5 items-center">
              <h3 className="text-xl font-semibold text-blue-600">Share Your Meal</h3>
              <button onClick={togglePopup} className="text-xl font-bold text-gray-500">X</button>
            </div>
            <div className="mt-4">
              <button 
                className="w-full py-3 font-semibold text-center bg-blue-500 text-white rounded-lg mb-3 hover:bg-blue-600 transition duration-200"
                onClick={inputFoodManually}
              >
                Input Manually
              </button>
              <button 
                className="w-full py-3 font-semibold text-center bg-blue-500 text-white rounded-lg mb-3 hover:bg-blue-600 transition duration-200"
                onClick={uploadFoodImageFunction}
              >
                Upload a Picture
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Input Food Manually Popup */}
      {inputManually && (
        <FoodInputManual isOpen={closeInputPopup}/>
      )}

      {
        uploadFoodImage && (
          <FoodUploadImage isOpen={closeUploadPopup} />
        )
      }
    </div>
  );
};

export default Dashboard;