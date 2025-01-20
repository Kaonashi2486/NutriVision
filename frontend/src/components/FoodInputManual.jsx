import React, { useState } from 'react';

const FoodInputManual = ({ isOpen }) => {
  const [food, setFood] = useState([{ foodItem: '', quantity: '' }]);  
 
  const handleAddInput = () => {
    setFood([...food, { foodItem: '', quantity: '' }]);
  };
 
  const handleFoodChange = (index, field, value) => {
    const newFood = [...food];
    newFood[index][field] = value;
    setFood(newFood);
  };

  return (
      <div
        className="fixed top-0 left-0 right-0 bottom-0 bg-black/50 opacity-100 z-40"
        onClick={isOpen}
      >
        <div
          className="fixed top-1/4 left-1/2 transform -translate-x-1/2 bg-white p-6 rounded-lg shadow-lg w-[30%]"
          onClick={(e) => e.stopPropagation()}
        >
          <div className="flex justify-between pb-5 items-center">
            <h3 className="text-xl font-semibold">Input Food Items</h3>
            <button
              onClick={isOpen}
              className="text-xl font-bold text-gray-500"
            >
              X
            </button>
          </div>
 
          <div className="mt-4 space-y-4">
            {food.map((food, index) => (
              <div key={index} className="flex gap-4">
                <input
                  type="text"
                  placeholder="Enter food item"
                  value={food.foodItem}
                  onChange={(e) => handleFoodChange(index, 'foodItem', e.target.value)}
                  className="w-full p-2 border border-gray-300 rounded-lg"
                />
                <input
                  type="number"
                  placeholder="Enter quantity"
                  value={food.quantity}
                  onChange={(e) => handleFoodChange(index, 'quantity', e.target.value)}
                  className="w-full p-2 border border-gray-300 rounded-lg"
                />
              </div>
            ))}
          </div>
 
          <div className="flex justify-between mt-4">
            <button
              onClick={handleAddInput}
              className="py-2 px-4 bg-blue-500 rounded-lg text-white hover:bg-blue-600 transition duration-200"
            >
              Add +
            </button>
            <button
              onClick={isOpen}
              className="py-2 px-4 bg-green-500 rounded-lg text-white hover:bg-green-600 transition duration-200"
            >
              Submit
            </button>
          </div>
        </div>
      </div>
    
  );
};

export default FoodInputManual;
