module

public import PiDisjunctivity.Definitions
import Mathlib.Tactic

/-! Hexadecimal words, their cylinders, and the closure of the hexadecimal orbit. -/

@[expose] public section

namespace PiDisjunctivity

/-- Big-endian value of a hexadecimal word. Its length is retained separately. -/
def blockValue : (k : ℕ) → (Fin k → Fin 16) → ℕ
  | 0, _ => 0
  | k + 1, s => 16 * blockValue k (fun i => s i.castSucc) + (s (Fin.last k)).val

theorem blockValue_lt (k : ℕ) (s : Fin k → Fin 16) : blockValue k s < 16 ^ k := by
  induction k with
  | zero => simp [blockValue]
  | succ k ih =>
    have h := ih (fun i => s i.castSucc)
    have hd := (s (Fin.last k)).isLt
    simp only [blockValue, pow_succ]
    omega

private theorem prefix_div (x : ℝ) (k : ℕ) :
    Nat.floor ((16 : ℝ) ^ (k + 1) * x) / 16 = Nat.floor ((16 : ℝ) ^ k * x) := by
  have h := Nat.cast_mul_floor_div_cancel (R := ℝ) (n := 16) (by norm_num)
    ((16 : ℝ) ^ k * x)
  simpa only [Nat.cast_ofNat, pow_succ, mul_assoc, mul_comm, mul_left_comm] using h

