// vi: ft=typst

#let title = [CSE16: Mini Project 1]

#set page(numbering: "1", header: align(right, title + " - Jack Nystrom"))
// #set heading(numbering: "1.")

\
\
\

#align(center, text(28pt)[ *#title* ])
#align(center, text(16pt)[ *Jack Nystrom* \ 3/8/2025 \ \ Collaborators: none ])

#pagebreak()

= Abstract

In this mini-project, we will cover the topics of sets, functions, proofs, recurrence
relations, and other miscellaneous areas within the realm of discrete
mathematics through introductions, example problems, and approachable explanations.

#pagebreak()

= Evaluating Sets

*Roster notation* is a way of representing that groups set items inside curly
braces separated by commas. ${1,2,3,4,5}$ is an example of a set in roster
notation. ${2,1,4,3,5}$ is an equivalent set. ${1,2,2,3}$ is equivalent to
${1,2,3}$, because sets cannot contain any item more than once. It is also
equivalent to ${3,1,2}$, because sets are unordered containers.

Set operations, such as union and intersection, are commonly represented using
roster notation. See the following examples and their solutions.

- ${1,2,3} union {2,3,4}$

To get the union of the two sets, we take all items from both sets, remove
duplicates, and create our new set: $underline({1,2,3,4})$

- ${1,2,3} inter {2,3,4}$

To get the intersection of the two sets, we use only the overlapping items from
both sets to create our new set: $underline({2, 3})$

- ${1,2,3} xor {2,3,4}$ (where $A xor B = (A - B) union (B - A)$)

This example uses the XOR operator ($xor$) between two sets. The XOR of two
sets, much like the truth table of XOR in boolean algebra, only yields elements
that are in one or the other set but NOT elements that are in both. XOR for sets
is defined in terms of set differences, so we'll use that to compute the result.
Subtraction returns the first set but with any shared items with the second set
removed:

${1,2,3} - {2,3,4} union {2,3,4} - {1,2,3} eq.triple {1} union {4} eq.triple
  underline({1,4})$

- ${n in NN : n < 10 "and" n "is even"}$

This notation, expressed in English, means "The set of all $n$ in $NN$ such that
$n$ is less than $10$ and $n$ is even." This notation is equivalent to
$underline({2,4,6,8})$

- ${0,1} times {a,b,c}$

For two sets $A$ and $B$, $A times B$ is the *Cartesian product* of $A$ and $B$,
which is equivalent to \ ${(a,b) : a in A "and" b in B}$. In English, this
notation means "the set of all ordered pairs $(a,b)$ such that $a$ is in set $A$
and $b$ is in set $B$." So ${0,1} times {a,b,c} eq.triple
underline({0a,0b,0c,1a,1b,1c})$.

- $display(union.big_(i=0)^3) {n in ZZ : -i < n < i}$

$union.big_(i=0)^n A_i$ is defined as: $x in union.big_(i in I)^n A_i eq.triple
exists i (i in I and x in A_i)$ with $I eq {1,2,...,n}$. (Note that $A$ is a set
of sets; that is, $A_1$, $A_2$, and $A_3$ are all distinct sets with different
items). In other words, for some $x$ to be in $union.big_(i=0)^n A_i$, there
must be an $i in I$ such that $x in A_i$. A better way to interpret that is to
say "$union.big_(i=0)^n A_i$ is the union of all sets in $A$." So lets compute
each roster notation set,\ ${n in ZZ : -i < n < i}$, from $i eq 0$ to $i eq 3$:

#align(center)[
  ${n in ZZ : -0 < n < 0} &eq.triple emptyset &("there is no "n : 0<n<0) \
    {n in ZZ : -1 < n < 1} &eq.triple {-1,0,1} \
    {n in ZZ : -2 < n < 2} &eq.triple {-2,-1,0,1,2} \
    {n in ZZ : -3 < n < 3} &eq.triple {-3,-2,-1,0,1,2,3}$
]

Now all we have to do is take the union of these sets, which is $underline({-3,-2,-1,0,1,2,3})$.

- $P(P(emptyset))$

For a set $A$, $P(A)$ is the *power set* of A, which is the set of all possible
subsets of $A$. For example, $P({1,2,3}) eq {emptyset, {1}, {2}, {3}, {1,2},
{2,3}, {1,3}, {1,2,3}}$.

