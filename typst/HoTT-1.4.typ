#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#let iter = math.sans("iter")
#let rec = math.sans("rec")
#let succ = math.sans("succ")
#let fst = math.sans("fst")
#let snd = math.sans("snd")
#let step = $lambda p. (s(fst p), c_s (fst p, snd p))$

#plain_box(title: "HoTT 1.4")[
  Assuming as given only the _iterator_ for natural numbers

  $ iter : product_(C:cal(U)) C → (C → C) → NN → C $

  with the defining equations

  $
          iter(C, c_0, c_s, 0) & defeq c_0, \
    iter(C, c_0, c_s, succ(n)) & defeq c_s (iter(C, c_0, c_s, n)),
  $

  derive a function having the type of the recursor $rec_NN$. Show that the defining equations of the recursor hold propositionally for this function, using the induction principle for $NN$.
]

#solution(users.ghost)[
  Let $iter : product_(C:cal(U)) C → (C → C) → NN → C$ s.t.

  $
       iter_C (c_0, c_s, 0) & defeq c_0 \
    iter_C (c_0, c_s, s(n)) & defeq c_s (iter(c_0, c_s, n))
  $

  Define $rec : product_(C:cal(U)) C → (NN → C → C) → NN → C$ as

  $ rec_C (c_0, c_s, n) defeq snd (iter_(NN times C)((0, c_0), step, n)) $

  *Lemma.* $rec_C (c_0, c_s, 0) = c_0$

  _Proof._ by reflexivity:
  $
    rec_C (c_0, c_s, 0) & equiv snd (iter_(NN times C)((0, c_0), step, 0)) \
                        & equiv snd (0, c_0) \
                        & equiv c_0
  $
  #h(1fr) #sym.qed

  *Lemma.* $product_(n:NN) fst (iter_(NN times C)((0, c_0), step, n)) = n$

  _Proof._ By induction on $n$.

  (i) $n equiv 0$. by reflexivity:
  $
    fst (iter_(NN times C)((0, c_0), step, 0)) equiv fst (0, c_0) equiv 0
  $

  (ii) $n equiv s(m)$.
  $
    & fst (iter_(NN times C)((0, c_0), step, s(m))) \
    & equiv fst ((step) dot iter_(NN times C)((0, c_0), step, m)) \
    & equiv s(fst (iter_(NN times C)((0, c_0), step, m))) \
    & = s(m) quad "(by I.H.)"
  $
  #h(1fr) #sym.qed

  *Lemma.* $rec_C (c_0, c_s, s(n)) = c_s (n, rec_C (c_0, c_s, n))$

  _Proof._
  $
    rec_C (c_0, c_s, s(n)) & equiv snd (iter_(NN times C)((0, c_0), step, s(n))) \
                           & equiv snd (s(fst p), c_s (fst p, snd p)) \
                           & equiv c_s (fst p, snd p) \
                           & = c_s (n, snd p) \
                           & equiv c_s (n, rec_C (c_0, c_s, n))
  $
  where $p equiv iter_(NN times C)((0, c_0), step, n)$.

  #h(1fr) #sym.qed
]
