const express = require("express");
const router = express.Router();
const { generateLesson } = require("../controllers/ai.controller");

router.post("/generate", generateLesson);

module.exports = router;
