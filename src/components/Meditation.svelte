<!-- The result panel: what the koan is trying to tell you. -->
<script lang="ts">
  import type { Report } from '../lib/tap';
  import type { Reveal } from '../lib/koans';
  import LogoGate from './LogoGate.svelte';

  interface Props {
    report: Report | null;
    /** Assertions this run got past that the previous run did not. */
    gained: number;
    running: boolean;
    runtimeError?: string;
    nextHref?: string;
    /** The answer on offer, hidden until the learner reveals it. */
    hint?: Reveal | null;
    /** Put the revealed answer into the code. */
    onuse?: () => void;
  }
  let { report, gained, running, runtimeError, nextHref, hint, onuse }: Props = $props();

  // Which answer was revealed: a new line or a new answer hides it again.
  let revealedKey = $state('');
  const hintKey = $derived(hint ? `${hint.line}:${hint.answer}` : '');
  const revealed = $derived(hintKey !== '' && revealedKey === hintKey);
  // Leaving a spot (for another spot, or none) hides its answer again: coming back shows it blurred.
  $effect(() => {
    void hintKey;
    revealedKey = '';
  });

  const CHEERS = [
    'The mist begins to clear.',
    'Your understanding grows.',
    'One more truth revealed.',
    'The path unfolds beneath your feet.',
    'Good. Keep walking.',
    'Camelia approves.',
    'A small step, and a real one.',
  ];
  // Re-picked for every new report, never the same line twice in a row.
  let lastCheer = -1;
  const cheer = $derived.by(() => {
    if (!report) return '';
    let i;
    do i = Math.floor(Math.random() * CHEERS.length);
    while (i === lastCheer);
    lastCheer = i;
    return CHEERS[i];
  });
</script>

