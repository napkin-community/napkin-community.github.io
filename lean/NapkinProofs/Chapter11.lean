import Mathlib.LinearAlgebra.Trace

/-
# Problem 11B† (Product of traces)
Let T : V → V and S : W → W be linear maps of finite-dimensional vector spaces V
and W. Define T ⊗ S : V ⊗ W → V ⊗ W by λv ⊗ w.T(v) ⊗ S(w). Prove that:

    Tr(T ⊗ S) = Tr(T) Tr(S).
-/
theorem trace_tensor_product_eq_mul_trace
  -- k ∈ Field
  {𝕜 : Type} [Field 𝕜]
  -- V, W ∈ FDVect_k
  {V : Type} [AddCommGroup V] [Module 𝕜 V] [FiniteDimensional 𝕜 V]
  {W : Type} [AddCommGroup W] [Module 𝕜 W] [FiniteDimensional 𝕜 W]
  -- T : V → V
  (T : V →ₗ[𝕜] V)
  -- S : W → W
  (S : W →ₗ[𝕜] W)
: -- Tr(T ⊗ S) = Tr(T) Tr(S)
  LinearMap.trace 𝕜 (TensorProduct 𝕜 V W) (TensorProduct.map T S) = LinearMap.trace 𝕜 V T * LinearMap.trace 𝕜 W S
:= LinearMap.trace_tensorProduct' T S
/-
V의 기저를 B_V라 하자
B_V = {v₁, ..., v_n}
n = dim(V)

W의 기저를 B_W라 하자
B_W = {w₁, ..., w_m}
m = dim(W)

V ⊗ W의 기저는 B_V ⊗ B_W이다.
B_{V ⊗ W} = {vᵢ ⊗ wⱼ | 1 ≤ i ≤ n, 1 ≤ j ≤ m}
nm = dim(V ⊗ W)

T와 S를 행렬로 A = [aᵢⱼ] (n x n), B = [bₖₗ] (m x m)라 하자.
T(vₖ) = Σᵢ aᵢₖ vᵢ
S(wₗ) = Σⱼ bⱼₗ wⱼ

Trace의 정의에 따라:
Tr(T) = Σᵢ aᵢᵢ
Tr(S) = Σⱼ bⱼⱼ

선형변환의 텐서곱 정의에 따라:
(T ⊗ S)(vₖ ⊗ wₗ) = T(vₖ) ⊗ S(wₗ)

이를 행렬 표현으로 바꾸면:
(T ⊗ S)(vₖ ⊗ wₗ) = (Σᵢ aᵢₖ vᵢ) ⊗ (Σⱼ bⱼₗ wⱼ)
                = ΣᵢΣⱼ aᵢₖ bⱼₗ (vᵢ ⊗ wⱼ)

여기에 Trace를 씌우면, 대각성분만 살아남는다:
Tr(T ⊗ S) = ΣᵢΣⱼ aᵢᵢ bⱼⱼ
          = (Σᵢ aᵢᵢ)(Σⱼ bⱼⱼ)
          = Tr(T) Tr(S)
-/
