#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#let rec = math.sans("rec")
#let ind = math.sans("ind")
#let inl = math.sans("inl")
#let inr = math.sans("inr")
#let two = math.bold("2")

#plain_box(title: "HoTT 1.5")[
  Show that if we define $A + B defeq sum_((x:two)) rec_two (cal(U), A, B, x)$, then we can give a definition of $ind_(A+B)$ for which the definitional equalities stated in #(sym.section)1.7 hold.
]

#plain_box[
  $
    ind_(A+B) : product_((C:(A+B) → cal(U))) (product_((a:A)) C(inl(a))) → (product_((b:B)) C(inr(b))) → product_((x:A+B)) C(x).
  $
]

#solution(users.ghost)[
  Let $A +' B defeq sum_((x:two)) rec_two (cal(U), A, B, x) equiv (x : two, y : rec_two (cal(U), A, B, x))$. Then it has only two types of elements: $(0_two, a)$ for $a : A$ and $(1_two, b)$ for $b : B$.

  We can identify(?) $(0_two, a)$ and $inl(a)$, $(1_two, b)$ and $inr(b)$. Then definition becomes:

  $
    ind_(A +' B) : product_(C:(A +' B) → cal(U)) ((product_(a:A) C((0_two, a))) → product_(b:B) C((1_two, b))) → product_(x:A +' B) C(x)
  $
  $
    ind_(A +' B)(C, g_0, g_1, (0_two, a)) & defeq g_0 (a) \
    ind_(A +' B)(C, g_0, g_1, (1_two, b)) & defeq g_1 (b)
  $

  Since below holds, we can say definitional equalities hold.

  $
    ind_(A +' B)(C, g_0, g_1, (0_two, a)) & := rec_two (cal(U), g_0, g_1, 0_two)(a) equiv g_0 (a) \
    ind_(A +' B)(C, g_0, g_1, (1_two, b)) & := rec_two (cal(U), g_0, g_1, 1_two)(b) equiv g_1 (b)
  $

  #h(1fr) #sym.qed
]
