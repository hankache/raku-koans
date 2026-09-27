<script lang="ts">
  let { passed, total }: { passed: number; total: number } = $props();
  const pct = $derived(total ? Math.round((passed / total) * 100) : 0);
  const left = $derived(total - passed);
</script>

<div class="meter" title="{passed} of {total} koans passed, {left} to go">
  <div class="track" role="progressbar" aria-valuenow={passed} aria-valuemin={0} aria-valuemax={total} aria-label="Enlightenment">
    <div class="fill" style:width="{pct}%"></div>
  </div>
  <div class="label">
    <span class="pct">{pct}% enlightened</span>
    <span class="counts">
      {#if left === 0}all {total} koans done{:else}{passed} done · {left} to go{/if}
    </span>
  </div>
</div>

<style>
  .meter { display: flex; align-items: center; gap: 0.7rem; min-width: 0; }
  .track {
    flex: 1;
    min-width: 40px;
    height: 10px;
    /* A faint tint of the text colour: visible on the header in both themes. */
    background: color-mix(in srgb, var(--ink) 12%, transparent);
    overflow: hidden;
  }
  .fill {
    height: 100%;
    background: linear-gradient(90deg, var(--sec-1), var(--sec-2), var(--sec-4), var(--sec-3));
    background-size: 400px 100%;
    transition: width 0.6s cubic-bezier(0.2, 0.8, 0.2, 1);
  }
  .label { display: flex; flex-direction: column; line-height: 1.2; white-space: nowrap; font-variant-numeric: tabular-nums; }
  .pct { font-size: 0.85rem; font-weight: 600; color: var(--ink); }
  .counts { font-size: 0.75rem; color: var(--ink-faint); }
</style>
