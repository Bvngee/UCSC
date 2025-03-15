// vi: ft=typst

#let title = [CSE16: Homework 9B]

#set page(numbering: "1", header: align(right, title + " - Jack Nystrom"))
// #set heading(numbering: "1.")

\
\
\

#align(center, text(20pt)[ #title ])
#align(center, text(14pt)[ Jack Nystrom \ 3/14/2025])

+ #set enum(numbering: "a)")
  + $10^8 = 100,000,000$
  + $(10^7)(1^1) = 10,000,000$ \
  + $|{0, 2, 4, 6, 8}| = 5$, so $(10^6)(5^2) = 25,000,000$
  + $|{0, 2, 4, 6, 8}| = 5$ and $|{1, 3, 5, 7, 9}| = 5$, \
    so only odd OR only even ending in $0$ is $(5^8) + (5^7)(1^1) = 468,750$
  + There is a bijection between the set of length-8 strings which are
    palindromes and the set of length-4 strings. Thus, the number of palindromes
    $= 10^4 = 10,000$
  + We'll count the number of strings that start with an even digit and the
    number of strings that end with two even digits, and then subtract the
    number of strings for which both are true: \
    $(5^1*10^7) + (10^6*5^2) - (10^5*5^2*5^1) = 62,500,000$
  + We'll count the total number of length-8 strings minus the number of strings
    that start with 000: \
    $(10^8) - (1^3*10^5) = 99,900,000$
  + The number of ways to place three 0s in a length-8 string is $mat(8;3)$. The
    number of ways to choose from the remaining five non-zero digits is $9^5$.
    Thus the number of length-8 strings with exactly three 0s is $mat(8;3)(9^5)
    = 8!/(5!3!) 9^5 = 56*9^5 = 3,306,744$
  + The number of length-8 strings with three 0s, two 1s, and three 2s is
    equivalent to $mat(8;3)mat(5;2)mat(3;3) = 8!/(5!3!) 5!/(3!2!) 3!/(3!0!) =
    560$.
  + $10 P 8 = 10!/2! = 1,814,400$.
  + The number of ways to select four distinct even digits is $5*4*3*2$. The
    remaining four digits can be anything from 0-9, so $10^4$. Thus $10^4 *
    5*4*3*2 = 1,200,000$
  + We have to evaluate the number of possible combinations with n distinct even
    integers for each case in $0 <= n <= 5$. First, we pick n even digits from
    the 5 available, then we pick n locations from the set of 8 spaces, then we
    fill the remaining $(8-n)$ digits with odd digits. Thus the
    total number of length-8 strings with no even digits that appear more than
    once is $sum_(n=0)^5 mat(5;n)mat(8;n)5^(8-n) = sum_(n=0)^5 5!/((5-n)!n!)
    8!/((8-n)!n!) 5^(8-n) = 9,866,375$.
  + We will count a) the number of all length-8 strings with no digits that appear more
    than once and that contain both 1 and 0, and subtract b) the number of length-8
    strings with no digits that appear more than once and where both 1 and 0
    appear adjacent to each other: \
    a) (\# of ways to place 1 and 0 into 8 digits)(\# of ways to fill the
    remaining 6 digits with unique numbers all $>=2$) $= mat(8;2)(8 P 6) = 28*8!/2!
    = 564,480$. \
    b) (\# of ways to place the digits 1,0 and the digits 0,1 adjacently into a
    length-8 string)(\# of ways to fill the remaining 6 digits with unique
    numbers all $>=2$) $= (7 + 7)(8 P 6) = 14*8!/2! = 282240$. \
    Final answer: $564480 - 282240 = 282,240$.
  + There is a bijection between the number of ways to pick 8 digits from 0-9
    and the number of ways to arrange 8 digits from 0-9 in increasing order. In
    other words, once 8 digits are picked, there is only one way to arrange them
    in increasing order. So $mat(10;8) = 10!/(2!8!) = 5*9 = 45$.
  + This is equivalent to the number of ways to distribute 8 identical ojects
    (the spaces in our length-8 string) into 10 distrinct bins (the integers
    from 0-9). Every possible combination has a nondecreasing arrangement. So,
    $mat(n + k - 1; n) = mat(17;8) = 17!/(9!8!) = 24,310$.

