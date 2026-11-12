-- SPDX-License-Identifier: AGPL-3.0-only
-- The table of .vale/styles/ste/PhrasalVerbs.yml, and the property that makes it safe for Vale:
-- no replacement is itself a phrase that the table replaces, so one pass of the substitution
-- reaches a fixed point and the rule cannot send a writer in a circle. scripts/agda-check.sh
-- fails if this table and the YAML file differ.

module ClosedSource.STE.PhrasalVerbs where

open import Data.Bool using (Bool; true; false; not; _∧_; _∨_)
open import Data.List using (List; []; _∷_; map; foldr)
open import Data.Product using (_×_; _,_; proj₁; proj₂)
open import Data.String using (String; _==_)
open import Relation.Binary.PropositionalEquality using (_≡_; refl)

Swap : Set
Swap = String × String   -- (phrasal verb, the one word to use)

table : List Swap
table =
  ("set up" , "configure") ∷ ("sets up" , "configures") ∷
  ("find out" , "find") ∷ ("finds out" , "finds") ∷ ("found out" , "found") ∷
  ("carry out" , "do") ∷ ("carries out" , "does") ∷ ("carried out" , "did") ∷
  ("point out" , "show") ∷ ("points out" , "shows") ∷ ("pointed out" , "showed") ∷
  ("figure out" , "find") ∷ ("figured out" , "found") ∷
  ("give up" , "stop") ∷ ("gave up" , "stopped") ∷
  ("look into" , "examine") ∷ ("looked into" , "examined") ∷
  ("make up" , "make") ∷ ("made up of" , "made of") ∷
  ("turn out" , "become") ∷ ("turned out" , "became") ∷
  ("come up with" , "make") ∷ ("came up with" , "made") ∷
  ("get rid of" , "remove") ∷ ("got rid of" , "removed") ∷
  ("put off" , "delay") ∷ ("went on" , "continued") ∷ ("goes on" , "continues") ∷ []

-- any and all, written here: the standard library moved them in v2.3, and the pinned one may
-- be older or newer.
any all : {A : Set} → (A → Bool) → List A → Bool
any p = foldr (λ x b → p x ∨ b) false
all p = foldr (λ x b → p x ∧ b) true

lefts : List String
lefts = map proj₁ table

replaced : String → Bool
replaced w = any (w ==_) lefts

-- No replacement is a phrase that the table replaces.
fixed-point : all (λ s → not (replaced (proj₂ s))) table ≡ true
fixed-point = refl

-- Each swap is a real change: no phrase is swapped for itself.
no-identity : all (λ s → not (proj₁ s == proj₂ s)) table ≡ true
no-identity = refl
