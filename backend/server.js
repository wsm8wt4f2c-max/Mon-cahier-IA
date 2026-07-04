const express = require("express");
const cors = require("cors");
require("dotenv").config();

const aiRoutes = require("./src/routes/ai.routes");

const app = express();

app.use(cors());
app.use(express.json());

app.use("/api/ai", aiRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log("Backend running on port " + PORT);
});
const paymentRoutes = require("./src/routes/payment.routes");

app.use("/api/payment", paymentRoutes);
