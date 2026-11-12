-- SPDX-License-Identifier: AGPL-3.0-only
-- The ASD-STE100 rules that Vale checks on papers/*/prose-ste/ (.vale/styles/ste/), as types.
-- Sources of the numbers: the public summary of ASD-STE100 issue 9 in Wikipedia, "Simplified
-- Technical English" (read 12 November 2026): "no more than 20 words in instructions
-- (procedures) and 25 words in descriptive texts"; "Do not write more than six sentences in each
-- paragraph". The specification is ASD's copyright; nothing of it is copied here.
-- docs/4-ways-of-working/agda.md says what each theorem backs.

module ClosedSource.STE.Rules where

open import Data.Nat using (ℕ; _≤_; _≤?_; s≤s; z≤n)
open import Data.Nat.Properties using (≤-trans)
open import Data.List using (List; []; _∷_; [_]; length; concat; map)
open import Data.List.Relation.Unary.All using (All; []; _∷_; all?)
open import Data.Product using (Σ; _×_; _,_)
open import Relation.Binary.PropositionalEquality using (_≡_; refl; cong)
open import Relation.Nullary.Decidable using (Dec; _×?_; True; toWitness)
open import Relation.Unary using (Decidable)

-- A sentence is an instruction or a description. The limit depends on the kind.
data Kind : Set where
  procedural descriptive : Kind

limit : Kind → ℕ
limit procedural  = 20
limit descriptive = 25

-- A sentence, as Vale sees it: its kind, and the number of its words outside quotations.
record Sentence : Set where
  constructor sentence
  field
    kind  : Kind
    words : ℕ
open Sentence public

-- The type of a sentence that keeps the rule. A value of it is the proof.
Short : Sentence → Set
Short s = words s ≤ limit (kind s)

-- The rule can be decided: a machine can check it, and Vale does.
short? : Decidable Short
short? s = words s ≤? limit (kind s)

-- The procedure limit is the stricter one ...
procedural≤descriptive : limit procedural ≤ limit descriptive
procedural≤descriptive = toWitness {a? = limit procedural ≤? limit descriptive} _

-- ... so a short instruction is also a short description. This is why a paper, which is
-- descriptive text, is checked at 25, and why a procedure that passes at 20 needs no second look.
short-procedure-is-short-description :
  ∀ n → Short (sentence procedural n) → Short (sentence descriptive n)
short-procedure-is-short-description n p = ≤-trans p procedural≤descriptive

-- A paragraph is a list of sentences.
Paragraph : Set
Paragraph = List Sentence

maxSentences : ℕ
maxSentences = 6

-- A paragraph that keeps both rules.
WellFormed : Paragraph → Set
WellFormed p = (length p ≤ maxSentences) × All Short p

wellFormed? : Decidable WellFormed
wellFormed? p = (length p ≤? maxSentences) ×? all? short? p

-- The fix that Vale asks for is always possible, and it loses nothing: each paragraph can be
-- split into paragraphs of at most six sentences whose sentences, in order, are the sentences of
-- the paragraph. (Here each sentence becomes its own paragraph; a writer splits at a change of
-- topic, which is one of the many splits that this theorem allows.)
split : (p : Paragraph) →
        Σ (List Paragraph) λ ps → (concat ps ≡ p) × All (λ q → length q ≤ maxSentences) ps
split []      = [] , refl , []
split (s ∷ p) with split p
... | ps , eq , ok = [ s ] ∷ ps , cong (s ∷_) eq , s≤s z≤n ∷ ok

-- Two examples, checked by the type checker. agda/SelfTest/LongSentence.agda is the third: a
-- descriptive sentence of 26 words, which must not check.
_ : True (short? (sentence descriptive 25))
_ = _

_ : True (short? (sentence procedural 20))
_ = _
