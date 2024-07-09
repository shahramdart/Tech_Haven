const express = require("express");
const app = express();
const port = 3000;
const knex = require("./config/app.config");
const errors = require("./middlewares/errors");
const bodyParser = require("body-parser");
const appRoutes = require("./router/app.routes");
const orderRoutes = require("./router/order.routes");

app.use(bodyParser.json());
app.use(express.json());
app.use("/uploads", express.static("uploads"));
app.use("/api", appRoutes);
app.use("/api", orderRoutes);
app.use(errors.errorHandles);

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
