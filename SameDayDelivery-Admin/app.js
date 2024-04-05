const express = require("express");
const app = express();
const path = require("path");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const cors = require("cors");
app.use(
  cors({
    origin: "http://localhost:5173", //frontend url
    credentials: true,
  })
);
//routes
const orderRoutes = require("./routes/order.routes");
const userRoutes = require("./routes/user.routes");
const productRoutes = require("./routes/product.routes");

app.get("/", (req, res) => {
  res.send("Server Working Correctly...");
});

app.use("/order", orderRoutes);
app.use("/user", userRoutes);
app.use("/product", productRoutes);

module.exports = app;