For $emptyset$, there is only one possible subset, which is $emptyset$ itself;
therefor $P(emptyset) eq {emptyset}$. However, there are two different possible
subsets of ${emptyset}$, which are ${emptyset}$ and $emptyset$. Therefore
$P(P(emptyset)) eq underline({emptyset, {emptyset}})$.

= Set Definitions

An important takeaway is that sets are fundamentally defined by what their elements are.
Notice, for example, how we defined $union.big_(i=0)^n A_i$ in the above
examples; we use "$x in ...$" to explain what we know about the items contained
within the set. Here, we provide some set definition equivalencies to
illustrate this point:

- $x in X union Y eq.triple x in X or x in Y$

- $x in X - (Y inter Z) eq.triple x in X and not (x in Y and x in Z) eq.triple x
    in X and x in.not Y or x in.not Z$

- $X union Y subset.eq Z eq.triple x in X union Y -> x in Z eq.triple (x in X or
      x in Y) -> x in Z$

= Proofs about Sets

The following are two set identities that are particularly important and useful
for proving facts and relationships about sets. For each identity, I will
illustrate how it might be used inside of a proof.

=== 1. Given sets $A$ and $B$, their _difference_ $A - B$ is equivalent to $A inter overline(B)$.

This identity is a core component to solving any proof that involves set
differences, as the vast majority of other set identities use only the most
low-level / basic set notations and so differences must be broken down into
those components.

One very important thing to remember when using this identity with more
complex sets, such as $overline(X) - (Y union overline(Z))$, is to apply De
Morgan's law correctly. In the aformentioned example, take attention to which
expressions are considered $A$ and $B$:

#align(center)[
  $underbracket((overline(X)), A) - underbracket((Y union overline(Z)), B)$
]

So, $overline(X) - (Y union overline(Z)) eq.triple overline(X) -
overline((Y union overline(Z))) eq.triple overline(X) union (overline(Y) inter
Z)$.

\

Before we look at the next proof, it is important to understand subset notation.
For two sets $A$ and $B$, $A subset.eq B$ means that $A$ is a subset of or
exactly equal to $B$ (Note that $A subset B$ is called a _strict subset,_ which
excludes the case where $A eq.triple B$). The easiest way to understand this is
with a ven diagram, where instead of partially overlapping, $A$ is completely
inside of $B$. However, it is also important to have the formal definition as
well: $A subset.eq B eq.triple forall x (x in A -> x in B)$. In english, this
says, "'$A$ is a subset of $B$' means that for all $x$, if $x$ is in $A$, then $x
$ is in $B$."

=== 2. If $x in A$ and $A subset.eq B$, then $x in B$. ("Modes Ponens" for subsets)

This identity is often used when proving subset relationships. For example:
"Given arbitrary sets $A, B, "and" C$ such that $A subset.eq B$ and $B subset.eq
C$, prove that $A subset.eq C$." In order to complete this proof, one needs to
examine an arbitrary element in $A$ and prove that it is also in $C$. To do this
requires making use of "modes ponens for subsets," just as you would use modes
ponens to prove \ "given $a->b "and" b->c "then" a->c$."

One thing to keep in mind when using this identity is that $A subset B$ implies $A
subset.eq B$, but this may need to be explicitly shown (in a dedicated step).

\

Now, let's take a look at two different set proofs and see how they utilize set
identities:

_Thm._ For sets $A$ and $B$, $A inter overline(A inter B) eq A inter
overline(B)$ \
_Pf._ \ #box(inset: (x: 2em))[
  $
    &A inter overline(A inter B) && "Given"\
  eq.triple& A inter (overline(A) union overline(B)) && "De Morgan's Law"\
  eq.triple& (A inter overline(A)) union (A inter overline(B)) && "Distributive Property"\
  eq.triple& emptyset union (A inter overline(B)) && "Compelement Law"\
  eq.triple& A inter overline(B) &qed #h(5em)& "Identity Law"\
  $
]

This first proof uses just the basic, fundamental set identities to manipulate
one expression into another in order to prove a new set identity.

Now, we will take a look at a proof relating to subsets:

_Thm._ Suppose $A$, $B$, $C$ and $D$ are sets such that $A subset.eq B inter
C$ and $B union C subset.eq D$. Then $A subset.eq D$ \
_Pf._ \ #box(inset: (x: 2em))[
  Let $x in A$ be arbitrary. Goal: $x in D$. \
  Since $x in A$ and $A subset.eq B inter C$, we have that $x in B inter C$. \
  Since $x in B inter C$ and $B inter C subset.eq D$, we have that $x in D$. \
  Therefore, since $x$ is arbitrary in $A$, we have that $A subset.eq D$. $qed$
]

