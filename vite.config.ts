import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';

export default defineConfig({
  // Relative links, so one build works at a domain's root or in a sub-folder
  // (e.g. user.github.io/raku-koans/). Safe because the app is a single page:
  // koans only change the #… part of the address, so the page is always index.html.
  base: './',
  plugins: [svelte()],
});
