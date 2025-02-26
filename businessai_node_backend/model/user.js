import mongoose from "mongoose";

// Define Schema
const UserSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
});

// Export Model
export default mongoose.model("User", UserSchema);
