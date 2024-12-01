import { defineConfig } from "vite";

export default defineConfig(({ command, mode }) => {
  console.log(`[vite.config.js] command: ${command}, mode: ${mode}`);

  // const dateTime = new Date();
  // const date = dateTime.toLocaleDateString("pl-PL").split(".").reverse().join("-");
  // const time = dateTime.toLocaleTimeString("pl-PL").split(":").join("-");
  // const directoryName = `${date}_${time}`;

  const BASE_URL = `/`;
  console.log(`[vite.config.js] BASE_URL: ${BASE_URL}`);

  return {
    base: BASE_URL,
    plugins: [],
    server: {
      host: true,
      port: 3001,
    },
  };
});
