<!-- The "gateless gate" mark: a torii in the text colour framing an amber question mark. -->
<script lang="ts">
  let { size = 32 }: { size?: number } = $props();
</script>

<svg width={size} height={size} viewBox="0 0 64 64" aria-hidden="true">
  <path d="M4 10.5 C18 15 46 15 60 10.5 L58 17.5 C45 21 19 21 6 17.5 Z" fill="currentColor" />
  <rect x="30" y="19" width="4" height="7" fill="currentColor" />
  <rect x="9" y="25" width="46" height="4" fill="currentColor" />
  <path d="M15 19.5 H21 L22 58 H14 Z" fill="currentColor" />
  <path d="M43 19.5 H49 L50 58 H42 Z" fill="currentColor" />
  <path
    d="M26.5 38.5 A5.5 5.5 0 1 1 34.75 43.26 Q32 44.8 32 47.5 V48.3"
    fill="none" stroke="var(--amber)" stroke-width="3.4" stroke-linecap="round"
  />
  <circle cx="32" cy="53.3" r="2.1" fill="var(--amber)" />
</svg>

<style>
  svg { display: block; flex: none; }
</style>
