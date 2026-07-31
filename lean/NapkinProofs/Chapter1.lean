import Mathlib.Algebra.Group.Equiv.Defs
import Mathlib.Analysis.Complex.Circle
import Mathlib.LinearAlgebra.Matrix.GeneralLinearGroup.Defs
import Mathlib.GroupTheory.SpecificGroups.Dihedral

import NapkinProofs.Obviouslib

/--
# Example 1.1.1 (Additive integers)

The pair (ℤ, +) is a group: ℤ = {. . . , −2, −1, 0, 1, 2, . . . } is the set and
the associative operation is addition. Note that
• The element 0 ∈ ℤ is an identity: a + 0 = 0 + a = a for any a.
• Every element a ∈ ℤ has an additive inverse: a + (−a) = (−a) + a = 0.
We call this group ℤ.
-/
instance : AddCommGroup ℤ := by infer_instance

/--
# Example 1.1.2 (Nonzero rationals)
Let ℚ^× be the set of *nonzero rational numbers*. The pair (ℚ^×, ·) is a group: the set
is ℚ^× and the associative operation is *multiplication*.
Again we see the same two nice properties.
• The element 1 ∈ ℚ^× is an identity: for any rational number, a · 1 = 1 · a = a.
• For any rational number x ∈ ℚ^×, we have an inverse x^−1, such that

    x · x^−1 = x^−1 · x = 1.
