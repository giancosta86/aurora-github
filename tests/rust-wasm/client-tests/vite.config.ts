import { fileURLToPath, URL } from "node:url";
import { defineConfig } from "vite";

export default defineConfig({
  resolve: {
    alias: {
      "@giancosta86/test_wasm": fileURLToPath(
        new URL("../pkg/test_wasm.js", import.meta.url)
      )
    }
  }
});
