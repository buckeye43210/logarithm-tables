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

#align(center)[
  #v(1cm)
  #text(15pt, weight: "bold")[Logarithmic Scale (Base 10)]
  #v(12pt)

  #table(
    columns: (7em, 7em),
    stroke: 0.7pt + black,
    inset: 9pt,
    align: center + horizon,

    // Header row — dark green background
    table.cell(fill: rgb("#006400"), text(white, weight: "bold")[Number]),
    table.cell(fill: rgb("#006400"), text(white, weight: "bold")[log₁₀]),

    // Row 1 – light green
    table.cell(fill: rgb("#d8f0d8"))[1],
    table.cell(fill: rgb("#d8f0d8"))[0.0000],

    // Row 2 – white
    table.cell(fill: white)[2],
    table.cell(fill: white)[0.3010],

    // Row 3 – light green
    table.cell(fill: rgb("#d8f0d8"))[3],
    table.cell(fill: rgb("#d8f0d8"))[0.4771],

    // Row 4 – white
    table.cell(fill: white)[4],
    table.cell(fill: white)[0.6021],

    // Row 5 – light green
    table.cell(fill: rgb("#d8f0d8"))[5],
    table.cell(fill: rgb("#d8f0d8"))[0.6990],

    // Row 6 – white
    table.cell(fill: white)[6],
    table.cell(fill: white)[0.7782],

    // Row 7 – light green
    table.cell(fill: rgb("#d8f0d8"))[7],
    table.cell(fill: rgb("#d8f0d8"))[0.8451],

    // Row 8 – white
    table.cell(fill: white)[8],
    table.cell(fill: white)[0.9031],

    // Row 9 – light green
    table.cell(fill: rgb("#d8f0d8"))[9],
    table.cell(fill: rgb("#d8f0d8"))[0.9542],

    // Row 10 – white
    table.cell(fill: white)[10],
    table.cell(fill: white)[1.0000],

    // Bonus constants – light green
    table.cell(fill: rgb("#d8f0d8"))[e ≈ 2.71828],
    table.cell(fill: rgb("#d8f0d8"))[0.4343],

    table.cell(fill: white)[π ≈ 3.14159],
    table.cell(fill: white)[0.4971],
  )

  #v(1cm)
]