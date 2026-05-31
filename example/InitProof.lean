/-
  Example: Working Lean4 Proof Using Modular Flake
  
  This demonstrates that Lean4 proofs work with the modular flake system.
  The Init module has no dependencies and can compile independently.
-/

namespace InitProof

-- Example: Basic propositional logic
theorem modusPonens (p q : Prop) : (p → q) → p → q := fun h ha => h ha

-- Example: Function composition
def compose {α β γ : Type} (g : β → γ) (f : α → β) : α → γ := fun x => g (f x)

-- Example: Identity function
theorem composeId {α β : Type} (f : α → β) : compose id f = f := rfl

-- Example: Associativity
theorem composeAssoc {α β γ δ : Type} (f : α → β) (g : β → γ) (h : γ → δ) :
  compose h (compose g f) = compose (compose h g) f := by
  funext x
  rfl

end InitProof

/-
  Build this:
  nix build "github:meta-introspector/mathlib4?ref=feature/split&dir=Init" --no-write-lock-file
-/