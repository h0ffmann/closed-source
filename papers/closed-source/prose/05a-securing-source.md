# Obfuscation, Nash's letters and how to secure source code in 2026 {#sec:securing}

If secrecy fails as a protection, what is left for code that must stay private, and for the
public code that others depend on? This section looks at one tempting answer, obfuscation, and at
the answer that cryptography gives instead.

## Nash's letters: security from computation, not concealment

In early 1955 John Nash, the author of the equilibrium concept for non-cooperative games
[@nash1950equilibrium], wrote to the US National Security Agency to propose an enciphering
machine [@nash1955letters]. The NSA declassified the
correspondence in 2012 [@branwen2012nash]. In it Nash argued that, for sufficiently complex
ciphers, "the mean key computation length increases exponentially with the length of the key"
[@branwen2012nash]. The idea is that security should rest on the cost of computation rather than on
hiding the design. Rivest, Shamir and their students read the letters as an anticipation of
complexity theory and modern cryptography [@rivest2012nash]. Nash's own machine fared less well. The NSA judged that it "affords only limited security"
[@nash1955letters], and when Ronald Rivest, Adi Shamir and their students analysed it in 2012
they found a polynomial-time chosen-plaintext attack and a subexponential known-plaintext attack,
and concluded that Nash was "a much better game theorist
than a cryptographer" [@rivest2012nash].

**[ANALYSIS]** Both halves of the story support Kerckhoffs. Nash's principle, security from the
work an attacker must do, is the one modern cryptography kept. His design, once published, was
judged and broken by others. That is how cryptography is supposed to work: the method is open,
and only the key is secret.

## Obfuscation: what it buys and what it cannot

Obfuscation transforms a program so that it does the same thing but is harder to read. One of the
I built a small, honest example. *nashkell*, a Haskell pipeline that runs OCR on Nash's
declassified letters and asks a language model to annotate and cross-check them, stores its source
in Git with identifiers translated into Latin [@hoffmann2026nashkell]. A Git `clean` filter
translates English identifiers to Latin on commit, and a `smudge` filter translates them back on
checkout, through a fixed dictionary; anyone who clones without the filter sees, and GitHub shows,
the Latin form.

The project's own documentation lists the limits, and they are general
[@hoffmann2026nashkell]:

- **Structure survives.** Only top-level names change. Control flow, types and local variables stay
  intact and inferable, so the result "raises, not eliminates, reading difficulty" and is "not a
  security boundary".
- **The key is the dictionary.** The mapping is a bijection stored next to the tool. Whoever has
  it, or can guess enough of it, undoes the transformation.
- **The stored form does not build.** File paths are not renamed, so the Latin modules no longer
  match their paths. Obfuscation costs the owner too.
- **It is a heuristic.** The filter is line-based, not a parser; it does not handle block comments
  or multi-line strings, and new names must be added to the dictionary by hand.

Theory says these limits are not a matter of effort. Barak and colleagues proved that a general
"virtual black box" obfuscator cannot exist. Such an obfuscator would let no one compute from the
obfuscated program anything they could not compute from input-output access alone. The authors
built a family of programs that can be reverse engineered from any equivalent program, although
black-box access reveals nothing of their code [@barak2012impossibility]. The result leaves room for weaker notions of obfuscation, but
not for a general method that makes source code secret. **[ANALYSIS]** And against the language
models of Section [-@sec:espionage], which already recover source from binaries, renaming
identifiers into Latin is a speed bump.

## What to secure instead: integrity, identity and keys

**[ANALYSIS]** The lesson of Nash and of obfuscation is to stop protecting the *readability* of
code and to protect what cryptography can protect: that code is what its authors wrote, and that
only they could have written it. In 2026 that means four layers, each with public, mature tools.

1. **Sign commits and tags.** Git signs tags and commits with GnuPG, and `git merge
   --verify-signatures` refuses history without trusted signatures [@chacon2014signing]. Since
   Git 2.34, SSH keys can sign as well as GnuPG keys [@git2021relnotes234].
2. **Keep signing keys in hardware.** Since OpenSSH 8.2, FIDO security keys back the `ecdsa-sk`
   and `ed25519-sk` key types; the private key never leaves the token, and the token must be
   present when the key is used [@openssh2020release82]. A stolen laptop no longer means a stolen
   signing key.
3. **Require two-factor authentication on the forge.** GitHub committed in 2022 to require every
   user who contributes code on GitHub.com to enable two-factor authentication by the end of 2023
   [@hanley2022twofactor]. A person who takes over an account can push code in its owner's name.
4. **Make signatures verifiable by everyone.** Sigstore lets developers sign with ephemeral keys
   bound to an existing identity through OpenID Connect, and records signatures in transparency
   logs, which removes most of the burden and risk of key management [@newman2022sigstore].

Hash functions matter too. In 2017 Stevens and colleagues produced the first collision for full
SHA-1 [@stevens2017first], the hash on which Git's object names were built. Git has offered a
SHA-256 object format since version 2.29, first marked experimental [@git2020relnotes229].

What stays secret under this model is small and explicit: private keys, credentials, and data that
is personal or under agreement, as in Section [-@sec:chemorx]. Those deserve encryption and access
control. The source code itself is better published, signed and cited.

**[ANALYSIS]** In Nash's own vocabulary, this is a change of strategy in a game whose payoffs have
moved. When reverse engineering was expensive, secrecy could be a sensible strategy for an
author. When reverse engineering is cheap, the payoff of secrecy falls towards zero, while the
payoff of credited, verifiable publication does not. I do not claim to have computed an
equilibrium [@nash1950equilibrium]; I claim only that the costs on which the old strategy rested
are gone.
