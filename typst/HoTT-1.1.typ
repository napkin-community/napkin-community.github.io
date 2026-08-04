#import "lib/napkin.typ": *
#import "lib/napkin-users.typ": *

#plain_box(title: "HoTT 1.1")[
  Given functions $f : A → B$ and $g : B → C$, define their #glossary[composite] $g ∘ f : A → C$. Show that we have $h ∘ (g ∘ f) equiv (h ∘ g) ∘ f$.
]

#solution(users.ghost)[
  To define something of type $A → C$, we use the introduction rule for functions.

  $ (g ∘ f)(x) defeq g(f(x)) $

  We will check the _judgemental_ equality $h ∘ (g ∘ f) equiv (h ∘ g) ∘ f$. This comes from the following chain of judgemental equalities:

  $
    h ∘ (g ∘ f) & equiv lambda x. ((h ∘ g) ∘ f)(x) \
                & equiv lambda x. (h ∘ g)(f(x)) \
                & equiv lambda x. h(g(f(x))) \
                & equiv lambda x. h((g ∘ f)(x)) \
                & equiv lambda x. (h ∘ (g ∘ f))(x) \
                & equiv h ∘ (g ∘ f)
  $

  The first and last equalities are the _uniqueness principle for function types_. The other equalities come from the definition of $∘$ substituted in the lambda expression $lambda x. minus$. #h(1fr) #sym.qed
]
