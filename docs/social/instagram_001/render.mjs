// SPDX-License-Identifier: AGPL-3.0-only
// Renders the five 1080x1350 slides of the first Instagram post next to this file, twice: the
// post in English (slide-N.png) and its easy Brazilian Portuguese version (slide-N.easy.pt-BR.png).
//   node render.mjs            (CHROMIUM=<path> to pick a browser; default google-chrome)
// After h0ffmann/picasso's docs/social/instagram_001/render.mjs at 29eb385: the same slide
// system (kicker, heading with a highlighter mark, a number with its source under it, a one-line
// drawing, a footer with the page). What differs: the colours are the book's identity (black and
// red, with yellow letters; no brown), the numbers
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

const C = { cream: '#F3EDE2', ink: '#141312', black: '#0F0E0D', red: '#A3201C', yellow: '#F2C230', muted: '#5F5B56', ok: '#2F6B2F', mid: '#E3A900' };
const band = (p) => (p >= 75 ? C.ok : p >= 25 ? C.mid : C.red);

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
.num{font-family:'Inter Display',Inter;font-weight:700;font-size:120px;line-height:1;letter-spacing:-4px;color:${C.ink}}
.src{font-family:'DejaVu Sans Mono',monospace;font-size:20px;line-height:1.4;color:${C.muted};margin-top:10px}
.mark{background:linear-gradient(transparent 62%, ${C.yellow} 62%);padding:0 4px}
.cover{background:${C.black};color:${C.yellow};padding:56px 48px 0;margin:48px 0 40px}
.cover b{display:block;font-family:'Inter Display',Inter;font-weight:900;font-size:128px;line-height:.95;letter-spacing:-4px}
.cover i{display:block;font-style:normal;background:${C.red};margin:36px -48px 0;padding:22px 48px;color:${C.cream};font-family:'DejaVu Sans Mono',monospace;font-size:30px;letter-spacing:6px}
.row{display:flex;align-items:center;gap:20px;font-size:30px;margin-top:18px}
.row b{width:250px;font-weight:700}.row span{font-family:'DejaVu Sans Mono',monospace;width:110px;text-align:right}
.bar{flex:1;height:26px;background:#dedad2}.bar div{height:100%}
.scale{display:flex;align-items:baseline;gap:24px;margin-top:20px;font-family:'Inter Display',Inter;font-weight:700;font-size:40px;letter-spacing:-1px}
.scale span{font-size:64px;width:190px}
.names{font-size:31px;line-height:1.5;margin-top:36px}
.foot{position:absolute;left:96px;right:96px;bottom:64px;display:flex;justify-content:space-between;align-items:center;font-family:'DejaVu Sans Mono',monospace;font-size:24px;color:${C.muted}}
.foot svg{width:64px;height:64px}
.page{color:${C.red}}
`;
const foot = (n) => `<div class="foot"><span>${icon}</span><span>h0ffmann.github.io/closed-source</span><span class="page">${n}/5</span></div>`;

// The words of the slides. `en` is the post; `easy.pt-BR` is its easy Brazilian Portuguese
// version, made with the easy-pt-br skill: shorter sentences, and each technical word explained.
const T = {
  en: {
    k1: 'v0.2.0 · live on zenodo', p1: 'If anyone can reverse engineer anything,<br><span class="mark">cite what you borrow.</span>', s1: `doi:${DOI}`,
    k2: 'the author', h2: 'Mr. Nobody on the cover.<br><span class="mark">A person behind it.</span>',
    p2: 'Written in the first person by Matheus Hoffmann, Escola Politécnica, UFRJ.', o2: 'His other work, each with a DOI you can cite:',
    k3: 'the skill', h3: 'How much of your text<br><span class="mark">is cited?</span>',
    p3: '<span class="mono">citation-score</span> counts the sentences that carry a citation mark.',
    top: 'PERFECT. HIGHEST MATURITY LEVEL.', bottom: 'POOR. 2 DIGIT IQ.', five: 'Five READMEs, scored:',
    s3: 'It counts marks, not truth. A README is not a paper.',
    k4: 'the references', h4: (n) => `${n} thinkers.<br><span class="mark">Two pages each.</span>`,
    pages: (named, open) => `pages: ${named} thinkers named, ${open} places open.`, refs: 'references in the paper, each fetched before it was cited.',
    k5: 'borrow · cite · propagate', h5: 'Publish the method.<br>Mint an identifier.<br><span class="mark">Cite what you use.</span>',
    p5: 'A position paper on reverse engineering and the ethics of citation in the age of coding agents. v0, not peer reviewed.',
    web: 'web', src: 'src',
  },
  'easy.pt-BR': {
    k1: 'v0.2.0 · no ar, no zenodo', p1: 'Hoje qualquer pessoa consegue desmontar um programa para ver como ele funciona.<br><span class="mark">Então cite o que você pega emprestado.</span>',
    s1: `doi:${DOI} · DOI é um endereço que não muda`,
    k2: 'o autor', h2: 'Na capa, Mr. Nobody.<br><span class="mark">Atrás dela, uma pessoa.</span>',
    p2: 'Quem escreve, em primeira pessoa, é Matheus Hoffmann, da Escola Politécnica da UFRJ.', o2: 'Outros trabalhos dele. Cada um tem um DOI, para você citar:',
    k3: 'a ferramenta', h3: 'Quanto do seu texto<br><span class="mark">tem citação?</span>',
    p3: 'A <span class="mono">citation-score</span> conta as frases que apontam para uma fonte: um link, um DOI, um autor e um ano.',
    top: 'PERFEITO. NÍVEL MÁXIMO DE MATURIDADE.', bottom: 'FRACO. QI DE 2 DÍGITOS.', five: 'Cinco páginas de projeto (READMEs), medidas:',
    s3: 'Ela conta as marcas. Não confere se a citação está certa.',
    k4: 'as referências', h4: (n) => `${n} pensadores.<br><span class="mark">Duas páginas para cada um.</span>`,
    pages: (named, open) => `páginas: ${named} pensadores já têm nome, ${open} lugares estão abertos.`, refs: 'referências no artigo. Cada uma foi lida antes de ser citada.',
    k5: 'pegue · cite · passe adiante', h5: 'Publique o método.<br>Registre um identificador.<br><span class="mark">Cite o que você usa.</span>',
    p5: 'Um artigo de opinião sobre engenharia reversa e a ética de citar, na época dos agentes de IA. É a versão v0: nenhuma revista revisou o texto ainda.',
    web: 'site', src: 'código',
  },
};

const slidesFor = (t) => [
  `<div class="pad">
    <div class="kicker">${t.k1}</div>
    <div class="cover"><b>CLOSED<br>SOURCE</b><i>THE GOD THAT FAILED</i></div>
    <p style="font-size:${t === T.en ? 44 : 38}px">${t.p1}</p>
    <div class="src" style="margin-top:28px">${t.s1}</div>
    <div style="margin-top:${t === T.en ? 36 : 8}px;margin-left:auto;width:${t === T.en ? 420 : 360}px">${draw('owl', t === T.en ? 420 : 360)}</div>
  </div>${foot(1)}`,

  `<div class="pad">
    <div class="kicker">${t.k2}</div>
    <h2 style="margin-top:36px">${t.h2}</h2>
    <p style="margin-top:36px">${t.p2}</p>
    <div class="src">orcid.org/0009-0009-1056-7661</div>
    <p style="margin-top:44px;font-size:30px">${t.o2}</p>
    <div class="mono" style="margin-top:16px;font-size:30px;line-height:1.7">
      <div><span style="color:${C.red}">marola&nbsp;</span> 10.5281/zenodo.23224155</div>
      <div><span style="color:${C.red}">ww3-gpu</span> 10.5281/zenodo.23221351</div>
      <div><span style="color:${C.red}">picasso</span> 10.5281/zenodo.23311208</div>
    </div>
    <div class="src">papers/closed-source/metadata.md</div>
    <div style="margin-top:8px;margin-left:auto;width:${t === T.en ? 380 : 320}px">${draw('face', t === T.en ? 380 : 320)}</div>
  </div>${foot(2)}`,

  `<div class="pad">
    <div class="kicker">${t.k3}</div>
    <h2 style="margin-top:36px">${t.h3}</h2>
    <p style="margin-top:28px;font-size:30px">${t.p3}</p>
    <div class="scale" style="color:${C.ok};margin-top:36px"><span>100%</span>${t.top}</div>
    <div class="scale" style="color:${C.red}"><span>0%</span>${t.bottom}</div>
    <p style="margin-top:44px;font-size:30px">${t.five}</p>
    ${scores.map((s) => `<div class="row"><b>${s.name}</b><div class="bar"><div style="width:${s.pct}%;background:${band(s.pct)}"></div></div><span>${s.pct}%</span></div>`).join('')}
    <div class="src" style="margin-top:22px">scripts/citation-score.sh, CITATION_SCORES.md, ${scored}.<br>${t.s3}</div>
  </div>${foot(3)}`,

  `<div class="pad">
    <div class="kicker">${t.k4}</div>
    <h2 style="margin-top:36px">${t.h4(roster.length)}</h2>
    <div style="display:flex;gap:56px;margin-top:44px">
      <div style="flex:1"><div class="num">${roster.length * 2}</div>
        <p style="margin-top:12px;font-size:30px">${t.pages(named.length, roster.length - named.length)}</p>
        <div class="src">50THINKERS.md</div></div>
      <div style="flex:1"><div class="num">${refs.verified + refs.partial}</div>
        <p style="margin-top:12px;font-size:30px">${t.refs}</p>
        <div class="src">papers/closed-source/REFERENCES.md</div></div>
    </div>
    <p class="names">${faces.join(' · ')} …</p>
    <div style="margin-top:4px;margin-left:auto;width:${t === T.en ? 330 : 260}px">${draw('guitar', t === T.en ? 330 : 260)}</div>
  </div>${foot(4)}`,

  `<div class="pad">
    <div class="kicker">${t.k5}</div>
    <h2 style="margin-top:36px">${t.h5}</h2>
    <p style="margin-top:28px">${t.p5}</p>
    <div class="src">Hoffmann, M. (2026). Closed Source: The God that Failed [Preprint]. Zenodo.</div>
    <div class="mono" style="margin-top:40px;font-size:32px;line-height:1.7">
      <div><span style="color:${C.red}">doi</span> ${DOI}</div>
      <div><span style="color:${C.red}">${t.web}</span> h0ffmann.github.io/closed-source</div>
      <div><span style="color:${C.red}">${t.src}</span> github.com/h0ffmann/closed-source</div>
    </div>
    <div style="margin-top:8px;margin-left:auto;width:${t === T.en ? 460 : 360}px">${draw('dove', t === T.en ? 460 : 360)}</div>
  </div>${foot(5)}`,
];

const browser = process.env.CHROMIUM ?? 'google-chrome';
let count = 0;
for (const [lang, t] of Object.entries(T)) {
  for (const [i, body] of slidesFor(t).entries()) {
    const name = lang === 'en' ? `slide-${i + 1}` : `slide-${i + 1}.${lang}`;
    const html = path.join(here, `.${name}.html`);
    writeFileSync(html, `<!doctype html><html lang="${lang === 'en' ? 'en' : 'pt-BR'}"><head><meta charset="utf-8"><style>${css}</style></head><body>${body}</body></html>`);
    execFileSync(browser, ['--headless=new', '--no-sandbox', '--disable-gpu', '--hide-scrollbars', '--force-device-scale-factor=1',
      '--window-size=1080,1350', `--screenshot=${path.join(here, `${name}.png`)}`, `file://${html}`], { stdio: 'ignore' });
    rmSync(html);
    count++;
  }
}
console.error(`instagram_001: ${count} slides in ${Object.keys(T).length} versions; ${scores.length} scores of ${scored}; ${named.length} of ${roster.length} thinkers; ${refs.verified + refs.partial} references`);
