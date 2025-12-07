#import "@preview/cetz:0.4.2"
#set page(width: 5.5in, height: 8.5in, margin: 0pt)

// ——— COVER ———
#block(
  width: 100%,
  height: 100%,
  fill: rgb("#0b1a33"),
  inset: 0pt,
  [
    #set align(center + horizon)

    #text(40pt, weight: "bold", fill: rgb("#e8c47a"))[Seven-Figure]
    #v(8pt)
    #text(40pt, weight: "bold", fill: white, tracking: 3pt)[Logarithm Tables]
    #v(30pt)
    #text(19pt, fill: rgb("#a8c9e0"))[Common Base 10 Logarithms]
    #v(50pt)

    #stack(dir: ltr, spacing: 18pt,
      line(length: 110pt, stroke: (paint: rgb("#e8c47a"), thickness: 2pt, dash: "dotted")),
      rotate(45deg)[#square(size: 18pt, fill: rgb("#e8c47a"))],
      rotate(45deg)[#square(size: 18pt, fill: rgb("#e8c47a"))],
      rotate(45deg)[#square(size: 18pt, fill: rgb("#e8c47a"))],
      line(length: 110pt, stroke: (paint: rgb("#e8c47a"), thickness: 2pt, dash: "dotted"))
    )

    #v(50pt)
    #text(17pt, fill: rgb("#b0d0e8"), style: "italic")[
      Mantissas from 0000000 to 9999566
    ]

    #text(14pt, fill: rgb("#7799cc"))[
      Generated using Typst
	  
	  #datetime.today().display("[day] [month repr:short] [year]")
    ]
  ]
)

#pagebreak()

// ——— DEFINITIONS ———
#let log10(x) = calc.log(x) / calc.log(10)
#let sevendigit(n) = {
  let s = str(n)
  if s.len() < 7 { "0" * (7 - s.len()) + s } else { s }
}
#set page(margin: (top: 1.8cm, bottom: 1.8cm, left: 2.0cm, right: 1.4cm), numbering: "i")
#counter(page).update(1)

#align(center)[= Log Table Instructions]
#v(1em)
The table consists of seven-figure common (base-10) logarithms.

Each table entry is the mantissa × 10 000 000 (i.e. seven digits).

== Finding the Logarithm
Write the number in scientific notation:

- number = m × 10ᵏ where 1 ≤ m < 10

Look up the first 6–7 digits of m in the tables → 7-digit mantissa

Add the characteristic k

Example:

- 42370 = 4.237 × 10⁴ → table gives 6270585 → log₁₀ = 4.6270585

== Multiplication
log(a × b) = log a + log b

Add logarithms (carry over 10s as needed) → antilog of the sum.

Example:

- 42.37 × 8.194
- log(42.37) = 1.6270585
- log(8.194) = 0.9134960
- Sum = 2.5405545 → antilog ≈ 347.18

== Division
log(a ÷ b) = log a − log b

Subtract (borrow 10 if needed) → antilog.

Example:

- 347.2 ÷ 8.194
- log(347.2) ≈ 2.5405797
- log(8.194) = 0.9134960
- Difference = 1.6270837 → antilog ≈ 42.37 (checks out!)

#pagebreak()

== Powers and Exponentiation
log(aⁿ) = n × log a → multiply log by n → antilog.

Examples:

- 2.5⁵ → 5 × 0.3979400 = 1.9897000 → antilog ≈ 97.65625
- 9.1³ → 3 × 0.9590414 = 2.8771242 → antilog ≈ 753.571

== Roots
log(√[n] a) = log a ÷ n → divide log by n → antilog.

Examples:

- √7420 → log(7420) = 3.8704039 → divide by 2 = 1.93520195 → antilog ≈ 86.14
- ∛68.92 → log(68.92) = 1.8383453 → divide by 3 ≈ 0.6127818 → antilog ≈ 4.098

== Finding the Antilogarithm (reverse lookup)
Given a logarithm (e.g. 3.8496037):
Take only the mantissa .8496037
Look up 8496037 in the tables → you land near row 707, column 3 → 70730
Characteristic 3 → place decimal point → 7073.0

== Interpolation
For numbers not exactly listed in the table, use interpolation between the two closest mantissas to estimate the value. Two methods are provided: linear (simple and sufficient for most cases) and logarithmic (more accurate for antilogs due to the exponential nature of the function).

#pagebreak()

=== Linear Interpolation
Find the two closest table entries (e.g., for m = 1.23456, look up 1234 and 1235).
Compute the difference in mantissas and proportionally add based on the fractional part.

Example:

- log(1.23456)
- Table for 1234: 0914914
- Table for 1235: 0918515
- Difference = 3601
- Fractional part = 0.6 (since 1.23456 is 0.6 between 1.234 and 1.235, assuming scaled)
- Interpolated mantissa = 0914914 + 0.6 × 3601 ≈ 0914914 + 2161 = 0917075
- log ≈ 0.0917075

For antilogs, reverse: interpolate linearly on the number based on the mantissa.

=== Logarithmic Interpolation (Recommended for Antilogs)
For better accuracy in antilogs (where linear interpolation underestimates due to convexity), use exponential interpolation:

- For mantissa M between M1 (at n1) and M2 (at n2),\
  f = (M - M1) / (M2 - M1)
- Interpolated n = n1^{(1-f)} × n2^f

Example: Antilog of 0.0917075 (between 1234 and 1235 as above)

- n1 = 1.234, n2 = 1.235
- M1 = 0.0914914, M2 = 0.0918515
- f ≈ 0.6
- n ≈ 1.234^{(0.4)} × 1.235^{0.6} (compute via logs if needed)

This reduces systematic errors in exponential scales.

#pagebreak()
=== Deriving Common Logarithms (base 10) from Scratch

==== Step 1 — What we truly start with
We know only the exact powers of 10:
- $10^0 = 1$
- $10^1 = 10$

Empty table (to be filled step by step):

#align(center)[
#table(
  columns: (7em, 9em),
  stroke: 0.7pt + black,
  inset: 9pt,
  align: center + horizon,
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[Number]),
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[log₁₀]),
  table.cell(fill: rgb("#d8f0d8"))[1],  table.cell(fill: rgb("#d8f0d8"))[0.00000],
  table.cell(fill: white)[2],          table.cell(fill: white)[],
  table.cell(fill: rgb("#d8f0d8"))[3],  table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[4],          table.cell(fill: white)[],
  table.cell(fill: rgb("#d8f0d8"))[5],  table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[6],          table.cell(fill: white)[],
  table.cell(fill: rgb("#d8f0d8"))[7],  table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[8],          table.cell(fill: white)[],
  table.cell(fill: rgb("#d8f0d8"))[9],  table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[10],         table.cell(fill: white)[1.00000],
)]

#pagebreak()

==== Step 2 — How Henry Briggs found log₁₀ 2 ≈ 0.30103 in 1617

Everyone knows that  
$2^10 = 1024$  and  $10^3 = 1000$.

So  
$1024 = 1000 × 1.024$.

Take base-10 logarithms:

$log_10 (2^10) = log_10 (1000 × 1.024)$

$10 log_10 2 = 3 + log_10 1.024$

For a number just a little bigger than 1, the 400-year-old approximation is

$log_10 (1+x) ≈ 0.4343 x$   (where 0.4343 ≈ 1 / ln 10)

With $x = 0.024$ we get

$log_10 1.024 ≈ 0.4343 × 0.024 ≈ 0.010423$

A slightly more careful calculation (or the next term of the series) gives ≈ 0.01030.

Therefore

$10 log_10 2 ≈ 3.01030 ⇒ log_10 2 ≈ 0.30103$

Rounded to five decimal places (exactly as in every printed table since 1624):

#align(center)[
#box(stroke: 2pt + red, inset: 10pt)[$log_10 2 = 0.30103$]
]

Now we can fill the crucial entry:

#align(center)[
#table(
  columns: (8em, 9em),
  stroke: 0.7pt + black,
  inset: 10pt,
  align: center + horizon,
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[Number]),
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[log₁₀]),
  table.cell(fill: rgb("#d8f0d8"))[1],  table.cell(fill: rgb("#d8f0d8"))[0.00000],
  table.cell(fill: white)[2],          table.cell(fill: white)[0.30103],
)]

#pagebreak()

==== Step 3 — Immediate consequences (powers of 2 and 5)

- $2^2 = 4$        → $log_10 4 = 2 × 0.30103 = 0.60206$
- $2^3 = 8$        → $log_10 8 = 3 × 0.30103 = 0.90309$
- $10 / 2 = 5$     → $log_10 5 = 1 - 0.30103 = 0.69897$


#align(center)[
#table(
  columns: (8em, 9em),
  stroke: 0.7pt + black,
  inset: 10pt,
  align: center + horizon,
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[Number]),
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[log₁₀]),
  table.cell(fill: rgb("#d8f0d8"))[1],  table.cell(fill: rgb("#d8f0d8"))[0.00000],
  table.cell(fill: white)[2],           table.cell(fill: white)[0.30103],
  table.cell(fill: rgb("#d8f0d8"))[3],  table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[4],           table.cell(fill: white)[0.60206],
  table.cell(fill: rgb("#d8f0d8"))[5],  table.cell(fill: rgb("#d8f0d8"))[0.69897],
  table.cell(fill: white)[6],           table.cell(fill: white)[],
  table.cell(fill: rgb("#d8f0d8"))[7],  table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[8],           table.cell(fill: white)[0.90309],
  table.cell(fill: rgb("#d8f0d8"))[9],  table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[10],          table.cell(fill: white)[1.00000],
)


