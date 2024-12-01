import { defineConfig } from "vite";
import dts from "vite-plugin-dts";

import * as packageJson from "./package.json";

const dependencies = "dependencies" in packageJson ? (packageJson.dependencies as object) : {};
const devDependencies = "devDependencies" in packageJson ? (packageJson.devDependencies as object) : {};
const peerDependencies = "peerDependencies" in packageJson ? (packageJson.peerDependencies as object) : {};

export default defineConfig(({ mode }) => {
  const isDevelopment = mode === "development";
  const externalDependencies = [
    ...Object.keys(isDevelopment ? dependencies : {}),
    ...Object.keys(devDependencies),
    ...Object.keys(peerDependencies),
  ];

  return {
    build: {
      lib: {
        entry: "./src/index.ts",
        name: "xTerraTiles3D",
        formats: ["es", "cjs"],
        fileName: (format) => `index.${format}.js`,
      },
      rollupOptions: {
        external: externalDependencies,
      },
      sourcemap: true,
    },
    plugins: [
      dts({
        outDir: "declarations",
        rollupTypes: true,
      }),
    ],
  };
});
