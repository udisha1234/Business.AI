import { sendMail } from '../config/nodemailer.js';
import Email from '../model/emailModel.js'; // Optional: Log emails in DB
import { successResponse, errorResponse } from '../utils/responseHandler.js';

export async function sendEmail(req, res) {
    const { to, subject, text } = req.body;
    if (!to || !subject || !text) {
        return errorResponse(res, 'All fields are required', 400);
    }
    try {
        await sendMail(to,subject,text);

        // to save in db
        // const email = new Email({ to, subject, text });
        // await email.save();

        return successResponse(res, 'Email sent successfully');
    } catch (error) {
        return errorResponse(res, 'Failed to send email', 500, error);
    }
}
