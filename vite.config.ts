import { execSync } from 'node:child_process';
import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';

const MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

/**
 * The commit a production build comes from, shown in the footer. null (shown as
 * "Development build") for the dev server, or when there is no git repository or there are
 * uncommitted changes: then no commit matches the code.
 */
function buildInfo(command: string) {
  if (command !== 'build') return null;
  try {
    const git = (args: string) => execSync(`git ${args}`, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'] }).trim();
    if (git('status --porcelain')) return null;
    const commit = git('rev-parse HEAD');
    const date = new Date(git('log -1 --format=%cI'));
    return {
      commit,
      short: commit.slice(0, 7),
      // "1 Oct 2026", spelled out by hand: date locales vary between Node versions ("Sept").
      date: `${date.getUTCDate()} ${MONTHS[date.getUTCMonth()]} ${date.getUTCFullYear()}`,
    };
  } catch {
    return null;
  }
}

export default defineConfig(({ command }) => ({
  // Relative links, so one build works at a domain's root or in a sub-folder
  // (e.g. user.github.io/raku-koans/). Safe because the app is a single page:
  // koans only change the #… part of the address, so the page is always index.html.
  base: './',
  define: {
    __BUILD__: JSON.stringify(buildInfo(command)),
  },
  plugins: [svelte()],
}));
