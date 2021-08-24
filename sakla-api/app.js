const express = require("express");
const authRouter = require("./routes/auth");
const homeRouter = require("./routes/home");
const Compress = require("./routes/compress");
const apikeyMiddleware = require("./middlewares/apikey");
const authMiddleware = require("./middlewares/auth");

const app = express();

app.use("/uploads", express.static("uploads"));

//app.use(apikeyMiddleware);

app.use("/auth", authRouter);
//app.use(authMiddleware);
app.use("/home", homeRouter);
app.use("/compress", Compress);

module.exports = app;
