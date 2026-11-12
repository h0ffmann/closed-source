-- SPDX-License-Identifier: AGPL-3.0-only
-- The self-test of scripts/agda-check.sh: this file must NOT check. Under --safe (the flag of
-- closed-source.agda-lib) a postulate is refused, because a postulate "can be used to assume any
-- axiom" (Agda docs, "Safe Agda"; notes/202611120009-agda-over-lean-types-are-signals.md).
module SelfTest.Postulate where

open import Data.Empty using (⊥)

postulate
  anything : ⊥
