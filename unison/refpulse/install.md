<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# refpulse: install

A UCM transcript (`just unison-install`): it makes the `refpulse` project in the codebase at
`unison/.codebase/` (not committed), installs the libraries from Unison Share and adds
`refpulse.u`. The output, `install.output.md`, shows what UCM said at each step.

```ucm
scratch/main> project.create-empty refpulse
refpulse/main> lib.install @unison/base
refpulse/main> lib.install @unison/cloud
refpulse/main> lib.install @unison/routes
refpulse/main> load unison/refpulse/refpulse.u
refpulse/main> add
```