{#snippet answer()}
  {#if hint}
    <p class="hint">
      <span class="muted">Stuck? The answer for line {hint.line}:</span>
      {#if revealed}
        <code class="answer">{hint.answer}</code>
        <button class="link" onclick={onuse}>Use it</button>
      {:else}
        <button class="spoiler" onclick={() => (revealedKey = hintKey)} aria-label="Reveal the answer for line {hint.line}" title="Click to reveal">
          <code aria-hidden="true">{hint.answer}</code>
        </button>
      {/if}
    </p>
  {:else}
    <p class="small muted">Stuck? Click a <code class="blank">___</code> to see its answer.</p>
  {/if}
{/snippet}

<div class="panel {report?.status ?? 'idle'}" aria-live="polite">
  {#if running}
    <p class="lead muted">Meditating…</p>
  {:else if !report}
    <p class="lead muted">Replace each <code class="blank">___</code>, then press <kbd>Run</kbd> or <kbd>Ctrl</kbd>+<kbd>Enter</kbd>.</p>
    {#if runtimeError}<p class="small error-note">{runtimeError}</p>{/if}
    {@render answer()}
  {:else if report.status === 'passed'}
    <div class="celebrate">
      {#key report}<LogoGate size={112} />{/key}
      <div>
        <p class="lead">Enlightenment!</p>
        <p class="small">{report.tests.length === 1 ? 'The assertion holds.' : `All ${report.tests.length} assertions hold.`}</p>
      </div>
    </div>
    {#if nextHref}<a class="next" href={nextHref}>Next koan →</a>{:else}<a class="next" href="#/">Back to the path</a>{/if}
  {:else if report.status === 'failed'}
    {@const f = report.failure}
    {#if gained > 0}
      <p class="cheer">✓ {gained === 1 ? 'Assertion passed' : `${gained} assertions passed`}. {cheer}</p>
    {/if}
    <p class="lead">
      {#if f.blank}Meditate on {f.line ? `line ${f.line}` : 'this'}{:else}Not quite{#if f.line}<span class="line">— line {f.line}</span>{/if}{/if}
    </p>
    {@render answer()}
    {#if !f.blank && f.actual !== undefined}
      <dl class="compare">
        {#if f.answer !== undefined}<dt>Your answer</dt><dd>{f.answer}</dd>{/if}
        <dt>Raku says</dt><dd>{f.actual}</dd>
      </dl>
    {:else if !f.blank && f.diag.length}
      <pre class="diag">{f.diag.join('\n')}</pre>
    {/if}
    <ol class="steps" aria-label="{f.n - 1} of {report.tests.length} assertions passed">
      {#each report.tests as t (t.n)}
        <li class:ok={t.ok && t.n < f.n} class:current={t.n === f.n}>
          <span class="mark" aria-hidden="true">{t.ok && t.n < f.n ? '✓' : t.n === f.n ? '→' : ''}</span>
          {t.description || `Assertion ${t.n}`}
        </li>
      {/each}
    </ol>
  {:else}
    <p class="lead">Your code has not yet found its form{#if report.line}<span class="line">— line {report.line}</span>{/if}</p>
    <pre class="diag">{report.message}</pre>
    {@render answer()}
  {/if}

  {#if report?.output.length}
    <details open>
      <summary>Output</summary>
      <pre>{report.output.join('\n')}</pre>
    </details>
  {/if}
</div>

<style>
  .panel {
    padding: 1.2rem 1.4rem;
    border: 1px solid var(--line);
    background: var(--bg-raised);
    transition: background 0.3s, border-color 0.3s;
  }
  .panel.passed { background: var(--pass-bg); border-color: var(--pass); }
  .panel.failed, .panel.error { background: var(--fail-bg); border-color: color-mix(in srgb, var(--fail) 50%, transparent); }
  .lead { font-family: var(--font-display); font-size: 1.3rem; margin: 0; }
  .failed .lead, .error .lead { color: var(--fail); }
  .passed .lead { color: var(--pass); }
  .line { margin-left: 0.4em; font-family: var(--font-body); font-size: 0.95rem; color: var(--ink-soft); }
  .muted { color: var(--ink-soft); }
  .error-note { color: var(--fail); }
  .small { font-size: 0.85rem; margin: 0.4rem 0 0; }
  pre {
    font-family: var(--font-mono);
    font-size: 0.85rem;
    white-space: pre-wrap;
    margin: 0.7rem 0 0;
    padding: 0.7rem 0.9rem;
    background: var(--bg-raised);
    border: 1px solid var(--line);
  }
  .link {
    padding: 0;
    border: none;
    background: none;
    color: var(--ink);
    font: inherit;
    text-decoration: underline;
    text-underline-offset: 0.2em;
    cursor: pointer;
  }
  .link:hover { color: var(--accent); }
  .hint {
    display: flex;
    flex-wrap: wrap;
    align-items: baseline;
    gap: 0.3rem 0.6rem;
    margin: 0.7rem 0 0;
    font-size: 0.88rem;
  }
  .answer { font-family: var(--font-mono); font-size: 0.95rem; color: var(--ink); overflow-wrap: anywhere; }
  /* A hidden answer: blurred until clicked, and not selectable or copyable meanwhile. */
  .spoiler {
    padding: 0.05rem 0.45rem;
    border: none;
    background: color-mix(in srgb, var(--ink) 8%, transparent);
    cursor: pointer;
    user-select: none;
  }
  .spoiler code { font-family: var(--font-mono); font-size: 0.95rem; color: var(--ink); filter: blur(5px); transition: filter 0.15s; }
  .spoiler:hover code, .spoiler:focus-visible code { filter: blur(4px); }
  .compare {
    display: grid;
    grid-template-columns: auto minmax(0, 1fr);
    gap: 0.35rem 0.9rem;
    margin: 0.7rem 0 0;
    padding: 0.7rem 0.9rem;
    background: var(--bg-raised);
    border: 1px solid var(--line);
    font-size: 0.85rem;
  }
  .compare dt { color: var(--ink-soft); }
  .compare dd { margin: 0; font-family: var(--font-mono); white-space: pre-wrap; overflow-wrap: anywhere; }
  .cheer {
    margin: 0 0 0.9rem;
    padding: 0.5rem 0.8rem;
    background: var(--pass-bg);
    color: var(--pass);
    font-weight: 600;
    font-size: 0.9rem;
    animation: pop 0.45s cubic-bezier(0.2, 1.6, 0.4, 1);
  }
  @keyframes pop { from { transform: scale(0.85); opacity: 0; } }
  .blank { color: var(--syn-blank); background: color-mix(in srgb, var(--syn-blank) 14%, transparent); padding: 0 0.3em; }
  .steps { list-style: none; padding: 0; margin: 1rem 0 0; display: grid; gap: 0.3rem; font-size: 0.88rem; }
  .steps li { display: flex; gap: 0.5rem; color: var(--ink-faint); }
  .steps li.ok { color: var(--pass); }
  .steps li.current { color: var(--ink); font-weight: 600; }
  .mark { width: 1em; flex: none; text-align: center; }
  .current .mark { color: var(--fail); }
  .celebrate { display: flex; gap: 1rem; align-items: center; }
  .next {
    display: inline-block;
    margin-top: 1rem;
    text-decoration: none;
    font-weight: 600;
    background: var(--pass);
    color: var(--bg);
    padding: 0.55rem 1.1rem;
  }
  details { margin-top: 1rem; }
  summary { cursor: pointer; font-size: 0.85rem; color: var(--ink-soft); }
  kbd {
    font-family: var(--font-mono);
    font-size: 0.8em;
    padding: 0.05em 0.4em;
    border: 1px solid var(--line);
    border-bottom-width: 2px;
    background: var(--bg-raised);
  }
</style>
