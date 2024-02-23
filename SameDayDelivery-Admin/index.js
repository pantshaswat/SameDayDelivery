const Database  = require("./config/database");
const app = require("./app");


const PORT = process.env.PORT || 3000;


(async () => {
    try {
      await Database.connect();
      app.listen(PORT, () => {
        console.log("Server is up on port " + PORT);
        console.log("http://localhost:" + PORT);
      });
    } catch (error) {
      console.error("Error connecting to the database:", error);
    }
})();