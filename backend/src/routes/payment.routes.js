const express = require("express");
const router = express.Router();

router.post("/subscribe", (req, res) => {
  const { userId, plan } = req.body;

  // simulation paiement validé
  res.json({
    success: true,
    message: "Paiement validé",
    plan,
    userId
  });
});

module.exports = router;