+ #set enum(numbering: "a)")
  + $|P({0,1,2,3,4,5,6,7,8,9})| = 2^10 = 1024$
  + $|P({0,1,2,3,4,5,6,7,8,9})| - |P({1,2,3,4,5,6,7,8,9})| = 2^10 - 2^9 = 2^9 = 512$
  + $|P({0,1,2,3,4,5,6,7,8,9})| - |P({2,3,4,5,6,7,8,9})| = 2^10 - 2^8 = 3*2^8 = 768$
  + $|P({0,2,4,6,8})| = 2^5 = 32$
  + Using the inclusion-exclusion principle for three sets:
    $|P({1,2,3,4,5,6,7,8,9})| + |P({0,2,3,4,5,6,7,8,9})| + |P({0,1,3,4,5,6,7,8,9})| \
    - |P({2,3,4,5,6,7,8,9})| - |P({0,3,4,5,6,7,8,9})| - |P({1,3,4,5,6,7,8,9})| \
    + |P({3,4,5,6,7,8,9})| = 3*2^9 - 3*2^8 + 1*2^7 = 896$
  + $mat(10;5) = 10!/((10-5)!5!) = 252$
  + $mat(9;4) = 9!/((9-4)!4!) = 126$
  + We will find the number of subsets of cardinality 5 and subtract the number
    of subsets of cardinality 5 that contain ${0,1}$ as a subset:
    $mat(10;5) - mat(8;3) = 252 - 8!/(5!3!) = 252 - 56 = 196$
  + There's 5 even and 5 odd numbers to choose from. So, $mat(5;3)mat(5;2) =
    5!/(2!3!) 5!/(3!2!) = 10*10 = 100$.

+ #set enum(numbering: "a)")
  + n indistinguishable balls in m distinguishable bins $=> mat(n + m - 1; m -
    1)$. So, \
    $mat(20 + 4 - 1; 4 - 1) = mat(23;3) = 23!/(20!3!) = 1,771$
  + Start by placing 3 balls in bin 1. We have $20 - 3 = 17$ left to
    distribute however we want. So, $mat(17 + 4 - 1; 4 - 1) = mat(20; 3) =
    20!/(17!3!) = 1140$.
  + The number of solutions that have $x_1 <= 10$ is equivalent to the total
    number of solutions minus the number of solutions that have $x_1 >= 11$. So,
    using our answer for a) and the same method as in b),
    $1771 - mat(9 + 4 - 1; 4 - 1) = 1771 - mat(12; 3) = 1771 - 12!/(9!3!) = 1771
    - 220 = 1551$.
  + Equivalent to the number of solutions that have $x_1 >= 3$ minus the number
    of solutions that have $x_1 > 10$. So, $1140 - 220 = 920$.
  + Equivalent to the number of solutions minus the number of solutions that
    have $x_1 >= 11$ minus the number of solutions that have $x_2 >= 6$ plus
    thus number of solutions for which both are true. So, using the same logic
    as in b) (with 9 balls left to distribute, then 14, then 3), \
    $1771 - mat(9 + 4 - 1; 4 - 1) - mat(14 + 4 - 1; 4 - 1) + mat(3 + 4 - 1; 4 -
    1) = 1771 - 12!/(9!3!) - 17!/(14!3!) + 6!/(3!3!) = 891$.
  + If $x_1 + x_2 = 10$, then $x_3 + x_4 = 10$ too. So, the total number of
    solutions that have $x_1 + x_2 = 10$ is the same as $($10 indistinguishable
    balls into 2 distinguishable bins$)^2 = mat(10 + 2 - 1; 2 - 1)^2 =
    (11!/(10!1!))^2 = 11^2 = 121$
  + None: there are more than $4*3=12$ balls to distribute, so at least one bin
    must have $>3$ balls.
  + Equivalent to the total number of solutions minus the number of solutions
    where $x_1 + x_2 >= 11$. The number of ways to distribute 11
    indistinguishable balls into 2 distinguishable bins is
    $mat(11 + 2 - 1; 2 - 1) = 12!/(11!1!) = 12$. The number of ways to
    distribute the remaining 9 balls however we want into the four bins is
    $mat(9 + 4 - 1; 4 - 1) = 12!/(9!3!) = 220$. So, $1771 - 12*220$ = -869
    (Unfortunately Im getting a negative number here? Not sure why.)

+ #set enum(numbering: "a)")
  + Equivalent to 12 indistinguishable balls in 10 distinguishable bins: \
    $mat(12 + 10 - 1; 10 - 1) = 21!/(12!9!) = 293,930$.
  + At most one indistinguishable ball per distinguishable bin $=> mat(10; 6) =
    10!/(4!6!) = 210$.
  + This question is illegible, I cannot understand what it's asking.
  + (4 indistinguishable balls into 10 bins)(8 indistinguishable balls into 10
    bins) $= mat(4 + 10 - 1; 10 - 1)mat(8 + 10 - 1; 10 - 1) = 13!/(4!9!)
    17!/(8!9!) = 17,381,650$.
  + (10 choose 4)(8 indistinguishable balls into 10 bins)
    $= mat(10; 4)mat(8 + 10 - 1; 10 - 1) = 10!/(6!4!) 17!/(8!9!) = 5,105,100$.
  + There are six possible outcomes for each plant: $|{0,2,2}| * 2 = 6$. Since
    there are 10 plants. the total possible ways to fertilize them is $6^10 =
    60,466,176$.

\

Questions I wasn't able to get correct: 1l, 1m, 3h (and 4c was illegible).
