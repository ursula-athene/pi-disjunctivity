/-
Copyright (c) 2026 Ursula Athene. All rights reserved.
SPDX-License-Identifier: MIT
Authors: Ursula Athene
-/
module

public import PiDisjunctivity.BBP.Tail
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Tactic

/-! Finite asymptotic expansions of the actual BBP tail,
with integer coefficients and signed bounds. -/
public section
namespace PiDisjunctivity.BBPAsymptotics

theorem bbpCoeff_eq_posFractions (n : ℕ) :
    bbpCoeff n = 6 / ((8 * (n : ℝ) + 1) * (8 * n + 4)) +
      4 / ((8 * (n : ℝ) + 1) * (8 * n + 5)) +
      5 / ((8 * (n : ℝ) + 1) * (8 * n + 6)) := by
  have h1 : (8 * (n : ℝ) + 1) ≠ 0 := by positivity
  have h4 : (8 * (n : ℝ) + 4) ≠ 0 := by positivity
  have h5 : (8 * (n : ℝ) + 5) ≠ 0 := by positivity
  have h6 : (8 * (n : ℝ) + 6) ≠ 0 := by positivity
  unfold bbpCoeff
  field_simp
  ring

theorem bbpCoeff_pos (n : ℕ) : 0 < bbpCoeff n := by
  rw [bbpCoeff_eq_posFractions]
  positivity

theorem bbpCoeff_le_quadratic (n : ℕ) :
    bbpCoeff n ≤ 15 / (8 * (n : ℝ) + 1) ^ 2 := by
  have hd : 0 < 8 * (n : ℝ) + 1 := by positivity
  have hb (c a : ℝ) (hc : 0 ≤ c) (ha : 1 ≤ a) :
      c / ((8 * (n : ℝ) + 1) * (8 * n + a)) ≤ c / (8 * (n : ℝ) + 1) ^ 2 := by
    apply div_le_div_of_nonneg_left hc (by positivity)
    rw [pow_two]
    exact mul_le_mul_of_nonneg_left (by linarith) hd.le
  rw [bbpCoeff_eq_posFractions]
  calc
    _ ≤ 6 / (8 * (n : ℝ) + 1) ^ 2 + 4 / (8 * (n : ℝ) + 1) ^ 2 +
        5 / (8 * (n : ℝ) + 1) ^ 2 := by
      exact add_le_add (add_le_add (hb 6 4 (by norm_num) (by norm_num))
        (hb 4 5 (by norm_num) (by norm_num))) (hb 5 6 (by norm_num) (by norm_num))
    _ = _ := by ring

theorem bbpTail_pos (n : ℕ) : 0 < bbpTail n := by
  rw [bbpTail]
  exact (hasSum_bbpTail n).summable.tsum_pos
    (fun r => (div_pos (bbpCoeff_pos _) (by positivity)).le) 0
    (div_pos (bbpCoeff_pos _) (by positivity))

theorem bbpTail_le_quadratic (n : ℕ) :
    bbpTail n ≤ 1 / (8 * (n : ℝ) + 9) ^ 2 := by
  have hg : HasSum
      (fun r : ℕ => (15 / (8 * (n : ℝ) + 9) ^ 2) / (16 : ℝ) ^ (r + 1))
      (1 / (8 * (n : ℝ) + 9) ^ 2) := by
    have h := (hasSum_geometric_of_lt_one (by norm_num : 0 ≤ (1 / 16 : ℝ))
      (by norm_num : (1 / 16 : ℝ) < 1)).mul_left ((15 / (8 * (n : ℝ) + 9) ^ 2) / 16)
    convert h using 1
    · funext r
      simp only [div_pow, one_pow, pow_succ]
      ring
    · ring
  rw [← (hasSum_bbpTail n).tsum_eq, ← hg.tsum_eq]
  apply (hasSum_bbpTail n).summable.tsum_le_tsum _ hg.summable
  intro r
  apply div_le_div_of_nonneg_right _ (by positivity)
  apply (bbpCoeff_le_quadratic _).trans
  apply div_le_div_of_nonneg_left (by norm_num) (by positivity)
  apply pow_le_pow_left₀ (by positivity)
  push_cast
  linarith only [Nat.cast_nonneg (α := ℝ) r]

theorem bbpTail_le_mass_bound (n : ℕ) (hn : 0 < n) :
    bbpTail n ≤ 1 / (64 * (n : ℝ) ^ 2) := by
  apply (bbpTail_le_quadratic n).trans
  apply div_le_div_of_nonneg_left (by norm_num) (by positivity)
  nlinarith [Nat.cast_nonneg (α := ℝ) n]

private theorem integral_inv_sq_shift (a b : ℝ) (ha : 0 ≤ a) (hb : 1 ≤ b) :
    (∫ t in (1 : ℝ)..b, 1 / (a + t) ^ 2) = 1 / (a + 1) - 1 / (a + b) := by
  have hne (x : ℝ) (hx : x ∈ Set.uIcc 1 b) : a + x ≠ 0 := by
    rw [Set.uIcc_of_le hb] at hx
    linarith [hx.1]
  have hi : IntervalIntegrable (fun x : ℝ => 1 / (a + x) ^ 2)
      MeasureTheory.volume 1 b := by
    apply ContinuousOn.intervalIntegrable
    exact continuousOn_const.div ((continuous_const.add continuous_id).pow 2).continuousOn
      (fun x hx => pow_ne_zero _ (hne x hx))
  have hd (x : ℝ) (hx : x ∈ Set.uIcc 1 b) :
      HasDerivAt (fun t : ℝ => -(a + t)⁻¹) (1 / (a + x) ^ 2) x := by
    convert (((hasDerivAt_id x).const_add a).inv (hne x hx)).neg using 1
    · rfl
    · dsimp only [id_eq]
      ring
  simpa only [one_div, neg_sub_neg] using
    intervalIntegral.integral_eq_sub_of_hasDerivAt hd hi

