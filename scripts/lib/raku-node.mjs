// Run Raku.js (Raku++ compiled to WebAssembly) under Node, so CI checks koans
// against the exact engine the browser uses.
//
// The published build is web-only: it fetches its .wasm over HTTP. We bypass that
// with Emscripten's `instantiateWasm` hook and hand it the bytes from disk.
import { readFileSync } from 'node:fs';
import { runInThisContext } from 'node:vm';
import { fileURLToPath } from 'node:url';

const runtimeDir = fileURLToPath(new URL('../../public/runtime/', import.meta.url));

export async function loadRaku() {
  let RakuJS, wasm;
  try {
    // rakujs.js is a classic script defining a global factory; our package is
    // "type": "module", so evaluate it as a script rather than require() it.
    RakuJS = runInThisContext(readFileSync(runtimeDir + 'rakujs.js', 'utf8') + '\n;RakuJS', {
      filename: 'rakujs.js',
    });
    wasm = readFileSync(runtimeDir + 'rakujs.wasm');
  } catch {
    throw new Error('Raku.js runtime missing — run `npm run fetch-runtime` first.');
  }

  let sink = null;
  const mod = await RakuJS({
    instantiateWasm(imports, done) {
      WebAssembly.instantiate(wasm, imports).then(r => done(r.instance, r.module));
      return {};
    },
    print: t => sink?.push({ stream: 'out', text: t }),
    printErr: t => sink?.push({ stream: 'err', text: t }),
  });

  return {
    version: mod.ccall('rakupp_version', 'string', [], []),
    /** Runs a whole program synchronously; returns exit code and output lines. */
    run(src, stdin = '') {
      sink = [];
      try {
        const rc = mod.ccall('rakupp_run', 'number', ['string', 'string'], [src, stdin]);
        return { rc, lines: sink };
      } finally {
        sink = null;
      }
    },
  };
}
