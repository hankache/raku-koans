<!--
  The logo, animated: the door swings open and the butterfly flies through it into the light.
  Layers are cut from design/logo.jpg by design/build-logo-assets.py, which also prints the
  positions used below (fractions of the square). With reduced motion it is just the logo.
-->
<script lang="ts">
  let { size = 112 }: { size?: number } = $props();
  const dir = `${import.meta.env.BASE_URL}anim/`;
</script>

<div class="scene" style:width="{size}px" style:height="{size}px" role="img" aria-label="The butterfly flies through the open gate">
  <div class="light"></div>
  <img class="gate" src="{dir}gate.webp" alt="" />
  <img class="door" src="{dir}door.webp" alt="" />
  <div class="flight"><img class="wings" src="{dir}butterfly.webp" alt="" /></div>
</div>

<style>
  .scene {
    position: relative;
    flex: none;
    overflow: hidden;
    perspective: 320px;
    --t: 2.8s;
  }
  .scene > * { position: absolute; }
  .gate, .flight, .wings { inset: 0; width: 100%; height: 100%; }

  /* The doorway: door.webp covers it at first; behind it, the light. */
  .light, .door { left: 54.63%; top: 35.98%; width: 25.49%; height: 49.63%; }
  .light {
    z-index: 0;
    /* Light, not a yellow panel: near-white at the centre, pale gold at the edges, no orange rim. */
    background: radial-gradient(ellipse at 50% 55%, #fffef8 0%, #fff5d6 40%, #f7e2a6 100%);
    animation: glow var(--t) ease-out forwards;
  }
  .gate { z-index: 2; }
  .door {
    z-index: 3;
    transform-origin: left center;
    animation: open var(--t) cubic-bezier(0.5, 0, 0.3, 1) forwards;
  }

  /* Both pivot on the butterfly's centre. */
  .flight, .wings { transform-origin: 27.23% 54.45%; }
  .flight { z-index: 4; animation: fly var(--t) ease-in-out forwards; }
  .wings { animation: flap 0.18s ease-in-out 14 alternate; }

  @keyframes open {
    0%, 15% { transform: rotateY(0); filter: none; }
    45%, 100% { transform: rotateY(78deg); filter: brightness(0.7); }
  }
  @keyframes glow {
    0%, 30% { filter: brightness(0.95); }
    100% { filter: brightness(1.04); }
  }
  /* Door centre is 40.15% right and 6.35% down from the butterfly's centre. Once the
     butterfly is small enough to fit the doorway it passes behind the gate (z-index 1). */
  @keyframes fly {
    0%, 22% { transform: none; opacity: 1; z-index: 4; }
    42% { transform: translate(16%, -14%) scale(0.8) rotate(8deg); }
    60% { transform: translate(38%, -6%) scale(0.42) rotate(3deg); z-index: 4; }
    62% { z-index: 1; }
    84% { transform: translate(40%, 4%) scale(0.22); opacity: 1; z-index: 1; }
    100% { transform: translate(40.15%, 6.35%) scale(0.06); opacity: 0; z-index: 1; }
  }
  @keyframes flap {
    to { transform: scaleX(0.55); }
  }
</style>
