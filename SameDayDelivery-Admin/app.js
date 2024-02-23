//dependencies
const express = require("express");
const app = express();
const path = require("path");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");


//routes
const orderRoutes = require("./routes/order.routes");
const userRoutes = require("./routes/user.routes");
const productRoutes = require("./routes/product.routes");

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


module.exports = app;