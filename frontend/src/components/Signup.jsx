import React from 'react'
import EarthCanvas from './EarthCanvas';
import StarrySky from '../utils/StarrySky';

const Signup = () => {
    return (
        <div className="bg-black w-screen h-screen flex">
          {/* Left side: Starry Sky + EarthCanvas */}
          <div className="flex-1 relative">
            <StarrySky />
            <EarthCanvas />
          </div>
    
          {/* Right side: Form */}
          <div className="w-[35%] h-[80%] mt-[5%] mr-[10%] p-6 flex items-center justify-center "> {/* Changed w-1/3 to w-2/3 */}
            <form className="text-neutral-100 py-6 relative overflow-hidden  flex flex-col justify-around w-full h-full border border-neutral-500 rounded-lg bg-black/10 backdrop-blur-[1.5px] p-6">
              <div className="before:absolute before:w-32 before:h-20 before:right-2  before:bg-rose-300 before:-z-10 before:rounded-full before:blur-xl before:-top-12 z-10 after:absolute after:w-24 after:h-24 after:bg-purple-300 after:-z-10 after:rounded-full after:blur after:-top-12 after:-right-6">
                <span className="font-extrabold text-2xl text-violet-400">
                  Welcome
                </span>
                <p className="text-neutral-400">
                  Please Sign in to continue
                </p>
              </div>
              
              <div className="flex flex-col gap-4 mt-4">

                <div className="relative rounded-lg w-full overflow-hidden before:absolute before:w-12 before:h-12 before:content[''] before:right-0 before:bg-violet-500/30 before:rounded-full before:blur-lg after:absolute after:z-10 after:w-20 after:h-20 after:content[''] after:bg-rose-300/30 after:right-12 after:top-3 after:rounded-full border border-neutral-500 after:blur-lg">
                  <input
                    type="text"
                    className="relative bg-transparent ring-0 outline-none text-neutral-100 rounded-lg block w-full p-2.5"
                    placeholder="Username"
                  />
                </div>

                {/* Email Input */}
                <div className="relative rounded-lg w-full overflow-hidden before:absolute before:w-12 before:h-12 before:content[''] before:right-0 before:bg-violet-500/30 before:rounded-full before:blur-lg after:absolute after:z-10 after:w-20 after:h-20 after:content[''] after:bg-rose-300/30 after:right-12 after:top-3 after:rounded-full border border-neutral-500 after:blur-lg">
                  <input
                    type="email"
                    className="relative bg-transparent ring-0 outline-none text-neutral-100 rounded-lg block w-full p-2.5"
                    placeholder="Email"
                  />
                </div>
    
                {/* Password Input */}
                <div className="relative rounded-lg w-full overflow-hidden before:absolute before:w-12 before:h-12 before:content[''] before:right-0 before:bg-violet-500/30 before:rounded-full before:blur-lg after:absolute after:z-10 after:w-20 after:h-20 after:content[''] after:bg-rose-300/30 after:right-12 after:top-3 after:rounded-full border border-neutral-500 after:blur-lg">
                  <input
                    type="password"
                    className="relative bg-transparent ring-0 outline-none text-neutral-100 rounded-lg block w-full p-2.5"
                    placeholder="Password"
                  />
                </div>
    
                {/* Login Button */}
                <button className="font-semibold bg-violet-500 text-neutral-50 p-2 rounded-lg hover:bg-violet-500/80 duration-500 mt-4">
                  Sign In
                </button>
                <p className="text-neutral-400">
                  Already have an account? <a href="/login" className="text-violet-500 cursor-pointer">Log In</a>
                </p>
              </div>
            </form>
          </div>
        </div>
      );
}

export default Signup
