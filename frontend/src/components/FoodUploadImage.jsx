import React, { useState } from 'react';
import BackupOutlinedIcon from '@mui/icons-material/BackupOutlined';
import axios from 'axios';
import Loader from './Loader';

const FoodUploadImage = ({ isOpen }) => {
  const [file, setFile] = useState(null);
  const [responseData, setResponseData] = useState(null); 
  const [loading, setLoading] = useState(false); 
 
  const handleFileChange = (e) => {
    setFile(e.target.files[0]);
  };
 
  const handleSubmit = async () => {
    if (!file) {
      alert('Please select a file to upload');
      return;
    }
    setLoading(true)
    const formData = new FormData();
    formData.append('image', file); 

    try { 
      const response = await axios.post('http://localhost:5000/dashboard', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      console.log('Upload successful:', response);
 
      setResponseData(response.data.result);
    } catch (error) {
      console.error('Error uploading the image:', error);
    }finally{
      setLoading(false)
    }
  };
 
  const formatScannedText = (text) => { 
    const lines = text.split("\n").filter((line) => line.trim() !== "");
    const headers = lines[0].split("|").map((header) => header.trim());
    const rows = lines.slice(1).map((line) => line.split("|").map((cell) => cell.trim()));

    const formattedText = text.replace(/\*\*(.*?)\*\*/g, (match, p1) => {
      return `<strong class="font-bold">${p1}</strong>`;
    });

    return (
      <div className="p-4 bg-white rounded-lg shadow-md">
        <h2 className="text-2xl font-bold text-gray-800 mb-4">
          Nutrient Breakdown for the Product
        </h2>
        <table className="w-full table-auto border-collapse border border-gray-200">
          <thead>
            <tr>
              {headers.map((header, index) => (
                <th
                  key={index}
                  className="px-4 py-2 border border-gray-300 bg-gray-100 text-left text-gray-700 font-semibold"
                >
                  {header}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {rows.map((row, rowIndex) => (
              <tr key={rowIndex}>
                {row.map((cell, cellIndex) => (
                  <td
                    key={cellIndex}
                    className="px-4 py-2 border border-gray-300 text-gray-800"
                  > 
                    {cell.split("**").map((part, partIndex) => {
                      if (partIndex % 2 !== 0) { 
                        return (
                          <strong key={partIndex} className="font-semibold">
                            {part}
                          </strong>
                        );
                      }
                      return part;  
                    })}
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  };

  return (
    <>
    {loading && (
              <div className="absolute z-50 h-screen top-0 left-0 bg-black/35 flex flex-col justify-center items-center w-full">
                <Loader />
              </div>
            )}
    <div
      className="fixed top-0 left-0 right-0 bottom-0 bg-black/50 opacity-100  z-40"
      onClick={isOpen}
    >
      <div
        className="fixed top-1/4 left-1/2 transform -translate-x-1/2 bg-white p-6 rounded-lg shadow-lg w-[50%] max-h-[80%] overflow-y-auto"
        onClick={(e) => e.stopPropagation()}
      >
        <div className="flex justify-between pb-5 items-center">
          <h3 className="text-xl font-semibold text-blue-600">Upload Food Image</h3>
          <button
            onClick={isOpen}
            className="text-xl font-bold text-gray-500"
          >
            X
          </button>
        </div>
 
        <label htmlFor="file" className="flex flex-col items-center justify-center border-2 border-dashed border-gray-400 bg-white p-6 rounded-lg shadow-md cursor-pointer">
          <div className="flex h-10 w-10 items-center justify-center">
            <BackupOutlinedIcon className="scale-150 opacity-50"/>
          </div>
          <div className="mt-2 text-gray-500">
            <span>Click to upload image</span>
          </div>
          <input 
            type="file" 
            id="file" 
            className="hidden" 
            onChange={handleFileChange} 
          />
        </label>
 
        <div className="flex justify-between mt-4">
          <button
            onClick={handleSubmit}
            className="py-2 px-4 bg-green-500 rounded-lg text-white hover:bg-green-600 transition duration-200"
          >
            Submit
          </button>
        </div>
 
        {responseData && (
          <div className="mt-6 max-h-[60vh] overflow-y-auto">
            {formatScannedText(responseData)}
          </div>
        )}
      </div>
    </div>
    </>
  );
};

export default FoodUploadImage;
