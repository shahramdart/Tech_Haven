// app.config.js
const knex = require("knex")({
  client: "mysql2",
  connection: {
    host: "localhost",
    port: 3306,
    user: "root",
    password: "",
    database: "techHaven",
  },
});

module.exports = knex;
