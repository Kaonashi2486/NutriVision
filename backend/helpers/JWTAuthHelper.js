const jwt = require("jsonwebtoken");
const JsonResponse = require('./JsonResponse');

exports.verifyToken = function (req, res, next) {
  try{
    const bearerToken = req.headers["authorization"];

    // if (!bearerToken) {
    //   throw new Error("Authorization header is missing");
    // }

    // const bearer = bearerToken.split(" ");
    // if (bearer.length !== 2 || bearer[0] !== "Bearer") {
    //   throw new Error("Authorization header is improperly formatted");
    // }
    const bearer = bearerToken.split(" ");

    const token = bearer[1];

    console.log(token);
    // console.log("Token:", token);

    req.apiUser = jwt.verify(token, process.env.JWTSECRET);
    console.log(req.apiUser)  
    next()
  } catch(error){
console.log("here")
    res.locals.data = {
        isVaild: false, 
        authorizationFailed: true,
      };

      res.locals.message = error;
      new JsonResponse(req, res).jsonError();
      // next(error)
      // return true
  }
};

// req.apiUser = jwt.verify(token, process.env.JWTSECRET);
// console.log("Decoded Token:", req.apiUser);
// next();
// } catch (error) {
// console.log("Error in verifyToken middleware:", error.message);

// res.locals.data = {
//   isVaild: false,
//   authorizationFailed: true,
// };

// res.locals.message = error.message; // Pass error message directly
// new JsonResponse(req, res).jsonError();
// }
// };