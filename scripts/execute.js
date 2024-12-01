// Cross-platform script execution

import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { spawn } from 'child_process';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const [,, SCRIPT_NAME, ...SCRIPT_ARGS] = process.argv;

if (!SCRIPT_NAME) {
  console.error("Usage: node execute.js <script-name-without-extension>");
  process.exit(1);
}

const SCRIPT_DIRECTORY_NAME = SCRIPT_NAME;
const SCRIPT_FILE_NAME = SCRIPT_NAME;

const runScript = (command, args, options) => {
  return new Promise((resolve, reject) => {
    console.log(`\x1b[35m${command} ${args.join(' ')}\x1b[0m`);

    const child = spawn(command, args, { stdio: 'inherit' });

    child.on('error', (error) => {
      reject(error);
    });

    child.on('close', (code) => {
      if (code === 0) {
        resolve(code);
      } else {
        reject(`Child process exited with code ${code}`);
      }
    });
  });
};

if (process.platform === "win32") {
  console.log("Running PowerShell script")

  const scriptFilePath = join(__dirname, SCRIPT_DIRECTORY_NAME, `${SCRIPT_FILE_NAME}.ps1`);

  try {
    await runScript('powershell', ['Set-ExecutionPolicy', '-Scope', 'CurrentUser', '-ExecutionPolicy', 'Unrestricted', '-Force'], { shell: true });
    console.log('Execution Policy has been changed.');
  
    await runScript('powershell', ['-File', scriptFilePath, ...SCRIPT_ARGS], { shell: true });
    console.log('PowerShell script has been executed successfully.\n');
  } catch (error) {
    console.error(error);
  }
} else {
  console.log("Running Bash script")

  const scriptFilePath = join(__dirname, SCRIPT_DIRECTORY_NAME, `${SCRIPT_FILE_NAME}.sh`);

  try {
    await runScript('sh', [scriptFilePath, ...SCRIPT_ARGS], { encoding: "utf8" });
    console.log('Bash script has been executed successfully.\n');
  } catch (error) {
    console.error(error);
  }
}
