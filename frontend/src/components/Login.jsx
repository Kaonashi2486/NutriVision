import React, { useState } from "react";
import EarthCanvas from "./EarthCanvas";
import StarrySky from "../utils/StarrySky";
import axios from "axios";

const Login = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [familyData, setFamilyData] = useState([{ name: "", problem: "" }]);

  const handleAddFamilyMember = () => {
    setFamilyData([...familyData, { name: "", problem: "" }]);
  };

  const handleFamilyChange = (index, field, value) => {
    const newFamilyData = [...familyData];
    newFamilyData[index][field] = value;
    setFamilyData(newFamilyData);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
  
    localStorage.setItem('email', email);
    localStorage.setItem('password', password);
    localStorage.setItem('familyData', JSON.stringify(familyData)); 
  
    console.log("🚀 ~ LOCALSTORAGE ~ familyData:", JSON.parse(localStorage.getItem('familyData'))) 
    
    setPassword("");
    setEmail("");
    setFamilyData([{ name: "", problem: "" }]); 
  
  };
    
  

  // const handleSubmit = async (e) => {
  //   e.preventDefault();
  //   try {
  //     const response = await axios.post('http://localhost:5000/login', {
  //       email: email,
  //       password: password,
  //       familyData: familyData,
  //     });
  //     console.log(response.data);
  //   } catch (error) {
  //     alert('Login Error: ', error);
  //     console.log('Login error: ', error);
  //   }
  //   console.log('Family Data:', familyData);
  // };

  return (
    <div className="bg-black w-screen h-screen flex">
      <div className="flex-1 relative">
        <StarrySky />
        <EarthCanvas />
      </div>

      {/* Right side: Form */}
      <div className="w-[35%] h-[80%] mt-[5%] mr-[10%] p-6 flex items-center justify-center">
        <form
          onSubmit={handleSubmit}
          className="text-neutral-100 overflow-y-scroll py-6 relative overflow-hidden flex flex-col justify-around w-full h-full border border-neutral-500 rounded-lg bg-black/10 backdrop-blur-[1.5px] p-6"
        >
          <div className="before:absolute before:w-32 before:h-20 before:right-2 before:bg-rose-300 before:-z-10 before:rounded-full before:blur-xl before:-top-12 z-10 after:absolute after:w-24 after:h-24 after:bg-purple-300 after:-z-10 after:rounded-full after:blur after:-top-12 after:-right-6">
            <span className="font-extrabold text-2xl text-violet-400">
              Welcome Back
            </span>
            <p className="text-neutral-400">Please log in to continue</p>
          </div>

          <div className="flex flex-col gap-4 mt-4">
            {/* Email Input */}
            <div className="relative rounded-lg w-full overflow-hidden before:absolute before:w-12 before:h-12 before:content[''] before:right-0 before:bg-violet-500/30 before:rounded-full before:blur-lg after:absolute after:z-10 after:w-20 after:h-20 after:content[''] after:bg-rose-300/30 after:right-12 after:top-3 after:rounded-full border border-neutral-500 after:blur-lg">
              <input
                type="email"
                onChange={(e) => setEmail(e.target.value)}
                value={email}
                className="relative bg-transparent ring-0 outline-none text-neutral-100 rounded-lg block w-full p-2.5"
                placeholder="Email"
              />
            </div>

            {/* Password Input */}
            <div className="relative rounded-lg w-full overflow-hidden before:absolute before:w-12 before:h-12 before:content[''] before:right-0 before:bg-violet-500/30 before:rounded-full before:blur-lg after:absolute after:z-10 after:w-20 after:h-20 after:content[''] after:bg-rose-300/30 after:right-12 after:top-3 after:rounded-full border border-neutral-500 after:blur-lg">
              <input
                type="password"
                onChange={(e) => setPassword(e.target.value)}
                value={password}
                className="relative bg-transparent ring-0 outline-none text-neutral-100 rounded-lg block w-full p-2.5"
                placeholder="Password"
              />
            </div>

            {/* Family Member Inputs */}
            {familyData.map((member, index) => (
              <div
                key={index}
                className="relative rounded-lg w-full overflow-hidden before:absolute before:w-12 before:h-12 before:content[''] before:right-0 before:bg-violet-500/30 before:rounded-full before:blur-lg after:absolute after:z-10 after:w-20 after:h-20 after:content[''] after:bg-rose-300/30 after:right-12 after:top-3 after:rounded-full border border-neutral-500 after:blur-lg mt-4"
              >
                {/* Family Member Name Input */}
                <input
                  type="text"
                  placeholder="Family Member Name"
                  value={member.name}
                  onChange={(e) =>
                    handleFamilyChange(index, "name", e.target.value)
                  }
                  className="relative bg-transparent ring-0 outline-none text-neutral-100 rounded-lg block w-full p-2.5"
                />
              </div>
            ))}

            {familyData.map((member, index) => (
              <div
                key={index}
                className="relative rounded-lg w-full overflow-hidden before:absolute before:w-12 before:h-12 before:content[''] before:right-0 before:bg-violet-500/30 before:rounded-full before:blur-lg after:absolute after:z-10 after:w-20 after:h-20 after:content[''] after:bg-rose-300/30 after:right-12 after:top-3 after:rounded-full border border-neutral-500 after:blur-lg mt-4"
              >
                {/* Family Member Problem Input */}
                <input
                  type="text"
                  placeholder="Problem"
                  value={member.problem}
                  onChange={(e) =>
                    handleFamilyChange(index, "problem", e.target.value)
                  }
                  className="relative bg-transparent ring-0 outline-none text-neutral-100 rounded-lg block w-full p-2.5"
                />
              </div>
            ))}

            {/* Button to add more family members */}
            <button
              type="button"
              onClick={handleAddFamilyMember}
              className="font-semibold bg-violet-500 text-neutral-50 p-2 rounded-lg hover:bg-violet-500/80 duration-500 mt-4"
            >
              Add Family Member +
            </button>

            {/* Login Button */}
            <button
              type="submit"
              className="font-semibold bg-violet-500 text-neutral-50 p-2 rounded-lg hover:bg-violet-500/80 duration-500 mt-4"
            >
              Login
            </button>
            <p className="text-neutral-400">
              Haven't made an account?{" "}
              <a href="/register" className="text-violet-500 cursor-pointer">
                Sign In
              </a>
            </p>
          </div>
        </form>
      </div>
    </div>
  );
};

export default Login;
