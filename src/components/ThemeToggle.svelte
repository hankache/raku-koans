<!--
  Switches between the light and dark themes. The page starts from the system setting (see the
  script in index.html); clicking here saves an explicit choice, remembered in this browser.
  Until then, the page keeps following the system setting as it changes.
-->
<script lang="ts">
  import { onMount } from 'svelte';

  const KEY = 'raku-koans:theme';
  let theme = $state(document.documentElement.dataset.theme === 'dark' ? 'dark' : 'light');

  function apply(next: string) {
    theme = next;
    document.documentElement.dataset.theme = next;
  }

  function toggle() {
    const next = theme === 'dark' ? 'light' : 'dark';
    apply(next);
    try {
      localStorage.setItem(KEY, next);
    } catch {
      // Storage unavailable: the choice lasts for this visit only.
    }
  }

  onMount(() => {
    const system = matchMedia('(prefers-color-scheme: dark)');
    const follow = (e: MediaQueryListEvent) => {
      let saved = null;
      try {
        saved = localStorage.getItem(KEY);
      } catch {}
      if (!saved) apply(e.matches ? 'dark' : 'light');
    };
    system.addEventListener('change', follow);
    return () => system.removeEventListener('change', follow);
  });

  const label = $derived(theme === 'dark' ? 'Switch to light theme' : 'Switch to dark theme');
</script>

<button class="toggle" onclick={toggle} aria-label={label} title={label}>
  {#if theme === 'dark'}
    <!-- sun: what you get -->
    <svg viewBox="0 0 24 24" width="18" height="18" aria-hidden="true">
      <circle cx="12" cy="12" r="4.5" />
      <path d="M12 2.5v2.5M12 19v2.5M2.5 12H5M19 12h2.5M5.3 5.3l1.8 1.8M16.9 16.9l1.8 1.8M5.3 18.7l1.8-1.8M16.9 7.1l1.8-1.8" />
    </svg>
  {:else}
    <!-- moon -->
    <svg viewBox="0 0 24 24" width="18" height="18" aria-hidden="true">
      <path d="M20 14.5A8 8 0 0 1 9.5 4a8 8 0 1 0 10.5 10.5z" />
    </svg>
  {/if}
</button>

<style>
  .toggle {
    flex: none;
    display: grid;
    place-items: center;
    width: 36px;
    height: 36px;
    padding: 0;
    color: var(--ink-soft);
    background: transparent;
  }
  .toggle:hover { color: var(--ink); }
  svg { fill: none; stroke: currentColor; stroke-width: 1.8; stroke-linecap: round; stroke-linejoin: round; }
</style>
