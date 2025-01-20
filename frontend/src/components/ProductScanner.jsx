import React, { useState, useRef, useEffect } from "react";
import Loader from "./Loader";

const ProductScanner = () => {
  const videoRef = useRef(null); // Reference to the video element
  const [capturedFrame, setCapturedFrame] = useState(null); // Captured image from video
  const [scannedText, setScannedText] = useState(""); // Text from OCR
  const [isCameraOn, setIsCameraOn] = useState(true); // Track camera state (on/off)
  const [loading, setLoading] = useState(false); // Track loading state

  // Get the media stream from the user's camera
  const getMedia = async () => {
    try {
      const constraints = {
        video: {
          facingMode: "environment", // Use rear camera
        },
      };
      const stream = await navigator.mediaDevices.getUserMedia(constraints);
      videoRef.current.srcObject = stream;
    } catch (error) {
      console.error("Error accessing camera:", error);
    }
  };

  // Turn the camera on or off
  const toggleCamera = () => {
    if (isCameraOn) {
      // Stop the camera stream
      const stream = videoRef.current?.srcObject;
      const tracks = stream?.getTracks();
      tracks?.forEach((track) => track.stop());
      setIsCameraOn(false);
    } else {
      getMedia(); // Start the camera feed
      setIsCameraOn(true);
    }
  };

  // Function to capture a frame from the video feed
  const captureFrame = () => {

    setLoading(true); // Set loading to true while processing the image

    const canvas = document.createElement("canvas");
    const video = videoRef.current;
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;
    const ctx = canvas.getContext("2d");
    ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
    
    canvas.toBlob(async (blob) => {
      setCapturedFrame(URL.createObjectURL(blob)); // Display captured image
      
      // Retrieve familyData from localStorage
      const storedFamilyData = JSON.parse(localStorage.getItem("familyData"));
      
      // Prepare FormData
      const formData = new FormData();
      formData.append("image", blob);
      formData.append("familyData", JSON.stringify(storedFamilyData)); // Send familyData as a JSON string
      
      // Send image and familyData to backend API for OCR processing
      const res = await fetch("http://localhost:5000/geminiocr", {
        method: "POST",
        body: formData,
      });
      
      // Handle response
      const data = await res.json();
      setScannedText(data.result); // Display the OCR result text
    }, "image/jpeg");

    setLoading(false); // Set loading to false after processing the image
  };
  

  // Initialize the camera feed when the component mounts
  useEffect(() => {
    if (isCameraOn) {
      getMedia();
    }
    return () => {
      if (videoRef.current?.srcObject) {
        // Stop the media stream when the component unmounts
        const stream = videoRef.current.srcObject;
        const tracks = stream.getTracks();
        tracks.forEach((track) => track.stop());
      }
    };
  }, [isCameraOn]);

  // Function to format and display scanned text in a structured table format
  const formatScannedText = (text) => {
    // Assume the text is formatted as a JSON or table-like structure
    const lines = text.split("\n").filter((line) => line.trim() !== "");
    const headers = lines[0].split("|").map((header) => header.trim());
    const rows = lines
      .slice(1)
      .map((line) => line.split("|").map((cell) => cell.trim()));
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
                    {/* Check for ** and replace with bold */}
                    {cell.split("**").map((part, partIndex) => {
                      if (partIndex % 2 !== 0) {
                        // This part is between the **, so make it bold
                        return (
                          <strong key={partIndex} className="font-semibold">
                            {part}
                          </strong>
                        );
                      }
                      return part; // Return non-bold part
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
    <div className="flex flex-col items-center space-y-8">
      {/* Video or Image Display */}
      <div className="flex flex-row p-8 space-x-8">
        <div className="flex flex-col gap-6">
          {/* Video feed or captured image */}
          {capturedFrame ? (
            <img
              className="rounded-lg shadow-lg max-w-full h-auto"
              src={capturedFrame}
              alt="Captured Frame"
            />
          ) : (
            <video
              className="rounded-lg shadow-lg max-w-full h-auto"
              ref={videoRef}
              autoPlay
              playsInline
            />
          )}

          {/* Camera control and capture buttons */}
          <div className="flex gap-6 w-full justify-between mt-4">
            <button
              className="px-6 py-3 bg-gray-800 text-white rounded-lg shadow-md hover:bg-gray-700 transition duration-300"
              onClick={toggleCamera}
            >
              {isCameraOn ? "Turn Off Camera" : "Turn On Camera"}
            </button>
            <button
              className="px-6 py-3 bg-blue-500 text-white rounded-lg shadow-md hover:bg-blue-400 transition duration-300"
              onClick={captureFrame}
            >
              Capture Frame
            </button>
          </div>
        </div>
      </div>

      {/* Display scanned text after capturing image */}
      {capturedFrame && (
        <div className="p-8 w-full bg-gray-100 rounded-lg shadow-lg">
          {scannedText ? (
            formatScannedText(scannedText)
          ) : (
            <h2 className="text-xl text-gray-500">Loading...</h2>
          )}
        </div>
      )}
    </div>
    </>
  );
};

export default ProductScanner;
