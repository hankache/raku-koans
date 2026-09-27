import manifest from '../generated/koans.json';
import { WasmRuntime } from './runtime/wasm-runtime';
import type { RakuRuntime } from './runtime/types';
import { parseRun, type Report } from './tap';

export interface Koan {
  id: string;
  title: string;
  intro: string;
  code: string;
}

export interface Section {
  id: string;
  title: string;
  blurb: string;
  koans: Koan[];
}

export const sections: Section[] = manifest.sections;
export const allKoans: Koan[] = sections.flatMap(s => s.koans);
export const koanById = new Map(allKoans.map(k => [k.id, k]));
export const sectionOf = (id: string) => sections.find(s => s.koans.some(k => k.id === id))!;

export function neighbours(id: string) {
  const i = allKoans.findIndex(k => k.id === id);
  return { prev: allKoans[i - 1], next: allKoans[i + 1] };
}

const PRELUDE_LINES = manifest.prelude.split('\n').length - 1;

let runtime: RakuRuntime | undefined;
/** Created lazily, but call early (e.g. on page load) to start downloading the 8 MB interpreter. */
export function getRuntime(): RakuRuntime {
  return (runtime ??= new WasmRuntime());
}

export async function runKoan(code: string): Promise<Report> {
  const result = await getRuntime().run(manifest.prelude + code + manifest.epilogue);
  return parseRun(result, code, PRELUDE_LINES);
}
