import express from 'express';
import { makeCall } from '../controllers/callController.js';

const router = express.Router();

router.post('/make-call', makeCall);

export default router;