In this proof, we used our knowledge about identities and the given subset
relationships to prove a new subset relationship between two of the sets. Now,
we'll introduce the concept of defining entirely new sets using the established
identities.

One such set that we'll define using the set identities we already know about is
the _implication set,_ $X => Y$. It is defined by the identity $X => Y eq.triple
overline(X) union Y$. It is important to note that "$=>$" is *NOT* a
proposition as we're used to, but rather a completely new set.

See the following example of evaluating an implication set: \
#box(inset: (x: 2em))[
  Let the Universe set $U = {1,2,3,4,5}$. Let $X = {1,2}$ and let $Y =
  {2,3,4}$. \
  $X => Y eq.triple overline(X) union Y eq.triple (U - X) union Y eq.triple {3,4,5}
  union {2,3,4} eq.triple {3,4}$.
]

The below is a proof that utilizes the identity of the implication set:

_Thm._ $x in (X => Y)$ is equivalent to $x in X -> x in Y$. \
_Pf._ \ #box(inset: (x: 2em))[
  Let $x in (X => Y)$ be arbitrary. \
  Since $X => Y equiv overline(X) union Y$, we have that $x in overline(X) union Y$. \
  $x in overline(X) union Y equiv x in overline(X) or x in Y equiv not (x in X)
  or x in Y$, using fundamental set identities.\
  Using the conditional identity, $not (x in X) or x in Y equiv x in X -> x in
  Y$. $qed$\
]

#pagebreak()

_Thm._ For all sets $A$, $B$, and $C$, $A subset.eq (B => C)$ if and only if $A
inter B subset.eq C$. \
_Pf._ \ #box(inset: (x: 2em))[
  Using the conditional identity, $A subset.eq (B => C) <--> A inter B subset.eq C$ \
  #h(1em) $equiv (A subset.eq (B => C) -> A inter B subset.eq C) and (A
  inter B subset.eq C -> A subset.eq (B => C))$. \
  We will prove that both directions of the conditional are true. \
]
#table(
  columns: (1fr, 1fr),
  inset: 4pt,
  table.header(
    [$A subset.eq (B => C) -> A inter B subset.eq C$],
    [$A inter B subset.eq C -> A subset.eq (B => C)$],
  ),

  [
    Assume $A subset.eq (B => C)$. Goal: $A inter B subset.eq C$ \
    Let $x in A inter B$ be arbitrary. So $x in A and x in B$. \
    Since $A subset.eq (B => C)$, we know $x in B => C$ \
    #h(1em) $equiv x in overline(B) union C$. \
    Since $x in B$, we know that $x in C$. \
    Therefore, $A inter B subset.eq C$.
  ],
  [
    Assume $A inter B subset.eq C$. Goal: $A subset.eq (B => C)$ \
    #h(1em) $equiv A subset.eq overline(B) union C$. \
    Let $x in A$ be arbitrary. \
    Case: $x in B$: \
    #box(inset: (x: 1em))[
      Then $x in A inter B$. \
      Since $A inter B subset.eq C, x in C equiv x in overline(B) union C$.
    ] \
    Case: $x in.not B$: \
    #box(inset: (x: 1em))[
      $x in.not B equiv x in overline(B) equiv x in overline(B) union C$.
    ] \
    Since $x in overline(B) union C$, $A subset.eq overline(B) union C equiv A
      subset.eq B => C$.
  ],
)
#box(inset: (x: 2em))[$qed$]

= Functions and Properties

A function is an object that maps elements from one set to another set; namely,
from its _domain_ to its _target._ The syntax $f : X -> Y$ states that $f$ is a
function that maps elements from the set $X$ to elements from the set $Y$, and
implies that $f$ is a subset of $X times Y$.

Surjective functions are functions whose range is equivalent to the target set.
That is, every element in the target set is pointed to by at least one element
in the domain. Another way of writing this is that for a function $f : X -> Y$,
range$(f) = Y$. The phrase "onto" is often used to describe surjective
functions.

Injective functions are functions for which no elements in the target set are
pointed to more than once. In other words, distinct elements in the domain are
mapped to distinct elements in the target set. The phrase "one-to-one" is often
used to describe injective functions.

Functions can be injective, surjective, both, or neither. A function that is
both injective and surjective is bijective, also called a bijection.