theorem bbpCoeff_eq_stieltjes (n : ℕ) :
    bbpCoeff n =
      2 * (∫ t in (1 : ℝ)..4, 1 / (8 * (n : ℝ) + t) ^ 2) +
      (∫ t in (1 : ℝ)..5, 1 / (8 * (n : ℝ) + t) ^ 2) +
      (∫ t in (1 : ℝ)..6, 1 / (8 * (n : ℝ) + t) ^ 2) := by
  rw [integral_inv_sq_shift _ 4 (by positivity) (by norm_num),
    integral_inv_sq_shift _ 5 (by positivity) (by norm_num),
    integral_inv_sq_shift _ 6 (by positivity) (by norm_num)]
  unfold bbpCoeff
  ring

/-- The three positive interval contributions to the actual BBP tail. -/
@[expose] noncomputable def stieltjesTerm (f : ℝ → ℝ) (r : ℕ) : ℝ :=
  (2 * (∫ t in (1 : ℝ)..4, f ((r : ℝ) + 1 + t / 8)) +
    (∫ t in (1 : ℝ)..5, f ((r : ℝ) + 1 + t / 8)) +
    (∫ t in (1 : ℝ)..6, f ((r : ℝ) + 1 + t / 8))) /
      (64 * (16 : ℝ) ^ (r + 1))

theorem hasSum_bbpTail_stieltjes (N : ℕ) :
    HasSum (stieltjesTerm (fun u => 1 / ((N : ℝ) + u) ^ 2)) (bbpTail N) := by
  convert hasSum_bbpTail N using 1
  funext r
  rw [bbpCoeff_eq_stieltjes]
  have heq (t : ℝ) :
      1 / (8 * ((N + r + 1 : ℕ) : ℝ) + t) ^ 2 =
        (1 / 64) * (1 / ((N : ℝ) + ((r : ℝ) + 1 + t / 8)) ^ 2) := by
    have hlin : 8 * ((N + r + 1 : ℕ) : ℝ) + t =
        8 * ((N : ℝ) + ((r : ℝ) + 1 + t / 8)) := by push_cast; ring
    rw [hlin, mul_pow]
    norm_num [mul_inv_rev, one_div]
    ring
  simp_rw [heq, intervalIntegral.integral_const_mul]
  unfold stieltjesTerm
  ring

theorem finite_inv_sq_remainder (K : ℕ) (x : ℝ) (hx : 0 ≤ x) :
    1 / (1 + x) ^ 2 -
      ∑ k ∈ Finset.range K, (-1 : ℝ) ^ k * ((k : ℝ) + 1) * x ^ k =
    (-1 : ℝ) ^ K * x ^ K * (((K : ℝ) + 1) + (K : ℝ) * x) / (1 + x) ^ 2 := by
  have hne : (1 + x) ≠ 0 := by linarith
  induction K with
  | zero => simp
  | succ K ih =>
    rw [Finset.sum_range_succ]
    calc
      _ = (1 / (1 + x) ^ 2 -
          ∑ k ∈ Finset.range K, (-1 : ℝ) ^ k * ((k : ℝ) + 1) * x ^ k) -
          (-1 : ℝ) ^ K * ((K : ℝ) + 1) * x ^ K := by ring
      _ = _ := by
        rw [ih]
        push_cast
        simp only [pow_succ]
        field_simp
        ring

private theorem remainder_factor_le (K : ℕ) (x : ℝ) (hx : 0 ≤ x) :
    (((K : ℝ) + 1) + (K : ℝ) * x) / (1 + x) ^ 2 ≤ (K : ℝ) + 1 := by
  apply (div_le_iff₀ (by positivity : 0 < (1 + x) ^ 2)).2
  nlinarith [sq_nonneg x, Nat.cast_nonneg (α := ℝ) K,
    mul_nonneg (Nat.cast_nonneg (α := ℝ) K) (sq_nonneg x),
    mul_nonneg (Nat.cast_nonneg (α := ℝ) K) hx]

/-- The integer-shift numerator determined by the four BBP coefficients. -/
@[expose] def bbpMomentNumerator (f : ℕ → ℝ) (n : ℕ) : ℝ :=
  4 * f (n + 9) - 2 * f (n + 12) - f (n + 13) - f (n + 14)

private theorem bbpMomentNumerator_convolution (f : ℕ → ℝ) (n : ℕ) :
    4 * bbpMomentNumerator f n - 4 * bbpMomentNumerator f (n + 1) +
      2 * bbpMomentNumerator f (n + 3) - bbpMomentNumerator f (n + 4) =
    16 * (f (n + 9) - f (n + 10)) - (f (n + 17) - f (n + 18)) := by
  simp only [bbpMomentNumerator, Nat.add_assoc]
  norm_num
  ring

private theorem summable_shifted_power_geometric (k : ℕ) (a : ℝ) (ha : 8 ≤ a) :
    Summable (fun r : ℕ => (8 * (r : ℝ) + a) ^ k / (16 : ℝ) ^ (r + 1)) := by
  have hgeom : Summable (fun r : ℕ => (r : ℝ) ^ k * (1 / 16 : ℝ) ^ r) :=
    summable_pow_mul_geometric_of_norm_lt_one k (by norm_num)
  have hs : Summable (fun r : ℕ => ((r : ℝ) + 1) ^ k / (16 : ℝ) ^ (r + 1)) := by
    simpa only [Nat.cast_add, Nat.cast_one, div_pow, one_pow,
      div_eq_mul_inv, one_mul, inv_pow] using
      (summable_nat_add_iff 1).mpr hgeom
  apply (hs.mul_left (a ^ k)).of_norm_bounded
  intro r
  rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
  calc
    (8 * (r : ℝ) + a) ^ k / (16 : ℝ) ^ (r + 1) ≤
        (a * ((r : ℝ) + 1)) ^ k / (16 : ℝ) ^ (r + 1) := by
      apply div_le_div_of_nonneg_right _ (by positivity)
      apply pow_le_pow_left₀ (by positivity)
      nlinarith [Nat.cast_nonneg (α := ℝ) r]
    _ = a ^ k * (((r : ℝ) + 1) ^ k / (16 : ℝ) ^ (r + 1)) := by
      rw [mul_pow]
      ring

