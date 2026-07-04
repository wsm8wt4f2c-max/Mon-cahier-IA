const express = require("express");
const router = express.Router();
const { generateLesson } = require("../controllers/ai.controller");
const auth = require("../middleware/auth");

router.post("/generate", auth, generateLesson);

module.exports = router;
