const compress_images = require('compress-images');
const express = require("express");
const router = express.Router();
const DataBase = require("../helpers/database");
const md5 = require("blueimp-md5");
const sha1 = require("js-sha1");
const jwt = require("jsonwebtoken");
const config = require("../config");
const { v4: uuid } = require("uuid");
// We will be compressing images [jpg] with two algorithms, [webp] and [jpg];

//[jpg] ---to---> [webp]

router.post("/set-compress", async (req, res) => {
    const resim_yolu = req.body;
    compress_images(
        "./image/manzara.jpg",
        "./outputcompress/asssass",
        { compress_force: false, statistic: true, autoupdate: true },
        false,
        { jpg: { engine: "mozjpeg", command: ["-quality", "60"] } },
        { png: { engine: "pngquant", command: ["--quality=20-50", "-o"] } },
        { svg: { engine: "svgo", command: "--multipass" } },
        {
            gif: { engine: "gifsicle", command: ["--colors", "64", "--use-col=web"] },
        },
        function (err, completed) {
            if (completed === true) {
                console.log("Başarıyla sıkıştırıldı!")
                res.json({
                    "complete":"1"
                })
            }
        }
    );
});

module.exports = router;


