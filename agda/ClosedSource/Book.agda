-- SPDX-License-Identifier: AGPL-3.0-only
-- The hard rule of AGENTS.md, "The book": *Closed Source: The God that Failed* has exactly 66
-- pages, 33 authors and two pages per author, in each of its two editions (pt-BR and en).
-- `just check` counts the roster of 33THINKERS.md; this module checks the arithmetic of the rule,
-- and of the two rules that it replaced, so that the numbers in AGENTS.md agree with each other.

module ClosedSource.Book where

open import Data.Nat using (ℕ; _*_)
open import Relation.Binary.PropositionalEquality using (_≡_; refl)

record Rule : Set where
  constructor rule
  field
    authors pagesPerAuthor pages : ℕ
open Rule public

-- A rule is consistent when its page count is its authors times their pages.
Consistent : Rule → Set
Consistent r = authors r * pagesPerAuthor r ≡ pages r

-- The rule now (Hoffmann, 12 November 2026).
now : Rule
now = rule 33 2 66

now-consistent : Consistent now
now-consistent = refl

-- The rules it replaced (AGENTS.md records both): 50 pages, one per author (12 October 2026),
-- and 100 pages, 50 authors (until 12 November 2026).
first second : Rule
first  = rule 50 1 50
second = rule 50 2 100

first-consistent : Consistent first
first-consistent = refl

second-consistent : Consistent second
second-consistent = refl

-- Every release ships both editions, each with the same thinkers and pages.
data Edition : Set where
  en ptBR : Edition

pagesOf : Edition → ℕ
pagesOf _ = authors now * pagesPerAuthor now

same-pages : ∀ e → pagesOf e ≡ 66
same-pages en   = refl
same-pages ptBR = refl
