// const express = require('express');
import express from "express";
// const { sendOtp, verifyOtp } = require('../controllers/otpController.js');
import { sendOtp, verifyOtp } from "../controllers/otpController.js";

const router = express.Router();

router.post('/send-otp', sendOtp);
router.post('/verify-otp', verifyOtp);

// module.exports = router;
export default router;
