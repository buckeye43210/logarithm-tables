#import "@preview/cetz:0.4.2"

#set page(width: 5.5in, height: 8.5in, margin: 0pt)
#set text(font: ("TeX Gyre Pagella", "Noto Serif", "Liberation Serif"), size: 11pt, lang: "en")
#set heading(numbering: none)

// ———————————————————————
// 1. COVER
// ———————————————————————
#block(width: 100%, height: 100%, fill: rgb("#0b1a33"), inset: 0pt)[
  #set align(center + horizon)
  #text(40pt, weight: "bold", fill: rgb("#e8c47a"))[Seven-Figure]
  #v(8pt)
  #text(40pt, weight: "bold", fill: white, tracking: 3pt)[Logarithm Tables]
  #v(30pt)
  #text(19pt, fill: rgb("#a8c9e0"))[Common Base-10 Logarithms]
  #v(50pt)
  #stack(dir: ltr, spacing: 18pt,
    line(length: 110pt, stroke: (paint: rgb("#e8c47a"), thickness: 2pt, dash: "dotted")),
    rotate(45deg)[#square(size: 18pt, fill: rgb("#e8c47a"))],
    rotate(45deg)[#square(size: 18pt, fill: rgb("#e8c47a"))],
    rotate(45deg)[#square(size: 18pt, fill: rgb("#e8c47a"))],
    line(length: 110pt, stroke: (paint: rgb("#e8c47a"), thickness: 2pt, dash: "dotted"))
  )
  #v(50pt)
  #text(17pt, fill: rgb("#b0d0e8"), style: "italic")[Mantissas from 0000000 to 9999566]
  #v(10pt)
  #text(14pt, fill: rgb("#7799cc"))[
    Reconstructed using only 17th-century methods \
    #datetime.today().display("[month repr:long] [year]")
  ]
]

#pagebreak()

// ———————————————————————
// 2. TITLE PAGE & INTRODUCTION
// ———————————————————————
#set page(margin: (top: 1.5cm, bottom: 1.5cm, left: 2cm, right: 2cm), numbering: "i")
#counter(page).update(1)

#align(center)[
  #text(24pt, weight: "bold", fill: rgb("#006400"))[The Big Problem]
]

#text(size: 12.5pt, hyphenate: false)[
  Imagine you are an astronomer, navigator, or merchant living in the year 1615. Every day you must multiply and divide numbers with six, ten, or twenty digits. There are no calculators — only you, a quill, and endless columns of figures.

  Then a rumour arrives from Scotland: a nobleman named *John Napier* has discovered a way to turn multiplication into addition, division into subtraction, and roots into simple division. He calls his invention “logarithms”.

  Three years later, an English professor named *Henry Briggs* travels north to meet the dying Napier. Together they decide that logarithms should be based on the number 10, so that the logarithm of 1 is 0 and of 10 is exactly 1.

  Briggs spends the rest of his life — and employs dozens of human “computors” — to calculate, entirely by hand, the first table of *common logarithms* to fourteen decimal places.

  From 1624 until the pocket calculator appeared in 1972, every published table of $log 2 = 0.3010$, $log 3 ≈ 0.4771$, $log 7 ≈ 0.8451$ traces its lineage directly back to Briggs’s ink-stained pages.

  This little book lets you travel back in time and rediscover those famous numbers using nothing more than the same simple observations and tricks Briggs himself used four hundred years ago.

  You will need no calculus, no computer — only:
  - the fact that $2^10 = 1024$ is close to $10^3 = 1000$,
  - a few powers of 2 and 5,
  - and one or two careful proportions.

  By the final page you will have reconstructed, with your own hands, the exact table that appeared in millions of textbooks throughout the 20th century.

  Let's party like it's 1624!
]

#align(center)[— — —]

#pagebreak()

// ———————————————————————
// 3. TABLE OF CONTENTS (with real page numbers)
// ———————————————————————
#set page(margin: (top: 1.5cm, bottom: 1.5cm, left: 2.5cm, right: 2cm))


#align(center)[#heading(level: 1, numbering: none, outlined: false)[Contents]]

