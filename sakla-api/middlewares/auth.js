const config = require("../config");
const DataBase = require("../helpers/database");
const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  let token = req.headers["Authorization"] || req.headers["authorization"];
  if (token !== undefined) {
    token = token.split("Bearer")[1].trim();
    jwt.verify(token, config.jwt_key, async (err, decoded) => {
      if (err) {
        res.status(401).send({ error: "Unauthorized error" });
      } else {
        const user = await DataBase.from("users")
          .select(
            DataBase.raw(
              "users.*"
            )
          )
          .where("users.id", decoded.uid)
          .first();
        if (user && user.status === 1) {
          res.locals = {
            user_id: decoded.uid,
            doctor_id: decoded.doctor_id ? decoded.doctor_id : -1,
          };
          next();
        } else {
          res.status(401).send({ error: "Unauthorized error" });
        }
      }
    });
  } else {
    res.status(401).send({ error: "Unauthorized error" });
  }
};
