// Downloads Raku.js (Raku++ compiled to WebAssembly, Artistic-2.0) from an official Raku++
// release on GitHub (https://github.com/ash/rakupp/releases) into public/runtime/.
//
//   npm run fetch-runtime                    the release pinned in runtime.lock.json, verified
//   npm run fetch-runtime -- --update        move to the latest release and re-pin it
//   npm run fetch-runtime -- --update v4.1.0 move to a given release
//
// After --update, run `npm run check:koans` before publishing.
import { createHash } from 'node:crypto';
import { existsSync, readFileSync, writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { inflateRawSync } from 'node:zlib';

const REPO = 'ash/rakupp';
const FILES = ['rakujs.js', 'rakujs.wasm'];
const outDir = fileURLToPath(new URL('../public/runtime/', import.meta.url));
const lockPath = fileURLToPath(new URL('../runtime.lock.json', import.meta.url));

const args = process.argv.slice(2);
const update = args.includes('--update');
const wantedTag = update ? args[args.indexOf('--update') + 1] : undefined;
const lock = existsSync(lockPath) ? JSON.parse(readFileSync(lockPath, 'utf8')) : null;
const sha256 = buf => createHash('sha256').update(buf).digest('hex');
const die = msg => {
  console.error(`✗ ${msg}`);
  process.exit(1);
};

async function download(url) {
  const res = await fetch(url, { headers: { 'User-Agent': 'raku-koans' } });
  if (!res.ok) die(`${url}: HTTP ${res.status}`);
  return Buffer.from(await res.arrayBuffer());
}

/** Reads the named files out of a zip archive (stored or deflated entries). */
function unzip(zip, names) {
  let eocd = zip.length - 22;
  while (eocd >= 0 && zip.readUInt32LE(eocd) !== 0x06054b50) eocd--;
  if (eocd < 0) die('not a zip archive');
  const count = zip.readUInt16LE(eocd + 10);
  let p = zip.readUInt32LE(eocd + 16);
  const found = {};
  for (let i = 0; i < count; i++) {
    const method = zip.readUInt16LE(p + 10);
    const size = zip.readUInt32LE(p + 20);
    const nameLen = zip.readUInt16LE(p + 28);
    const skip = nameLen + zip.readUInt16LE(p + 30) + zip.readUInt16LE(p + 32);
    const local = zip.readUInt32LE(p + 42);
    const name = zip.toString('utf8', p + 46, p + 46 + nameLen);
    const base = name.split('/').pop();
    if (names.includes(base)) {
      const start = local + 30 + zip.readUInt16LE(local + 26) + zip.readUInt16LE(local + 28);
      const data = zip.subarray(start, start + size);
      found[base] = method === 0 ? data : method === 8 ? inflateRawSync(data) : die(`${name}: unsupported compression`);
    }
    p += 46 + skip;
  }
  for (const n of names) if (!found[n]) die(`${n} is not in the release archive`);
  return found;
}

// Which release?
let tag = lock?.tag;
if (update) {
  tag = wantedTag ?? JSON.parse((await download(`https://api.github.com/repos/${REPO}/releases/latest`)).toString()).tag_name;
} else if (!tag) {
  die('runtime.lock.json has no release pinned: run `npm run fetch-runtime -- --update` once.');
}

// Download it and check it against the checksum Raku++ publishes with the release.
const base = `https://github.com/${REPO}/releases/download/${tag}/rakujs-${tag}.zip`;
const zip = await download(base);
const published = (await download(`${base}.sha256`)).toString().trim().split(/\s+/)[0];
const zipHash = sha256(zip);
if (zipHash !== published) die(`rakujs-${tag}.zip does not match the checksum published with the release`);
if (!update && zipHash !== lock.zip) {
  die(`rakujs-${tag}.zip differs from the one pinned in runtime.lock.json. Re-run with --update to accept it, then npm run check:koans.`);
}
console.log(`✓ rakujs-${tag}.zip  ${(zip.length / 1e6).toFixed(1)} MB, checksum verified`);

const files = unzip(zip, FILES);
const hashes = {};
for (const name of FILES) {
  hashes[name] = sha256(files[name]);
  if (!update && hashes[name] !== lock.files[name]) die(`${name} differs from runtime.lock.json`);
  writeFileSync(outDir + name, files[name]);
  console.log(`✓ ${name}  ${(files[name].length / 1e6).toFixed(1)} MB`);
}

const { loadRaku } = await import('./lib/raku-node.mjs');
const { version } = await loadRaku();
console.log(`✓ Raku++ ${version}`);

if (update) {
  const source = `https://github.com/${REPO}/releases/tag/${tag}`;
  writeFileSync(lockPath, JSON.stringify({ source, tag, version, zip: zipHash, files: hashes }, null, 2) + '\n');
  console.log(`✓ runtime.lock.json now pins ${tag}. Run npm run check:koans before publishing.`);
}
