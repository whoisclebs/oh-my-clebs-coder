#!/usr/bin/env node

const fs = require('node:fs');
const path = require('node:path');

const PROJECT_ROOT = process.cwd();
const TASKS_ROOT = path.join(PROJECT_ROOT, '.tmp', 'tasks');
const ACTIVE_DIR = path.join(TASKS_ROOT, 'active');
const COMPLETED_DIR = path.join(TASKS_ROOT, 'completed');

function ensureDir(dir) {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
}

function cmdInit() {
  ensureDir(ACTIVE_DIR);
  ensureDir(COMPLETED_DIR);
  console.log('Created:');
  console.log(`- ${ACTIVE_DIR}`);
  console.log(`- ${COMPLETED_DIR}`);
}

const [, , command] = process.argv;

switch (command) {
  case 'init':
    cmdInit();
    break;
  default:
    console.log('Usage: node .opencode/scripts/task-cli.ts <init>');
    process.exit(1);
}
