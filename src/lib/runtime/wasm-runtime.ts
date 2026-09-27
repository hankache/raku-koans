import type { RakuRuntime, RunResult } from './types';

const WORKER_URL = `${import.meta.env.BASE_URL}runtime/raku-worker.js`;

/** Raku.js in a Web Worker, with a watchdog that kills runaway programs. */
export class WasmRuntime implements RakuRuntime {
  ready!: Promise<string>;
  private worker!: Worker;
  private nextId = 1;
  private pending = new Map<number, (r: RunResult) => void>();

  constructor(private timeoutMs = 8000) {
    this.spawn();
  }

  private spawn() {
    this.worker = new Worker(WORKER_URL);
    this.ready = new Promise((resolve, reject) => {
      this.worker.onmessage = ({ data }) => {
        switch (data.type) {
          case 'ready':
            return resolve(data.version);
          case 'loaderror':
            return reject(new Error(data.message));
          case 'done':
            return this.settle(data.id, { rc: data.rc, lines: data.lines, ms: data.ms });
          case 'crash':
            return this.settle(data.id, {
              rc: -1, lines: data.lines, ms: 0, aborted: 'crash', message: data.message,
            });
        }
      };
      this.worker.onerror = e => reject(new Error(e.message || 'Raku.js worker failed to start'));
    });
  }

  private settle(id: number, result: RunResult) {
    this.pending.get(id)?.(result);
    this.pending.delete(id);
  }

  async run(src: string): Promise<RunResult> {
    // Don't start the watchdog until the 8 MB interpreter has loaded.
    await this.ready;
    const id = this.nextId++;
    return new Promise(resolve => {
      const timer = setTimeout(() => {
        // The interpreter is synchronous: the only way to stop it is to kill the worker.
        this.worker.terminate();
        this.pending.clear();
        this.spawn();
        resolve({ rc: -1, lines: [], ms: this.timeoutMs, aborted: 'timeout' });
      }, this.timeoutMs);
      this.pending.set(id, r => {
        clearTimeout(timer);
        resolve(r);
      });
      this.worker.postMessage({ type: 'run', id, src });
    });
  }
}
