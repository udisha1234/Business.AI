// const twilio = require('twilio');
// const Otp = require('../models/otpModel');
// require('dotenv').config();

import twilio from 'twilio';
import dotenv from 'dotenv';
import Otp from '../model/otpModel.js';  

dotenv.config();

const client = twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN);

const sendOtp = async (req, res) => {
  const { phone } = req.body;
  try {
    if (!phone) {
        return res.status(400).json({ success: false, message: "Phone number is required" });
      }
    const otp = Math.floor(100000 + Math.random() * 900000);
    await Otp.create({ phone, otp });


    await client.messages.create({
      body: `Your OTP code is ${otp}`,
      from: process.env.TWILIO_PHONE_NUMBER,
      to: phone
    });

    res.json({ success: true, message: 'OTP sent successfully' });
  } catch (error) {
    console.error("Error sending OTP:", error);
    res.status(500).json({ success: false, message: 'Error sending OTP', error });
  }
};

const verifyOtp = async (req, res) => {
  const { phone, otp } = req.body;
  try {
    const validOtp = await Otp.findOne({ phone, otp });

    if (!validOtp) {
      return res.status(400).json({ success: false, message: 'Invalid OTP' });
    }

    await Otp.deleteOne({ phone });

    res.json({ success: true, message: 'OTP verified successfully' });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error verifying OTP', error });
  }
};

export { sendOtp, verifyOtp };

