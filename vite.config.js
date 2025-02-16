import { defineConfig } from 'vite';
import { sveltekit } from '@sveltejs/kit/vite';

export default defineConfig({
  plugins: [sveltekit()],
  server: {
    proxy: {
      '/fonts': {
        target: 'http://cdn.serenyxleague.com',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/fonts/, '/u')
      }
    }
  }
});