/-- A geometric term of an actual numerator moment. -/
@[expose] noncomputable def numeratorTerm (k a r : ℕ) : ℝ :=
  bbpMomentNumerator (fun n => (n : ℝ) ^ k) (8 * r + a) / (16 : ℝ) ^ (r + 1)
/-- The convergent geometric numerator moment at an integer shift. -/
@[expose] noncomputable def numeratorMomentShift (k a : ℕ) : ℝ := ∑' r : ℕ, numeratorTerm k a r

private theorem summable_numeratorTerm (k a : ℕ) : Summable (numeratorTerm k a) := by
  have h9 := summable_shifted_power_geometric k ((a : ℝ) + 9)
    (by linarith [Nat.cast_nonneg (α := ℝ) a])
  have h12 := summable_shifted_power_geometric k ((a : ℝ) + 12)
    (by linarith [Nat.cast_nonneg (α := ℝ) a])
  have h13 := summable_shifted_power_geometric k ((a : ℝ) + 13)
    (by linarith [Nat.cast_nonneg (α := ℝ) a])
  have h14 := summable_shifted_power_geometric k ((a : ℝ) + 14)
    (by linarith [Nat.cast_nonneg (α := ℝ) a])
  convert (((h9.mul_left 4).sub (h12.mul_left 2)).sub h13).sub h14 using 1
  funext r
  simp only [numeratorTerm, bbpMomentNumerator, Nat.cast_add, Nat.cast_mul, Nat.cast_ofNat]
  ring

