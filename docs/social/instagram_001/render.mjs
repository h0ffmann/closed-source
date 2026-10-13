// SPDX-License-Identifier: AGPL-3.0-only
// Renders the five 1080x1350 slides of the first Instagram post next to this file.
//   node render.mjs            (CHROMIUM=<path> to pick a browser; default google-chrome)
// After h0ffmann/picasso's docs/social/instagram_001/render.mjs at 29eb385: the same slide
// system (kicker, heading with a highlighter mark, a number with its source under it, a one-line
// drawing, a footer with the page). What differs: the colours are the book cover's, the numbers
// come from this repository's files at render time, and Chrome's own --screenshot replaces
// Playwright. The drawings are picasso's, read from the forks/picasso submodule and not copied.
import { execFileSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import path from 'node:path';
import { readFileSync, writeFileSync, rmSync, existsSync } from 'node:fs';

const here = path.dirname(fileURLToPath(import.meta.url));
const root = path.resolve(here, '../../..');
const read = (p) => readFileSync(path.join(root, p), 'utf8');
// The drawings carry their own light/dark <style>; the slides set one palette for all of them.
const draw = (n, w) => {
  const own = `forks/picasso/site/static/drawings/${n}.svg`;
  if (!existsSync(path.join(root, own))) throw new Error(`${own} is missing: git submodule update --init --depth 1 forks/picasso`);
  return read(own).replace(/<style>[\s\S]*?<\/style>/, '')
    .replace('width="360" height="240"', `width="${w}" height="${Math.round(w * 2 / 3)}"`);
};
const icon = read('site/static/icons/favicon.svg');

// The numbers on the slides, each from the file that is its source.
const scores = [...read('CITATION_SCORES.md').matchAll(/^\|\s*([^|]+?)\s*\|[^|]*\|[^|]*\|\s*(\d+)\s*\|\s*(\d+)\s*\|\s*(\d+)%\s*\|/gm)]
  .map(([, name, cited, total, pct]) => ({ name, cited: +cited, total: +total, pct: +pct }));
const scored = read('CITATION_SCORES.md').match(/^date: (\S+)$/m)[1];
const roster = [...read('50THINKERS.md').matchAll(/^\|\s*(\d+)\s*\|([^|]*)\|([^|]*)\|([^|]*)\|([^|]*)\|([^|]*)\|\s*$/gm)]
  .map(([, n, name, , , , status]) => ({ n: +n, name: name.trim(), status: status.trim() }));
const named = roster.filter((t) => t.status !== 'open');
// People a reader will know by name; an alias from PERSONAS.md (lower case) is not shown.
const faces = named.map((t) => t.name).filter((n) => /^\p{Lu}/u.test(n)).slice(0, 14);
const log = read('papers/closed-source/REFERENCES.md');
const refs = { verified: (log.match(/\|\s*verified\s*\|/g) ?? []).length, partial: (log.match(/\|\s*partial\s*\|/g) ?? []).length };
const DOI = read('CITATION.cff').match(/^doi: (\S+)$/m)[1];

const C = { cream: '#F3EDE2', ink: '#1d1b19', brown: '#5A3A22', red: '#A3201C', rose: '#E8A87C', muted: '#6b645b', ok: '#2F6B2F', warn: '#8A5A00' };
const band = (p) => (p >= 75 ? C.ok : p >= 25 ? C.warn : C.red);

const css = `
*{margin:0;padding:0;box-sizing:border-box}
body{width:1080px;height:1350px;font-family:Inter,sans-serif;color:${C.ink};background:${C.cream};position:relative;overflow:hidden}
.l{fill:none;stroke:${C.ink};stroke-width:3.2;stroke-linecap:round;stroke-linejoin:round}.d{fill:${C.ink}}
.a{fill:none;stroke:${C.red};stroke-width:3.2;stroke-linecap:round}
.pad{position:absolute;inset:96px 96px 160px}
.mono{font-family:'DejaVu Sans Mono',monospace}
.kicker{font-family:'DejaVu Sans Mono',monospace;font-size:28px;letter-spacing:2px;color:${C.red}}
h1{font-family:'Inter Display',Inter;font-weight:700;font-size:112px;line-height:1;letter-spacing:-3px}
h2{font-family:'Inter Display',Inter;font-weight:700;font-size:72px;line-height:1.05;letter-spacing:-2px}
p{font-size:36px;line-height:1.35}
.num{font-family:'Inter Display',Inter;font-weight:700;font-size:120px;line-height:1;letter-spacing:-4px;color:${C.brown}}
.src{font-family:'DejaVu Sans Mono',monospace;font-size:20px;line-height:1.4;color:${C.muted};margin-top:10px}
.mark{background:linear-gradient(transparent 62%, ${C.rose} 62%);padding:0 4px}
.cover{background:${C.brown};color:${C.cream};padding:56px 48px 0;margin:48px 0 40px}
.cover b{display:block;font-family:'Inter Display',Inter;font-weight:900;font-size:128px;line-height:.95;letter-spacing:-4px}
.cover i{display:block;font-style:normal;background:${C.red};margin:36px -48px 0;padding:22px 48px;font-family:'DejaVu Sans Mono',monospace;font-size:30px;letter-spacing:6px}
.row{display:flex;align-items:center;gap:20px;font-size:30px;margin-top:18px}
.row b{width:250px;font-weight:700}.row span{font-family:'DejaVu Sans Mono',monospace;width:110px;text-align:right}
.bar{flex:1;height:26px;background:#e2d8c8}.bar div{height:100%}
.scale{display:flex;align-items:baseline;gap:24px;margin-top:20px;font-family:'Inter Display',Inter;font-weight:700;font-size:40px;letter-spacing:-1px}
.scale span{font-size:64px;width:190px}
.names{font-size:31px;line-height:1.5;margin-top:36px}
.foot{position:absolute;left:96px;right:96px;bottom:64px;display:flex;justify-content:space-between;align-items:center;font-family:'DejaVu Sans Mono',monospace;font-size:24px;color:${C.muted}}
.foot svg{width:64px;height:64px}
.page{color:${C.red}}
`;
const foot = (n) => `<div class="foot"><span>${icon}</span><span>h0ffmann.github.io/closed-source</span><span class="page">${n}/5</span></div>`;

const slides = [
  `<div class="pad">
    <div class="kicker">v0.1.0 · first release on zenodo</div>
    <div class="cover"><b>CLOSED<br>SOURCE</b><i>THE GOD THAT FAILED</i></div>
    <p style="font-size:44px">If anyone can reverse engineer anything,<br><span class="mark">cite what you borrow.</span></p>
    <div class="src" style="margin-top:28px">doi:${DOI}</div>
    <div style="margin-top:36px;margin-left:auto;width:420px">${draw('owl', 420)}</div>
  </div>${foot(1)}`,

  `<div class="pad">
    <div class="kicker">the author</div>
    <h2 style="margin-top:36px">Mr. Nobody on the cover.<br><span class="mark">A person behind it.</span></h2>
    <p style="margin-top:36px">Written in the first person by Matheus Hoffmann, Escola Politécnica, UFRJ.</p>
    <div class="src">orcid.org/0009-0009-1056-7661</div>
    <p style="margin-top:44px;font-size:30px">His other work, each with a DOI you can cite:</p>
    <div class="mono" style="margin-top:16px;font-size:30px;line-height:1.7">
      <div><span style="color:${C.red}">marola&nbsp;</span> 10.5281/zenodo.23224155</div>
      <div><span style="color:${C.red}">ww3-gpu</span> 10.5281/zenodo.23221351</div>
      <div><span style="color:${C.red}">picasso</span> 10.5281/zenodo.23311208</div>
    </div>
    <div class="src">papers/closed-source/metadata.md</div>
    <div style="margin-top:8px;margin-left:auto;width:380px">${draw('face', 380)}</div>
  </div>${foot(2)}`,

  `<div class="pad">
    <div class="kicker">the skill</div>
    <h2 style="margin-top:36px">How much of your text<br><span class="mark">is cited?</span></h2>
    <p style="margin-top:28px;font-size:30px"><span class="mono">citation-score</span> counts the sentences that carry a citation mark.</p>
    <div class="scale" style="color:${C.ok};margin-top:36px"><span>100%</span>PERFECT. HIGHEST MATURITY LEVEL.</div>
    <div class="scale" style="color:${C.red}"><span>0%</span>POOR. 2 DIGIT IQ.</div>
    <p style="margin-top:44px;font-size:30px">Five READMEs, scored:</p>
    ${scores.map((s) => `<div class="row"><b>${s.name}</b><div class="bar"><div style="width:${s.pct}%;background:${band(s.pct)}"></div></div><span>${s.pct}%</span></div>`).join('')}
    <div class="src" style="margin-top:22px">scripts/citation-score.sh, CITATION_SCORES.md, ${scored}.<br>It counts marks, not truth. A README is not a paper.</div>
  </div>${foot(3)}`,

  `<div class="pad">
    <div class="kicker">the references</div>
    <h2 style="margin-top:36px">${roster.length} thinkers.<br><span class="mark">Two pages each.</span></h2>
    <div style="display:flex;gap:56px;margin-top:44px">
      <div style="flex:1"><div class="num">${roster.length * 2}</div>
        <p style="margin-top:12px;font-size:30px">pages: ${named.length} thinkers named, ${roster.length - named.length} places open.</p>
        <div class="src">50THINKERS.md</div></div>
      <div style="flex:1"><div class="num">${refs.verified + refs.partial}</div>
        <p style="margin-top:12px;font-size:30px">references in the paper, each fetched before it was cited.</p>
        <div class="src">papers/closed-source/REFERENCES.md</div></div>
    </div>
    <p class="names">${faces.join(' · ')} …</p>
    <div style="margin-top:4px;margin-left:auto;width:330px">${draw('guitar', 330)}</div>
  </div>${foot(4)}`,

  `<div class="pad">
    <div class="kicker">borrow · cite · propagate</div>
    <h2 style="margin-top:36px">Publish the method.<br>Mint an identifier.<br><span class="mark">Cite what you use.</span></h2>
    <p style="margin-top:28px">A position paper on reverse engineering and the ethics of citation in the age of coding agents. v0, not peer reviewed.</p>
    <div class="src">Hoffmann, M. (2026). Closed Source: The God that Failed [Preprint]. Zenodo.</div>
    <div class="mono" style="margin-top:40px;font-size:32px;line-height:1.7">
      <div><span style="color:${C.red}">doi</span> ${DOI}</div>
      <div><span style="color:${C.red}">web</span> h0ffmann.github.io/closed-source</div>
      <div><span style="color:${C.red}">src</span> github.com/h0ffmann/closed-source</div>
    </div>
    <div style="margin-top:8px;margin-left:auto;width:460px">${draw('dove', 460)}</div>
  </div>${foot(5)}`,
];

const browser = process.env.CHROMIUM ?? 'google-chrome';
for (const [i, s] of slides.entries()) {
  const html = path.join(here, `.slide-${i + 1}.html`);
  writeFileSync(html, `<!doctype html><html><head><meta charset="utf-8"><style>${css}</style></head><body>${s}</body></html>`);
  execFileSync(browser, ['--headless=new', '--no-sandbox', '--disable-gpu', '--hide-scrollbars', '--force-device-scale-factor=1',
    '--window-size=1080,1350', `--screenshot=${path.join(here, `slide-${i + 1}.png`)}`, `file://${html}`], { stdio: 'ignore' });
  rmSync(html);
}
console.error(`instagram_001: ${slides.length} slides; ${scores.length} scores of ${scored}; ${named.length} of ${roster.length} thinkers; ${refs.verified + refs.partial} references`);
