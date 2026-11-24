import Mathlib

#check Real.pi
#check Int.fract
#check Nat.floor
#check Set.Icc

example : Irrational Real.pi := by
  exact irrational_pi

example : (Real.pi : ℝ) > 3 := by
  exact Real.pi_gt_three