private theorem actual_moment_convolution (k : ℕ) :
    4 * numeratorMomentShift k 0 - 4 * numeratorMomentShift k 1 +
      2 * numeratorMomentShift k 3 - numeratorMomentShift k 4 = (9 : ℝ) ^ k - (10 : ℝ) ^ k := by
  let g : ℕ → ℝ := fun r => ((8 * (r : ℝ) + 9) ^ k - (8 * (r : ℝ) + 10) ^ k) / (16 : ℝ) ^ r
  have hg : Summable g := by
    have h9 := summable_shifted_power_geometric k 9 (by norm_num)
    have h10 := summable_shifted_power_geometric k 10 (by norm_num)
    convert (h9.sub h10).mul_left 16 using 1
    funext r
    dsimp [g]
    rw [pow_succ]
    ring
  have hshift : HasSum (fun r => g (r + 1)) ((∑' r, g r) - g 0) := by
    simpa using (hasSum_nat_add_iff' 1).mpr hg.hasSum
  have htel : HasSum (fun r => g r - g (r + 1)) (g 0) := by
    convert hg.hasSum.sub hshift using 1
    ring
  have hc := (((((summable_numeratorTerm k 0).hasSum).mul_left 4).sub
    (((summable_numeratorTerm k 1).hasSum).mul_left 4)).add
    (((summable_numeratorTerm k 3).hasSum).mul_left 2)).sub
    ((summable_numeratorTerm k 4).hasSum)
  have heq : (fun r => 4 * numeratorTerm k 0 r - 4 * numeratorTerm k 1 r +
      2 * numeratorTerm k 3 r - numeratorTerm k 4 r) = (fun r => g r - g (r + 1)) := by
    funext r
    have hh := bbpMomentNumerator_convolution (fun n => (n : ℝ) ^ k) (8 * r)
    simp only [Nat.cast_add, Nat.cast_mul, Nat.cast_ofNat] at hh
    dsimp only [numeratorTerm]
    rw [Nat.add_zero]
    calc
      _ = (4 * bbpMomentNumerator (fun n => (n : ℝ) ^ k) (8 * r) -
          4 * bbpMomentNumerator (fun n => (n : ℝ) ^ k) (8 * r + 1) +
          2 * bbpMomentNumerator (fun n => (n : ℝ) ^ k) (8 * r + 3) -
          bbpMomentNumerator (fun n => (n : ℝ) ^ k) (8 * r + 4)) / (16 : ℝ) ^ (r + 1) := by ring
      _ = _ := by
        rw [hh]
        dsimp only [g]
        simp only [Nat.cast_add, Nat.cast_one]
        have h17 : 8 * ((r : ℝ) + 1) + 9 = 8 * (r : ℝ) + 17 := by ring
        have h18 : 8 * ((r : ℝ) + 1) + 10 = 8 * (r : ℝ) + 18 := by ring
        rw [h17, h18, pow_succ]
        ring
  rw [heq] at hc
  have hh := hc.unique htel
  simpa only [numeratorMomentShift, g, Nat.cast_zero, mul_zero,
    zero_add, pow_zero, div_one] using hh

private theorem numeratorTerm_shift (k a r : ℕ) :
    numeratorTerm k a r = ∑ i ∈ Finset.range (k + 1),
      (Nat.choose k i : ℝ) * (a : ℝ) ^ (k - i) * numeratorTerm i 0 r := by
  simp only [numeratorTerm, bbpMomentNumerator, Nat.add_zero, Nat.cast_add,
    Nat.cast_mul, Nat.cast_ofNat]
  have hp (c : ℝ) : (8 * (r : ℝ) + (a : ℝ) + c) ^ k =
      ∑ i ∈ Finset.range (k + 1),
        (8 * (r : ℝ) + c) ^ i * (a : ℝ) ^ (k - i) * (Nat.choose k i : ℝ) := by
    rw [show 8 * (r : ℝ) + (a : ℝ) + c = (8 * (r : ℝ) + c) + (a : ℝ) by ring, add_pow]
  rw [hp 9, hp 12, hp 13, hp 14]
  simp only [mul_sub, sub_div, mul_div_assoc, Finset.sum_sub_distrib,
    Finset.mul_sum, Finset.sum_div]
  congr 3 <;> first
    | (apply Finset.sum_congr rfl; intro i hi; ring)
    | (funext i; ring)

private theorem numeratorMomentShift_binomial (k a : ℕ) :
    numeratorMomentShift k a = ∑ i ∈ Finset.range (k + 1),
      (Nat.choose k i : ℝ) * (a : ℝ) ^ (k - i) * numeratorMomentShift i 0 := by
  have h := hasSum_sum (s := Finset.range (k + 1)) (fun i _ =>
    ((summable_numeratorTerm i 0).hasSum).mul_left
      ((Nat.choose k i : ℝ) * (a : ℝ) ^ (k - i)))
  simp only [← numeratorTerm_shift] at h
  exact (summable_numeratorTerm k a).hasSum.unique h

/-- Integer coefficients of the finite numerator-moment recurrence. -/
@[expose] def denomMoment (k : ℕ) : ℤ := 4 * (0 : ℤ) ^ k - 4 + 2 * (3 : ℤ) ^ k - (4 : ℤ) ^ k

theorem numeratorMoment_recurrence (k : ℕ) :
    numeratorMomentShift k 0 + ∑ i ∈ Finset.range k,
      (Nat.choose k i : ℝ) * (denomMoment (k - i) : ℝ) * numeratorMomentShift i 0 =
    (9 : ℝ) ^ k - (10 : ℝ) ^ k := by
  have h := actual_moment_convolution k
  rw [numeratorMomentShift_binomial k 0, numeratorMomentShift_binomial k 1,
    numeratorMomentShift_binomial k 3, numeratorMomentShift_binomial k 4] at h
  have he : (∑ i ∈ Finset.range (k + 1), (Nat.choose k i : ℝ) *
      (denomMoment (k - i) : ℝ) * numeratorMomentShift i 0) =
    4 * (∑ i ∈ Finset.range (k + 1),
      (Nat.choose k i : ℝ) * (0 : ℝ) ^ (k - i) * numeratorMomentShift i 0) -
    4 * (∑ i ∈ Finset.range (k + 1),
      (Nat.choose k i : ℝ) * (1 : ℝ) ^ (k - i) * numeratorMomentShift i 0) +
    2 * (∑ i ∈ Finset.range (k + 1),
      (Nat.choose k i : ℝ) * (3 : ℝ) ^ (k - i) * numeratorMomentShift i 0) -
    (∑ i ∈ Finset.range (k + 1),
      (Nat.choose k i : ℝ) * (4 : ℝ) ^ (k - i) * numeratorMomentShift i 0) := by
    simp only [Finset.mul_sum, ← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro i hi
    simp only [denomMoment, Int.cast_sub, Int.cast_add, Int.cast_mul,
      Int.cast_pow, Int.cast_ofNat, Int.cast_zero, one_pow]
    ring
  norm_num only [Nat.cast_zero, Nat.cast_one, Nat.cast_ofNat] at h
  have hall := he.trans h
  rw [Finset.sum_range_succ] at hall
  have hd0 : denomMoment 0 = 1 := by norm_num [denomMoment]
  simp only [Nat.sub_self, Nat.choose_self, hd0, Nat.cast_one, Int.cast_one, one_mul] at hall
  linarith

theorem numeratorMoment_integer (k : ℕ) : ∃ z : ℤ, numeratorMomentShift k 0 = (z : ℝ) := by
  induction k using Nat.strong_induction_on with
  | ind k ih =>
    choose z hz using ih
    let zi (i : ℕ) : ℤ := if hi : i < k then z i hi else 0
    have ht : (∑ i ∈ Finset.range k, (Nat.choose k i : ℝ) *
        (denomMoment (k - i) : ℝ) * numeratorMomentShift i 0) =
        ((∑ i ∈ Finset.range k, (Nat.choose k i : ℤ) * denomMoment (k - i) * zi i : ℤ) : ℝ) := by
      push_cast
      apply Finset.sum_congr rfl
      intro i hi
      have hik := Finset.mem_range.mp hi
      rw [hz i hik]
      simp only [zi, dite_eq_left hik]
    refine ⟨(9 : ℤ) ^ k - (10 : ℤ) ^ k -
      ∑ i ∈ Finset.range k, (Nat.choose k i : ℤ) * denomMoment (k - i) * zi i, ?_⟩
    have hh := numeratorMoment_recurrence k
    rw [ht] at hh
    push_cast at hh ⊢
    linarith

private theorem integral_shift_power (k r : ℕ) (b : ℝ) :
    (∫ t in (1 : ℝ)..b, ((r : ℝ) + 1 + t / 8) ^ k) =
      8 * (((r : ℝ) + 1 + b / 8) ^ (k + 1) -
        ((r : ℝ) + 1 + 1 / 8) ^ (k + 1)) / ((k : ℝ) + 1) := by
  rw [intervalIntegral.integral_comp_add_div (fun x : ℝ => x ^ k)
    (by norm_num : (8 : ℝ) ≠ 0), integral_pow]
  simp only [smul_eq_mul]
  ring

private theorem stieltjesTerm_monomial (k r : ℕ) :
    stieltjesTerm (fun u => u ^ k) r =
      -numeratorTerm (k + 1) 0 r / (((k : ℝ) + 1) * (8 : ℝ) ^ (k + 2)) := by
  unfold stieltjesTerm
  rw [integral_shift_power, integral_shift_power, integral_shift_power]
  have hp (c : ℝ) : ((r : ℝ) + 1 + c / 8) ^ (k + 1) =
      (8 * (r : ℝ) + 8 + c) ^ (k + 1) / (8 : ℝ) ^ (k + 1) := by
    rw [show (r : ℝ) + 1 + c / 8 = (8 * (r : ℝ) + 8 + c) / 8 by ring, div_pow]
  rw [hp 4, hp 1, hp 5, hp 6]
  simp only [numeratorTerm, bbpMomentNumerator, Nat.add_zero, Nat.cast_add,
    Nat.cast_mul, Nat.cast_ofNat]
  have hk : (k : ℝ) + 1 ≠ 0 := by positivity
  rw [show k + 2 = (k + 1) + 1 by omega, pow_succ]
  field_simp
  ring

/-- The kth moment of the actual positive tail representation. -/
@[expose] noncomputable def moment (k : ℕ) : ℝ := ∑' r : ℕ, stieltjesTerm (fun u => u ^ k) r
/-- The kth coefficient in the finite inverse-power tail expansion. -/
@[expose] noncomputable def coefficient (k : ℕ) : ℝ := (-1 : ℝ) ^ k * ((k : ℝ) + 1) * moment k

theorem hasSum_moment (k : ℕ) :
    HasSum (stieltjesTerm (fun u => u ^ k))
      (-numeratorMomentShift (k + 1) 0 / (((k : ℝ) + 1) * (8 : ℝ) ^ (k + 2))) := by
  convert ((summable_numeratorTerm (k + 1) 0).hasSum.neg).div_const
    (((k : ℝ) + 1) * (8 : ℝ) ^ (k + 2)) using 1
  · funext r
    exact stieltjesTerm_monomial k r
  · rfl

theorem coefficient_eq_numeratorMoment (k : ℕ) :
    coefficient k = (-1 : ℝ) ^ (k + 1) * numeratorMomentShift (k + 1) 0 /
      (8 : ℝ) ^ (k + 2) := by
  unfold coefficient moment
  rw [(hasSum_moment k).tsum_eq, pow_succ]
  have hk : (k : ℝ) + 1 ≠ 0 := by positivity
  field_simp
  ring

theorem coefficient_dyadic (k : ℕ) : ∃ B : ℤ,
    coefficient k = (B : ℝ) / (8 : ℝ) ^ (k + 2) := by
  obtain ⟨z, hz⟩ := numeratorMoment_integer (k + 1)
  refine ⟨(-1 : ℤ) ^ (k + 1) * z, ?_⟩
  rw [coefficient_eq_numeratorMoment, hz]
  push_cast
  rfl

private theorem pow_shift_le_factorial_geom (k r : ℕ) (t : ℝ) (ht : t ∈ Set.Icc (1 : ℝ) 6) :
    ((r : ℝ) + 1 + t / 8) ^ k ≤ (Nat.factorial k : ℝ) * 9 * (3 : ℝ) ^ r := by
  have hu : 0 ≤ (r : ℝ) + 1 + t / 8 := by linarith [Nat.cast_nonneg (α := ℝ) r, ht.1]
  have hfac : (0 : ℝ) < Nat.factorial k := by positivity
  have hp := (div_le_iff₀ hfac).mp (Real.pow_div_factorial_le_exp _ hu k)
  have he1 : 0 ≤ Real.exp 1 := (Real.exp_pos 1).le
  have he2 : Real.exp (2 : ℝ) ≤ 9 := by
    have he := pow_le_pow_left₀ he1 Real.exp_one_lt_three.le 2
    have heq : Real.exp (2 : ℝ) = (Real.exp 1) ^ 2 := by
      simpa only [Nat.cast_ofNat, mul_one] using Real.exp_natCast_mul 2 1
    rw [heq]
    norm_num at he ⊢
    exact he
  have her : Real.exp (r : ℝ) ≤ (3 : ℝ) ^ r := by
    have heq : Real.exp (r : ℝ) = (Real.exp 1) ^ r := by
      simpa only [mul_one] using Real.exp_natCast_mul r 1
    rw [heq]
    exact pow_le_pow_left₀ he1 Real.exp_one_lt_three.le r
  have heu : Real.exp ((r : ℝ) + 1 + t / 8) ≤ 9 * (3 : ℝ) ^ r := by
    calc
      _ ≤ Real.exp ((r : ℝ) + 2) := Real.exp_le_exp.mpr (by linarith [ht.2])
      _ = Real.exp (r : ℝ) * Real.exp 2 := Real.exp_add _ _
      _ ≤ (3 : ℝ) ^ r * 9 := mul_le_mul her he2 (Real.exp_pos _).le (by positivity)
      _ = _ := by ring
  calc
    _ ≤ Real.exp ((r : ℝ) + 1 + t / 8) * (Nat.factorial k : ℝ) := hp
    _ ≤ (9 * (3 : ℝ) ^ r) * (Nat.factorial k : ℝ) := mul_le_mul_of_nonneg_right heu hfac.le
    _ = _ := by ring

private theorem stieltjesTerm_monomial_bound (k r : ℕ) :
    stieltjesTerm (fun u => u ^ k) r ≤
      (Nat.factorial k : ℝ) * (135 / 1024) * (3 / 16 : ℝ) ^ r := by
  have hi (b : ℝ) (hb1 : 1 ≤ b) (hb6 : b ≤ 6) :
      (∫ t in (1 : ℝ)..b, ((r : ℝ) + 1 + t / 8) ^ k) ≤
        (b - 1) * ((Nat.factorial k : ℝ) * 9 * (3 : ℝ) ^ r) := by
    have h := intervalIntegral.integral_mono_on hb1
      ((by fun_prop : Continuous (fun t : ℝ => ((r : ℝ) + 1 + t / 8) ^ k)).intervalIntegrable 1 b)
      (intervalIntegrable_const : IntervalIntegrable
        (fun _ : ℝ => (Nat.factorial k : ℝ) * 9 * (3 : ℝ) ^ r) MeasureTheory.volume 1 b)
      (fun t ht => pow_shift_le_factorial_geom k r t ⟨ht.1, ht.2.trans hb6⟩)
    simpa only [intervalIntegral.integral_const, smul_eq_mul] using h
  have h4 := hi 4 (by norm_num) (by norm_num)
  have h5 := hi 5 (by norm_num) (by norm_num)
  have h6 := hi 6 (by norm_num) (by norm_num)
  unfold stieltjesTerm
  calc
    _ ≤ (15 * ((Nat.factorial k : ℝ) * 9 * (3 : ℝ) ^ r)) /
        (64 * (16 : ℝ) ^ (r + 1)) := by
      apply div_le_div_of_nonneg_right _ (by positivity)
      linarith
    _ = _ := by rw [div_pow, pow_succ]; ring

private theorem stieltjesTerm_monomial_pos (k r : ℕ) :
    0 < stieltjesTerm (fun u => u ^ k) r := by
  have hp (b : ℝ) (hb : 1 < b) :
      0 < ∫ t in (1 : ℝ)..b, ((r : ℝ) + 1 + t / 8) ^ k := by
    apply intervalIntegral.integral_pos hb (by fun_prop)
    · intro t ht
      apply pow_nonneg
      linarith [Nat.cast_nonneg (α := ℝ) r, ht.1]
    · refine ⟨1, ⟨le_rfl, hb.le⟩, ?_⟩
      positivity
  have h4 := hp 4 (by norm_num)
  have h5 := hp 5 (by norm_num)
  have h6 := hp 6 (by norm_num)
  unfold stieltjesTerm
  positivity

theorem moment_pos (k : ℕ) : 0 < moment k := by
  unfold moment
  exact (hasSum_moment k).summable.tsum_pos
    (fun r => (stieltjesTerm_monomial_pos k r).le) 0 (stieltjesTerm_monomial_pos k 0)

theorem moment_lt_factorial (k : ℕ) : moment k < (Nat.factorial k : ℝ) := by
  have hg : HasSum (fun r : ℕ => (Nat.factorial k : ℝ) * (135 / 1024) * (3 / 16 : ℝ) ^ r)
      ((Nat.factorial k : ℝ) * (135 / 832)) := by
    convert (hasSum_geometric_of_lt_one (by norm_num : (0 : ℝ) ≤ 3 / 16)
      (by norm_num : (3 / 16 : ℝ) < 1)).mul_left ((Nat.factorial k : ℝ) * (135 / 1024)) using 1
    ring
  have hle : moment k ≤ (Nat.factorial k : ℝ) * (135 / 832) := by
    exact hasSum_le (stieltjesTerm_monomial_bound k) (hasSum_moment k).summable.hasSum hg
  have hfac : (0 : ℝ) < Nat.factorial k := by positivity
  linarith

/-- The first K inverse-power terms at the positive anchor N. -/
@[expose] noncomputable def correction (K N : ℕ) : ℝ :=
  ∑ k ∈ Finset.range K, coefficient k / (N : ℝ) ^ (k + 2)
/-- The positive kernel of the signed order-K remainder. -/
@[expose] noncomputable def remainderKernel (K N : ℕ) (u : ℝ) : ℝ :=
  (u / (N : ℝ)) ^ K * (((K : ℝ) + 1) + (K : ℝ) * u / (N : ℝ)) /
    ((N : ℝ) + u) ^ 2

private theorem signed_kernel_expansion (N K : ℕ) (hN : 0 < N) (u : ℝ) (hu : 0 ≤ u) :
    (-1 : ℝ) ^ K * (1 / ((N : ℝ) + u) ^ 2 -
      ∑ k ∈ Finset.range K, (-1 : ℝ) ^ k * ((k : ℝ) + 1) * u ^ k / (N : ℝ) ^ (k + 2)) =
    remainderKernel K N u := by
  have hn : (0 : ℝ) < N := by exact_mod_cast hN
  have hn0 : (N : ℝ) ≠ 0 := hn.ne'
  have hnu : (N : ℝ) + u ≠ 0 := by positivity
  have hratio : 1 + u / (N : ℝ) = ((N : ℝ) + u) / (N : ℝ) := by field_simp
  have hs : (-1 : ℝ) ^ K * (-1 : ℝ) ^ K = 1 := by rw [← mul_pow]; norm_num
  calc
    _ = ((-1 : ℝ) ^ K / (N : ℝ) ^ 2) * (1 / (1 + u / (N : ℝ)) ^ 2 -
        ∑ k ∈ Finset.range K, (-1 : ℝ) ^ k * ((k : ℝ) + 1) * (u / (N : ℝ)) ^ k) := by
      rw [mul_sub, mul_sub, Finset.mul_sum, Finset.mul_sum]
      congr 1
      · rw [hratio, div_pow]
        field_simp
      · apply Finset.sum_congr rfl
        intro k hk
        rw [div_pow, pow_add]
        field_simp
    _ = ((-1 : ℝ) ^ K * (-1 : ℝ) ^ K) *
        ((u / (N : ℝ)) ^ K * (((K : ℝ) + 1) + (K : ℝ) * (u / (N : ℝ))) /
          ((1 + u / (N : ℝ)) ^ 2 * (N : ℝ) ^ 2)) := by
      rw [finite_inv_sq_remainder K _ (div_nonneg hu hn.le)]
      field_simp
    _ = remainderKernel K N u := by
      rw [hs, one_mul, hratio, div_pow]
      unfold remainderKernel
      simp only [div_pow]
      field_simp

private theorem remainderKernel_pos (N K : ℕ) (hN : 0 < N) (u : ℝ) (hu : 0 < u) :
    0 < remainderKernel K N u := by
  unfold remainderKernel
  positivity

private theorem remainderKernel_le (N K : ℕ) (hN : 0 < N) (u : ℝ) (hu : 0 ≤ u) :
    remainderKernel K N u ≤ ((K : ℝ) + 1) * u ^ K / (N : ℝ) ^ (K + 2) := by
  have hn : (0 : ℝ) < N := by exact_mod_cast hN
  have hn0 : (N : ℝ) ≠ 0 := hn.ne'
  have hnu : (N : ℝ) + u ≠ 0 := by positivity
  have hratio : 1 + u / (N : ℝ) = ((N : ℝ) + u) / (N : ℝ) := by field_simp
  have heq : remainderKernel K N u = (u ^ K / (N : ℝ) ^ (K + 2)) *
      ((((K : ℝ) + 1) + (K : ℝ) * (u / (N : ℝ))) / (1 + u / (N : ℝ)) ^ 2) := by
    unfold remainderKernel
    rw [hratio, div_pow, div_pow, pow_add]
    field_simp
  rw [heq]
  calc
    _ ≤ (u ^ K / (N : ℝ) ^ (K + 2)) * ((K : ℝ) + 1) :=
      mul_le_mul_of_nonneg_left (remainder_factor_le K _ (div_nonneg hu hn.le)) (by positivity)
    _ = _ := by ring

private theorem stieltjes_intervalIntegrable (f : ℝ → ℝ) (hf : ContinuousOn f (Set.Ici 0))
    (r : ℕ) (b : ℝ) (hb : 1 ≤ b) :
    IntervalIntegrable (fun t => f ((r : ℝ) + 1 + t / 8)) MeasureTheory.volume 1 b := by
  apply ContinuousOn.intervalIntegrable
  apply hf.comp (by fun_prop : Continuous (fun t : ℝ => (r : ℝ) + 1 + t / 8)).continuousOn
  intro t ht
  rw [Set.uIcc_of_le hb] at ht
  change 0 ≤ (r : ℝ) + 1 + t / 8
  linarith [Nat.cast_nonneg (α := ℝ) r, ht.1]

private theorem stieltjesTerm_const_mul (f : ℝ → ℝ) (c : ℝ) (r : ℕ) :
    stieltjesTerm (fun u => c * f u) r = c * stieltjesTerm f r := by
  unfold stieltjesTerm
  simp only [intervalIntegral.integral_const_mul]
  ring

private theorem stieltjesTerm_sub (f g : ℝ → ℝ) (hf : ContinuousOn f (Set.Ici 0))
    (hg : ContinuousOn g (Set.Ici 0)) (r : ℕ) :
    stieltjesTerm (fun u => f u - g u) r = stieltjesTerm f r - stieltjesTerm g r := by
  unfold stieltjesTerm
  rw [intervalIntegral.integral_sub (stieltjes_intervalIntegrable f hf r 4 (by norm_num))
      (stieltjes_intervalIntegrable g hg r 4 (by norm_num)),
    intervalIntegral.integral_sub (stieltjes_intervalIntegrable f hf r 5 (by norm_num))
      (stieltjes_intervalIntegrable g hg r 5 (by norm_num)),
    intervalIntegral.integral_sub (stieltjes_intervalIntegrable f hf r 6 (by norm_num))
      (stieltjes_intervalIntegrable g hg r 6 (by norm_num))]
  ring

private theorem stieltjesTerm_finsetSum {ι : Type*} (s : Finset ι) (f : ι → ℝ → ℝ)
    (hf : ∀ i ∈ s, ContinuousOn (f i) (Set.Ici 0)) (r : ℕ) :
    stieltjesTerm (fun u => ∑ i ∈ s, f i u) r = ∑ i ∈ s, stieltjesTerm (f i) r := by
  unfold stieltjesTerm
  rw [intervalIntegral.integral_finsetSum (fun i hi =>
      stieltjes_intervalIntegrable (f i) (hf i hi) r 4 (by norm_num)),
    intervalIntegral.integral_finsetSum (fun i hi =>
      stieltjes_intervalIntegrable (f i) (hf i hi) r 5 (by norm_num)),
    intervalIntegral.integral_finsetSum (fun i hi =>
      stieltjes_intervalIntegrable (f i) (hf i hi) r 6 (by norm_num))]
  simp only [Finset.mul_sum, ← Finset.sum_add_distrib, Finset.sum_div]

private theorem stieltjesTerm_congr (f g : ℝ → ℝ) (hfg : ∀ u : ℝ, 0 ≤ u → f u = g u) (r : ℕ) :
    stieltjesTerm f r = stieltjesTerm g r := by
  have he (b : ℝ) (hb : 1 ≤ b) :
      (∫ t in (1 : ℝ)..b, f ((r : ℝ) + 1 + t / 8)) =
      (∫ t in (1 : ℝ)..b, g ((r : ℝ) + 1 + t / 8)) := by
    apply intervalIntegral.integral_congr
    intro t ht
    rw [Set.uIcc_of_le hb] at ht
    apply hfg
    linarith [Nat.cast_nonneg (α := ℝ) r, ht.1]
  unfold stieltjesTerm
  rw [he 4 (by norm_num), he 5 (by norm_num), he 6 (by norm_num)]

private theorem continuousOn_tailKernel (N : ℕ) (hN : 0 < N) :
    ContinuousOn (fun u : ℝ => 1 / ((N : ℝ) + u) ^ 2) (Set.Ici 0) := by
  apply continuousOn_const.div ((continuous_const.add continuous_id).pow 2).continuousOn
  intro u hu
  have hn : (0 : ℝ) < N := by exact_mod_cast hN
  have h : 0 < (N : ℝ) + u := add_pos_of_pos_of_nonneg hn hu
  exact pow_ne_zero _ h.ne'

private theorem continuousOn_remainderKernel (N K : ℕ) (hN : 0 < N) :
    ContinuousOn (remainderKernel K N) (Set.Ici 0) := by
  unfold remainderKernel
  apply (by fun_prop : Continuous (fun u : ℝ =>
    (u / (N : ℝ)) ^ K * (((K : ℝ) + 1) + (K : ℝ) * u / (N : ℝ)))).continuousOn.div
    ((continuous_const.add continuous_id).pow 2).continuousOn
  intro u hu
  have hn : (0 : ℝ) < N := by exact_mod_cast hN
  have h : 0 < (N : ℝ) + u := add_pos_of_pos_of_nonneg hn hu
  exact pow_ne_zero _ h.ne'

private theorem stieltjesTerm_remainder (N K r : ℕ) (hN : 0 < N) :
    stieltjesTerm (remainderKernel K N) r = (-1 : ℝ) ^ K *
      (stieltjesTerm (fun u => 1 / ((N : ℝ) + u) ^ 2) r -
        ∑ k ∈ Finset.range K, (-1 : ℝ) ^ k * ((k : ℝ) + 1) *
          stieltjesTerm (fun u => u ^ k) r / (N : ℝ) ^ (k + 2)) := by
  rw [stieltjesTerm_congr _ _ (fun u hu => (signed_kernel_expansion N K hN u hu).symm) r,
    stieltjesTerm_const_mul,
    stieltjesTerm_sub _ _ (continuousOn_tailKernel N hN) (by fun_prop),
    stieltjesTerm_finsetSum _ _ (by intro i hi; fun_prop)]
  congr 2
  apply Finset.sum_congr rfl
  intro k hk
  have he : (fun u : ℝ => (-1 : ℝ) ^ k * ((k : ℝ) + 1) * u ^ k / (N : ℝ) ^ (k + 2)) =
      (fun u : ℝ => ((-1 : ℝ) ^ k * ((k : ℝ) + 1) / (N : ℝ) ^ (k + 2)) * u ^ k) := by
    funext u
    ring
  rw [he, stieltjesTerm_const_mul]
  ring

theorem hasSum_remainder (N K : ℕ) (hN : 0 < N) :
    HasSum (stieltjesTerm (remainderKernel K N))
      ((-1 : ℝ) ^ K * (bbpTail N - correction K N)) := by
  have hm (k : ℕ) : HasSum (stieltjesTerm (fun u => u ^ k)) (moment k) :=
    (hasSum_moment k).summable.hasSum
  have hs := hasSum_sum (s := Finset.range K) (fun k _ =>
    ((hm k).mul_left ((-1 : ℝ) ^ k * ((k : ℝ) + 1))).div_const ((N : ℝ) ^ (k + 2)))
  have h := ((hasSum_bbpTail_stieltjes N).sub hs).mul_left ((-1 : ℝ) ^ K)
  convert h using 1
  · funext r
    exact stieltjesTerm_remainder N K r hN
  · rfl

private theorem stieltjesTerm_mono (f g : ℝ → ℝ) (hf : ContinuousOn f (Set.Ici 0))
    (hg : ContinuousOn g (Set.Ici 0)) (hfg : ∀ u : ℝ, 0 ≤ u → f u ≤ g u) (r : ℕ) :
    stieltjesTerm f r ≤ stieltjesTerm g r := by
  have hi (b : ℝ) (hb : 1 ≤ b) :
      (∫ t in (1 : ℝ)..b, f ((r : ℝ) + 1 + t / 8)) ≤
      (∫ t in (1 : ℝ)..b, g ((r : ℝ) + 1 + t / 8)) := by
    apply intervalIntegral.integral_mono_on hb (stieltjes_intervalIntegrable f hf r b hb)
      (stieltjes_intervalIntegrable g hg r b hb)
    intro t ht
    apply hfg
    linarith [Nat.cast_nonneg (α := ℝ) r, ht.1]
  have h4 := hi 4 (by norm_num)
  have h5 := hi 5 (by norm_num)
  have h6 := hi 6 (by norm_num)
  unfold stieltjesTerm
  apply div_le_div_of_nonneg_right _ (by positivity)
  linarith

private theorem stieltjesTerm_pos (f : ℝ → ℝ) (hf : ContinuousOn f (Set.Ici 0))
    (hpos : ∀ u : ℝ, 0 < u → 0 < f u) (r : ℕ) : 0 < stieltjesTerm f r := by
  have hi (b : ℝ) (hb : 1 < b) :
      0 < ∫ t in (1 : ℝ)..b, f ((r : ℝ) + 1 + t / 8) := by
    apply intervalIntegral.integral_pos hb
    · apply hf.comp (by fun_prop : Continuous (fun t : ℝ => (r : ℝ) + 1 + t / 8)).continuousOn
      intro t ht
      change 0 ≤ (r : ℝ) + 1 + t / 8
      linarith [Nat.cast_nonneg (α := ℝ) r, ht.1]
    · intro t ht
      apply (hpos _ _).le
      linarith [Nat.cast_nonneg (α := ℝ) r, ht.1]
    · refine ⟨1, ⟨le_rfl, hb.le⟩, hpos _ ?_⟩
      positivity
  have h4 := hi 4 (by norm_num)
  have h5 := hi 5 (by norm_num)
  have h6 := hi 6 (by norm_num)
  unfold stieltjesTerm
  positivity

theorem remainder_pos (N K : ℕ) (hN : 0 < N) :
    0 < (-1 : ℝ) ^ K * (bbpTail N - correction K N) := by
  have hp (r : ℕ) : 0 < stieltjesTerm (remainderKernel K N) r :=
    stieltjesTerm_pos _ (continuousOn_remainderKernel N K hN) (remainderKernel_pos N K hN) r
  rw [← (hasSum_remainder N K hN).tsum_eq]
  exact (hasSum_remainder N K hN).summable.tsum_pos (fun r => (hp r).le) 0 (hp 0)

theorem remainder_lt_factorial (N K : ℕ) (hN : 0 < N) :
    (-1 : ℝ) ^ K * (bbpTail N - correction K N) <
      (Nat.factorial (K + 1) : ℝ) / (N : ℝ) ^ (K + 2) := by
  let c : ℝ := ((K : ℝ) + 1) / (N : ℝ) ^ (K + 2)
  have hc : 0 < c := by dsimp [c]; positivity
  have hb (r : ℕ) : stieltjesTerm (remainderKernel K N) r ≤
      c * stieltjesTerm (fun u => u ^ K) r := by
    rw [← stieltjesTerm_const_mul]
    apply stieltjesTerm_mono _ _ (continuousOn_remainderKernel N K hN) (by fun_prop)
    intro u hu
    have h := remainderKernel_le N K hN u hu
    dsimp [c]
    convert h using 1
    ring
  have hle : (-1 : ℝ) ^ K * (bbpTail N - correction K N) ≤ c * moment K :=
    hasSum_le hb (hasSum_remainder N K hN) ((hasSum_moment K).summable.hasSum.mul_left c)
  calc
    _ ≤ c * moment K := hle
    _ < c * (Nat.factorial K : ℝ) := mul_lt_mul_of_pos_left (moment_lt_factorial K) hc
    _ = (Nat.factorial (K + 1) : ℝ) / (N : ℝ) ^ (K + 2) := by
      simp only [c, Nat.factorial_succ, Nat.cast_mul, Nat.cast_add, Nat.cast_one]
      ring

end PiDisjunctivity.BBPAsymptotics
