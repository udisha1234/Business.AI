import { Router } from "express";
import geminiController from "../controllers/geminiController.js"; // ✅ Import as default

const router = Router(); // ✅ Fixed issue with `router = router();`

// Define the chat route
router.post("/chat", geminiController.chatWithGemini);

export default router;
