//dependencies
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
const rideRoutes = require('./routes/ride.routes');

//middlewares
app.use(express.raw());
app.use(bodyParser.urlencoded({ extended: true })); // to support URL
app.use(bodyParser.json()); // to support JSON-encoded bodies
app.use(cookieParser());
app.use(express.static(path.resolve("./public")));

app.get("/", (req, res) => {
    res.send("Server Working Correctly...");
});

app.use("/order", orderRoutes);
app.use("/user", userRoutes);
app.use("/product", productRoutes);
app.use('/ride',rideRoutes);


module.exports = app;