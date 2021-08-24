const DataBase = require("../helpers/database");

module.exports = async () => {
  try {
    await DataBase('appointments')
        .whereRaw("TIMESTAMPDIFF(MINUTE, created_dt, NOW()) >= ? && status = ?", [30, 3])
        .del();


  } catch (e) {
    console.error(e);
  }
};
