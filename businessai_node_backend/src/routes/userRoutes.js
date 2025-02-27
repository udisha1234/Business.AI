import express from "express";

const router = express.Router();

// Sample route
router.get("/users", (req, res) => {
  res.json({ message: "List of users" });
});

export default router; 