#align(
  center,
  figure(
    image("injective-surjective.png", width: 40%),
    caption: "Comparison of injective and surjective functions",
  ),
)

As an example of injectivity and surjectivity, consider a function $f : X -> X$
which is defined by the rule $f(x) = 1 - (1-x)^2$, where $X = {0,1,2}$. The
following is a table of all the input-output combinations of $f$:

#align(
  center,
  table(
    rows: 2,
    columns: 4,
    inset: 8pt,
    [$x$], [$0$], [$1$], [$2$],
    [$f(x)$], [$0$], [$1$], [$0$],
  ),
)

Is $f$ surjective? No, since range$(f) = {0,1}$, which is missing the $2$ from $X$.

Is $f$ injective? No, as both $f(0)$ and $f(2)$ result in $0$ (more than one
input points to the same output).

An interesting fact about $f$ is that $f compose f = f$. \ _Pf:_

#box(inset: (x: 2em))[
  $(f compose f)(x) = f(f(x)) = 1 - (1-(1 - (1-x)^2))^2 = 1 - (1 - x)^4$, which
  yeilds the same results for all elements in the input domain. Using this to
  add $f compose f$ the table clearly illustrates that fact:
]
#align(
  center,
  table(
    rows: 3,
    columns: 4,
    inset: 8pt,
    [$x$], [$0$], [$1$], [$2$],
    [$f(x)$], [$0$], [$1$], [$0$],
    [$f compose f(x)$], [$0$], [$1$], [$0$],
  ),
)

Note that even though $f$ is neither injective nor surjective, the property
$f compose f = f$ still holds!

= Recurrence Relations

When working with sequences, it is often most convenient to define a sequence
(such as ${a_n}$) using a *recurrence relation*. A recurrence relations is a
rule that defines a term of a sequence using previous terms of that same
sequence. For example, in a simple arithmetic sequence (${1,3,5,7,...}$), each
term is equal to the previous term $+2$. This is best expressed as a recurrence
relation, where $a_0 = 1$ and $a_n = a_n-1 + 2$.

Define the sequence ${a_n}$ by

#align(center)[
  $a_0 &= 0 \
   a_n &= 3a_(n-1) + 4n-2 & #h(3em) "for" n >= 1$
]
The first few values are given in the following table:
#align(
  center,
  table(
    rows: 2,
    columns: 5,
    inset: 8pt,
    [$n$], [$0$], [$1$], [$2$], [$3$],
    [$a_n$], [$0$], [$2$], [$16$], [$58$],
  ),
)

= Ceilings and Floors

The functions $ceil(x)$ and $floor(x)$, called ceiling and floor,
simply round decimal numbers up or down respectively. For example: $ceil(5.4) =
6$, $floor(3.2) = 3$, and $floor(-3.2) = -4$.

#pagebreak()

_Thm._ For all $n in ZZ$, $floor(n/2) ceil(n/2) = floor(n^2/4)$. \
_Pf._ \ #box(inset: (x: 2em))[
  Let $n in ZZ$ be arbitrary. \
  Case $n$ is even: \
    #box(inset: (x: 2em))[
      $n = 2k$ for some integer $k$. Also, $k = n/2$. \
      Substituting $n=2k$ into the expression $floor(n/2) ceil(n/2)$, we get
      $floor((2k)/2) ceil((2k)/2) = floor(k) ceil(k)$. \
      Since $k$ is an integer, $floor(k) ceil(k) = k*k = k^2$. \
      Substituting in our expression for $k$, we get $n^2/4$. \
      Since n is even, $n^2/4$ is an integer, and thus $floor(n/2) ceil(n/2) =
      n^2/4 = floor(n^2/4)$.
    ] \
  Case $n$ is odd: \
    #box(inset: (x: 2em))[
      $n = 2k + 1$ for some integer $k$. Also, $k = (n-1)/2$. \
      Substituting $n=2k+1$ into the expression $floor(n/2) ceil(n/2)$, we get
      $floor((2k+1)/2) ceil((2k+1)/2)$. \
      Since $k$ is an integer, $floor(k+1/2) ceil(k+1/2) = (k)(k+1).$ \
      Substituting in our expression for $k$, we get $((n-1)/2)((n-1)/2 +
      2/2) = ((n-1)(n+1))/4 = (n^2 -1)/4$. Since $n=2k+1$, $(n^2 -1)/4$ is
      an integer, and thus $floor(n/2) ceil(n/2) = floor(n^2/4)$. \
    ] \
  $qed$
]

