---
title: "refpulse: a Unison service behind a button on a static page"
status: draft
date: 2026-10-15
related: [refpulse.u, install.md, ../../justfile, ../../site/src/closed_source_site/app.gleam, ../../site/src/closed_source_site_ffi.mjs]
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# refpulse

The site is static, on GitHub Pages. Its **Live** section has a button, "Check the DOIs now".
The button asks this Unison service to check that each of the book's DOIs resolves at doi.org,
then shows the answer on the page. The page needs no server of its own: the browser calls the
service directly.

```text
browser (h0ffmann.github.io)              refpulse (Unison)                 doi.org
  click ──► GET /check?doi=…&doi=…  ──►  for each DOI: GET doi.org/<doi> ──►  302 or 404
  draw  ◄── 200 JSON, CORS: *       ◄──  {"checked","ran","results":[…]}
```

## The contract

| Request | Answer |
|---|---|
| `GET /health` | `{"ok":true,"service":"refpulse"}` |
| `GET /check?doi=10.5281/zenodo.1&doi=…` | `{"checked":n,"ran":"unison","results":[{"doi":…,"status":302,"ok":true}, …]}` |

- **No preflight.** The request is a plain `GET` with no custom header, so the browser sends it
  at once. The answer carries `Access-Control-Allow-Origin: *`.
- **Public and read-only.** It takes DOIs, at most 8 per request (`refpulse.maxDois`). It holds
  no secret and writes nothing.
- **Live, never a fact of the book.** The page says so. If the service is down, the button shows
  a message and points to `links.json`, the links checked at build time. Nothing else breaks.

## Run it

You need only Nix: `nix develop .#unison` gives `ucm`, the Unison Codebase Manager (pinned by
`flake.lock`).

```sh
just unison-install   # makes the refpulse project in unison/.codebase/, with @unison/cloud and @unison/routes
just unison-serve     # runs it on this machine; prints the URL; Enter stops it
```

Then open the site with the URL in the address, for example
`https://h0ffmann.github.io/closed-source/?refpulse=http://localhost:<port>/<path>#live`, or
open a local build (`just site-build`, then serve `site/dist/`) the same way.

## Deploy to Unison Cloud

1. Make an account at <https://app.unison.cloud> (the free tier is enough for a prototype).
2. Log in once from UCM: `nix develop .#unison --command ucm -c unison/.codebase`, then type
   `auth.login` and follow the browser.
3. `just unison-deploy`. It prints the service's public URL, a stable name for `refpulse`. A new
   deploy moves the name to the new code, so the URL does not change.
4. Put that URL in `refpulse_url` in `site/src/closed_source_site/app.gleam`, and open a pull
   request. From then on the button works for every reader, with no `?refpulse=`.

Unison Cloud's free tier, as its pricing page said on 15 October 2026: 5 services, which
"deactivate every 3 weeks", 50 MB of storage and 5,000 requests a month
(<https://www.unison.cloud/pricing/>). So the button must survive a service that is down, and it
does.

## Can it run on my own machine?

Yes, in three ways, from the smallest to the largest.

1. **Unison Cloud's local runtime** (`just unison-serve`, `Cloud.main.local.serve`). The same
   code, the same `deployHttp`, running on your computer. Use it to develop and to test. The page
   you open in your own browser can call it. A reader's browser cannot, because the service is on
   your machine and not on the internet.
2. **On your machine, for everyone.** Run it as in 1. Then put it on the internet with HTTPS,
   for example through a tunnel (Cloudflare Tunnel, Tailscale Funnel) or a small server of your
   own. HTTPS is required: the site is served over HTTPS, and a browser blocks an HTTPS page that
   calls a plain HTTP address on the internet. The service then runs only while your machine and
   the tunnel are up.
3. **Unison Cloud on your own machines** ("bring your own cloud", BYOC). Unison's own runtime,
   on servers you run. It is free for personal or non-commercial use, up to 10 nodes. It needs
   S3-compatible storage, and DynamoDB for transactional storage
   (<https://www.unison-lang.org/blog/cloud-byoc/>).

One thing to know for 1 and 2. Chrome is adding a permission prompt for a public page that
calls an address on your own network or machine ("local network access"). The page can still
call `localhost`, after the prompt. A tunnel's public HTTPS address does not need the prompt.

## What was checked, and what was not

- **Checked (15 October 2026).** The browser half works end to end. A stand-in server with the
  same contract asked doi.org for real: the book's DOI came back 302 and a made-up DOI 404, with
  the CORS header. A local build of the site, on a different origin from the service, was driven
  in headless Chrome. The click went out, the answer came back, and the page drew "1 of 1 DOIs
  resolve · 302". With the service down, it showed "refpulse did not answer". With no URL, it
  showed "refpulse is not deployed yet".
- **Checked (15 October 2026): `refpulse.u` itself.** `just unison-install` compiles it against
  `@unison/base` 7.20.0, `@unison/cloud` 27.3.1 and `@unison/routes` 7.0.2. `just unison-serve`
  ran it in the local runtime: `GET /health` gave 200, and `GET /check` gave 302 for the book's
  DOI and 404 for a made-up one, with `Access-Control-Allow-Origin: *`.
- **Deployed (15 October 2026).** `just unison-deploy` put refpulse on Unison Cloud at
  `https://h0ffmann.unison-services.cloud/h/uidn3rn5oag2ww53c5h4tltjlje76o3nlm44ct7tyjarcn24j2eq`.
  It answered `/health` 200, and `/check` 302 and 404, with the CORS header. The site's
  `refpulse_url` is this address. The step after it, `ServiceName.assign` (the stable name
  `/s/refpulse`), failed with 401 Unauthorized. When the name works, put `/s/refpulse` in
  `refpulse_url`: a name stays the same when the code changes, and a hash does not.
- **Next.** The checks run one after another, which takes about 0.5 s per DOI. `Remote.fork` and
  `Remote.await` could run them at the same time, on many machines, if the forked task may call
  `Http`. That is the "distributed" step, after this one compiles.

## Sources

- Unison Cloud, "Local development", <https://www.unison.cloud/docs/local-development/>, read
  15 October 2026: `Cloud.main.local.serve`.
- `@unison/routes` 7.0.2 README, <https://share.unison-lang.org/@unison/routes>, read through
  `api.unison-lang.org` on 15 October 2026: `serveSimple`, `deployHttp` with `Route.run`,
  `response.headers.add`, the CORS middleware example.
- `@unison/cloud` 27.3.1 README, <https://share.unison-lang.org/@unison/cloud>, read the same
  way: `deployHttp`, `ServiceName.assign`, `parMap`, `Remote`.
