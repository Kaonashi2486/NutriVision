const express = require('express');
const router = express.Router();
const AuthHelper = require('./helpers/JWTAuthHelper');
const TryCatch = require('./helpers/TryCatch');
const Messages = require('./constants/Message');

// imports here
// const productController = require('./controllers/productController');
const customerController = require('./controllers/customerController');

//routes for customer
router.post('/register-customer', new TryCatch(customerController.apiRegister).tryCatchGlobe());
router.post('/login-customer', new TryCatch(customerController.apiLogin).tryCatchGlobe());

//add a route to get a customer's profile
router.get('/customer-profile', AuthHelper.verifyToken, new TryCatch(customerController.getById).tryCatchGlobe());


//routes for product
//have to do 

module.exports = router;