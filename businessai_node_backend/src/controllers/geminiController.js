import geminiModel from "../model/geminiModel.js";

const chatWithGemini = async (req, res) => {
    try {
        const { message } = req.body;

        if (!message) {
            return res.status(400).json({ error: "Message is required" });
        }

        const reply = await geminiModel.generateAIResponse(message);
        res.json({ reply });

    } catch (error) {
        console.error("Error calling Gemini API:", error.message);
        res.status(500).json({ error: "Internal server error" });
    }
};

export default { chatWithGemini }; // ✅ Exporting as default object
