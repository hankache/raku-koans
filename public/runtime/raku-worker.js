// Runs Raku.js (Raku++ compiled to WebAssembly) off the main thread.
//
// rakupp_run() is synchronous and runs a program to completion, so it must not
// block the UI. Living in a worker also lets the page kill a runaway program
// (e.g. an infinite loop) by terminating us.
//
// Protocol:  in  { type: 'run', id, src }
//            out { type: 'ready', version } | { type: 'loaderror', message }
//                { type: 'done', id, rc, lines: [{ stream, text }] }
//                { type: 'crash', id, message, lines }   (instance rebuilt)

/* global RakuJS */
importScripts('rakujs.js'); // defines the RakuJS factory; the .wasm is found next to it

let Module = null;
let lines = null; // collecting output only while a run is in progress

function makeModule() {
  return RakuJS({
    print:    text => (lines ? lines.push({ stream: 'out', text }) : console.log(text)),
    printErr: text => (lines ? lines.push({ stream: 'err', text }) : console.warn(text)),
  }).then(m => (Module = m));
}

let ready = makeModule()
  .then(m => self.postMessage({ type: 'ready', version: m.ccall('rakupp_version', 'string', [], []) }))
  .catch(err => self.postMessage({ type: 'loaderror', message: String(err) }));

self.onmessage = async ({ data }) => {
  if (data.type !== 'run') return;
  await ready;
  if (!Module) return self.postMessage({ type: 'loaderror', message: 'Raku.js failed to load' });

  lines = [];
  try {
    const rc = Module.ccall('rakupp_run', 'number', ['string', 'string'], [data.src, '']);
    self.postMessage({ type: 'done', id: data.id, rc, lines });
  } catch (err) {
    // Deep recursion (RangeError) or an abort leaves the instance in an unknown
    // state: report it and build a fresh one for the next run.
    self.postMessage({ type: 'crash', id: data.id, message: String(err), lines });
    Module = null;
    ready = makeModule();
  } finally {
    lines = null;
  }
};
