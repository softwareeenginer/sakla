const express = require("express");
const router = express.Router();
const DataBase = require("../helpers/database");
const md5 = require("blueimp-md5");
const sha1 = require("js-sha1");
const jwt = require("jsonwebtoken");
const config = require("../config");
const { v4: uuid } = require("uuid");


router.post("/tokenControl", async (req, res) => {
  let { token, deviceToken, ip, platform } = req.body;
  if (token) {
    jwt.verify(token, config.jwt_key, async (err, decoded) => {
      if (err) {
        res.json({
          error: 1,
        });
      } else {
        const user = await DataBase.from("users")
          .select(
            "users.*",
          )
          .where("users.status", 1)
          .where("users.id", decoded.uid)
          .first();

        if (user) {
          res.json({
            user,
            error:0
          })
        } else {
          res.json({
            error: 1,
          });
        }
      }
    });
  } else {
    res.json({
      error: 1,
    });
  }
});

router.post("/login", async (req, res) => {
  let { username, password, token, ip } = req.body;

  password = md5(sha1(password));

  const user = await DataBase.from("users")
    .where("users.email", username)
    .where("users.password", password)
    .first();

});

router.post("/register", async (req, res) => {
  try {
    const data = req.body;
    const type = data.type;
    delete data.type;

    const control = await DataBase("users").where("email", data.email);
    if (control.length > 0) {
      return res.json({
        error: 2,
      });
    }

    const user_id = await DataBase.insert({
      ...data,
      password: md5(sha1(data.password)),
    }).into("users");

    res.json({
      error: 0,
      user_id,
    });
  } catch (e) {
    console.error(e.message);
    res.json({
      error: 1,
      msg: e.message,
    });
  }
});


module.exports = router;