= Assorted Problems

In this section, we will go over five miscellaneous "assorted problems" in the
areas covered so far in this mini-project.

1. *Q:* Is ${1,2}$ equal to ${2,1,2,2,2,1}$?

*A:* Yes. Since unordered sets don't contain duplicates, the second set
is equivalent to the first one. If the two sets were series instead, which are
ordered containers, they would not be equal, because in that case the order of
elements and quantity of identical elements would make them unique.

2. *Q:* Is $emptyset$ equal to ${emptyset}$?

*A:* No. The former is the set with no elements, whereas the latter is the set
with one element, which is itself the set with no elements. The latter is a
nested set!

3. *Q:* Is $P(A union B)$ equal to $P(A) union P(B)$ for all sets $A$ and $B$?

*A:* No. The power set (the set of all subsets) of $A union B$ can contain far
more subsets than $P(A)$ and $P(B)$ can combined, because the cardinality of the
power set is exponential relative to the cardinality of the input set. So if
$|X| = |Y| + 1$, then $|P(X)| = 2*|P(Y)|$.

4. *Q:* Is it true that if $f : X -> Y$ is an injective function, then it cannot be surjective?

*A:* No. A function from $X$ to $Y$ that is both injective and surjective is
called a bijection! Functions of this type are both common and very useful.

5. *Q:* If $f : X -> Y$ and $g : Y -> Z$ are functions such that $g compose f$
  is surjective, is it true that $g$ is surjective?

*A:* Yes. If $g compose f$ is surjective, then for every $z in Z$, there exists
some $x in X$ such that $g(f(x)) = z$. This means the range of $g$ must include
every element of $Z$, which is exactly the definition of $g$ being surjective.

#pagebreak()

Multiple Choice Questions:

- *Q:* Select the infinite set: \
  a) $emptyset$, \
  b) ${x in NN : x < 100}$, \
  c) ${x in NN : x > 100}$, \
  d) $x in ZZ : x^2 < 100$ \

*A:* $c$. ${x in NN : x > 100}$ includes every natural number ($0,1,2,...$)
greater than 100, which is an infinite set.

- *Q:* Let $A = {{1,2},3,{4,5,6,7}}$. Select the correct value of $|A|$.
  a) 1 \
  b) 3 \
  c) 6 \
  d) 7

*A:* $b$. The three elements in $A$ are ${1,2}$, $3$, and ${4,5,6,7}$.

- *Q:* A donut shop sells boxes of 12 donuts. If they made $n$ donuts, how many
  complete boxes can they make? \
  a) $floor(12n)$ \
  b) $ceil(12n)$ \
  c) $floor(n/12)$ \
  d) $ceil(n/12)$

*A:* $c$. The shop can make one 12th the number of boxes as donuts (since 12
donuts go in a box), rounded down, because they can't sell partially filled
boxes.

- *Q:* Let $f : {0,1}^4 -> {0,1}^4$ be the function where $f(x)$ is the result
  of taking the second bit from $x$ and moving it to the end of the string.
  Select the correct description of $f$. \
  a) Injective, Surjective \
  b) Not Injective, Surjective \
  c) Injective, Not Surjective \
  d) Not Injective, Not Surjective \

*A:* a. Since every distinct input produces a distinct output, $f$ is injective.
Since every combination of four bits is a possible output, $f$ is surjective.

#pagebreak()

= Reflections

I approached the second midterm with a similar strategy as the first; utilizing
knowledge gained through Zybooks activities and homework assignments to ensure I
knew the main topics before going in. I've never been much of a
study-last-second person, and I feel a lot better if I always make sure I know
the week's content as it's being taught, which I achieved through Zybooks. If I
could do anything differently/better, it would be to review the more complex set
identities beyond what was provided on the midterm equation sheet. A refresher
on, for example, the definition of the subset, would have helped.

This mini-project taught me about expressing myself and my though process and
reminded me that sometimes the best way to learn and solve a problem is to
simply _start writing down my thought process_. I also took the opportunity to
learn a typesetting system (Typst!), which I've enjoyed learning quite a bit.

Discrete Math is a challenging area of study, and it can often be very difficult
to see and understand the applications of the work while in the midst of
practicing it. However, the reality is that the problems tackled by this area of
Math are present in countless aspects of everyday life, most especially in
technology, which would not be possible without it.
