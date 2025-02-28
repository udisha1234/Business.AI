import dotenv from "dotenv";
import axios from "axios";

dotenv.config(); // Load environment variables

const GEMINI_API_KEY = process.env.GEMINI_API_KEY;

const generateAIResponse = async (message) => {
    if (!GEMINI_API_KEY) throw new Error("Missing API key");

    const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${GEMINI_API_KEY}`;

    const response = await axios.post(
        url,
        {
            contents: [{ parts: [{ text: message }] }]
        },
        { headers: { "Content-Type": "application/json" } }
    );

    return response.data?.candidates?.[0]?.content?.parts?.[0]?.text || "No response from AI.";
};

export default { generateAIResponse }; // ✅ Exporting as default object
