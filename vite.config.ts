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
  build: {
    rollupOptions: {
      external: [
        "@supabase/supabase-js",
      ],
    },
  },
  ssr: {
    noExternal: ["@supabase/supabase-js"],
  },
});
