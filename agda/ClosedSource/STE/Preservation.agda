-- SPDX-License-Identifier: AGPL-3.0-only
-- What tools/fabric ste-check promises, as a type. An STE pass may change words, never facts:
-- the citation markers, anchors, quotations and numbers of prose-ste/ are those of prose/, as a
-- multiset (tools/src/fabric/ste_check.gleam). A multiset is a list up to order, so "the same
-- multiset" is a permutation (_↭_ of the standard library).

module ClosedSource.STE.Preservation where

open import Data.List using (List; []; _∷_; [_]; concat; map; _++_)
open import Data.List.Relation.Binary.Permutation.Propositional using (_↭_; ↭-refl; ↭-trans)
open import Data.List.Relation.Binary.Permutation.Propositional.Properties using (++-comm)
open import Function using (_∘_)
open import Relation.Binary.PropositionalEquality using (_≡_; refl)

module _ {Text Fact : Set} (facts : Text → List Fact) where

  -- A pass keeps the facts.
  Keeps : (Text → Text) → Set
  Keeps pass = ∀ t → facts (pass t) ↭ facts t

  -- STE100.md logs several passes (rewrite, check, then one pass per change). Two passes that
  -- each keep the facts, one after the other, keep them: so the check of each pass is enough.
  keeps-∘ : ∀ {p q} → Keeps p → Keeps q → Keeps (q ∘ p)
  keeps-∘ {p} {q} kp kq t = ↭-trans (kq (p t)) (kp t)

  -- The pass that changes nothing keeps everything.
  keeps-id : Keeps (λ t → t)
  keeps-id t = ↭-refl

-- Facts are counted, not placed: a pass may move a sentence, with its citation, to another place.
move : {A : Set} (xs ys : List A) → (xs ++ ys) ↭ (ys ++ xs)
move = ++-comm

-- Splitting a paragraph keeps its sentences, so it keeps their facts (ClosedSource.STE.Rules.split).
split-keeps : {A Fact : Set} (facts : A → List Fact) (p : List A) (ps : List (List A)) →
              concat ps ≡ p → concat (map facts (concat ps)) ↭ concat (map facts p)
split-keeps facts .(concat ps) ps refl = ↭-refl
