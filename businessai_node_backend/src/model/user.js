import mongoose from "mongoose";

// Define Schema
const UserSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
});

export default mongoose.model("User", UserSchema);
