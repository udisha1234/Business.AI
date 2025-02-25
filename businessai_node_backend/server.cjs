const express = require("express");
const dotenv = require("dotenv");
const axios = require("axios");

dotenv.config(); // Load environment variables

const app = express();
const PORT = process.env.PORT || 5000;
const GEMINI_API_KEY = process.env.GEMINI_API_KEY;

app.use(express.json()); // Middleware to parse JSON requests

// API Endpoint to interact with Gemini AI
app.post("/chat", async (req, res) => {
    try {
        const { message } = req.body;

        if (!message) {
            return res.status(400).json({ error: "Message is required" });
        }

        if (!GEMINI_API_KEY) {
            return res.status(500).json({ error: "Missing API key" });
        }
        const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${GEMINI_API_KEY}`;

        const response = await axios.post(url, {
            contents: [
                {
                    parts: [{ text: message }]
                }
            ]
        }, {
            headers: { "Content-Type": "application/json" }
        });

        // Extract AI response
        const aiResponse = response.data?.candidates?.[0]?.content?.parts?.[0]?.text || "No response from AI.";
        res.json({ reply: aiResponse });
    } catch (error) {
        console.error("Error calling Gemini API:", error.response?.data || error.message);
        res.status(500).json({ error: "Internal server error" });
    }
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});