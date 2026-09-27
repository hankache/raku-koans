<script lang="ts">
  import { onMount } from 'svelte';
  import { EditorView, keymap, lineNumbers, highlightActiveLine, Decoration, type DecorationSet } from '@codemirror/view';
  import { EditorState, StateEffect, StateField } from '@codemirror/state';
  import { defaultKeymap, history, historyKeymap, indentWithTab } from '@codemirror/commands';
  import { HighlightStyle, syntaxHighlighting, bracketMatching } from '@codemirror/language';
  import { raku } from '../lib/raku-mode';
  import { tags as t } from '@lezer/highlight';

  interface Props {
    value: string;
    /** 1-based line to flag, e.g. the failing assertion. */
    markLine?: number;
    markKind?: 'fail' | 'error';
    onchange: (code: string) => void;
    onrun: () => void;
  }
  let { value, markLine, markKind = 'fail', onchange, onrun }: Props = $props();

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

  // Pink pill behind every ___ so blanks jump out.
  const blankMark = Decoration.mark({ class: 'cm-blank' });
  const blanks = StateField.define<DecorationSet>({
    create: s => findBlanks(s),
    update: (deco, tr) => (tr.docChanged ? findBlanks(tr.state) : deco),
    provide: f => EditorView.decorations.from(f),
  });
  function findBlanks(state: EditorState): DecorationSet {
    const text = state.doc.toString();
    const ranges = [...text.matchAll(/___/g)].map(m => blankMark.range(m.index!, m.index! + 3));
    return Decoration.set(ranges);
  }

  // The flagged line (failing test or error), set from outside.
  const setMark = StateEffect.define<{ line?: number; kind: string }>();
  const marked = StateField.define<DecorationSet>({
    create: () => Decoration.none,
    update(deco, tr) {
      for (const e of tr.effects) {
        if (!e.is(setMark)) continue;
        const { line, kind } = e.value;
        if (!line || line > tr.state.doc.lines) return Decoration.none;
        const from = tr.state.doc.line(line).from;
        return Decoration.set([Decoration.line({ class: `cm-mark-${kind}` }).range(from)]);
      }
      return tr.docChanged ? Decoration.none : deco;
    },
    provide: f => EditorView.decorations.from(f),
  });

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
          blanks,
          marked,
          keymap.of([
            { key: 'Mod-Enter', run: () => (onrun(), true), preventDefault: true },
            indentWithTab,
            ...defaultKeymap,
            ...historyKeymap,
          ]),
          EditorView.updateListener.of(u => u.docChanged && onchange(u.state.doc.toString())),
          EditorView.lineWrapping,
          // Tab indents inside the editor, so tell keyboard and screen-reader users how to get out.
          EditorView.contentAttributes.of({
            'aria-label': 'Koan code. Ctrl+Enter runs it. Press Escape, then Tab, to move on to the Run button.',
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
    view?.dispatch({ effects: setMark.of({ line: markLine, kind: markKind }) });
  });
</script>

<div class="editor" bind:this={host}></div>

<style>
  .editor {
    border: 1px solid var(--line);
    overflow: hidden;
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
  .editor :global(.cm-blank) {
    color: var(--syn-blank);
    background: color-mix(in srgb, var(--syn-blank) 16%, transparent);
    font-weight: 600;
  }
  .editor :global(.cm-mark-fail) { background: color-mix(in srgb, var(--fail) 12%, transparent); box-shadow: inset 3px 0 var(--fail); }
  .editor :global(.cm-mark-error) { background: color-mix(in srgb, var(--fail) 18%, transparent); box-shadow: inset 3px 0 var(--fail); }
</style>