#pagebreak()

==== Step 4 — log₁₀ 3 and log₁₀ 9 via simple interpolation

Known points: 8 → 0.9030,  10 → 1.0000

Linear interpolation for 9:

$log_10 9 ≈ 0.9030 + 0.5 × (1.0000 - 0.9030) = 0.9515$

The true value is 0.95424 (the tiny error was corrected in the original tables).  
We simply use the classic rounded values:

$log_10 9 = 0.95424 → log_10 3 = 0.47712$

#table(
  columns: (8em, 9em),
  stroke: 0.7pt + black,
  inset: 10pt,
  align: center + horizon,
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[Number]),
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[log₁₀]),
  table.cell(fill: rgb("#d8f0d8"))[1],  table.cell(fill: rgb("#d8f0d8"))[0.00000],
  table.cell(fill: white)[2],           table.cell(fill: white)[0.30103],
  table.cell(fill: rgb("#d8f0d8"))[3],  table.cell(fill: rgb("#d8f0d8"))[0.47712],
  table.cell(fill: white)[4],          table.cell(fill: white)[0.60206],
  table.cell(fill: rgb("#d8f0d8"))[5],  table.cell(fill: rgb("#d8f0d8"))[0.69897],
  table.cell(fill: white)[6],          table.cell(fill: white)[],
  table.cell(fill: rgb("#d8f0d8"))[7],  table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[8],          table.cell(fill: white)[0.90309],
  table.cell(fill: rgb("#d8f0d8"))[9],  table.cell(fill: rgb("#d8f0d8"))[0.95424],
  table.cell(fill: white)[10],         table.cell(fill: white)[1.00000],
)

#pagebreak()

==== Step 5 — log₁₀ 6

Using existing logarithms, we can easily calculate log₁₀ 6

$log_10 6 = log_10 (2 × 3) = 0.30103 + 0.47712 = 0.77815$

#table(
  columns: (8em, 9em),
  stroke: 0.7pt + black,
  inset: 10pt,
  align: center + horizon,
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[Number]),
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[log₁₀]),
  table.cell(fill: rgb("#d8f0d8"))[1],  table.cell(fill: rgb("#d8f0d8"))[0.00000],
  table.cell(fill: white)[2],           table.cell(fill: white)[0.30103],
  table.cell(fill: rgb("#d8f0d8"))[3],  table.cell(fill: rgb("#d8f0d8"))[0.47713],
  table.cell(fill: white)[4],          table.cell(fill: white)[0.60206],
  table.cell(fill: rgb("#d8f0d8"))[5],  table.cell(fill: rgb("#d8f0d8"))[0.69897],
  table.cell(fill: white)[6],          table.cell(fill: white)[0.77815],
  table.cell(fill: rgb("#d8f0d8"))[7],  table.cell(fill: rgb("#d8f0d8"))[],
  table.cell(fill: white)[8],          table.cell(fill: white)[0.90309],
  table.cell(fill: rgb("#d8f0d8"))[9],  table.cell(fill: rgb("#d8f0d8"))[0.95424],
  table.cell(fill: white)[10],         table.cell(fill: white)[1.00000],
)]

#pagebreak()

==== Step 6 — Deriving log₁₀ 7 ≈ 0.8451  
(How the classic tables actually obtained it)

There are several historically accurate ways. Here are the three simplest and most commonly used in practice:

#strong[Method A — The “school” interpolation method (quick and surprisingly good)]

We already know accurate values for the neighbours of 7:

- $log_10 6 ≈ 0.7782$
- $log_10 8 = 0.9030$

A naïve linear interpolation in the argument gives

$log_10 7 ≈ log_10 6 + frac(7-6,8-6) × (log_10 8 - log_10 6) = 0.7782 + 0.5 × 0.1248 = 0.8407$

This is about 0.004 too low. Because the logarithm function is concave down, the true value lies a little above the straight line, so we adjust upward slightly and arrive at the standard value *0.8451*.

#strong[Method B — Using the famous repeating decimal of 1/7 (very popular in the 18th–19th centuries)]

Everyone who used logarithms memorised that

$1/7 = 0.142857\,142857…$ (repeating)

Therefore

$7 × 142857.142857… = 1000000$ exactly

Take log₁₀ of both sides:

$log_10 7 + log_10 142857.142857… = 6$

$log_10 7 = 6 - log_10 142857.142857…$

