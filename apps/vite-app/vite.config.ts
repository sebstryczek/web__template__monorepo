import { defineConfig } from "vite";
import mkcert from "vite-plugin-mkcert";

export default defineConfig(({ command, mode }) => {
  console.log(`[vite.config.js] command: ${command}, mode: ${mode}`);

  return {
    plugins: [mkcert()],
    server: {
      host: true,
      port: 3001,
    },
  };
});
