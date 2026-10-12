// Browser glue the Gleam modules cannot express.
export function copy(text, done) {
  if (!navigator.clipboard) return void done(false);
  navigator.clipboard.writeText(text).then(() => done(true), () => done(false));
}
