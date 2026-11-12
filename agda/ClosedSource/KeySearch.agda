-- SPDX-License-Identifier: AGPL-3.0-only
-- Section "Nash's letters" of the paper (papers/closed-source/prose/05a-securing-source.md):
-- Nash argued that "the mean key computation length increases exponentially with the length of
-- the key" [@branwen2012nash]. The part of that claim that is pure counting: an attacker who
-- knows the method (Kerckhoffs) and not the key must search a key space of 2^n keys for a key of
-- n bits, and each bit doubles it. That the best attack is no better than search is Nash's
-- conjecture about his ciphers, not a theorem, and this module does not claim it.

module ClosedSource.KeySearch where

open import Data.Bool using (Bool; true; false)
open import Data.List using (List; []; _∷_; [_]; map; _++_; length)
open import Data.List.Properties using (length-++; length-map)
open import Data.List.Membership.Propositional using (_∈_)
open import Data.List.Membership.Propositional.Properties using (∈-++⁺ˡ; ∈-++⁺ʳ; ∈-map⁺)
open import Data.List.Relation.Unary.Any using (here)
open import Data.Nat using (ℕ; zero; suc; _+_; _^_; _<_)
open import Data.Nat.Properties using (+-identityʳ; m^n>0; m<m+n)
open import Data.Vec using (Vec; []; _∷_)
open import Relation.Binary.PropositionalEquality using (_≡_; refl; cong; cong₂; trans; sym)

Key : ℕ → Set
Key n = Vec Bool n

-- Every key of n bits, the list that a search goes through.
keys : (n : ℕ) → List (Key n)
keys zero    = [ [] ]
keys (suc n) = map (true ∷_) (keys n) ++ map (false ∷_) (keys n)

-- The search is complete: each key is in the list.
complete : ∀ {n} (k : Key n) → k ∈ keys n
complete []          = here refl
complete (true ∷ k)  = ∈-++⁺ˡ (∈-map⁺ (true ∷_) (complete k))
complete (false ∷ k) = ∈-++⁺ʳ (map (true ∷_) (keys _)) (∈-map⁺ (false ∷_) (complete k))

-- The search space of n bits has 2^n keys.
size : ∀ n → length (keys n) ≡ 2 ^ n
size zero    = refl
size (suc n) =
  trans (length-++ (map (true ∷_) (keys n)))
        (trans (cong₂ _+_ (trans (length-map (true ∷_) (keys n)) (size n))
                          (trans (length-map (false ∷_) (keys n)) (size n)))
               (cong (2 ^ n +_) (sym (+-identityʳ (2 ^ n)))))

-- One more bit doubles the space ...
doubles : ∀ n → 2 ^ suc n ≡ 2 ^ n + 2 ^ n
doubles n = cong (2 ^ n +_) (+-identityʳ (2 ^ n))

-- ... and so it always grows.
grows : ∀ n → 2 ^ n < 2 ^ suc n
grows n rewrite doubles n = m<m+n (2 ^ n) (m^n>0 2 n)
