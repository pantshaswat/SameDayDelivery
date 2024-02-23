const mongoose = require("mongoose");

class Database {
  static async connect() {
    //Insert MONGODB_URI here
    const MONGODB_URI =
      "mongodb+srv://pantshaswat:samedaydelivery@cluster0.09zjlsa.mongodb.net/?retryWrites=true&w=majority";
    try {
      mongoose.connect(MONGODB_URI, {
        useNewUrlParser: true,
       
      });
      console.log("Database connected successfully");
    } catch (error) {
      console.log(error);
      throw error;
    }
  }
}

module.exports = Database;