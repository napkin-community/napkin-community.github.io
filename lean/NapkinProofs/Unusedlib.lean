import Aesop
import Mathlib.Data.Nat.Notation
import Mathlib.Data.Rat.Init
import Mathlib.Algebra.Group.Nat.Even
import Mathlib.Tactic.Lemma
import Mathlib.Analysis.InnerProductSpace.PiL2

import NapkinProofs.Obviouslib


/-
# Series of unused lemmas
-/
example {a : ℕ} : a < 2 ↔ a = 0 ∨ a = 1 :=
  have ltor (h : a < 2) : a = 0 ∨ a = 1 := match a with | 0 | 1 => by decide
  have rtol (h : a = 0 ∨ a = 1) : a < 2 := match a with | 0 | 1 => by decide
  ⟨ltor, rtol⟩

example {a : ℕ} : (2 ∣ a) ∨ ¬(2 ∣ a) := by
  cases (Nat.mod_two_eq_zero_or_one a) with
  | inl even => left; exact Nat.dvd_of_mod_eq_zero even
  | inr odd => aesop

example {a : ℕ} : (a % 2 = 0) ↔ 2 ∣ a :=
  have ltor : a % 2 = 0 → 2 ∣ a := by
    intro h
    apply Nat.dvd_of_mod_eq_zero
    exact h
  have rtol : 2 ∣ a → a % 2 = 0 := by
    intro h
    apply Nat.mod_eq_zero_of_dvd
    exact h
  ⟨ltor, rtol⟩

example {a : ℕ} : (a % 2 = 1) ↔ ¬(2 ∣ a) := by simp

example {a : ℚ} {n : ℤ} (h : a = n) : a.den = 1 ∧ a.num = n := by
  aesop

example {x y : ℝ} : ‖!₂[x, y]‖ ^ 2 = ‖!₂[x, 0]‖ ^ 2 + ‖!₂[0, y]‖ ^ 2 := by
  repeat rw [PiLp.norm_sq_eq_of_L2]
  aesop


/-
## Prove termination of Ackermann function
-/
private def ackermann (m n : ℕ) : ℕ :=
  match m, n with
  | 0, n => n + 1
  | m + 1, 0 => ackermann m 1
  | m + 1, n + 1 => ackermann m (ackermann (m + 1) n)

-- NOTE: Since for natural numbers 0 - 1 = 0, n - 1 < n is simply not true.
-- Therefore, if you define ackermann function as below, Lean cannot
-- automatically prove termination.
private partial def ackermann0 (m n : ℕ) : ℕ :=
  match m, n with
  | 0, n => n + 1
  | m, 0 => ackermann0 (m - 1) 1
  | m, n => ackermann0 (m - 1) (ackermann0 m (n - 1))


/-
## Triangular numbers

###### References
- https://en.wikipedia.org/wiki/Triangular_number
-/
private def tri (n : ℕ) : ℕ :=
  match n with
  | 0 => 0
  | n_minus_1 + 1 => tri n_minus_1 + (n_minus_1 + 1)

private def tri_fast (n : ℕ) : ℕ := (n * (n + 1)) / 2

#guard (Array.range 12).map tri = #[0, 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66]
#guard (Array.range 100).map tri = (Array.range 100).map tri_fast

private lemma tri_eq_tri_fast (n : ℕ) : tri n = tri_fast n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    calc
      tri (n + 1)
        = tri n + (n + 1)                       := by rw [tri]
      _ = tri_fast n + (n + 1)                  := by rw [ih]
      _ = (n * (n + 1)) / 2 + (n + 1)           := by rw [tri_fast]
      _ = (n * (n + 1)) / 2 + (n + 1) * 2 / 2   := by rw [Nat.mul_div_cancel (n + 1) (n:= 2) (by decide)]
      _ = (n * (n + 1) + (n + 1) * 2) / 2       := by rw [nat_div_add_of_dvd (Even.two_dvd (Nat.even_mul_succ_self n)) (Nat.dvd_mul_left 2 _) (by decide)]
      _ = ((n + 1) * (n + 2)) / 2               := by ring_nf
      _ = tri_fast (n + 1)                      := by rw [tri_fast]


