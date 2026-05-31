/-
  Example: Graded Monoid Structure and Proofs
  
  This demonstrates building a Lean4 project using modular mathlib flakes.
  Run: nix build "github:meta-introspector/mathlib4?ref=feature/split&dir=Algebra/GradedMonoid" --no-write-lock-file
  Then: ls /tmp/result/*.lean
-/

namespace GradedMonoidExample

/-- A graded monoid where M n is the type of homogeneous elements of degree n -/
structure GradedMonoid (M : ℕ → Type) where
  one : M 0
  mul : ∀ (i j : ℕ), M i → M j → M (i + j)
  one_mul : ∀ (i : ℕ) (a : M i), mul 0 i one a = a
  mul_one : ∀ (i : ℕ) (a : M i), mul i 0 a one = a
  mul_assoc : ∀ (i j k : ℕ) (a : M i) (b : M j) (c : M k),
    mul (i + j) k (mul i j a b) c = mul i (j + k) a (mul j k b c)

/-- The trivial graded monoid (one element at each degree) -/
def trivialGradedMonoid : GradedMonoid (λ _ => Unit) where
  one := ()
  mul := fun _ _ _ _ => ()
  one_mul := by simp [trivialGradedMonoid.mul]
  mul_one := by simp [trivialGradedMonoid.mul]
  mul_assoc := by simp [trivialGradedMonoid.mul]

/-- Verification: the trivial graded monoid satisfies all axioms -/
theorem trivialGradedMonoid_ok : GradedMonoid (λ _ => Unit) := trivialGradedMonoid

end GradedMonoidExample

/-
  Build this example:
  nix build "github:meta-introspector/mathlib4?ref=feature/split&dir=Algebra/GradedMonoid" --no-write-lock-file
  
  The module Algebra.GradedMonoid.lean is available from the feature/split branch.
-/