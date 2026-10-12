# Obfuscation, Nash's letters and how to secure source code in 2026 {#sec:securing}

If secrecy fails as a protection, what remains for code that must stay private? And what remains
for the public code that other people depend on? This section examines one attractive answer,
obfuscation. It also examines the different answer that cryptography gives.

## Nash's letters: security from computation, not concealment

In early 1955, John Nash wrote to the US National Security Agency to propose an enciphering
machine [@nash1955letters]. Nash is the author of the equilibrium concept for non-cooperative games
[@nash1950equilibrium]. The NSA declassified the correspondence in 2012 [@branwen2012nash]. In it,
Nash argued that, for sufficiently complex ciphers, "the mean key computation length increases
exponentially with the length of the key" [@branwen2012nash]. The idea is that security should
come from the cost of computation, not from a hidden design. Rivest, Shamir and their students read
the letters as an anticipation of complexity theory and modern cryptography [@rivest2012nash].

The machine of Nash himself had less success. The NSA decided that it "affords only limited
security" [@nash1955letters]. In 2012, Ronald Rivest, Adi Shamir and their students analysed the
machine. They found a polynomial-time chosen-plaintext attack and a subexponential known-plaintext
attack. They concluded that Nash was "a much better game theorist than a cryptographer"
[@rivest2012nash].

**[ANALYSIS]** Both parts of the story support Kerckhoffs. Modern cryptography kept the principle
of Nash: security that comes from the work that an attacker must do. After Nash's design was
published, other people judged it and broke it. That is how cryptography should work: the method
is open, and only the key is secret.

## Obfuscation: what it gives and what it cannot give

Obfuscation changes a program so that it does the same thing but is more difficult to read. One of
I made a small, honest example. *nashkell* is a Haskell pipeline that applies OCR to the
declassified letters of Nash. It asks a language model to annotate and cross-check the letters. It
stores its source code in Git with identifiers translated into Latin [@hoffmann2026nashkell].

On commit, a Git `clean` filter translates English identifiers to Latin. On checkout, a `smudge`
filter translates them to English again. Both filters use a fixed dictionary. If a person clones
the repository without the filter, that person sees the Latin form. GitHub also shows the Latin
form.

The documentation of the project lists the limits, and these limits are general
[@hoffmann2026nashkell]:

- **Structure survives.** Only top-level names change. Control flow, types and local variables stay
  intact, and a reader can infer them. Thus the result "raises, not eliminates, reading difficulty"
  and is "not a security boundary".
- **The key is the dictionary.** The mapping is a bijection, and it is stored next to the tool. A
  person who has the mapping, or can guess enough of it, can reverse the transformation.
- **The stored form does not build.** The filter does not rename file paths, so the Latin modules
  no longer agree with their paths. Obfuscation also costs the owner.
- **It is a heuristic.** The filter operates line by line and is not a parser. It does not process
  block comments or multi-line strings. A person must add new names to the dictionary manually.

Theory shows that more effort cannot remove these limits. Barak and colleagues proved that a
general "virtual black box" obfuscator cannot exist. Such an obfuscator would let no one compute
from the obfuscated program anything that they could not compute from input-output access alone.
The authors made a family of programs that a person can reverse engineer from any equivalent
program. But black-box access to these programs shows nothing of their code
[@barak2012impossibility]. The result leaves space for weaker types of obfuscation, but not for a
general method that makes source code secret.

**[ANALYSIS]** The language models of Section [-@sec:espionage] already recover source code from
binaries. Against these models, the translation of identifiers into Latin is a speed bump.

## What to secure instead: integrity, identity and keys

**[ANALYSIS]** The lesson of Nash and of obfuscation is this: do not protect the *readability* of
code. Protect what cryptography can protect: that code is what its authors wrote, and that only
they could write it. In 2026, this means four layers, and each layer has public, mature tools.

1. **Sign commits and tags.** Git signs tags and commits with GnuPG. The command
   `git merge --verify-signatures` refuses history that does not have trusted signatures
   [@chacon2014signing]. Since Git 2.34, SSH keys can sign as well as GnuPG keys
   [@git2021relnotes234].
2. **Keep signing keys in hardware.** Since OpenSSH 8.2, the `ecdsa-sk` and `ed25519-sk` key types
   use FIDO security keys. The private key never leaves the token, and the token must be present
   when the key is used [@openssh2020release82]. Thus a person who steals a laptop no longer gets
   the signing key.
3. **Require two-factor authentication on the forge.** In 2022, GitHub made a commitment about
   two-factor authentication. By the end of 2023, each user who contributes code on GitHub.com
   must enable it [@hanley2022twofactor]. A person who takes control of an account can push code
   in the name of its owner.
4. **Make signatures verifiable by everyone.** Sigstore lets developers sign with ephemeral keys
   that are bound to an existing identity through OpenID Connect. Sigstore records signatures in
   transparency logs. This removes most of the burden and risk of key management
   [@newman2022sigstore].

Hash functions are also important. In 2017, Stevens and colleagues produced the first collision for
full SHA-1 [@stevens2017first]. Git used SHA-1 as the hash for its object names. Git version 2.29
added a SHA-256 object format, and Git marked this format as experimental at first
[@git2020relnotes229].

In this model, only a small and explicit set of things stays secret. These things are private
keys, credentials, and data that is personal or under agreement, as in Section [-@sec:chemorx].
These things should have encryption and access control. For the source code itself, it is better
to publish it, sign it and cite it.

**[ANALYSIS]** In the vocabulary of Nash himself, this is a change of strategy in a game whose
payoffs moved. When reverse engineering was expensive, secrecy could be a sensible strategy for an
author. When reverse engineering is cheap, the payoff of secrecy falls towards zero. But the payoff
of a publication that others can check and credit does not fall. I do not claim that I computed
an equilibrium [@nash1950equilibrium]. I claim only that the costs on which the old strategy
rested are gone.
