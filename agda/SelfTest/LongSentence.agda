-- SPDX-License-Identifier: AGPL-3.0-only
-- The self-test of scripts/agda-check.sh: this file must NOT check. A descriptive sentence of 26
-- words breaks the rule, so no proof that it is short can exist, and the type checker says so.
module SelfTest.LongSentence where

open import Relation.Nullary.Decidable using (True)
open import ClosedSource.STE.Rules

_ : True (short? (sentence descriptive 26))
_ = _