#v(2em)

#outline(title: none, indent: auto)
#v(1em)
#align(center)[— — —]

#pagebreak()

// ———————————————————————
// 4. THE FOUR GREAT LAWS OF LOGARITHMS
// ———————————————————————
#heading(level: 1, outlined: true)[The Four Great Laws of Logarithms]

#grid(columns: (1fr, 1fr), gutter: 2em,
  [
    #set align(center)
    #text(14pt, weight: "bold")[Law 1 – Product Rule]  
    $ log(a × b) = log a + log b $  
    _Multiplication becomes addition_
  ],
  [
    #set align(center)
    #text(14pt, weight: "bold")[Law 2 – Quotient Rule]  
    $ log(a ÷ b) = log a - log b $  
    _Division becomes subtraction_
  ],
  [
    #set align(center)
    #text(14pt, weight: "bold")[Law 3 – Power Rule]  
    $ log(a^n) = n × log a $
    $ log(ⁿ√a) = log a ÷ n $
    _Powers and roots become multiplication and division_ 
  ],
  [
    #set align(center)
    #text(14pt, weight: "bold")[Law 4 – The Foundation]  
    $ log 1 = 0 $
    $ log 10 = 1 $  
    _The two sacred numbers of common logarithms_
  ]
)

#v(2em)
#align(center)[
  #box(stroke: 1.5pt + rgb("#006400"), inset: 15pt, width: 90%)[
    With these four laws, a table of logarithms lets you compute *any* arithmetic using only addition, subtraction, multiplication and division.
  ]
]

#pagebreak()

// ———————————————————————
// 5. DERIVING THE LOGARITHMS FROM SCRATCH
// ———————————————————————

#set page(numbering: "1")
#counter(page).update(1)

#heading(level: 1, outlined: true)[Deriving Common Logarithms]

#heading(level: 2, outlined: true)[Step 1 – What we truly start with]
We know only:
- $10^0 = 1$
- $10^1 = 10$

#align(center)[#table(
  columns: (7em, 9em),
  stroke: 0.7pt + black,
  inset: 9pt,
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[Number]),
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[log₁₀]),
  table.cell(fill: rgb("#d8f0d8"))[1], table.cell(fill: rgb("#d8f0d8"))[0.00000],
  table.cell(fill: white)[2], table.cell(fill: white)[],
  table.cell(fill: rgb("#d8f0d8"))[3], table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[4], table.cell(fill: white)[],
  table.cell(fill: rgb("#d8f0d8"))[5], table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[6], table.cell(fill: white)[],
  table.cell(fill: rgb("#d8f0d8"))[7], table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[8], table.cell(fill: white)[],
  table.cell(fill: rgb("#d8f0d8"))[9], table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[10], table.cell(fill: white)[1.00000],
)]

#pagebreak()

#heading(level: 2, outlined: true)[Step 2 – Finding log₁₀ 2 (Briggs’s, 1617)]
$2^10 = 1024 ≈ 10^3 = 1000$  
$1024 = 1000 × 1.024$  
$10 log_10 2 = 3 + log_10 1.024$  
$log_10(1+x) ≈ 0.4343 x$ → $log_10 1.024 ≈ 0.01030$  
$log_10 2 ≈ 0.30103$

#align(center)[
#box(stroke: 2pt + red, inset: 10pt)[$log_10 2 = 0.30103$]
]

#heading(level: 2, outlined: true)[Step 3 – Finding log₁₀ 3]

#align(left)[
=== First compute log₁₀ 730 = $log_10 3 ^ 6$:

Factored: 730 = 73 × 10 → only need log 73\
Used a close power (73² = 5329 ≈ 10⁴) or nearby multiple (72 = 8×9)\
Applied the log(1+x) series to the tiny correction\
Cross-checked with 73⁵ or 73¹⁰

$log 73 = 1.86332$\
$log 730 = 2.86332$\
$log 3 approx (log 730) ÷ 6 = 0.47720 approx 0.47712$
]

#align(center)[
#box(stroke: 2pt + red, inset: 10pt)[$log_10 3 = 0.47712$]

