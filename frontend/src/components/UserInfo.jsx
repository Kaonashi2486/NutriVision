import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const UserInfo = () => {
  const [height, setHeight] = useState('');
  const [weight, setWeight] = useState('');
  const [age, setAge] = useState('');
  const [userInfoSubmitted, setUserInfoSubmitted] = useState(false);
  const [goal, setGoal] = useState('');

  const navigate = useNavigate();

  const handleUserInfoSubmit = (e) => {
    e.preventDefault();
    console.log('User Info:', { height, weight, age });
    setUserInfoSubmitted(true); // Switch to goal setting form
  };

  const handleGoalSubmit = (e) => {
    e.preventDefault();
    console.log('User Goal:', goal);
    // Handle goal submission logic here
  };

  return (
    <>
    <div className="flex justify-center items-center h-screen bg-gradient-to-b from-[#DCF9E0] to-white">
      <div className="w-[450px] bg-gray-100/30 shadow-[rgba(0,_0,_0,_0.10)_0px_10px_36px_0px,_rgba(0,_0,_0,_0.06)_0px_0px_0px_1px] rounded-lg p-6">
        {!userInfoSubmitted ? (
          <>
            <label className="text-center text-2xl font-bold text-gray-800 mb-4">
              User Health Analysis
            </label>
            <p className="text-center pt-5 text-sm font-semibold text-gray-500 mb-6">
              Please provide your height, weight, and age. This helps us to better understand your needs.
            </p>
            <form onSubmit={handleUserInfoSubmit} className="space-y-6 pb-5 pt-5">
              <div className="relative w-full">
                <input
                  type="number"
                  value={height}
                  onChange={(e) => setHeight(e.target.value)}
                  className="w-full p-3 text-gray-800 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                  placeholder="Height (cm)"
                  required
                />
              </div>
              <div className="relative w-full">
                <input
                  type="number"
                  value={weight}
                  onChange={(e) => setWeight(e.target.value)}
                  className="w-full p-3 text-gray-800 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                  placeholder="Weight (kg)"
                  required
                />
              </div>
              <div className="relative w-full">
                <input
                  type="number"
                  value={age}
                  onChange={(e) => setAge(e.target.value)}
                  className="w-full p-3 text-gray-800 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                  placeholder="Age"
                  required
                />
              </div>
              <button
                type="submit"
                className="w-full py-3 bg-green-500 text-white font-semibold rounded-lg hover:bg-green-600 transition duration-300"
              >
                Submit
              </button>
            </form>
          </>
        ) : (
          <>
            <label className="text-center text-2xl font-bold text-gray-800 mb-4">
              Set a Goal for Yourself
            </label>
            <p className="text-left pt-5 text-sm font-semibold text-gray-500 mb-6">
              Select a goal to help us customize your plan.
            </p>
            <form onSubmit={handleGoalSubmit} className="space-y-6 pb-5 pt-5">
              <div className="flex flex-col gap-4">
                <label className="flex items-center space-x-3">
                  <input
                    type="radio"
                    name="goal"
                    value="Lose Fat"
                    onChange={(e) => setGoal(e.target.value)}
                    className="check"
                    checked={goal === 'Lose Fat'}
                  />
                  <span>Lose Fat</span>
                </label>
                <label className="flex items-center space-x-3">
                  <input
                    type="radio"
                    name="goal"
                    value="Build Muscle"
                    onChange={(e) => setGoal(e.target.value)}
                    className="check"
                    checked={goal === 'Build Muscle'}
                  />
                  <span>Build Muscle</span>
                </label>
                <label className="flex items-center space-x-3">
                  <input
                    type="radio"
                    name="goal"
                    value="Maintain Weight"
                    onChange={(e) => setGoal(e.target.value)}
                    className="check"
                    checked={goal === 'Maintain Weight'}
                  />
                  <span>Maintain Weight</span>
                </label>
                <label className="flex items-center space-x-3">
                  <input
                    type="radio"
                    name="goal"
                    value="General Health"
                    onChange={(e) => setGoal(e.target.value)}
                    className="check"
                    checked={goal === 'General Health'}
                  />
                  <span>General Health</span>
                </label>
              </div>
              <button
                type="submit"
                onClick={()=>navigate('/dashboard')}
                className="w-full py-3 bg-green-500 text-white font-semibold rounded-lg hover:bg-green-600 transition duration-300"
              >
                Start Your Journey
              </button>
            </form>
          </>
        )}
      </div>
    </div>

    <style jsx>{`
      .check {
        position: relative;
        width: 20px;
        height: 20px;
        border-radius: 2px;
        appearance: none;
        background-color: gray;
        opacity:0.2;
        transition: all .3s;
      }

      .check::before {
        content: '';
        position: absolute;
        border: solid #fff;
        display: block;
        width: .3em;
        height: .6em;
        border-width: 0 .2em .2em 0;
        z-index: 1;
        opacity: 0;
        right: calc(50% - .1em);
        top: calc(50% - .4em);
        transform: rotate(0deg);
        transition: all .3s;
        transform-origin: center center;
      }

      .check:checked {
        animation: a .3s ease-in forwards;
        background-color: rgb(120, 190, 120);
      }

      .check:checked::before {
        opacity: 1;
        transform: rotate(405deg);
      }

      @keyframes a {
        0% {
          opacity: 1;
          transform: scale(1) rotateY(0deg);
        }
        50% {
          opacity: 0;
          transform: scale(.8) rotateY(180deg);
        }
        100% {
          opacity: 1;
          transform: scale(1) rotateY(360deg);
        }
      }
    `}</style>
    </>
  );
};

export default UserInfo;
