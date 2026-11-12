-- SPDX-License-Identifier: AGPL-3.0-only
-- Section "What to secure instead" of the paper (papers/closed-source/prose/05a-securing-source.md):
-- a SWHID "names any artefact of source code by its cryptographic hash" [@swh2026swhid], and "A
-- hash that proves integrity and an identifier that gives credit are, in this standard, the same
-- string". And: "In 2017 Stevens and colleagues produced the first collision for full SHA-1"
-- [@stevens2017first]. What the types say about both:
--   * same content, same identifier: always;
--   * different identifiers, different content: always, so a mismatch proves a change;
--   * same identifier, same content: never a theorem. When there are more contents than digests,
--     a collision exists (the pigeonhole principle). A hash is trusted because a collision is hard
--     to find, which is a fact of cryptography, not of types.

module ClosedSource.Hash where

open import Data.Fin using (Fin; _<_)
open import Data.Fin.Properties using (pigeonhole)
open import Data.Nat using (ℕ) renaming (_<_ to _<ℕ_)
open import Data.Product using (∃₂; _×_; _,_)
open import Function using (_∘_)
open import Relation.Binary.PropositionalEquality using (_≡_; _≢_; refl; cong)

module _ {Content Digest : Set} (hash : Content → Digest) where

  -- Integrity: the identifier of a copy that is the same is the same identifier.
  same-content-same-id : ∀ {x y} → x ≡ y → hash x ≡ hash y
  same-content-same-id = cong hash

  -- The check that a reader can trust: if the identifiers differ, the code differs.
  different-id-different-content : ∀ {x y} → hash x ≢ hash y → x ≢ y
  different-id-different-content h = h ∘ cong hash

-- Collisions exist: n contents and m < n digests, so two different contents share a digest.
collision : ∀ {m n} → m <ℕ n → (hash : Fin n → Fin m) →
            ∃₂ λ x y → x < y × hash x ≡ hash y
collision = pigeonhole
