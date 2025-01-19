const Messages = require("../constants/Message");
const JsonResponse = require("../helpers/JsonResponse");
const TryCatch = require("../helpers/TryCatch");
const Customer = require("../models/Customers");
const jwt = require("jsonwebtoken");


// how long a token lasts before expiring
const tokenLasts = "365d";


//LOGIN
exports.apiLogin = async function (req, res) {
    let customer = new Customer(req.body);

    let result = await customer.login();
    if (result) {
        let data = {
            token: jwt.sign(
                { _id: customer.data._id, name: customer.data.name, email: customer.data.email },
                process.env.JWTSECRET,
                { expiresIn: tokenLasts }
            ),
            id: customer.data._id,
            name: customer.data.name,
            role: "customer",
        };

        new JsonResponse(req, res).jsonSuccess(data, "Login success");
    } else {
        res.locals.data = {
            isValid: false,
            loginFailed: true,
        };
        res.locals.message = new Messages().INVALID_CREDENTIALS;
        new JsonResponse(req, res).jsonError();
    }

};


//REGISTER
exports.apiRegister = async function (req, res) {
    let customer = new Customer(req.body);
    console.log(req.body);

    let result = await customer.register();
    if (result) {
        let data = {
            token: jwt.sign(
                { _id: customer.data._id, name: customer.data.name, email: customer.data.email },
                process.env.JWTSECRET,
                { expiresIn: tokenLasts }
            ),
            id: customer.data._id,
            name: customer.data.name,
            role: "customer",
        };
        new JsonResponse(req, res).jsonSuccess(data, "Register success");
    } else {
        res.locals.data = {
            isVaild: false,
            authorizationFailed: true,
        };
        res.locals.message = regErrors;
        new JsonResponse(req, res).jsonError();
    }
};
  
exports.getById = async function(req, res){
  let customer = new Customer()
  let customerDoc = await customer.getById(req.params.id)
  new JsonResponse(req, res).jsonSuccess(customerDoc, new Messages().SUCCESSFULLY_RECEIVED)
}

exports.getByEmail = async function(req, res){
    let customer = new Customer()
    let customerDoc = await customer.findByEmail(req.params.email)
    console.log(customerDoc)
    new JsonResponse(req, res).jsonSuccess(customerDoc, new Messages().SUCCESSFULLY_RECEIVED)
    }

exports.getAllCustomers = async function(req, res){
  let customer = new Customer()
  let customers = await customer.getAllCustomers()
  new JsonResponse(req, res).jsonSuccess(customers, new Messages().SUCCESSFULLY_RECEIVED)
  return customers
}

exports.deleteById= async function(req, res){
  let customer = new Customer();
  await customer.deleteById()
  new JsonResponse(req, res).jsonSuccess(true, new Messages().SUCCESSFULLY_DELETED)
}

