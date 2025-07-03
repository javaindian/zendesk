import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'path'; // Import path module

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'), // Setup @ alias for src folder
    },
  },
  server: {
    port: 3000, // Optional: specify dev server port
    proxy: {
      // Optional: proxy API requests to backend during development
      // '/api': {
      //   target: 'http://localhost:5000', // Your backend server
      //   changeOrigin: true,
      // },
    },
  },
});
