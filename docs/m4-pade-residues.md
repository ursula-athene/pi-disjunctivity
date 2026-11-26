# M4: digit-sensitive Pade residues and their cost

Research checkpoint, 2026-11-26. The bounded numerator-sensitive test and independent changed-file review are complete. These are paper arguments and exact finite checks, not Lean exports or M4 acceptance.

## Outcome

There is an arithmetic gain: a rank-two family of actual BBP Padé vectors can prescribe the residual residues so that every candidate whose last m hexadecimal digits omit F has a nonzero integer residual of magnitude at least 16^m/32. The coefficients of P and Q are kept coupled throughout.

The specified construction cannot use that gain in the symmetric prefix-error estimate: its coefficient alpha is necessarily at least 16^m-1 in magnitude. This elementary obstruction survives replacing the modulus by any larger modulus under the same alpha congruence. A separate prime argument shows that primitive normalization does not eliminate the exponential cost of clearing the coefficients of P. It does not control cancellation after evaluation at 1/16 or a common factor of the evaluated integer pair.

The next live question concerns that evaluated cancellation and a signed remainder estimate. More prescriptions with the same fixed clearing and alpha congruence would repeat the diagnosed obstruction. No digit occurrence for pi, V, Hpi, T, or M4 is proved.

## 1. Exact residual/interface before choosing the vector

