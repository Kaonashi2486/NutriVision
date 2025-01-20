import React, { useState } from 'react';
import axios from 'axios';
import Loader from './Loader';

const ChatBot = () => {
  const [userInput, setUserInput] = useState('');
  const [chatHistory, setChatHistory] = useState([]);
  const [loading, setLoading] = useState(false);

  const handleInputChange = (e) => {
    setUserInput(e.target.value);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    if (userInput.trim() === '') return;

    const newChatHistory = [...chatHistory, { role: 'user', content: userInput }];
    setChatHistory(newChatHistory);
  
    try {
      const response = await axios.post('http://localhost:5000/messageai', { msg: userInput });
      console.log(response);
  
      const chatbotMessage = response.data.response || "Sorry, I couldn't understand that.";
  
      setChatHistory([
        ...newChatHistory,
        { role: 'chatbot', content: formatMessage(chatbotMessage) },
      ]);
      setUserInput('');
    } catch (error) {
      console.error('Error sending message to AI:', error);
    }finally{
      setLoading(false);
    }
  };

  const formatMessage = (message) => {
    if (typeof message !== 'string') {
      return message;
    }

    const lines = message.split("\n").filter(line => line.trim() !== "");

    return lines.map((line, index) => {
      return (
        <div key={index}>
          {loading && (
              <div className="absolute z-20 h-screen top-0 left-0 bg-black/35 flex flex-col justify-center items-center w-full">
                <Loader />
              </div>
            )}
          {index === 0 ? (
            <h3 className="font-bold text-lg mb-2">{line}</h3>
          ) : (
            <p className="text-sm">
              {line.split("**").map((part, partIndex) => {
                if (partIndex % 2 !== 0) {
                  return <strong key={partIndex} className="font-semibold">{part}</strong>;
                }
                return part;
              })}
            </p>
          )}
          <br />
        </div>
      );
    });
  };

  return (
    <div className="flex justify-center items-center h-screen bg-gradient-to-b from-[#DCF9E0] to-white">
      <div className="w-full max-w-4xl bg-white/40 backdrop-blur-lg rounded-lg shadow-xl p-6">
        <div className="flex-1 overflow-auto p-4 space-y-4 max-h-[calc(100vh-200px)]">
          {chatHistory.map((message, index) => (
            <div
              key={index}
              className={`flex ${message.role === 'user' ? 'justify-end' : 'justify-start'} items-start space-x-2`}
            >
              <div
                className={`p-4 rounded-lg max-w-xs ${
                  message.role === 'user'
                    ? 'bg-indigo-600 text-white rounded-br-none'
                    : 'bg-gray-100 text-gray-800 rounded-bl-none'
                }`}
              >
                {message.role === 'chatbot' ? (
                  formatMessage(message.content)
                ) : (
                  <p className="text-sm">{message.content}</p>
                )}
              </div>
            </div>
          ))}
        </div>
  
        <form onSubmit={handleSubmit} className="flex items-center space-x-2 p-4">
          <input
            type="text"
            value={userInput}
            onChange={handleInputChange}
            placeholder="Ask me anything..."
            className="w-full p-3 text-gray-800 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white/60 backdrop-blur-lg"
          />
          <button
            type="submit"
            className="p-3 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition duration-300"
          >
            Send
          </button>
        </form>
      </div>
    </div>
  );
};

export default ChatBot;
