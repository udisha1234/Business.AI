import express from "express";
import Customer from "../model/customer.js";

const router = express.Router();

// Add a new customer
router.post("/customers", async (req, res) => {
  try {
    const { name, email, phone } = req.body;
    const newCustomer = new Customer({ name, email, phone });
    await newCustomer.save();
    res.status(201).json({ message: "Customer added successfully!", customer: newCustomer });
  } catch (error) {
    console.log("the error during the uploading custor data",error)
    res.status(400).json({ error: error.message });
  }
});

// Get all customers
router.get("/customers", async (req, res) => {
  try {
    const customers = await Customer.find();
    res.status(200).json(customers);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
