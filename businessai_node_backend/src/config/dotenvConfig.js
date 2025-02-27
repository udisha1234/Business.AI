import 'dotenv/config';

const config = {
    port: process.env.PORT || 5000,
    mongoURI: process.env.MONGO_URI,
    emailUser: process.env.EMAIL_USER,
    emailPass: process.env.EMAIL_PASS,
};

export default config;
