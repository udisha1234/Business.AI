import { createTransport } from 'nodemailer';
import config from './dotenvConfig.js';

const { emailUser, emailPass } = config;

const transporter = createTransport({
    service: 'gmail',
    auth: {
        user: emailUser,
        pass: emailPass,
    },
});

// ✅ Function to send an email
export const sendMail = async (to, subject, text) => {
    try {
        const mailOptions = {
            from: emailUser,
            to ,
            subject ,
            text ,
        };
        const info = await transporter.sendMail(mailOptions);
        console.log('✅ Email sent:', info.response);
        return info;
    } catch (error) {
        console.error('Error sending email:', error);
        throw error;
    }
};

// ✅ Ensure transporter is ready
transporter.verify((error, success) => {
    if (error) {
        console.error('Nodemailer setup failed:', error);
    } else {
        console.log('Nodemailer is ready to send emails.');
    }
});
