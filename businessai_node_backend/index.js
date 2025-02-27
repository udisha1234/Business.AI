import express from "express";
import mongoose from "mongoose";
import cors from "cors";
import dotenv from "dotenv";
import userRoutes from "./src/routes/userRoutes.js"; // Ensure the correct path
import customerrouter from "./src/routes/customerRoutes.js"
import otpRoutes from "./src/routes/otpRoutes.js"
import callRoutes from "./src/routes/callRoutes.js"
import emailRoutes from "./src/routes/emailRoutes.js"
dotenv.config(); // Load environment variables

const app = express();

// Middleware
app.use(cors()); // Enable CORS for frontend communication
app.use(express.json()); // Parse JSON request body

// Connect to MongoDB
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log("✅ MongoDB Connected Successfully"))
  .catch((err) => {
    console.error("❌ MongoDB Connection Error:", err.message);
    process.exit(1); // Exit process on DB connection failure
  });

// Simple API Route
app.get("/", (req, res) => {
  res.send("Welcome to the Node.js API!");
});

// Define API Routes
app.use("/api", userRoutes);
app.use("/api",customerrouter)
app.use('/api/otp', otpRoutes);
app.use('/api', callRoutes);
app.use('/api/email', emailRoutes);
// Start the Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
