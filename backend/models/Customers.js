const bcrypt=require("bcryptjs");
const nodemailer = require("nodemailer");
const Messages = require("../constants/Message");
const TryCatch = require("../helper/TryCatch");
const { ObjectId } = require('mongodb');
const customerCollection = require("../db").db("Hackathon").collection("Customer");

let Customer = function (data) {
    this.data = data;
    this.errors = [];
    };

    Customer.prototype.cleanUp = function () {
        // get rid of any bogus properties
        this.data = {
            // predefined start
            name: this.data.name,
            lName: this.data.lName,
            email: this.data.email.trim().toLowerCase(),
            password: this.data.password,
            contactNumber: this.data.contactNumber,
            address: this.data.address,
            city: this.data.city,
            role: "customer",
            createdAt: new Date(),
            // predefined end
    
            // Additional fields
            age: this.data.age,
            weight: this.data.weight,
            height: this.data.height,
            gender: this.data.gender,
            isPregnant: this.data.gender === "female" ? this.data.isPregnant : null,
            healthIssues: this.data.healthIssues || {}, // Object to store health issues
            allergies: Array.isArray(this.data.allergies) ? this.data.allergies : [],
            foodPreference: ["veg", "non-veg", "jain"].includes(this.data.foodPreference) 
                            ? this.data.foodPreference 
                            : "veg", // Default to 'veg'
        };
    };
    
                
                Customer.prototype.login = async function () {
                    let attemptedUser = await customerCollection.findOne({ email: this.data.email });
                    this.cleanUp();
                    if (
                      attemptedUser &&
                      bcrypt.compareSync(this.data.password, attemptedUser.password)
                    ) {
                      this.data = attemptedUser;
                      return true;
                    } else {
                      return false;
                    }
                    };

                Customer.prototype.register = async function () {
                    this.cleanUp();
                    let customer = await customerCollection.findOne({ email: this.data.email });
                    if (customer) {
                        this.errors.push(Messages.emailAlreadyExists);
                    }
                    if (!this.errors.length) {
                        let salt = bcrypt.genSaltSync(10);
                        this.data.password = bcrypt.hashSync(this.data.password, salt);
                        await customerCollection.insertOne(this.data);
                        return true;
                    } else {
                        return false;
                    }
                };                        
              
              
               // Method to send a registration email
                Customer.prototype.sendRegistrationEmail = async function () {
                  // Configure the transporter
                  const transporter = nodemailer.createTransport({
                    service: "gmail",
                    host: "smtp.gmail.com",
                    port: 465,
                    secure: true,
                    auth: {
                      user: process.env.NODEMAILER_ADMIN_EMAIL, // Your email
                      pass: process.env.NODEMAILER_ADMIN_PASSWORD // Your email password
                    }
                  });
                
                  // Define the email details
                  const mailOptions = {
                    from: process.env.NODEMAILER_ADMIN_EMAIL,
                    to: this.data.email, // Send to the student's email
                    subject: "Welcome to Our food scanner app!",
                    html: `
                      <h1>Welcome, ${this.data.name}!</h1>
                      <p>We are excited to have you as part of the community. Here are your details:</p>
                      <ul>
                        <li><strong>Email:</strong> ${this.data.email}</li>
                        <li><strong>age:</strong> ${this.data.age}</li>
                        <li><strong>weight:</strong> ${this.data.weight}</li>
                        <li><strong>heigth:</strong> ${this.data.height}</li>
                      </ul>
                      <p>If you have any questions, feel free to reach out.</p>
                      <p>Best regards,<br>FoodScanner</p>
                    `
                  };

                  // Send the email
                  await transporter.sendMail(mailOptions);
                  
                };
                              
model.exports = Customer;                
