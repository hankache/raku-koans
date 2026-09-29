<script lang="ts">
  import { onMount } from 'svelte';
  import { EditorView, keymap, lineNumbers, highlightActiveLine, Decoration, WidgetType, type DecorationSet } from '@codemirror/view';
  import { EditorState, StateEffect, StateField } from '@codemirror/state';
  import { defaultKeymap, history, historyKeymap, indentWithTab } from '@codemirror/commands';
  import { HighlightStyle, syntaxHighlighting, bracketMatching } from '@codemirror/language';
  import { raku } from '../lib/raku-mode';
  import type { Reveal } from '../lib/koans';
  import { tags as t } from '@lezer/highlight';

  interface Props {
    value: string;
    /** 1-based line to flag, e.g. the failing assertion. */
    markLine?: number;
    markKind?: 'fail' | 'error';
    /** Changes on every run, so the mark is redrawn even when the same line fails again. */
    markRun?: number;
    /** Where each answer goes: the text around its ___ on the koan's line (0-based). */
    spots: { line: number; before: string; after: string }[];
    onchange: (code: string) => void;
    onrun: () => void;
    /** The line of the answer spot the cursor is on, or null when it isn't on one. */
    onspot: (line: number | null) => void;
  }
  let { value, markLine, markKind = 'fail', markRun = 0, spots, onchange, onrun, onspot }: Props = $props();

  let host: HTMLDivElement;
  let view: EditorView;

  const highlight = HighlightStyle.define([
    { tag: [t.keyword, t.controlKeyword, t.definitionKeyword], color: 'var(--syn-keyword)' },
    { tag: [t.string, t.special(t.string)], color: 'var(--syn-string)' },
    { tag: t.number, color: 'var(--syn-number)' },
    { tag: [t.variableName, t.special(t.variableName)], color: 'var(--syn-variable)' },
    { tag: [t.comment, t.docComment], color: 'var(--syn-comment)', fontStyle: 'italic' },
    { tag: t.typeName, color: 'var(--syn-type)' },
    { tag: t.standard(t.variableName), color: 'var(--syn-builtin)' },
    { tag: t.atom, color: 'var(--syn-number)' },
    { tag: [t.regexp, t.escape], color: 'var(--syn-regexp)' },
    { tag: t.operator, color: 'var(--ink-soft)' },
  ]);

  // Answer spots: where each answer goes, found by the text around it, so a spot stays marked
  // (pink, clickable) whatever it holds: ___, the learner's answer, or nothing at all.
  interface SpotRange { from: number; to: number; line: number }
  function findSpots(state: EditorState): SpotRange[] {
    const found: SpotRange[] = [];
    for (let n = 1; n <= state.doc.lines; n++) {
      const l = state.doc.line(n);
      let best: (typeof spots)[number] | undefined;
      for (const sp of spots) {
        const fits = l.text.length >= sp.before.length + sp.after.length && l.text.startsWith(sp.before) && l.text.endsWith(sp.after);
        if (fits && (!best || Math.abs(sp.line - (n - 1)) < Math.abs(best.line - (n - 1)))) best = sp;
      }
      if (best) found.push({ from: l.from + best.before.length, to: l.to - best.after.length, line: n });
    }
    return found;
  }
  // An emptied spot still shows, as a thin marker.
  class EmptySpot extends WidgetType {
    toDOM() {
      const span = document.createElement('span');
      span.className = 'cm-blank cm-blank-empty';
      return span;
    }
  }
  const spotField = StateField.define<SpotRange[]>({
    create: s => findSpots(s),
    update: (ranges, tr) => (tr.docChanged ? findSpots(tr.state) : ranges),
    provide: f =>
      EditorView.decorations.from(f, ranges =>
        Decoration.set(
          ranges.map(r =>
            r.from === r.to
              ? Decoration.widget({ widget: new EmptySpot(), side: 1 }).range(r.from)
              : Decoration.mark({ class: 'cm-blank' }).range(r.from, r.to),
          ),
        ),
      ),
  });
  const spotAt = (state: EditorState, pos: number) => state.field(spotField).find(r => pos >= r.from && pos <= r.to);

  // The flagged line (the first failing assertion, or an error), set after each run. It stays on
  // its line while the learner edits, until the next run moves it.
  const setMark = StateEffect.define<{ line?: number; kind: string }>();
  // Kept as a position at the start of the line; text inserted right there pushes it along
  // with its line (mapPos with assoc 1), so the mark never lands on a new line above.
  const marked = StateField.define<{ pos: number; kind: string } | null>({
    create: () => null,
    update(m, tr) {
      for (const e of tr.effects) {
        if (!e.is(setMark)) continue;
        const { line, kind } = e.value;
        return line && line <= tr.state.doc.lines ? { pos: tr.state.doc.line(line).from, kind } : null;
      }
      return m && tr.docChanged ? { ...m, pos: tr.changes.mapPos(m.pos, 1) } : m;
    },
    provide: f =>
      EditorView.decorations.from(f, m =>
        m ? Decoration.set([Decoration.line({ class: `cm-mark-${m.kind}` }).range(m.pos)]) : Decoration.none,
      ),
  });

  /** Puts a revealed answer in its place (the result panel's "Use it"), then moves to the line's end. */
  export function fillAnswer(r: Reveal) {
    if (!view || r.line > view.state.doc.lines) return;
    const line = view.state.doc.line(r.line);
    if (r.end > line.length) return;
    view.dispatch({
      changes: { from: line.from + r.start, to: line.from + r.end, insert: r.answer },
      selection: { anchor: line.to - (r.end - r.start) + r.answer.length },
      scrollIntoView: true,
    });
    view.focus();
  }

  /** After a run: the cursor to the start of a line (the failing one), in view and focused. */
  export function focusLine(lineNumber?: number) {
    if (!view) return;
    if (lineNumber && lineNumber <= view.state.doc.lines) {
      view.dispatch({ selection: { anchor: view.state.doc.line(lineNumber).from }, scrollIntoView: true });
    }
    view.focus();
  }

  onMount(() => {
    view = new EditorView({
      parent: host,
      state: EditorState.create({
        doc: value,
        extensions: [
          lineNumbers(),
          history(),
          highlightActiveLine(),
          bracketMatching(),
          raku,
          syntaxHighlighting(highlight),
          spotField,
          marked,
          // Clicking an answer spot selects what's in it, so typing replaces it.
          EditorView.domEventHandlers({
            mousedown(e, v) {
              const el = (e.target as HTMLElement).closest('.cm-blank');
              if (!el || e.shiftKey || e.detail > 1) return false;
              const spot = spotAt(v.state, v.posAtDOM(el));
              if (!spot) return false;
              e.preventDefault();
              v.dispatch({ selection: { anchor: spot.from, head: spot.to } });
              v.focus();
              return true;
            },
          }),
          keymap.of([
            { key: 'Mod-Enter', run: () => (onrun(), true), preventDefault: true },
            indentWithTab,
            ...defaultKeymap,
            ...historyKeymap,
          ]),
          EditorView.updateListener.of(u => {
            if (u.docChanged) onchange(u.state.doc.toString());
            if (u.docChanged || u.selectionSet) onspot(spotAt(u.state, u.state.selection.main.head)?.line ?? null);
          }),
          EditorView.lineWrapping,
          // Tab indents inside the editor, so tell keyboard and screen-reader users how to get out.
          EditorView.contentAttributes.of({
            'aria-label':
              'Koan code. Ctrl+Enter runs it. Press Escape, then Tab, to move on to the Run button.',
          }),
        ],
      }),
    });
    return () => view.destroy();
  });

  // Replace the document when the koan changes (or is reset) from outside.
  $effect(() => {
    if (view && value !== view.state.doc.toString()) {
      view.dispatch({ changes: { from: 0, to: view.state.doc.length, insert: value } });
    }
  });

  $effect(() => {
    void markRun; // redraw after every run, even for the same line
    view?.dispatch({ effects: setMark.of({ line: markLine, kind: markKind }) });
  });