/-
## Proof that `1` is not accessible w.r.t. `<` on the closed interval [0, 1]
-/
-- Closed interval [0, 1]
private abbrev I : Type := { x : ℝ // x ∈ Set.Icc (0 : ℝ) 1 }
-- Relation `<` on the closed interval [0, 1]
private def r (a b : I) : Prop := a.1 < b.1
-- The point `1` in the closed interval [0, 1]
private def oneI : I := ⟨1, by simp [Set.Icc]⟩
-- Descending chain `n ↦ 1 / 2^n` (always in [0, 1])
private noncomputable def chain (n : Nat) : I :=
  ⟨(1 : ℝ) / (2 : ℝ) ^ n, by
    refine ⟨by positivity, ?_⟩
    refine (div_le_one (pow_pos (by norm_num : (0 : ℝ) < 2) n)).2 ?_
    simpa using (one_le_pow₀ (by norm_num : (1 : ℝ) ≤ 2))⟩
-- Proof
private theorem one_not_accessible : ¬Acc r oneI := by
  refine (not_acc_iff_exists_descending_chain (r := r) (x := oneI)).2 ?_
  refine ⟨chain, ?_, ?_⟩
  · exact Subtype.ext (by simp [chain, oneI])
  ·
    intro n
    change (1 : ℝ) / (2 : ℝ) ^ (n + 1) < (1 : ℝ) / (2 : ℝ) ^ n
    have hpos : 0 < (2 : ℝ) ^ n := by positivity
    have hlt : (2 : ℝ) ^ n < (2 : ℝ) ^ (n + 1) := by
      rw [pow_succ]
      exact lt_mul_of_one_lt_right hpos (by norm_num : (1 : ℝ) < 2)
    simpa using (one_div_lt_one_div_of_lt hpos hlt)


/-
## Cantor pairing function
```
6
3 7
1 4 8
0 2 5 9
```

###### References
- https://en.wikipedia.org/wiki/Pairing_function#Cantor_pairing_function
-/
private def cantor_pair (xy : ℕ × ℕ) : ℕ :=
  match xy with
  | (0, 0) => 0
  | (0, y_minus_1 + 1) => cantor_pair (y_minus_1, 0) + 1 -- (y - 1, 0) 다음은 (0, y)
  | (x_minus_1 + 1, y) => cantor_pair (x_minus_1, y + 1) + 1 -- (x - 1, y + 1) 다음은 (x, y)
termination_by
  let (x, y) := xy
  let s := x + y
  2 * x + (s * (s + 1))
decreasing_by
  linarith
  linarith

#guard cantor_pair (2, 3) = 17
#guard cantor_pair (3, 2) = 18

private def cantor_unpair (z : ℕ) : ℕ × ℕ :=
  match z with
  | 0 => (0, 0)
  | z_minus_1 + 1 =>
    let (x, y) := cantor_unpair z_minus_1
    match y with
    | 0 => (0, x + 1) -- (x, 0) 다음은 (0, x+1), 아래 대각선으로 내려가 새 줄 시작
    | y_minus_1 + 1 => (x + 1, y_minus_1) -- (x, y) 다음은 (x + 1, y - 1), 같은 대각선에서 오른쪽 아래로 이동

#guard (Array.range 15).map cantor_unpair = #[
  (0, 0),
  (0, 1), (1, 0),
  (0, 2), (1, 1), (2, 0),
  (0, 3), (1, 2), (2, 1), (3, 0),
  (0, 4), (1, 3), (2, 2), (3, 1), (4, 0)
]

