const Messages = require("../constants/Message");
const TryCatch = require("../helper/TryCatch");
const { ObjectId } = require('mongodb');
const productCollection = require("../db").db("Hackathon").collection("Product");

let Product = function (data) {
    this.data = data;
    this.errors = [];
    };

    Product.prototype.cleanUp = function () {
        // get rid of any bogus properties
        this.data = {
            // predefined start
            name: this.data.name,
            productid: this.data.productid,  //14 digit FSSAI code
            country: this.data.country,      //Country of origin/manufacturer   
            role: "product",
            createdAt: new Date(),
            // predefined end
    
            // Additional fields
            ingredients: this.data.ingredients,
            allergens: this.data.allergens,
            calories: this.data.calories,
            fat: this.data.fat,
            sugar: this.data.sugar,
            salt: this.data.salt,
            protein: this.data.protein,
            fiber: this.data.fiber,
            otherdata: this.data.otherdata || {},//object to store other data
            
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
