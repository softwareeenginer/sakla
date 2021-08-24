const multer = require("multer");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "uploads/");
  },
  filename: function (req, file, cb) {
    let ext = file.mimetype.split("/")[1];

    ext =
      ext ===
      "vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        ? "xslx"
        : ext === "vnd.ms-excel"
        ? "xls"
        : ext;

    cb(null, Date.now() + "." + ext);
  },
});
const upload = multer({ storage, limits: { fieldSize: 25 * 1024 * 1024 } });

module.exports = upload;
