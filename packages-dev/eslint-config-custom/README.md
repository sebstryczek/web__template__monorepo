The idea is to have a package which keeps all ESLint config.

The whole configuration is in `index.js`.
We use `.js` and not `.ts` for that to make it possible to import it to `eslint.config.js` - which cannot be a `.ts` file.

We want to import `index.js` to `eslint.config.js` to use ESLint config defined in `index.js` for linting the file itself.

This package doesn't use na TypeScript code.
The `tsconfig.json` is used only for defining `languageOptions` in `eslint.config.js`.
The `src/index.ts` is created only to silence `tsconfig.json` complaining about no `.ts` files.
