import Mathlib.Tactic.Ring
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.ZMod.Basic

import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

/-
# Series of obvious lemmas

These lemmas are all very obvious, so I won't care too much about the
readability of the proofs.
-/
private lemma if_dvd_nz_then_le
  {a b : ℕ}
  (h : a ∣ b)
  (hz : b ≠ 0)
: a ≤ b := by
  rcases h with ⟨k, h⟩
  rw [le_iff_exists_add]
  use a*(k - 1)
  cases k with
  | zero => contradiction
  | succ k =>
    simp
    linarith

private lemma prime_is_coprime_with_smaller_pnats
  {z p: ℕ}
  (hz: z < p)
  (hp: p.Prime)
: z.Coprime p ↔ z ≠ 0 where
  mp := by aesop
  mpr h := by
    have : ¬p ∣ z := by
      intro hx
      exact Nat.not_lt_of_ge (if_dvd_nz_then_le hx h) hz
    have := Nat.Prime.coprime_pow_of_not_dvd (m := 1) hp this
    aesop

private def fin_coprime_equiv_fin_nz
  {p : ℕ}
  [Fact p.Prime]
: { x : Fin p // x.val.Coprime p } ≃ { x : Fin p // x.val ≠ 0 } where
  toFun x := by
    have := prime_is_coprime_with_smaller_pnats (x.val.isLt) Fact.out
    exact ⟨x.val, by aesop⟩
  invFun x := by
    have := prime_is_coprime_with_smaller_pnats (x.val.isLt) Fact.out
    exact ⟨x.val, by aesop⟩
  left_inv x := by aesop
  right_inv x := by aesop

private def zmod_coprime_equiv_fin
  {p : ℕ}
  [NeZero p]
: { x : ZMod p // x.val.Coprime p } ≃ { x : Fin p // x.val.Coprime p } where
  toFun x := by
    have : p ≠ 0 := by aesop
    cases p with
    | zero => contradiction
    | succ => exact x
  invFun x := by
    have : p ≠ 0 := by aesop
    cases p with
    | zero => contradiction
    | succ => exact x
  left_inv x := by
    have : p ≠ 0 := by aesop
    cases p with
    | zero => contradiction
    | succ => aesop
  right_inv x := by
    have : p ≠ 0 := by aesop
    cases p with
    | zero => contradiction
    | succ => aesop

def zmod_coprime_equiv_fin_nz
  {p : ℕ}
  [NeZero p]
  [Fact p.Prime]
: { x : ZMod p // x.val.Coprime p } ≃ { x : Fin p // x.val ≠ 0 } := by
  exact Equiv.trans zmod_coprime_equiv_fin fin_coprime_equiv_fin_nz

private lemma div_gcd_dvd (a b : ℕ) : a / b.gcd a ∣ a := by
  use b.gcd a
  calc
    a = a - a % b.gcd a         := by simp [Nat.mod_eq_zero_of_dvd (Nat.gcd_dvd_right b a)]
    _ = a / b.gcd a * b.gcd a   := by simp [Nat.div_mul_self_eq_mod_sub_self]

private lemma two_dvd_trans_contrapose {a b : ℕ} (h0 : ¬(2 ∣ b)) (h1 : a ∣ b) : ¬(2 ∣ a) := by
  intro h2
  exact h0 (Nat.dvd_trans h2 h1)

theorem rat_odd_denom_add {a b : ℚ} (ha : ¬(2 ∣ a.den)) (hb : ¬(2 ∣ b.den)) : ¬(2 ∣ (a + b).den) := by
  have hx : ¬(2 ∣ (a.den * b.den)) := by
    simp_all [Nat.mul_mod]
  have hy : (a + b).den ∣ (a.den * b.den) := by
    simp_all [Rat.add_def, Rat.normalize, div_gcd_dvd (a.den * b.den) (a.num * ↑b.den + b.num * ↑a.den).natAbs]
  exact two_dvd_trans_contrapose hx hy

private lemma nz_le2_is_0or1 {a : ℕ} (hnz : a ≠ 0) (hle : a ≤ 2) : a = 1 ∨ a = 2 :=
  match a with | 1 | 2 => by decide

private lemma even_iff_abs_even {a : ℤ} : a % 2 = 0 ↔ a.natAbs % 2 = 0 where
  mp h := by
    rw [← Int.dvd_iff_emod_eq_zero, ← Int.dvd_natAbs, Int.dvd_natCast, Nat.dvd_iff_mod_eq_zero] at h
    exact h
  mpr h := by
    rw [← Int.dvd_iff_emod_eq_zero, ← Int.dvd_natAbs, Int.dvd_natCast, Nat.dvd_iff_mod_eq_zero]
    exact h

private lemma odd_iff_abs_odd {a : ℤ} : a % 2 = 1 ↔ a.natAbs % 2 = 1 where
  mp h := by
    contrapose! h
    simp_all
    rw [even_iff_abs_even]
    exact h
  mpr h := by
    contrapose! h
    simp_all
    rw [← even_iff_abs_even]
    exact h

private lemma odd_iff_coprime2 {a : ℕ} : a % 2 = 1 ↔ a.Coprime 2 where
  mp h := by
    rw [Nat.Coprime, Nat.gcd_comm, Nat.gcd_rec, h]
    decide
  mpr h := by
    rw [Nat.Coprime, Nat.gcd_comm, Nat.gcd_rec] at h
    have := Nat.mod_two_eq_zero_or_one a
    aesop

private lemma odd_mul2_mod4_eq2 {a : ℤ} (h : a % 2 = 1) : (a * 2) % 4 = 2 := by
  rw [Int.emod_eq_iff (by decide)] at h
  have ⟨_, _, h⟩ := h
  have h : 2 ∣ (a - 1) := by simp_all [← @Int.dvd_neg 2 (a - 1)]
  rcases h with ⟨k, h⟩
  have h : a - 1 = k * 2 := by simp_all [Int.mul_comm]
  rw [Eq.comm, eq_sub_iff_add_eq, Eq.comm] at h
  have h : a * 2 = k * 4 + 2 := by rw [h]; ring
  aesop

private lemma denom2rat_fact {a : ℚ} (h : a.den = 2) : (a.num * 2) % 4 = 2 := by
  have h := a.reduced
  have h : ¬(2 ∣ a.num.natAbs) := by have := @odd_iff_coprime2 a.num.natAbs; aesop
  have h : a.num % 2 = 1 := by simp_all [odd_iff_abs_odd]
  exact odd_mul2_mod4_eq2 h

private lemma rat_add
  {a b : ℚ}
: (a + b).den = a.den * b.den / (a.num * b.den + b.num * a.den).natAbs.gcd (a.den * b.den) := by
  simp [Rat.add_def, Rat.normalize]

-- TODO
private lemma rat1_add_rat2_den {a b : ℚ} (ha : a.den = 1) (hb : b.den = 2) : (a + b).den = 2 := by
  have := b.reduced
  have : b.num.gcd 2 = 1 := by simp_all only; exact this
  have : (a.num * 2 + b.num).gcd 2 = 1 := by aesop
  have : (a.num * 2 + b.num).natAbs.Coprime 2 := this
  rw [rat_add]
  simp_all only [dvd_mul_left, Int.gcd_add_left_left_of_dvd, one_mul, Nat.cast_ofNat, Nat.cast_one,
    mul_one, Nat.div_one]

theorem rat_denom_le2_add {a b : ℚ} (ha : a.den ≤ 2) (hb : b.den ≤ 2) : (a + b).den ≤ 2 := by
  have ha : a.den = 1 ∨ a.den = 2 := nz_le2_is_0or1 a.den_nz ha
  have hb : b.den = 1 ∨ b.den = 2 := nz_le2_is_0or1 b.den_nz hb

  rcases ha with (ha | ha) <;> rcases hb with (hb | hb)

  -- case (1, 1)
  have h : (a + b).den = 1 := by rw [rat_add]; aesop
  aesop

  -- case (1, 2)
  simp [rat1_add_rat2_den ha hb]

  -- case (2, 1)
  rw [add_comm]
  simp [rat1_add_rat2_den hb ha]

  -- case (2, 2)
  have h : (a.num * 2 + b.num * 2) % 4 = 0 := by
    rw [Int.add_emod, denom2rat_fact ha, denom2rat_fact hb]
    decide
  have h : 4 ∣ (a.num * 2 + b.num * 2) := Int.dvd_of_emod_eq_zero h
  have h : ↑((a.num * 2 + b.num * 2).gcd 4) = (4 : ℤ) := by
    simp_all [@Int.gcd_eq_right_iff_dvd 4 (a.num * 2 + b.num * 2) (by decide)]
  have h : (a.num * 2 + b.num * 2).gcd 4 = 4 := by
    rw [← (@Nat.cast_inj ℤ)]
    exact h
  have h : (a.num * 2 + b.num * 2).natAbs.gcd 4 = 4 := h
  have h : (a + b).den = 1 := by rw [rat_add]; aesop
  aesop

theorem rat_denom_le2_mul : ¬(∀ {a b : ℚ}, a.den ≤ 2 → b.den ≤ 2 → (a * b).den ≤ 2) := by
  intro h
  have ha : (mkRat 1 2 : ℚ).den ≤ 2 := by rfl
  have hb : (mkRat 1 2 : ℚ).den ≤ 2 := by rfl
  have h := h ha hb
  have h0 : (mkRat 1 4).den = 4 := by aesop
  aesop

theorem nat_div_add_of_dvd
  {a b c : Nat} (ha : c ∣ a) (hb : c ∣ b) (hc : 0 < c)
: (a + b) / c = a / c + b / c := by
  rw [Nat.add_div hc]
  nth_rewrite 2 [← Nat.add_zero (a / c + b / c)]
  rw [Nat.add_left_cancel_iff (n := a / c + b /c) (m := (if c ≤ a % c + b % c then 1 else 0)) (k := 0)]
  rw [Nat.dvd_iff_mod_eq_zero] at ha
  rw [Nat.dvd_iff_mod_eq_zero] at hb
  rw [ha, hb]
  simp
  intro h
  subst h
  contradiction
