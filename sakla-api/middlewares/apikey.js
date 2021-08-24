const config = require("../config");

module.exports = (req, res, next) => {
  const api_key = req.headers["x-api-key"] || req.headers["X-Api-Key"];
  if (api_key === config.api_key) {
    next();
  } else {
    res.status(401).json({ error: "Unauthorized", errorCode: 401 });
  }
};
