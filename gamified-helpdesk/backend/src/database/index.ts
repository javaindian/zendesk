import { Pool } from 'pg';
import dotenv from 'dotenv';

dotenv.config({ path: process.cwd() + '/backend/.env' }); // Specify .env path for backend

const dbConfig = {
  connectionString: process.env.DATABASE_URL,
  // Heroku-specific SSL for production, common if deploying there
  // ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false,
};

// console.log("DATABASE_URL used:", process.env.DATABASE_URL); // For debugging

const pool = new Pool(dbConfig);

pool.on('connect', () => {
  console.log('Successfully connected to the PostgreSQL database.');
});

pool.on('error', (err: Error) => {
  console.error('Unexpected error on idle PostgreSQL client', err);
  // It's important to handle errors, but exiting might not always be desired
  // depending on the application's resilience strategy.
  // process.exit(-1);
});

/**
 * Executes a SQL query.
 * @param text The SQL query string.
 * @param params An array of parameters to pass to the query.
 * @returns A Promise resolving to the query result.
 */
export const query = async (text: string, params?: any[]) => {
  const start = Date.now();
  try {
    const res = await pool.query(text, params);
    const duration = Date.now() - start;
    // console.log('Executed query', { text, duration, rows: res.rowCount }); // Basic logging
    return res;
  } catch (error) {
    console.error('Error executing query', { text, params, error });
    throw error;
  }
};

// Optional: A function to test the connection
export const testConnection = async () => {
  try {
    await pool.query('SELECT NOW()');
    console.log('Database connection test successful.');
    return true;
  } catch (error) {
    console.error('Database connection test failed:', error);
    return false;
  }
};

export default pool;