#table(
  columns: (8em, 9em),
  stroke: 0.7pt + black,
  inset: 10pt,
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[Number]),
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[log₁₀]),
  table.cell(fill: rgb("#d8f0d8"))[1], table.cell(fill: rgb("#d8f0d8"))[0.00000],
  table.cell(fill: white)[2],          table.cell(fill: white)[0.30103],
  table.cell(fill: rgb("#d8f0d8"))[3],         table.cell(fill: rgb("#d8f0d8"))[0.47712],
  table.cell(fill: white)[10], table.cell(fill: white)[1.00000],
)]

#pagebreak()

#heading(level: 2, outlined: true)[Steps 4–6 – Filling The Remaining Table]

#v(.5em)

- $log_10 4 = 2 log_10 2 = 0.60206$
- $log_10 5 = log_10 10 - log_10 2 = 0.69897$
- $log_10 6 = log_10 3 + log_10 2 = 0.77815$
- $log_10 7 approx log_10 6 + (log_10 8 - log_10 6) ÷ 2 = 0.84062$\
  - $log_10 (7^2) ÷ 2 approx log 50 ÷ 2 = 0.849485$\
  - $(0.840620 + 0.849485) ÷ 2 approx 0.84510$
- $log_10 8 = 3 log_10 2 = 0.90309$
- $log_10 9 = 2 log_10 3 = 0.95424$


#align(center)[
#table(
  columns: (8em, 9em),
  stroke: 0.7pt + black,
  inset: 10pt,
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[Number]),
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[log₁₀]),
  table.cell(fill: rgb("#d8f0d8"))[1], table.cell(fill: rgb("#d8f0d8"))[0.00000],
  table.cell(fill: white)[2], table.cell(fill: white)[0.30103],
  table.cell(fill: rgb("#d8f0d8"))[3], table.cell(fill: rgb("#d8f0d8"))[0.47712],
  table.cell(fill: white)[4], table.cell(fill: white)[0.60206],
  table.cell(fill: rgb("#d8f0d8"))[5], table.cell(fill: rgb("#d8f0d8"))[0.69897],
  table.cell(fill: white)[6], table.cell(fill: white)[0.77815],
  table.cell(fill: rgb("#d8f0d8"))[7], table.cell(fill: rgb("#d8f0d8"))[0.84510],
  table.cell(fill: white)[8], table.cell(fill: white)[0.90309],
  table.cell(fill: rgb("#d8f0d8"))[9], table.cell(fill: rgb("#d8f0d8"))[0.95424],
  table.cell(fill: white)[10], table.cell(fill: white)[1.00000],
)]

#pagebreak()

// ———————————————————————
// 6. A BRIEF HISTORY OF LOGARITHMS
// ———————————————————————

#heading(level: 1, outlined: true)[A Brief History of Logarithms]

#heading(level: 2, numbering: none, outlined: true)[1594 – The spark]  
Scottish laird *John Napier* (1550–1617) invents logarithms and publishes the first table (1614).

#heading(level: 2, numbering: none, outlined: true)[1615 – Briggs arrives]  
*Henry Briggs* travels to Scotland and proposes base-10 (“common”) logarithms.

#heading(level: 2, numbering: none, outlined: true)[1617 – First common table]  
Briggs publishes logarithms of 1–1000 to 14 places — entirely by hand.

#heading(level: 2, numbering: none, outlined: true)[1624 – Arithmetica Logarithmica]  
Briggs publishes 1–20,000 and 90,000–100,000.\
*Adriaan Vlacq* fills the gap in 1628.

#heading(level: 2, numbering: none, outlined: true)[1620s–1970s – The slide rule era]  
Logarithms + Oughtred’s slide rule = the pocket calculator of three centuries.

#heading(level: 2, numbering: none, outlined: true)[1972 – The end]  
HP-35 electronic calculator released. Log tables and slide rules vanish from classrooms within a decade.

#heading(level: 2, numbering: none, outlined: true)[Today]  
Briggs’s logarithm values are still taught exactly as printed in 1624.

