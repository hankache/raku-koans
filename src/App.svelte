<script lang="ts">
  import { onMount } from 'svelte';
  import { allKoans, koanById, getRuntime } from './lib/koans';
  import { progress } from './lib/progress.svelte';
  import GateMark from './components/GateMark.svelte';
  import ThemeToggle from './components/ThemeToggle.svelte';
  import PathMap from './components/PathMap.svelte';
  import KoanView from './components/KoanView.svelte';
  import Meter from './components/Meter.svelte';

  // Tiny hash router: #/ is the path, #/koan/<section>/<name> is a koan.
  let hash = $state(location.hash);
  // Count current koans only: saved progress may include koans that were since removed.
  const passed = $derived(allKoans.filter(k => progress.get(k.id)?.status === 'passed').length);
  const koanId = $derived(hash.match(/^#\/koan\/(.+)$/)?.[1]);

  onMount(() => {
    progress.init();
    getRuntime(); // start loading the interpreter in the background
    const onHash = () => {
      hash = location.hash;
      window.scrollTo(0, 0);
    };
    addEventListener('hashchange', onHash);
    return () => removeEventListener('hashchange', onHash);
  });
</script>

<header class="bar">
  <a class="brand" href="#/"><GateMark size={32} /> <span>Raku Koans</span></a>
  <div class="meter"><Meter {passed} total={allKoans.length} /></div>
  <ThemeToggle />
</header>

<main>
  {#if !progress.loaded}
    <!-- a moment while saved progress loads -->
  {:else if koanId && koanById.has(koanId)}
    {#key koanId}<KoanView id={koanId} />{/key}
  {:else}
    <PathMap />
  {/if}
</main>

<footer>
  © 2026 Naoum Hankache ·
  Code: <a href="https://opensource.org/license/artistic-2-0">Artistic License 2.0</a> ·
  Artwork: <a href="https://creativecommons.org/licenses/by-sa/4.0/">CC BY-SA 4.0</a> ·
  <a href="https://github.com/hankache/raku-koans">GitHub</a>
</footer>

<style>
  .bar {
    position: sticky;
    top: 0;
    z-index: 10;
    display: flex;
    align-items: center;
    gap: 1.5rem;
    padding: 0.7rem max(16px, calc((100vw - 1120px) / 2));
    background: color-mix(in srgb, var(--bg) 85%, transparent);
    backdrop-filter: blur(10px);
    border-bottom: 1px solid var(--line);
  }
  .brand {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    text-decoration: none;
    font-family: var(--font-display);
    font-weight: 700;
    font-size: 1.15rem;
    white-space: nowrap;
  }
  .meter { flex: 1; min-width: 0; max-width: 360px; margin-left: auto; }
  main { max-width: 1120px; margin: 0 auto; padding: 0 16px; }
  footer { text-align: center; color: var(--ink-faint); font-size: 0.8rem; padding: 3rem 16px 2rem; }
  footer a { color: var(--ink-soft); }

  @media (max-width: 600px) {
    .bar { gap: 0.6rem; }
    .brand span { display: none; }
  }
</style>
