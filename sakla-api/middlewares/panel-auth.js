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
        const user = await DataBase.from("managers")
          .where("id", decoded.id)
          .first();
        if (user && user.status === 1) {
          res.locals = { isSuper: decoded.is_super };
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
