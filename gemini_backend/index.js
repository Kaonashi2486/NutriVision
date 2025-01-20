const express = require('express');
const app = express();
const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');
require('dotenv').config()
const Groq = require('groq-sdk');
const multer = require('multer');
const cors = require('cors');
app.use(cors())
app.use(express.json());

// Set up the port
const PORT = process.env.PORT || 5000;
const groq = new Groq({ apiKey:  process.env.GROQ_KEY});

// Setup for file upload using multer with disk storage
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadDir = './uploads';  // Directory to store uploaded files
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir);
    }
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    const filename = Date.now() + path.extname(file.originalname);  // Unique filename
    cb(null, filename);
  },
});

const upload = multer({ storage });

// Check if virtual environment exists, and create if not
const venvPath = path.join(__dirname, 'venv');
if (!fs.existsSync(venvPath)) {
  console.log("Creating virtual environment...");

  const createEnv = spawn('python', ['-m', 'venv', 'venv']);
  createEnv.stdout.on('data', (data) => console.log(`stdout: ${data}`));
  createEnv.stderr.on('data', (data) => console.error(`stderr: ${data}`));

  createEnv.on('close', (code) => {
    console.log(`Virtual environment created with code ${code}`);
    installDependencies();
  });
} else {
  console.log("Virtual environment already exists. Skipping creation...");
  installDependencies();
}

function installDependencies() {
  const requirementsPath = path.join(__dirname, 'requirements.txt');
  if (fs.existsSync(requirementsPath)) {
    console.log("Installing dependencies...");

    const installDeps = spawn('pip', ['install', '-r', requirementsPath], {
      cwd: __dirname,
    });

    installDeps.stdout.on('data', (data) => console.log(`stdout: ${data}`));
    installDeps.stderr.on('data', (data) => console.error(`stderr: ${data}`));

    installDeps.on('close', (code) => {
      console.log(`Dependencies installed with code ${code}`);
    });
  } else {
    console.error('requirements.txt not found!');
  }
}

// POST route to handle image uploads
app.post('/dashboard', upload.single('image'), (req, res) => {
  // If no image was uploaded
  if (!req.file) {
    return res.status(400).json({ error: 'No image uploaded' });
  }

  const uploadedImage = req.file;
  const imagePath = path.join(__dirname, 'uploads', uploadedImage.filename);

  // Python script should process the image
  const pythonProcess = spawn('python', ['app.py', 'process_image', imagePath]);

  let responseSent = false; // Track if a response has already been sent

  // Collect the output from Python
  pythonProcess.stdout.on('data', (data) => {
    if (!responseSent) {
      const response = data.toString();
      res.json({ result: response });
      responseSent = true;  // Mark that the response has been sent
    }
  });

  // Handle errors from Python script
  pythonProcess.stderr.on('data', (data) => {
    if (!responseSent) {
      console.error(`stderr: ${data}`);
      res.status(500).json({ error: 'Error executing Python script' });
      responseSent = true;  // Mark that the response has been sent
    }
  });

  // Handle process close event
  pythonProcess.on('close', (code) => {
    if (!responseSent) {  // Ensure response is not sent twice
      if (code !== 0) {
        res.status(500).json({ error: `Python process exited with code ${code}` });
      }
      responseSent = true;  // Mark that the response has been sent
    }
  });
});



app.post('/geminiocr', upload.single('image'), (req, res) => {
  // If no image was uploaded
  if (!req.file) {
    return res.status(400).json({ error: 'No image uploaded' });
  }

  const uploadedImage = req.file;
  const imagePath = path.join(__dirname, 'uploads', uploadedImage.filename);

  // Retrieve familyData from request body (as it was sent from frontend)
  const familyData = JSON.parse(req.body.familyData);
  console.log(familyData)
  // Prepare the data to send to the Python process
  const familyDataPrompt = JSON.stringify(familyData);

  // Spawn a Python process to process the image
  const pythonProcess = spawn('python', ['app.py', 'scan_image_for_ingredients', imagePath, familyDataPrompt]);

  let responseSent = false; // Track if a response has already been sent

  // Collect the output from the Python script
  pythonProcess.stdout.on('data', (data) => {
    if (!responseSent) {
      const response = data.toString();  // Extract the output from Python script
      res.json({ result: response });    // Send the response back to the frontend
      responseSent = true;  // Mark that the response has been sent
    }
  });

  // Handle errors from the Python script
  pythonProcess.stderr.on('data', (data) => {
    if (!responseSent) {
      console.error(`stderr: ${data}`);
      res.status(500).json({ error: 'Error executing Python script' });
      responseSent = true;  // Mark that the response has been sent
    }
  });

  // Handle process close event
  pythonProcess.on('close', (code) => {
    if (!responseSent) {  // Ensure response is not sent twice
      if (code !== 0) {
        res.status(500).json({ error: `Python process exited with code ${code}` });
      }
      responseSent = true;  // Mark that the response has been sent
    }

    // Clean up the uploaded image after processing
    fs.unlinkSync(imagePath);
  });
});



app.post('/messageai', async (req, res) => {
  try {
    const { msg } = req.body;

    const completion = await groq.chat.completions.create({
      messages: [
        {
          role: 'user',
          content: 'Act as a nutritionist adviser for the following question given to you and answer appropriately with proper numbers and facts and help the user understand by breaking down the scientific terms to simple language. MAKE SURE to answer as briefly and formally as possible. MAKE SURE to format the code such that each new point is on a new line and ensure proper readability.' + msg,
        },
      ],
      model: 'llama3-8b-8192',
      temperature: 0.7,
      max_tokens: 1024,
    });

    return res.status(200).json({
      success: true,
      response: completion.choices[0]?.message?.content || 'No response generated',
    });

  } catch (error) {
    console.error('Error during AI chat generation:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.post('/login', async(req,res)=>{
  try {
    
    const {username, password, familyInfo} = req.body;
    localStorage.setItem("username",username)
    localStorage.setItem("password",password)

  } catch (error) {
    console.log("Error in login: ", error)
    res.status(500).json({error:"Login Error"})
  }
})

// Start the Express server
app.listen(PORT, () => {
  console.log(`Server listening on PORT ${PORT}`);
});
