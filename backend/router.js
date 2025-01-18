const express = require('express');
const router = express.Router();
const AuthHelper = require('./helper/JWTAuthHelper');
const TryCatch = require('./helper/TryCatch');
const Messages = require('./constants/Message');

// imports here
const productController = require('./controllers/productController');
const customerController = require('./controllers/customerController');

//routes for customer
router.post('/register-customer', new TryCatch(customerController.apiRegister).tryCatchGlobe());
router.post('/login-customer', new TryCatch(customerController.apiLogin).tryCatchGlobe());

router.get('/product/get-by-id/:id', AuthHelper.verifyToken, new TryCatch(productController.getById).tryCatchGlobe());


//routes for product
//have to do 

module.exports = router;