/-- A hexadecimal prefix is exactly the integer part after scaling by its length. -/
theorem digits_iff_prefix (y : ℝ) (hy : y ∈ Set.Ico (0 : ℝ) 1)
    (k : ℕ) (s : Fin k → Fin 16) :
    (∀ i : Fin k, baseDigit 16 y i.val = (s i).val) ↔
      Nat.floor ((16 : ℝ) ^ k * y) = blockValue k s := by
  induction k with
  | zero => simp [blockValue, Nat.floor_eq_zero.mpr hy.2]
  | succ k ih =>
    rw [Fin.forall_fin_succ']
    simp only [Fin.val_castSucc, Fin.val_last]
    rw [ih]
    have hdiv := prefix_div y k
    have hmod := Nat.mod_add_div (Nat.floor ((16 : ℝ) ^ (k + 1) * y)) 16
    have hd := (s (Fin.last k)).isLt
    have hr := Nat.mod_lt (Nat.floor ((16 : ℝ) ^ (k + 1) * y)) (by decide : 0 < 16)
    simp only [baseDigit, blockValue, Nat.cast_ofNat]
    omega

/-- Taking a fractional part shifts the hexadecimal expansion by exactly `n` places. -/
theorem baseDigit_hexadecimal_shift (x : ℝ) (hx : 0 ≤ x) (n i : ℕ) :
    baseDigit 16 x (n + i) = baseDigit 16 (Int.fract ((16 : ℝ) ^ n * x)) i := by
  let z := (16 : ℝ) ^ n * x
  have hz : 0 ≤ z := mul_nonneg (by positivity) hx
  have hsplit : z = Int.fract z + (Nat.floor z : ℝ) := by
    rw [natCast_floor_eq_intCast_floor hz]
    exact (Int.fract_add_floor z).symm
  have hscale : (16 : ℝ) ^ (n + i + 1) * x =
      (16 : ℝ) ^ (i + 1) * Int.fract z +
        ((16 ^ (i + 1) * Nat.floor z : ℕ) : ℝ) := by
    push_cast
    rw [← mul_add, ← hsplit]
    dsimp [z]
    rw [show n + i + 1 = n + (i + 1) by omega, pow_add]
    ring
  simp only [baseDigit, Nat.cast_ofNat]
  rw [hscale, Nat.floor_add_natCast (mul_nonneg (by positivity) (Int.fract_nonneg z))]
  simp [Nat.add_mod, pow_succ, Nat.mul_mod, z]

/-- A word specifies a half-open hexadecimal cell, including its left endpoint. -/
theorem digits_iff_mem_cylinder (y : ℝ) (hy : y ∈ Set.Ico (0 : ℝ) 1)
    (k : ℕ) (s : Fin k → Fin 16) :
    (∀ i : Fin k, baseDigit 16 y i.val = (s i).val) ↔
      y ∈ Set.Ico ((blockValue k s : ℝ) / 16 ^ k)
        (((blockValue k s : ℝ) + 1) / 16 ^ k) := by
  rw [digits_iff_prefix y hy, Nat.floor_eq_iff (mul_nonneg (by positivity) hy.1)]
  change _ ↔ _ ≤ y ∧ y < _
  rw [div_le_iff₀ (by positivity : (0 : ℝ) < 16 ^ k),
    lt_div_iff₀ (by positivity : (0 : ℝ) < 16 ^ k)]
  simp only [mul_comm]

/-- Occurrence at offset `n` is membership of the shifted orbit point in a cylinder. -/
theorem block_iff_mem_cylinder (x : ℝ) (hx : 0 ≤ x)
    (n k : ℕ) (s : Fin k → Fin 16) :
    (∀ i : Fin k, baseDigit 16 x (n + i.val) = (s i).val) ↔
      Int.fract ((16 : ℝ) ^ n * x) ∈
        Set.Ico ((blockValue k s : ℝ) / 16 ^ k)
          (((blockValue k s : ℝ) + 1) / 16 ^ k) := by
  simp_rw [baseDigit_hexadecimal_shift x hx n]
  exact digits_iff_mem_cylinder _ ⟨Int.fract_nonneg _, Int.fract_lt_one _⟩ k s

private theorem dist_lt_of_prefix_eq (y z : ℝ) (hy : 0 ≤ y) (hz : 0 ≤ z)
    (k : ℕ) (h : Nat.floor ((16 : ℝ) ^ k * y) = Nat.floor ((16 : ℝ) ^ k * z)) :
    dist y z < 1 / (16 : ℝ) ^ k := by
  have hp : (0 : ℝ) < 16 ^ k := by positivity
  have hyl := Nat.floor_le (mul_nonneg hp.le hy)
  have hyu := Nat.lt_floor_add_one ((16 : ℝ) ^ k * y)
  have hzl := Nat.floor_le (mul_nonneg hp.le hz)
  have hzu := Nat.lt_floor_add_one ((16 : ℝ) ^ k * z)
  rw [h] at hyl hyu
  rw [Real.dist_eq, abs_lt]
  constructor
  · have : z - y < 1 / (16 : ℝ) ^ k := (lt_div_iff₀ hp).2 (by nlinarith)
    linarith
  · exact (lt_div_iff₀ hp).2 (by nlinarith)

theorem orbit_closure_of_hexadecimal_disjunctive (x : ℝ) (hx : 0 ≤ x)
    (hd : IsDisjunctive 16 x) : closure (hexadecimalOrbit x) = Set.Icc (0 : ℝ) 1 := by
  apply Set.Subset.antisymm
  · apply closure_minimal _ isClosed_Icc
    rintro y ⟨n, rfl⟩
    exact ⟨Int.fract_nonneg _, (Int.fract_lt_one _).le⟩
  · have hIco : Set.Ico (0 : ℝ) 1 ⊆ closure (hexadecimalOrbit x) := by
      intro y hy
      rw [Metric.mem_closure_iff]
      intro ε hε
      obtain ⟨k, hk⟩ := exists_pow_lt_of_lt_one hε (by norm_num : (1 / 16 : ℝ) < 1)
      let s : Fin k → Fin 16 := fun i =>
        ⟨baseDigit 16 y i.val, Nat.mod_lt _ (by decide)⟩
      obtain ⟨n, hn⟩ := hd k s
      have hprefixY := (digits_iff_prefix y hy k s).1 (fun _ => rfl)
      have hprefixZ := (digits_iff_prefix (Int.fract ((16 : ℝ) ^ n * x))
        ⟨Int.fract_nonneg _, Int.fract_lt_one _⟩ k s).1
        (fun i => (baseDigit_hexadecimal_shift x hx n i.val).symm.trans (hn i))
      refine ⟨Int.fract ((16 : ℝ) ^ n * x), ⟨n, rfl⟩, ?_⟩
      have hdist := dist_lt_of_prefix_eq y _ hy.1 (Int.fract_nonneg _) k
        (hprefixY.trans hprefixZ.symm)
      have hsmall : 1 / (16 : ℝ) ^ k < ε := by simpa only [one_div_pow] using hk
      exact hdist.trans hsmall
    have hclosed := closure_minimal hIco isClosed_closure
    simpa only [closure_Ico (by norm_num : (0 : ℝ) ≠ 1)] using hclosed

theorem hexadecimal_disjunctive_of_orbit_closure (x : ℝ) (hx : 0 ≤ x)
    (hc : closure (hexadecimalOrbit x) = Set.Icc (0 : ℝ) 1) : IsDisjunctive 16 x := by
  intro k s
  let a : ℝ := (blockValue k s : ℝ) / 16 ^ k
  let b : ℝ := ((blockValue k s : ℝ) + 1) / 16 ^ k
  have hp : (0 : ℝ) < 16 ^ k := by positivity
  have ha : 0 ≤ a := by dsimp [a]; positivity
  have hab : a < b := by
    dsimp [a, b]
    exact (div_lt_div_iff_of_pos_right hp).2 (by linarith)
  have hb : b ≤ 1 := by
    dsimp [b]
    rw [div_le_iff₀ hp, one_mul]
    exact_mod_cast (blockValue_lt k s)
  have hm : (a + b) / 2 ∈ Set.Icc (0 : ℝ) 1 := ⟨by linarith, by linarith⟩
  have hmc : (a + b) / 2 ∈ closure (hexadecimalOrbit x) := by rwa [hc]
  obtain ⟨y, hy, n, rfl⟩ := mem_closure_iff.1 hmc (Set.Ioo a b) isOpen_Ioo
    ⟨by linarith, by linarith⟩
  refine ⟨n, (block_iff_mem_cylinder x hx n k s).2 ?_⟩
  exact ⟨hy.1.le, hy.2⟩

/-- Hexadecimal disjunctivity is equivalent to the orbit having closure `[0, 1]` in `ℝ`. -/
theorem hexadecimal_disjunctive_iff_orbit_closure (x : ℝ) (hx : 0 ≤ x) :
    IsDisjunctive 16 x ↔ closure (hexadecimalOrbit x) = Set.Icc (0 : ℝ) 1 :=
  ⟨orbit_closure_of_hexadecimal_disjunctive x hx, hexadecimal_disjunctive_of_orbit_closure x hx⟩

end PiDisjunctivity
