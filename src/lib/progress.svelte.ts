// Learner progress, kept in this browser's IndexedDB.
import { get, set } from 'idb-keyval';

export interface KoanProgress {
  status: 'attempted' | 'passed';
  code: string;
  attempts: number;
  passedAt: string | null;
  updatedAt: string;
}

type ProgressMap = Record<string, KoanProgress>;

const STORAGE_KEY = 'raku-koans:progress';

class Progress {
  map = $state<ProgressMap>({});
  loaded = $state(false);

  async init() {
    try {
      this.map = (await get<ProgressMap>(STORAGE_KEY)) ?? {};
      // Ask the browser not to evict our data under storage pressure.
      void navigator.storage?.persist?.();
    } catch {
      // Private mode or blocked storage: keep going in memory.
    }
    this.loaded = true;
  }

  get(id: string): KoanProgress | undefined {
    return this.map[id];
  }

  /** Called after every run. The latest run decides: breaking a solved koan un-passes it. */
  record(id: string, code: string, passed: boolean) {
    const now = new Date().toISOString();
    const prev = this.map[id];
    this.map[id] = {
      code,
      attempts: (prev?.attempts ?? 0) + 1,
      status: passed ? 'passed' : 'attempted',
      passedAt: passed ? (prev?.passedAt ?? now) : null,
      updatedAt: now,
    };
    void this.save();
  }

  /** Restores a koan's starting code. Its status stays until the next run re-evaluates it. */
  resetCode(id: string, starter: string) {
    const prev = this.map[id];
    if (!prev) return;
    this.map[id] = { ...prev, code: starter, updatedAt: new Date().toISOString() };
    void this.save();
  }

  /** Forgets everything: passes, attempts and saved code. */
  resetAll() {
    this.map = {};
    void this.save();
  }

  private async save() {
    try {
      await set(STORAGE_KEY, $state.snapshot(this.map));
    } catch {
      /* storage unavailable */
    }
  }
}

export const progress = new Progress();