</script>

<div class="editor" bind:this={host}></div>

<style>
  .editor {
    border: 1px solid var(--line);
    background: var(--code-bg);
    box-shadow: var(--shadow);
  }
  .editor :global(.cm-editor) { font-size: 14.5px; background: var(--code-bg); color: var(--ink); }
  .editor :global(.cm-editor.cm-focused) { outline: none; }
  .editor :global(.cm-scroller) { font-family: var(--font-mono); line-height: 1.7; padding: 0.5rem 0; }
  .editor :global(.cm-content) { caret-color: var(--accent); }
  .editor :global(.cm-cursor) { border-left-color: var(--accent); border-left-width: 2px; }
  .editor :global(.cm-gutters) { background: var(--code-bg); color: var(--ink-faint); border: none; }
  .editor :global(.cm-activeLine) { background: color-mix(in srgb, var(--ink) 4%, transparent); }
  .editor :global(.cm-activeLineGutter) { background: transparent; color: var(--ink-soft); }
  .editor :global(.cm-selectionBackground),
  .editor :global(.cm-focused .cm-selectionBackground) { background: color-mix(in srgb, var(--wing-blue) 25%, transparent) !important; }
  .editor :global(.cm-blank-empty) {
    display: inline-block;
    width: 0.6ch;
    height: 1.1em;
    vertical-align: text-bottom;
  }
  .editor :global(.cm-blank) {
    cursor: pointer;
    color: var(--syn-blank);
    background: color-mix(in srgb, var(--syn-blank) 16%, transparent);
    font-weight: 600;
  }
  .editor :global(.cm-mark-fail) { background: color-mix(in srgb, var(--fail) 12%, transparent); box-shadow: inset 3px 0 var(--fail); }
  .editor :global(.cm-mark-error) { background: color-mix(in srgb, var(--fail) 18%, transparent); box-shadow: inset 3px 0 var(--fail); }

</style>
