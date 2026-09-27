export interface OutputLine {
  stream: 'out' | 'err';
  text: string;
}

export interface RunResult {
  rc: number;
  lines: OutputLine[];
  ms: number;
  /** Set when the program was killed or the interpreter crashed. */
  aborted?: 'timeout' | 'crash';
  message?: string;
}

/**
 * Anything that can run a Raku program. The default is the in-browser
 * WasmRuntime; a server-backed runtime (real Rakudo in a sandbox) can
 * implement this too, for features Raku.js cannot offer.
 */
export interface RakuRuntime {
  /** Resolves with the engine's version string once it can run code. */
  readonly ready: Promise<string>;
  run(src: string): Promise<RunResult>;
}
