import dotenv from 'dotenv';

dotenv.config({ path: process.cwd() + '/backend/.env' });

export const authConfig = {
  jwtSecret: process.env.JWT_SECRET || 'your-default-super-secret-key',
  jwtExpiration: process.env.JWT_EXPIRATION || '1h', // e.g., 1h, 7d
  bcryptSaltRounds: 10,
};

if (authConfig.jwtSecret === 'your-default-super-secret-key' && process.env.NODE_ENV === 'production') {
  console.warn('WARNING: JWT_SECRET is using the default value in a production-like environment. Please set a strong, unique secret in your .env file.');
}