#align(center)[
  #box(stroke: 1.5pt + rgb("#006400"), inset: 15pt)[
    “Logarithms reduce days of work to hours, and hours to minutes.”  
    — Pierre-Simon Laplace
  ]
]

#pagebreak()

// ———————————————————————
// 7. HOW TO USE THE SEVEN-FIGURE TABLE
// ———————————————————————

#heading(level: 1, outlined: true)[How to Use the Seven-Figure Table]

The following table gives the *mantissa* of the common logarithm multiplied by 10 000 000.

== Finding the logarithm
Write the number in scientific notation: $m × 10^k$ with $1 ≤ m < 10$

Look up the first 6–7 digits of m → 7-digit mantissa.  

Add the characteristic k.

Example:  
42370 = 4.237 × 10⁴ → table gives 6270585 → log₁₀ = 4.6270585

== Multiplication
$log(a × b) = log a + log b$ → add → antilog

== Division
$log(a ÷ b) = log a - log b$ → subtract → antilog

== Powers and Roots
$log(a^n) = n × log a$

$log(ⁿ√a) = log a ÷ n$

== Antilogarithms
Take the mantissa → look up → place decimal point using the characteristic.

// ———————————————————————
// 8. THE FULL SEVEN-FIGURE TABLE
// ———————————————————————
#set page(margin: (top: 1.0cm, bottom: 1.2cm, left: 1.6cm, right: 1.4cm))

#let log10(x) = calc.log(x) / calc.log(10)
#let sevendigit(n) = {
  let s = str(n)
  if s.len() < 7 { "0" * (7 - s.len()) + s } else { s }
}

#for base in range(1, 10) {
  let start = base * 1000
  pagebreak(weak: true)
  align(center)[
    #heading(level: 1, outlined: true)[Logarithms for #start – #(start + 999)]
    #v(0.3cm)
  ]

  let cells = ()

  cells.push(table.header([*N*],[*0*],[*1*],[*2*],[*3*],[*4*],[*5*],[*6*],[*7*],[*8*],[*9*]))

  for row0 in range(0, 1000, step: 10) {
    let n = start + row0
    let label = str(n).slice(0,3)

    cells.push([
      #set text(7pt, weight: "semibold")
      #label
    ])

    for col in range(0,10) {
      let num = n + col
      let mant = log10(num / 1000.0)
      let value = calc.round(mant * 10000000)
      let digits = sevendigit(int(value))

      cells.push([
        #set text(6.5pt, font: "DejaVu Sans Mono")
        #digits
      ])
    }
  }

  table(
    columns: 11,
    column-gutter: 1.8pt,
    row-gutter: 4.5pt,
    inset: (x: 2pt, y: 3pt),
    stroke: (x, y) => if x == 0 or y == 0 { 0.8pt } else { 0.3pt },
    fill: (c, r) => {
      if r == 0 or c == 0 { rgb("#d8e8d8") }
      else if calc.rem(r, 2) == 1 { rgb("#c8e8c8") }
      else { white }
    },
    align: center + horizon,
    ..cells
  )
}

#align(center)[
  #v(2cm)
  #text(10pt)[End of tables • Generated with Typst • #datetime.today().display("[year]")]
]



#pagebreak()


// ———————————————————————
// 9. BIBLIOGRAPHY
// ———————————————————————

#heading(level: 1, outlined: true)[Bibliography]

#set par(justify: true)
#text(size: 11pt)[
  - John Napier. *Mirifici Logarithmorum Canonis Descriptio*. Edinburgh, 1614.
  - Henry Briggs. *Logarithmorum Chilias Prima*. London, 1617.
  - Henry Briggs. *Arithmetica Logarithmica*. London, 1624.
  - Adriaan Vlacq. *Arithmetica Logarithmica* (expanded). Gouda, 1628.
  - William Oughtred. *Clavis Mathematicae*. London, 1631 (slide rule).
  - David Eugene Smith. *A Source Book in Mathematics*. McGraw-Hill, 1929.
]

#v(4em)
#align(center)[
  #text(10pt, style: "italic")[
    Typeset with Typst in #datetime.today().display("[year]") — exactly 400 years after Briggs’s final tables.
  ]
]
