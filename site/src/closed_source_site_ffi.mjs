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
