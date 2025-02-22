import { sveltekit } from "@sveltejs/kit/vite";
import Icons from "unplugin-icons/vite";
import { defineConfig } from "vite";

export default defineConfig({
  plugins: [
    sveltekit(),
    Icons({
      compiler: "svelte",
    }),
  ],
  test: {
    include: ["src/**/*.{test,spec}.{js,ts}"],
  },
  server: {
    proxy: {
      "/fonts": {
        target: "https://cdn.serenyxleague.com",
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/fonts/, "/u"),
      },
    },
  },
  optimizeDeps: {
    include: ["@supabase/supabase-js"],
  },
  build: {
    commonjsOptions: {
      include: [/node_modules/],
    },
    rollupOptions: {
      output: {
        manualChunks: {
          supabase: ["@supabase/supabase-js"],
        },
      },
    },
  },
  ssr: {
    noExternal: ["@supabase/supabase-js"],
  },
});