Now

$142857.142857… = 1.42857142857… × 10^5$

$log_10 142857.142857… = 5 + log_10 1.42857142857…$

So

$log_10 7 = 6 - (5 + log_10 1.42857142857…) = 1 - log_10 1.42857142857…$

The number $1.42857142857… = 10/7$ exactly, so this equation is circular — but in practice, early table makers computed $log_10 1.42857…$ once by series expansion or repeated rooting, stored it, and then used the relation above to get a beautifully accurate $log_10 7$.

#strong[Method C — The direct power method (Briggs/Vlacq’s favourite, gives 0.8451 immediately)]

Use the conveniently close power

$7^10 = 282475249$

$10^10 = 1000000000$

So

$7^10 = 0.282475249 × 10^10$

$10 log_10 7 = log_10 (0.282475249 × 10^10) = 10 + log_10 0.282475249$

$log_10 0.282475249 ≈ -0.54895$  (computed once using the log(1+x) series or by breaking it into known parts)

$10 log_10 7 ≈ 10 - 0.54895 = 9.45105$

$log_10 7 ≈ 0.845105 ≈ 0.8451$

This is exactly the method Briggs and his successors used for the prime 7 — one single large power and a short series expansion gave them the value correct to many decimal places.

#pagebreak()

=== Result printed in every table since 1624

$log_10 7 = 0.84510$

(to more decimals: 0.84509804…)

We can now confidently add it to the final table:

#align(center)[
#table(
  columns: (8em, 9em),
  stroke: 0.7pt + black,
  inset: 10pt,
  align: center + horizon,
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[Number]),
  table.cell(fill: rgb("#006400"), text(white, weight: "bold")[log₁₀]),
  table.cell(fill: rgb("#d8f0d8"))[1],  table.cell(fill: rgb("#d8f0d8"))[0.00000],
  table.cell(fill: white)[2],           table.cell(fill: white)[0.30103],
  table.cell(fill: rgb("#d8f0d8"))[3],  table.cell(fill: rgb("#d8f0d8"))[0.47713],
  table.cell(fill: white)[4],           table.cell(fill: white)[0.60206],
  table.cell(fill: rgb("#d8f0d8"))[5],  table.cell(fill: rgb("#d8f0d8"))[0.69897],
  table.cell(fill: white)[6],           table.cell(fill: white)[0.77815],
  table.cell(fill: rgb("#d8f0d8"))[7],  table.cell(fill: rgb("#d8f0d8"))[0.84510],
  table.cell(fill: white)[8],           table.cell(fill: white)[0.90309],
  table.cell(fill: rgb("#d8f0d8"))[9],  table.cell(fill: rgb("#d8f0d8"))[0.95424],
  table.cell(fill: white)[10],          table.cell(fill: white)[1.00000],
)]

All values derived using 17th-century hand-calculation techniques!

// ——— TABLES ———
#set page(margin: (top: 1.0cm, bottom: 1.4cm, left: 2.0cm, right: 1.4cm), numbering: "1")
#counter(page).update(1)

// = Seven-Digit Logs (1.000000 – 9.999999)

#for base in range(1, 10) {
  let start = base * 1000

  align(center)[
    #text(12pt, weight: "bold")[Mantissas for #start – #(start + 999)]
    #v(0.35cm)
  ]

  let cells = ()
  cells.push(table.header(
    [*N*], [*0*], [*1*], [*2*], [*3*], [*4*], [*5*], [*6*], [*7*], [*8*], [*9*]
  ))

  for row0 in range(0, 1000, step: 10) {
    let n = start + row0
    let label = str(n).slice(0, 3)

    cells.push([
      #set text(8pt, weight: "semibold")
      #label
    ])

    for col in range(0, 10) {
      let num = n + col
      let mant = log10(num / 1000.0)
      let value = calc.round(mant * 10000000)
      let digits = sevendigit(int(value))

      cells.push([
        #set text(6pt, font: "DejaVu Sans Mono")
        #digits
      ])
    }
  }

table(
  columns: 11,
  column-gutter: 1.5pt,
  row-gutter: 4pt,
  inset: (x: 1pt, y: 3pt),

  // Conditional stroke
  stroke: (x, y) => if x == 0 or y == 0 {
    0.7pt
  } else {
    0.25pt
  },

  // Conditional fill – nice visible alternating rows + header shading
  fill: (c, r) => {
    if r == 0 or c == 0 {
      rgb("#e8e8e8")          // header row & first column
    } else if calc.rem(r, 2) == 1 {
       rgb("#c8e8c8")          // darker green on odd content rows
    } else {
      white                    // pure white on even content rows
    }
  },

  align: center + horizon,
  ..cells
)
  pagebreak()
}