The source motivation is [Fischler–Rivoal](https://rivoal.perso.math.cnrs.fr/articles/approxG.pdf), Section 3.1, printed pp.11-12: the cleared residual is nonzero, and a degree separation forces divisibility by b^m. The proof then compares this integer lower bound with the analytic remainder. Both pages were visually checked. The following scalar construction is derived directly; no simultaneous-derivative rank theorem or source threshold is assumed.

Let H(z)=sum A(n)z^n be the actual BBP generating function, H(1/16)=pi, with

    A(n)=(120n^2+151n+47)/[(2n+1)(4n+3)(8n+1)(8n+5)].

Let n be an integer, B a positive integer, and q,m,L natural numbers. Take Q in Z[z], deg Q<=q, P=trunc_L(QH), with L>=q+m. Let delta be any positive integer clearing every coefficient of P. Set

    R=QH-P,
    V=16^q Q(1/16) in Z,
    U=delta*16^L P(1/16) in Z,
    alpha=delta*16^(L-q-m)*V,
    beta=B*U,
    J(n)=alpha*n-beta in Z.

The original cleared residual is exactly

    delta*16^L [n Q(1/16)-B*16^m P(1/16)] = 16^m J(n).

For e=pi-n/(B*16^m), without assuming that J is nonzero,

    J(n) = B*delta*16^L [R(1/16)-Q(1/16)*e].       (1)

Consequently a proved |J(n)|>=G gives

    B*delta*16^L*|Q(1/16)|*|e|
      >= G-B*delta*16^L*|R(1/16)|.                (2)

Nonzero Q(1/16) and a positive right side are essential to obtaining a useful approximation bound. The digit construction below supplies nonzero J and Q(1/16) explicitly, rather than treating them as automatic.

## 2. A uniform extra divisor cannot come from avoiding one word

For m>=1, let S_m(w) be the m-digit hexadecimal integers whose digit strings, with leading zeros retained, avoid one fixed nonempty word w. This set contains consecutive integers.

For a one-letter word, choose c in {0,...,14} with c and c+1 both different from that letter. For a longer word, choose c in {0,...,14} different from its first letter. The strings c^m and c^(m-1)(c+1) avoid w and represent consecutive integers. If m is shorter than w, avoidance is automatic. For longer w, every possible occurrence starts before the final position and hence starts with c, which differs from w's first letter.

Thus for any fixed affine residual alpha*n-beta, any common divisor of its values on all n in a translate of S_m(w) must divide alpha (subtract the consecutive cases) and then beta. It already divides every value on all integers. This applies to any selected auxiliary coefficient vector. It excludes an extra *uniform divisor* inferred solely from this avoidance condition; it does not exclude an absolute gap in the allowed residue set or branch-dependent arithmetic information.

## 3. An actual Padé family with two free integer parameters

Now fix m>=2, L=m+2, q=2, B=1, and write

    Q(z)=u_0+u_1 z+u_2 z^2,
    P=trunc_L(QH),
    A(L+1)u_0+A(L)u_1+A(L-1)u_2=0.              (3)

The last equation forces ord_0 R>=L+2=m+4. Its rational solution space has dimension two. Let c be the primitive integer vector obtained by clearing the three denominators in (3) and dividing their common gcd. All those denominators are odd. The integral kernel Lambda={u in Z^3:c dot u=0} has rank two and is saturated because c is primitive.

Set

    delta=lcm(denominator(A(0)),...,denominator(A(L))).

This odd integer clears P for every integer vector in Lambda; in particular delta>=15 because A(0)=47/15. The evaluation map is

    T:Lambda -> Z^2, u |-> (alpha,beta),
    alpha=delta*(256u_0+16u_1+u_2),
    beta=delta*16^L P(1/16).                      (4)

Crucially, beta is computed from the same u by convolution with A. It is not a free additional coefficient.

### Surjectivity modulo every power of two

In the ring of rationals with odd denominator,

    A(n) = n+1 mod 2.

This follows directly from the displayed numerator and odd denominator. Reduction of the primitive constraint therefore gives:

- If L is odd: u_0+u_2=0 mod2, alpha=u_2 mod2, beta=u_1 mod2.
- If L is even: u_1=0 mod2, alpha=u_2 mod2, beta=u_0+u_2 mod2.

In either case the map from the two-dimensional constraint kernel over F_2 to (alpha,beta) is an isomorphism. Since the integral kernel is saturated, reduction of any integral basis spans that kernel. Thus the determinant of the 2 by 2 evaluation matrix for any integral basis is odd. It is invertible modulo 2^k for every k. Every pair of target residues (alpha,beta) modulo 2^k is therefore attainable by an actual vector in (3).

This also gives an explicit height budget. For any integral basis b_1,b_2, solve the two modular equations for parameters s,t and choose representatives with |s|,|t|<=M/2. Then

    height(Q)<= (M/2)*(height(b_1)+height(b_2)).    (5)

For a coarse explicit basis bound, put K_m=151*8^8*(m+4)^10. Each entry of c has magnitude at most K_m: multiply the three displayed quartic denominators before dividing their gcd. An extended-Euclidean kernel basis has heights at most K_m and K_m^2. Hence one can use height(Q)<=M*K_m^2. This is an existence upper bound, not an assertion that every prescribed class requires that much height or that the bound is optimal.

## 4. The digit-sensitive gain

Take M=16^m and prescribe

    alpha = 1 mod M,
    beta = 31M/32 mod M.                         (6)

The target beta is integral because m>=2. The modular surjectivity above provides an actual Q and its coupled P. Also alpha is nonzero, so Q(1/16) is nonzero.

Let S_m be the prefixes using only digits 0,...,14. Every p in S_m satisfies

    0<=p<=14(M-1)/15.

For any integer k, a candidate n=kM+p satisfies

    J(n) = p-31M/32 mod M.

The circular distance of that residue from zero is at least M/32: its distances to the neighboring multiples 0 and -M are at least

    31M/32-14(M-1)/15 = 17M/480+14/15 > M/32,
    M-31M/32 = M/32.

Thus

    |J(kM+p)| >= M/32 >0 for every p in S_m.      (7)

The modular certificate is sharp, since p=0 gives circular distance exactly M/32. For the actual prefix n=floor(16^m*pi), k=3; only the fractional digits, equivalently n mod M, are constrained. No integer-part digit is inadvertently subjected to the forbidden-digit condition. For avoidance after N, distinguish the full orbit exponent s=N+m from the tested suffix length m: use n=floor(16^s*pi), L=s+2 and q=2 in (1) with exponent s, while prescribing residues modulo 16^m. Then alpha=delta*V still holds, n mod16^m is the relevant suffix, and the signed error is tau=16^s*pi-n. The following displayed consumer specializes back to N=0.

One exact sample at m=2 is

    Q=(6081407,4208158,-4883165), delta=78058255275,
    alpha=126398761331820602625,
    beta=101655915522798929305080.

It satisfies (3), alpha=1 mod256, beta=248 mod256, and G=8. This is a finite arithmetic example of the construction, not a pi word search or an occurrence certificate.

## 5. Its actual analytic consumer and the elementary cost obstruction

The existing positive BBP integral kernel proves A(n)>0 and decreasing. For n>=L+2,

    |[z^n]R|<=3*height(Q)*A(n-2)<=3*height(Q)*A(L).

Absolute convergence at 1/16 therefore yields

    |R(1/16)| <= (16/5)*height(Q)*A(L)*16^(-L-2),
    delta*16^L*|R(1/16)| <= delta*height(Q)*A(L)/80.       (8)

For a truncation candidate n=floor(M*pi), let tau=M*pi-n in (0,1). Keep the exact signed identity:

    J(n)=-alpha*tau+delta*16^L R(1/16).            (9)

The symmetric estimate implied by (8) is

    |J(n)| < |alpha|+delta*height(Q)*A(L)/80.      (10)

A contradiction using (7) and this symmetric estimate would require its lower bound to exceed the right side. It cannot. Indeed alpha=delta*V with delta>=15 and V an integer, so alpha cannot equal 1. Together with alpha=1 mod M, this forces

    |alpha|>=M-1>M/32.

The parent supplied this elementary sharpening of the initial denominator-cost argument. More generally, for any modulus M>1, the same alpha congruence and delta>1 force |alpha|>=M-1, while a pure circular-distance certificate modulo M is at most M/2. Merely increasing the modulus cannot overcome the symmetric |alpha| error term for this prescription.

This is not a proof against every one-sided argument. Equation (9) retains tau in (0,1), the sign of alpha and the signed remainder. No claim is made that these signs and their dependence can be discarded without loss. Nor is this a bound on other alpha residues, a different residual normalization, or an additional lower bound using the common gcd of the evaluated pair. Dividing the existing inequalities by one common factor leaves their comparison unchanged; obtaining a stronger joint congruence certificate after reduction is a separate problem.

## 6. Coefficient clearing versus evaluated cancellation

There is an additional uniform denominator statement, separate from the elementary obstruction in Section 5.

First, delta includes every prime 7<=p<=4L. If p=1 mod8, use n=(p-1)/8 and the pole term 4/(8n+1); if p=5 mod8, use n=(p-5)/8 and -1/(8n+5); if p=3 mod4, use n=(p-3)/4 and -1/(8n+6)=-1/(2p). In each case n<=L, and for p>=7 the other three denominators are p-adic units. Thus v_p(A(n))=-1.

More strongly, suppose Q is primitive as an integer polynomial, deg Q<=2, and let delta_Q be the *minimal coefficient-clearing denominator* of P=trunc_L(QH). Define

    K_L=product {prime p : p>=7, sqrt(8L+6)<p<=4(L-2)}.

Then K_L divides delta_Q. To prove this, take such a p and let j be the first index with v_p(A(j))=-1. The preceding pole argument gives j<=L-2. The condition p^2>8L+6 ensures v_p(A(n))>=-1 for all n<=L; the four original poles cannot coincide modulo p>=7. If every coefficient of P were p-integral, the coefficient at j would force p|u_0. The coefficient at j+1 would then force p|u_1, and the coefficient at j+2 would force p|u_2. Earlier A-indices are p-integral by minimality of j; already-divisible u_i times later A-coefficients remain p-integral. This contradicts primitive Q.

The ordinary prime number theorem Theta(x)~x gives

    log K_L=4L+o(L),
    log(delta_Q)>=4L+o(L).

The PNT is the same one already used in the repository's denominator analyses; its statement is on [Sutherland's slide 3](https://math.mit.edu/~drew/PrimeGapsOberwolfach1.pdf#page=3). No uniform progression theorem is needed. For L=m+2 this coefficient-clearing cost exceeds 16^m asymptotically, since 4>log16.

This does not imply the same bound for the reduced denominator of P(1/16). Evaluation can cancel primes across coefficients. It also does not bound the common gcd of (alpha,beta), whose reduction is precisely part of the remaining opening. Primitive normalization of Q, coefficient-specific clearing, evaluation, and primitive reduction of the evaluated residual pair are distinct operations.

Finally the analytic dependence of the free parameters is exact. If two Padé vectors have the same Q(1/16), their difference Z has Z(1/16)=0. Therefore

    delta*16^L*Delta R(1/16)=-Delta beta.         (11)

Changing beta along a fixed-evaluation fibre changes the signed remainder by exactly the opposite amount. Beta is not a residue parameter that can be prescribed without an analytic cost. This identity alone does not exclude choosing a better centre or obtaining sign control; it identifies what that argument must retain.

## 7. Exact point-evaluation freedom and its height restriction

The parent supplied the following determinant identity; the worker verified the factors and explicit inverse. Put

    a=A(L+1), b=A(L), c=A(L-1),
    H_L=sum_(j=0)^L A(j)/16^j,
    V=256u_0+16u_1+u_2,
    W=16b*u_1+(16c+b)*u_2.

Directly separating the last two terms in the truncated convolution gives

    256*16^L*P(1/16)=16^L*H_L*V-W.              (12)

The determinant of the three rows

    (a,b,c), (256,16,1), (0,16b,16c+b)

is exactly D=256(ac-b^2)>0. Strict positivity follows from the actual positive BBP moment kernel: ac-b^2 is one half of the double integral with integrand

    s^(8(L-1))*t^(8(L-1))*(s^8-t^8)^2*P_A(s)*P_A(t),
    P_A(t)=4-2t^3-t^4-t^5>0 for 0<t<1.

The integrand is positive off the diagonal on a set of positive area. Thus the restricted map from the two-dimensional rational cancellation kernel (3) to (V,P(1/16)) is onto Q^2. The explicit inverse, given V,W, is

    u_0=[-b^2*V+(b-16c)*W]/D,
    u_1=[a(16c+b)*V+(256c-a)*W]/D,
    u_2=[(16a-256b)*W-16ab*V]/D.               (13)

For any rational target r, take V=1 and W=16^L(H_L-r), then clear denominators in (13). The resulting integer vector satisfies P(1/16)/Q(1/16)=r and (3). This shows that existence of coefficients alone does not distinguish good rational approximants: coefficient height, nonzero residual and the remainder budget are the restrictions with mathematical content.

In particular, exact interpolation of r=n/16^m makes J(n)=0. It is therefore **not a valid nonzero-residual witness** for the source argument or for the active digit prescription. This is a separate diagnostic family, not a way to satisfy (6).

There is a numerator-independent cost in this exact interpolation. Write T=16^L H_L in lowest terms with odd denominator q_L. If L>=m and r=n/16^m, then

    W/V=T-n*16^(L-m)

has exactly the same denominator q_L, regardless of the digits of n. Let D_bc=lcm(denominator(b),denominator(c)); it is bounded by (8L+8)^8. For integer Q, D_bc*W is integral. Consequently

    q_L divides D_bc*V,
    |V|>=q_L/D_bc,
    height(Q)>=|V|/273>=q_L/(273*D_bc).          (14)

Here 273=256+16+1, and V is nonzero for an approximant ratio. The existing evaluated-prefix valuation argument in `docs/m4-fourier-windows.md` gives a product of primes p=1 mod4 in (4L+3,8L+1] dividing q_L: such a prime occurs only once among A(0),...,A(L), and the dyadic weights are units at p. The fixed-progression PNT on the same Sutherland slide gives log of this product equal to 2L+o(L). Hence (14) imposes height(Q)>=exp(2L+o(L)).

This lower bound concerns exact interpolation of a radix-denominator rational. It is independent of whether its numerator avoids a word and is not asserted to defeat every possible approximation budget. It does not identify the primitive evaluated denominator for an arbitrary active vector, and it supplies no nonzero-residual theorem. Its role is to expose why unrestricted rational interpolation cannot itself be a visitation mechanism.

## Verification and continuation

Exact standard-library checker: `/tmp/pi-m4-pade-numerator-check-v3.py`, SHA-256 `7d11576cf622945e7182b040b199eab1e2aadaa1c68e508850630e84390ce45d`.

Immutable exact data: `/tmp/pi-m4-pade-numerator-data-v3.json`, SHA-256 `c7685eef1f4dd369603a568a13c1302934093b20dc27d0c63db6a2dde2a1dac6`.

Exit 0: 63 actual Padé prescriptions (m=2,...,64); 54,225 no-F prefix residue cases; 1,875 common-denominator prime cases; 1,560 primitive coefficient-denominator prime cases; 4,368 consecutive-prefix witnesses; 315 exact inverse/interpolation cases. No pi digits were computed or searched. The checker is replayable and verifies existing data rather than overwriting it. Earlier report/checker/data versions remain preserved.

For m=2,4,8,16,32,64, bit-lengths (delta, height(Q), |alpha|, gain) were respectively

    (37,23,67,4), (57,37,101,12), (81,57,145,28),
    (158,92,256,60), (294,159,461,124), (564,293,864,252).

The parent read the full checker and reran it successfully with exit 0, preserving the immutable data. The universal modular-surjectivity proof, analytic remainder estimate, prime valuations and PNT asymptotic are paper arguments, not certified by those finite checks. Source PDF and hashes are in the preceding G-function report; the parent also visually inspected the residual argument on printed pp.11–12; newly inspected source-page images are `/tmp/pi-m4-pade-source-page-11.png` and `-12.png`.

The changed next question is whether the *primitive evaluated* pair and its *signed* remainder admit a digit-sensitive lower bound that exceeds the exact one-sided range in (9), with (11) and all evaluation cancellations included. The present report supplies no such bound. This is an internal reassessment result, not permission to end the authorized M4 milestone.