private lemma cantor_pair_unpair (z : ℕ) : cantor_pair (cantor_unpair z) = z := by
  induction z with
  | zero => simp [cantor_unpair, cantor_pair]
  | succ n ih =>
      rcases hxy : cantor_unpair n with ⟨x, y⟩
      cases y with
      | zero =>
          have ih' : cantor_pair (x, 0) = n := by simpa [hxy] using ih
          simp [cantor_unpair, cantor_pair, hxy, ih']
      | succ y =>
          have ih' : cantor_pair (x, y + 1) = n := by simpa [hxy] using ih
          simp [cantor_unpair, cantor_pair, hxy, ih']

private lemma cantor_unpair_pair (x y : ℕ) : cantor_unpair (cantor_pair (x, y)) = (x, y) := by
  generalize hpairxy : cantor_pair (x, y) = n
  revert x y
  induction n with
  | zero =>
      intro x y hpair
      cases x <;> cases y <;> simp [cantor_unpair, cantor_pair] at hpair ⊢
  | succ n ih =>
      intro x y hpair
      cases x with
      | zero =>
          cases y with
          | zero =>
              simp [cantor_pair] at hpair
          | succ y =>
              have hprev : cantor_pair (y, 0) = n := by
                exact Nat.succ.inj (by simpa [cantor_pair] using hpair)
              have ih' : cantor_unpair n = (y, 0) := ih y 0 hprev
              simp [cantor_unpair, ih']
      | succ x =>
          have hprev : cantor_pair (x, y + 1) = n := by
            exact Nat.succ.inj (by simpa [cantor_pair] using hpair)
          have ih' : cantor_unpair n = (x, y + 1) := ih x (y + 1) hprev
          simp [cantor_unpair, ih']

def cantor_pairing : ℕ × ℕ ≃ ℕ where
  toFun := cantor_pair
  invFun := cantor_unpair
  right_inv z := cantor_pair_unpair z
  left_inv xy := by
    obtain ⟨x, y⟩ := xy
    simpa using cantor_unpair_pair x y


/-
## Closed-form definition of Cantor pairing function
-/
private def cantor_fast_pair (xy : ℕ × ℕ) : ℕ :=
  let (x, y) := xy
  let s := x + y
  x + (s * (s + 1)) / 2

#guard cantor_fast_pair (2, 3) = 17
#guard cantor_fast_pair (3, 2) = 18

private def cantor_fast_unpair (z : ℕ) : ℕ × ℕ :=
  let w := Nat.floor ((Nat.sqrt (8 * z + 1) - 1) / 2)
  let x := z - (w * (w + 1)) / 2
  (x, w - x)

#guard (Array.range 15).map cantor_fast_unpair = #[
  (0, 0),
  (0, 1), (1, 0),
  (0, 2), (1, 1), (2, 0),
  (0, 3), (1, 2), (2, 1), (3, 0),
  (0, 4), (1, 3), (2, 2), (3, 1), (4, 0)
]

private lemma cantor_fast_pair_unpair (z : ℕ) : cantor_fast_pair (cantor_fast_unpair z) = z := by
  simp [cantor_fast_unpair, cantor_fast_pair]
  set s : ℕ := Nat.sqrt (8 * z + 1)
  set w : ℕ := (s - 1) / 2
  set x : ℕ := z - (w * (w + 1)) / 2

  have hs_pos : 0 < s := by
    have : 0 < 8 * z + 1 := Nat.succ_pos _
    simpa [s] using Nat.sqrt_pos.2 this

  have hw_mul_le : w * 2 ≤ s - 1 := by
    simpa [w] using Nat.div_mul_le_self (s - 1) 2

  have hw_lower : 2 * w + 1 ≤ s := by
    omega

  have hw_mul_lt : s - 1 < (w + 1) * 2 := by
    apply Nat.lt_mul_of_div_lt
    · simp [w]
    · decide

  have hw_upper : s + 1 ≤ 2 * w + 3 := by
    omega

  have hsqrt_le : s * s ≤ 8 * z + 1 := by
    simpa [s] using Nat.sqrt_le (8 * z + 1)

  have hsqrt_lt : 8 * z + 1 < (s + 1) * (s + 1) := by
    simpa [s] using Nat.lt_succ_sqrt (8 * z + 1)

  have hsq_low : (2 * w + 1) * (2 * w + 1) ≤ 8 * z + 1 := by
    exact le_trans (Nat.mul_le_mul hw_lower hw_lower) hsqrt_le

  have hsq_high : 8 * z + 1 < (2 * w + 3) * (2 * w + 3) := by
    exact lt_of_lt_of_le hsqrt_lt (Nat.mul_le_mul hw_upper hw_upper)

  have h4 : 4 * (w * (w + 1)) ≤ 8 * z := by
    have hsq_low' : 4 * (w * (w + 1)) + 1 ≤ 8 * z + 1 := by
      have hpoly : (2 * w + 1) * (2 * w + 1) = 4 * (w * (w + 1)) + 1 := by ring_nf
      simpa [hpoly] using hsq_low
    exact Nat.le_of_add_le_add_right hsq_low'

  have hmul : w * (w + 1) ≤ 2 * z := by
    omega

  have htri_le : (w * (w + 1)) / 2 ≤ z := by
    exact Nat.div_le_of_le_mul (by simpa [Nat.mul_comm] using hmul)

  have h4high : 8 * z < 4 * ((w + 1) * (w + 2)) := by
    have hsq_high' : 8 * z + 1 < 4 * ((w + 1) * (w + 2)) + 1 := by
      have hpoly : (2 * w + 3) * (2 * w + 3) = 4 * ((w + 1) * (w + 2)) + 1 := by ring_nf
      simpa [hpoly] using hsq_high
    exact Nat.lt_of_add_lt_add_right hsq_high'

  have htri_succ : z < ((w + 1) * (w + 2)) / 2 := by
    have hEven : 2 ∣ ((w + 1) * (w + 2)) := by
      exact Even.two_dvd (Nat.even_mul_succ_self (w + 1))
    have h8tri : 8 * (((w + 1) * (w + 2)) / 2) = 4 * ((w + 1) * (w + 2)) := by
      calc
        8 * (((w + 1) * (w + 2)) / 2)
            = 4 * (2 * (((w + 1) * (w + 2)) / 2)) := by ring_nf
        _ = 4 * ((w + 1) * (w + 2)) := by rw [Nat.mul_div_cancel' hEven]
    have h8 : 8 * z < 8 * (((w + 1) * (w + 2)) / 2) := by
      simpa [h8tri] using h4high
    exact (Nat.mul_lt_mul_left (by decide : 0 < 8)).1 h8

  have htri_succ' : z < (w * (w + 1)) / 2 + (w + 1) := by
    have htri_succ_eq : ((w + 1) * (w + 2)) / 2 = (w * (w + 1)) / 2 + (w + 1) := by
      calc
        ((w + 1) * (w + 2)) / 2
            = (w * (w + 1) + (w + 1) * 2) / 2 := by ring_nf
        _ = (w * (w + 1)) / 2 + ((w + 1) * 2) / 2 := by
          rw [nat_div_add_of_dvd (Even.two_dvd (Nat.even_mul_succ_self w))
            (Nat.dvd_mul_left 2 (w + 1)) (by decide)]
        _ = (w * (w + 1)) / 2 + (w + 1) := by
          rw [Nat.mul_div_cancel (w + 1) (n := 2) (by decide)]
    simpa [htri_succ_eq] using htri_succ

  have hz_le : z ≤ (w * (w + 1)) / 2 + w := by
    omega

  have hx_le_w : x ≤ w := by
    dsimp [x]
    omega

  have hx_add : x + (w - x) = w := Nat.add_sub_of_le hx_le_w
  have hx_cancel : x + (w * (w + 1)) / 2 = z := Nat.sub_add_cancel htri_le

  calc
    x + ((x + (w - x)) * (x + (w - x) + 1)) / 2
        = x + (w * (w + 1)) / 2 := by simp [hx_add]
    _ = z := hx_cancel


/-
## Prove equivalence of two definitions of Cantor pairing function
-/
#guard cantor_fast_pair (2, 3) = cantor_pair (2, 3)
#guard cantor_fast_pair (20, 30) = cantor_pair (20, 30)

#guard (Array.range 100).map cantor_unpair = (Array.range 100).map cantor_fast_unpair
#guard ((Array.range 100).map cantor_unpair).map cantor_pair = Array.range 100

private lemma cantor_pair_eq_cantor_fast_pair (xy : ℕ × ℕ) : cantor_pair xy = cantor_fast_pair xy := by
  obtain ⟨x, y⟩ := xy
  generalize h : x + y = s
  revert x y

  -- Outer induction on s := x + y (generalized over x, y)
  induction s with
  | zero => simp [cantor_pair, cantor_fast_pair]
  | succ n ih =>
    intro x

    -- Inner induction on x
    induction x with
    | zero =>
      simp
      calc
        cantor_pair (0, n + 1)
          = cantor_pair (n, 0) + 1                    := by simp [cantor_pair]
        _ = cantor_fast_pair (n, 0) + 1               := by rw [ih _ _ (Nat.add_zero _)]
        _ = (n + (n * (n + 1)) / 2) + 1               := by rw [cantor_fast_pair]; ac_rfl
        _ = n + 1 + n * (n + 1) / 2                   := by ac_rfl
        _ = (n + 1) * 2 / 2 + n * (n + 1) / 2         := by rw [Nat.mul_div_cancel _ (n := 2) (by decide)]
        _ = ((n + 1) * 2 + n * (n + 1)) / 2           := by rw [← nat_div_add_of_dvd (c := 2) (Nat.dvd_mul_left 2 _) (Even.two_dvd (Nat.even_mul_succ_self n)) (by decide)]
        _ = ((n + 1) * (n + 2)) / 2                   := by ring_nf
        _ = 0 + (0 + (n + 1)) * (0 + (n + 1) + 1) / 2 := by ac_rfl
        _ = cantor_fast_pair (0, n + 1)               := by rw [cantor_fast_pair]
    | succ m ihx =>
      intro y hsum
      rw [Nat.add_right_comm] at hsum
      calc
        cantor_pair (m + 1, y)
          = cantor_pair (m, y + 1) + 1                  := by simp [cantor_pair]
        _ = cantor_fast_pair (m, y + 1) + 1             := by rw [ihx (y + 1) hsum]
        _ = cantor_fast_pair (m + 1, y)                 := by rw [cantor_fast_pair, cantor_fast_pair]; ac_rfl

private lemma cantor_unpair_eq_cantor_fast_unpair (z : ℕ) : cantor_unpair z = cantor_fast_unpair z := by
  apply cantor_pairing.injective
  simp [cantor_pairing]
  rw [cantor_pair_unpair, cantor_pair_eq_cantor_fast_pair, cantor_fast_pair_unpair]

def cantor_fast_pairing : ℕ × ℕ ≃ ℕ where
  toFun := cantor_fast_pair
  invFun := cantor_fast_unpair
  right_inv z := cantor_fast_pair_unpair z
  left_inv _ := by
    rw [← cantor_unpair_eq_cantor_fast_unpair, ← cantor_pair_eq_cantor_fast_pair, cantor_unpair_pair]


/-
## Binary trees are bijective to ℕ
-/
inductive BinaryTree where
  | nil
  | node (left right: BinaryTree)

def treeToNat : BinaryTree → ℕ
  | .nil => 0
  | .node left right =>
    let x := treeToNat left
    let y := treeToNat right
    let s := x + y
    x + (s * (s + 1)) / 2 + 1

private lemma unpair_lt_succ (n : ℕ) : (cantor_fast_unpair n).1 + (cantor_fast_unpair n).2 < n + 1 := by
  have nat_le_tri_fast (n : ℕ) : n ≤ tri_fast n := by
    rw [← tri_eq_tri_fast]
    induction n with
    | zero => simp [tri]
    | succ n _ =>
        calc
          n + 1 ≤ tri n + (n + 1) := Nat.le_add_left _ _
          _ = tri (n + 1) := by rw [tri]

  apply Nat.lt_succ_of_le
  nth_rewrite 3 [← cantor_fast_pair_unpair n]
  obtain ⟨x, y⟩ := cantor_fast_unpair n
  calc
    x + y ≤ tri_fast (x + y) := nat_le_tri_fast (x + y)
    _ ≤ x + tri_fast (x + y) := Nat.le_add_left _ _
    _ = cantor_fast_pair (x, y) := by simp [cantor_fast_pair, tri_fast]

private def natToTree (n : ℕ) : BinaryTree :=
  match n with
  | 0 => .nil
  | n + 1 =>
    let xy := cantor_fast_unpair n
    .node (natToTree xy.1) (natToTree xy.2)
termination_by n
decreasing_by
  .
    have := unpair_lt_succ n
    linarith
  .
    have := unpair_lt_succ n
    linarith

example : BinaryTree ≃ ℕ where
  toFun := treeToNat
  invFun := natToTree
  left_inv t := by
    induction t with
    | nil =>
        rw [treeToNat, natToTree.eq_1]
    | node left right ihLeft ihRight =>
        have hxy :
            cantor_fast_unpair (cantor_fast_pair (treeToNat left, treeToNat right)) =
              (treeToNat left, treeToNat right) := by
          simpa [cantor_fast_pairing] using
            (cantor_fast_pairing.left_inv (treeToNat left, treeToNat right))
        calc
          natToTree (treeToNat (.node left right))
              = natToTree (cantor_fast_pair (treeToNat left, treeToNat right) + 1) := by
                  simp [treeToNat, cantor_fast_pair]
          _ = .node (natToTree (treeToNat left)) (natToTree (treeToNat right)) := by
                rw [natToTree.eq_2]
                simp [hxy]
          _ = .node left right := by simp [ihLeft, ihRight]

  right_inv n := by
    induction n using Nat.strong_induction_on with
    | h n ih =>
        cases n with
        | zero =>
            rw [natToTree.eq_1]
            rfl
        | succ n =>
            rcases hxy : cantor_fast_unpair n with ⟨x, y⟩
            have : x + y < n + 1 := by simpa [hxy] using unpair_lt_succ n
            have hx : x < n + 1 := by linarith
            have hy : y < n + 1 := by linarith
            have ihx : treeToNat (natToTree x) = x := ih x hx
            have ihy : treeToNat (natToTree y) = y := ih y hy
            have hsucc : natToTree (n + 1) = .node (natToTree x) (natToTree y) := by
              rw [natToTree.eq_2]
              simp [hxy]
            have hpair : cantor_fast_pair (x, y) = n := by
              simpa [hxy] using cantor_fast_pair_unpair n
            calc
              treeToNat (natToTree (n + 1))
                  = treeToNat (.node (natToTree x) (natToTree y)) := by rw [hsucc]
              _ = cantor_fast_pair (treeToNat (natToTree x), treeToNat (natToTree y)) + 1 := by
                    simp [treeToNat, cantor_fast_pair]
              _ = cantor_fast_pair (x, y) + 1 := by simp [ihx, ihy]
              _ = n + 1 := by simp [hpair]
