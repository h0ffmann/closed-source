import { Ok, Error } from "./gleam.mjs";
// Browser glue the Gleam modules cannot express.
export function copy(text, done) {
  if (!navigator.clipboard) return void done(false);
  navigator.clipboard.writeText(text).then(() => done(true), () => done(false));
}

export function scroll_by(id, dx) {
  const el = document.getElementById(id);
  if (!el) return;
  const calm = matchMedia("(prefers-reduced-motion: reduce)").matches;
  el.scrollBy({ left: dx, behavior: calm ? "auto" : "smooth" });
}

// The live DOI check (refpulse, unison/refpulse/). A plain GET, so no CORS preflight: the
// service answers with Access-Control-Allow-Origin: *.
export function refpulse(url, dois, done) {
  const endpoint = new URLSearchParams(location.search).get("refpulse") || url;
  if (!endpoint) return void done(new Error("refpulse is not deployed yet: see unison/refpulse/README.md"));
  const query = [...dois].map((d) => "doi=" + encodeURIComponent(d)).join("&");
  const started = performance.now();
  fetch(endpoint.replace(/\/$/, "") + "/check?" + query)
    .then((r) => (r.ok ? r.json() : Promise.reject(new globalThis.Error("HTTP " + r.status))))
    .then((j) => {
      const ms = Math.round(performance.now() - started);
      const rows = (j.results || []).map((x) => [x.doi, x.status, x.ok].join("\t"));
      done(new Ok([ms + "\t" + endpoint, ...rows].join("\n")));
    })
    .catch((e) => done(new Error("refpulse did not answer (" + e.message + "). The last checked links are in links.json.")));
}
