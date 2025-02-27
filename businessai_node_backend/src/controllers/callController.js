import twilio from 'twilio';
import dotenv from 'dotenv';

dotenv.config();

const client = twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN);


export const makeCall = async (req, res) => {
    console.log('Incoming Request Body:', req.body);
  const { phoneNumber } = req.body; 
  
  if (!phoneNumber) {
    console.log('❌ Missing phoneNumber in request body');
    return res.status(400).json({ success: false, message: 'Phone number is required...' });
  }
  if(phoneNumber){
    console.log('ok');
  }
  try {
    const call = await client.calls.create({
      twiml: '<Response><Say voice="alice">Hello! This is an AI-powered call from Business.AI. We have an exciting offer for you. Stay tuned for more details!</Say></Response>',
      to: phoneNumber,
      from: process.env.TWILIO_PHONE_NUMBER,
    });

    res.json({ success: true, message: 'Call initiated successfully', callSid: call.sid });
  } catch (error) {
    console.error('🚨 Error making call:\n', error); 
    res.status(500).json({ success: false, message: 'Error making call', error });
  }
};