-/
instance : CommGroup ℚˣ := by infer_instance
-- It's equivalent with manually defined version
instance : Mul { q : ℚ // q ≠ 0 } where mul a b := ⟨a.val * b.val, by aesop⟩
example : ℚˣ ≃* { q : ℚ // q ≠ 0 } where
  toFun q := ⟨q.val, q.ne_zero⟩
  invFun q := Units.mk0 q.val q.property
  left_inv q := by aesop
  right_inv q := by aesop
  map_mul' x y := by aesop

/--
# Example 1.1.6 (Non-Examples of groups)
• The pair (ℚ, ·) is NOT a group. (Here ℚ is rational numbers.) While there is
  an identity element, the element 0 ∈ ℚ does not have an inverse.
-/
example : ¬(∀ {a : ℚ}, a * a⁻¹ = 1) := by
  push Not
  use 0
  linarith

/--
• The pair (Z, ·) is also NOT a group. (Why?)
-/
example [Group ℤ] : ¬(∀ {a : ℤ}, a * a⁻¹ = 1) := by
  push Not
  use 0
  linarith

/--
• Let Mat_2×2(ℝ) be the set of 2 × 2 real matrices. Then (Mat_2×2(ℝ), ·)
  (where · is matrix multiplication) is NOT a group.
-/
example : ¬(∀ {a : (Matrix (Fin 2) (Fin 2) ℝ)}, a * a⁻¹ = 1) := by
  intro h
  specialize h (a := 0)
  aesop

/--
# Example 1.1.7 (Complex unit circle)
Let S^1 denote the set of complex numbers z with absolute value one; that is

    S^1 := {z ∈ ℂ | |z| = 1}

Then (S^1, ×) is a group
-/
noncomputable instance : CommGroup Circle := by infer_instance
-- It's equivalent with manually defined version
instance : Mul { z : ℂ // ‖z‖ = 1 } where
  mul a b := ⟨a.val * b.val, by aesop⟩
noncomputable example : Circle ≃* { z : ℂ // ‖z‖ = 1 } where
  toFun z := ⟨z, by aesop⟩
  invFun z := ⟨z.val, by
    change z.val ∈ Submonoid.unitSphere ℂ
    exact mem_sphere_zero_iff_norm.2 z.property⟩
  left_inv z := by aesop
  right_inv z := by aesop
  map_mul' x y := by aesop

/--
# Example 1.1.8 (Addition mod n)
Here is an example from number theory: Let n > 1 be an integer, and consider the
residues (remainders) modulo n. These form a group under addition. We call this
the **cyclic group of order n**, and denote it as Z/nZ, with elements 0, 1, . . . . The
identity is 0.
-/
instance : AddCommGroup (ZMod n) := by infer_instance

/--
# Example 1.1.9 (Multiplication mod p)
Let p be a prime. Consider the *nonzero residues modulo* p, which we denote by
(Z/pZ)^×. Then ((Z/pZ)^×, ×) is a group.
-/
instance [Fact p.Prime] : CommGroup (ZMod p)ˣ := by infer_instance
example [Fact p.Prime] : Fintype.card (ZMod p)ˣ = p - 1 := by
  rw [Fintype.card_congr ZMod.unitsEquivCoprime, Fintype.card_congr zmod_coprime_equiv_fin_nz]
  aesop

/--
# Question 1.1.10. Why do we need the fact that p is prime?
-/
example : ¬(∀ {n : ℕ} [NeZero n], Fintype.card (ZMod n)ˣ = n - 1) := by
  intro h
  specialize h (n := 4)
  contradiction

/--
# Example 1.1.11 (General linear group)
Let n be a positive integer. Then GL_n(ℝ) is defined as the set of n×n real matrices
which have nonzero determinant. It turns out that with this condition, every matrix
does indeed have an inverse, so (GL_n(ℝ), ×) is a group, called the general linear
group.
-/
instance [NeZero n] : Group (Matrix.GeneralLinearGroup (Fin n) ℝ) := by infer_instance

/--
# Example 1.1.12 (Special linear group)
Following the example above, let SL_n(ℝ) denote the set of n × n matrices whose
determinant is actually 1. Again, for linear algebra reasons it turns out that
(SL_n(ℝ), ×) is also a group, called the special linear group.
-/
instance [NeZero n] : Group (Matrix.SpecialLinearGroup (Fin n) ℝ) := by infer_instance

/--
# Example 1.1.13 (Symmetric groups)
Let S_n be the set of permutations of {1, ... , n}. By viewing these permutations as
functions from {1, ... , n} to itself, we can consider *compositions* of permutations.
Then the pair (S_n, ◦) (here ◦ is function composition) is also a group, because

- There is an identity permutation, and
- Each permutation has an inverse.

The group S_n is called the **symmetric group** on n elements.
-/
instance : Group (Equiv.Perm (Fin n)) := by infer_instance

/--
# Example 1.1.14 (Dihedral group)
The **dihedral group of order 2n**, denoted D_2n, is the group of symmetries of a
regular n-gon A_1, A_2, ... , A_n, which includes rotations and reflections. It consists of
the 2n elements

    {1, r, r^2, ..., r^{n-1}, s, sr, sr^2, ..., sr^{n-1} }.

The element r corresponds to rotating the n-gon by 2π/n, while s corresponds to
reflecting it across the line OA_1 (here O is the center of the polygon). So rs means
“reflect then rotate” (like with function composition, we read from right to left).
In particular, r^n = s^2 = 1. You can also see that r^k s = sr^−k.
-/
instance : Group (DihedralGroup n) := by infer_instance

/--
# Example 1.1.15 (Products of groups)
Let (G, ⋆) and (H, *) be groups. We can define a product group (G × H, ·), as
follows. The elements of the group will be ordered pairs (g, h) ∈ G × H. Then

    (g1, h1) · (g2, h2) = (g1 ⋆ g2, h1 * h2) ∈ G × H

is the group operation.
-/
instance [Group A] [Group B] : Group (A × B) := by infer_instance

/--
# Question 1.1.16. What are the identity and inverses of the product group?
-/
example
  {A B : Type} {a : A} {b : B}
  [Group A] [Group B] [Group (A × B)]
: (1 : (A × B)) = (1, 1) ∧ (a, b)⁻¹ = (a⁻¹, b⁻¹) := by aesop

/--
# Example 1.1.17 (Trivial group)
The trivial group, often denoted 0 or 1, is the group with only an identity element.
I will use the notation {1}.
-/
instance : CommGroup PUnit := by infer_instance

/--
# Exercise 1.1.18. Which of these are groups?

(a) Rational numbers with odd denominators (in simplest form), where the
operation is addition. (This includes integers, written as n/1, and 0 = 0/1).
-/
def RatOddDenom := { q : ℚ // ¬(2 ∣ q.den) }

instance : Add RatOddDenom where
  add a b := ⟨a.val + b.val, by exact rat_odd_denom_add a.property b.property⟩
instance : Zero RatOddDenom where
  zero := ⟨mkRat 0 1, by simp⟩
instance : Neg RatOddDenom where
  neg a := ⟨-a.val, by simp [a.property]⟩
instance : AddCommGroup RatOddDenom where
  add_assoc a b c := by apply Subtype.ext; exact Rat.add_assoc a.val b.val c.val
  zero_add a := by apply Subtype.ext; exact Rat.zero_add a.val
  add_zero a := by apply Subtype.ext; exact Rat.add_zero a.val
  nsmul := nsmulRec
  zsmul := zsmulRec
  neg_add_cancel a := by apply Subtype.ext; exact Rat.neg_add_cancel a.val
  add_comm a b := by apply Subtype.ext; exact Rat.add_comm a.val b.val

/--
(b) The set of rational numbers with denominator at most 2, where the operation is addition.
-/
def RatDenomLE2 := { q : ℚ // q.den ≤ 2 }

instance : Add RatDenomLE2 where
  add a b := ⟨a.val + b.val, by exact rat_denom_le2_add a.property b.property⟩
instance : Zero RatDenomLE2 where
  zero := ⟨mkRat 0 1, by simp⟩
instance : Neg RatDenomLE2 where
  neg a := ⟨-a.val, by simp [a.property]⟩
instance : AddCommGroup RatDenomLE2 where
  add_assoc a b c := by apply Subtype.ext; exact Rat.add_assoc a.val b.val c.val
  zero_add a := by apply Subtype.ext; exact Rat.zero_add a.val
  add_zero a := by apply Subtype.ext; exact Rat.add_zero a.val
  nsmul := nsmulRec
  zsmul := zsmulRec
  neg_add_cancel a := by apply Subtype.ext; exact Rat.neg_add_cancel a.val
  add_comm a b := by apply Subtype.ext; exact Rat.add_comm a.val b.val

/--
(c) The set of rational numbers with denominator at most 2, where the operation is multiplication.
-/
example [Group RatDenomLE2] : ¬(∀ {a b : RatDenomLE2}, (a * b).val = a.val * b.val) := by
  intro h
  have h0 := rat_denom_le2_mul
  push Not at h0
  obtain ⟨a, b, ha, hb, hab_not⟩ := h0
  let a : RatDenomLE2 := ⟨a, ha⟩
  let b : RatDenomLE2 := ⟨b, hb⟩
  have := (a * b).property
  have : (a * b).val.den = (a.val * b.val).den := by rw [h]
  linarith

/--
(d) The set of nonnegative integers, where the operation is addition.
-/
example [AddGroup ℕ] : ¬(∀ {a : ℕ}, a + (-a) = 0) := by
  intro h
  specialize h (a := 1)
  linarith

/--
# Proposition 1.2.4 (Inverse of products)
Let G be a group, and a, b ∈ G. Then (ab)^−1 = b^−1a^−1
-/
example [Group G] (a b : G) : (a * b)⁻¹ = b⁻¹ * a⁻¹ := by aesop

/--
# Lemma 1.2.5 (Left multiplication is a bijection)
Let G be a group, and pick a g ∈ G. Then the map G → G given by λx ↦ gx is a
bijection.

# Exercise 1.2.6.
Check this by showing injectivity and surjectivity directly. (If you don’t know
what these words mean, consult Appendix E.)
-/
example {G : Type} [Group G] (g : G) : Function.Bijective (λx ↦ g * x) where
  left a b := by aesop
  right y := by use g⁻¹ * y; aesop

/--
# Example 1.3.2 (Examples of isomorphisms)
Let G and H be groups. We have the following isomorphisms.
(a) ℤ ≅ 10ℤ, as above.
-/
def Tenℤ := { n : ℤ // 10 ∣ n }
instance : Add Tenℤ where
  add a b := ⟨a.val + b.val, dvd_add a.property b.property⟩
example : ℤ ≃+ Tenℤ where
  toFun n := ⟨10 * n, dvd_mul_right 10 n⟩
  invFun n10 := n10.val / 10
  left_inv n := by simp
  right_inv n10 := by obtain ⟨_, _, _⟩ := n10; aesop
  map_add' x y := by have := mul_add 10 x y; aesop

/--
(b) There is an isomorphism

    G × H ≅ H × G

by the map (g, h) ↦ (h, g).
-/
example
  {A B : Type} [Group A] [Group B] [Group (A × B)] [Group (B × A)]
: A × B ≃* B × A where
  toFun ab := (ab.2, ab.1)
  invFun ba := (ba.2, ba.1)
  left_inv ab := by simp
  right_inv ba := by simp
  map_mul' x y := by simp

/--
(c) The identity map id: G → G is an isomorphism, hence G ∼= G.
-/
example {G : Type} [Group G] : G ≃* G where
  toFun := id
  invFun := id
  left_inv g := by repeat rw [id]
  right_inv g := by repeat rw [id]
  map_mul' x y := by repeat rw [id]

/--
(d) There is another isomorphism of Z to itself: send every x to −x.
-/
example : ℤ ≃+ ℤ where
  toFun n := -n
  invFun n := -n
  left_inv n := by linarith
  right_inv n := by linarith
  map_add' x y := by linarith
