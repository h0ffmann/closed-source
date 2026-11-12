-- SPDX-License-Identifier: AGPL-3.0-only
-- Section "Obfuscation: what it buys and what it cannot" of the paper
-- (papers/closed-source/prose/05a-securing-source.md), on nashkell [@hoffmann2026nashkell]:
--   "The key is the dictionary. The mapping is a bijection stored next to the tool. Whoever has
--    it ... undoes the transformation."
--   "Structure survives. Only top-level names change. Control flow, types and local variables
--    stay intact and inferable."
-- Both claims are theorems here, of a model: a program is a tree whose leaves are top-level names.

module ClosedSource.Obfuscation where

open import Data.Unit using (⊤; tt)
open import Function using (_∘_; id)
open import Relation.Binary.PropositionalEquality using (_≡_; refl; cong; cong₂; trans)

-- The dictionary: English names to Latin names, and back.
record Dictionary (English Latin : Set) : Set where
  field
    toLatin   : English → Latin
    toEnglish : Latin → English
    back      : ∀ e → toEnglish (toLatin e) ≡ e
    forth     : ∀ l → toLatin (toEnglish l) ≡ l
open Dictionary public

-- A program in the model: names (the only thing the filter renames), application, and binders
-- with local variables as numbers (de Bruijn), which the filter cannot see.
data Prog (N : Set) : Set where
  name : N → Prog N
  var  : Prog N
  app  : Prog N → Prog N → Prog N
  lam  : Prog N → Prog N

rename : {A B : Set} → (A → B) → Prog A → Prog B
rename f (name x)  = name (f x)
rename f var       = var
rename f (app p q) = app (rename f p) (rename f q)
rename f (lam p)   = lam (rename f p)

rename-∘ : {A B C : Set} (g : B → C) (f : A → B) (p : Prog A) →
           rename g (rename f p) ≡ rename (g ∘ f) p
rename-∘ g f (name x)  = refl
rename-∘ g f var       = refl
rename-∘ g f (app p q) = cong₂ app (rename-∘ g f p) (rename-∘ g f q)
rename-∘ g f (lam p)   = cong lam (rename-∘ g f p)

rename-id : {A : Set} (f : A → A) → (∀ x → f x ≡ x) → (p : Prog A) → rename f p ≡ p
rename-id f h (name x)  = cong name (h x)
rename-id f h var       = refl
rename-id f h (app p q) = cong₂ app (rename-id f h p) (rename-id f h q)
rename-id f h (lam p)   = cong lam (rename-id f h p)

module _ {English Latin : Set} (d : Dictionary English Latin) where

  -- The Git filters of nashkell: clean on commit, smudge on checkout.
  clean : Prog English → Prog Latin
  clean = rename (toLatin d)

  smudge : Prog Latin → Prog English
  smudge = rename (toEnglish d)

  -- "Whoever has it undoes the transformation": with the dictionary, checkout gives back
  -- exactly what was committed.
  undo : ∀ p → smudge (clean p) ≡ p
  undo p = trans (rename-∘ (toEnglish d) (toLatin d) p) (rename-id _ (back d) p)

  undo' : ∀ p → clean (smudge p) ≡ p
  undo' p = trans (rename-∘ (toLatin d) (toEnglish d) p) (rename-id _ (forth d) p)

-- "Structure survives": forget the names, and the obfuscated program is the original program.
shape : {N : Set} → Prog N → Prog ⊤
shape = rename (λ _ → tt)

structure-survives : {A B : Set} (f : A → B) (p : Prog A) → shape (rename f p) ≡ shape p
structure-survives f p = rename-∘ _ f p
