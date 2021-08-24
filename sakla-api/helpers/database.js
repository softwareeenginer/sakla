const config = require("../config");

const DataBase = require("knex")({
  client: "mysql",
  connection: config.database,
});

module.exports = DataBase;
