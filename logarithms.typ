#let title = "Log Tables (Base 10)\nwith Instructions"

#set page(
  width:  5.5in,
  height: 8.5in,
  margin: (x: 1.4cm, y: 1.8cm),
  numbering: none,
  number-align: center,
)

#set text(font: "TeX Gyre Pagella", size: 10.2pt)
#set heading(numbering: "1.")
#show heading: it => block(above: 1.8em, below: 1.2em, text(weight: "bold", size: 11pt, it))

#let log10(x) = calc.log(x) / calc.log(10)

#let fivedigit(n) = {
  let s = str(n)
  if s.len() < 5 { "0" * (5 - s.len()) + s } else { s }
}

#align(center)[
  #text(size: 18pt, weight: "bold")[#title]
  \
  #text(size: 11pt)[Generated with Typst — #datetime.today().display("[month repr:long] [year]")]
]

#pagebreak()

#set page(
  width:  5.5in,
  height: 8.5in,
  margin: (x: 1.4cm, y: 1.8cm),
  numbering: "i",
  number-align: center,
)
#set heading(numbering: "1.")
#show heading: it => block(above: 1.8em, below: 1.2em, text(weight: "bold", size: 11pt, it))

#counter(page).update(1)   // forces the first real content page to be number 1

= Complete Instructions for Using the Tables

These are *five-figure common (base-10) logarithms*.  
Each table entry is the mantissa × 100 000 (i.e. five decimal places).

== 1. Finding the Logarithm
Write the number in scientific notation:  
any number = m × 10ᵏ   where 1 ≤ m < 10

- Look up the first 4–5 digits of m in the tables → 5-digit mantissa  
- Add the characteristic k

*Example:*  
42370 = 4.2370 × 10⁴ → table gives *62714* → log₁₀ = 4.62714

== 2. Multiplication
To compute a × b:
- log(a × b) = log a + log b
- Add the logarithms (carry over 10s as needed)
- Find the antilog of the result

*Example:* 42.37 × 8.194  
- log(42.37) = 1.62714  
- log(8.194) = 0.91349  
- Sum         = 2.54063 → antilog(2.54063) ≈ *347.2*
- ∴ 42.37 × 8.194 ≈ 347.2

== 3. Division
To compute a ÷ b:
- log(a ÷ b) = log a − log b
- Subtract the logarithms (borrow 10 if needed)
- Antilog of the result

*Example:* 347.2 ÷ 8.194  
- log(347.2) ≈ 2.54063  
- log(8.194) = 0.91349  
- Difference = 1.62714 → antilog = *42.37* (checks out!)

#pagebreak()

== 4. Powers and Exponentiation
To compute aⁿ:
- log(aⁿ) = n × log a
- Multiply the log by n
- Take antilog

*Examples:*  
- 2.5⁵ → 5 × log(2.5) = 5 × 0.39794 = 1.98970 → antilog ≈ *97.66*
- 9.1³ → 3 × log(9.1) = 3 × 0.95904 = 2.87712 → antilog ≈ *753.6*

== 5. Roots
To compute √[n] a  (nth root):
- log(√[n] a) = log a ÷ n
- Divide the log by n
- Take antilog

*Examples:*  
- √7420 → log(7420) = 3.87041 → divide by 2 = 1.935205 → antilog ≈ *86.14*
- ∛68.92 → log(68.92) = 1.83840 → divide by 3 ≈ 0.61280 → antilog ≈ *4.10*

== 6. Finding the Antilogarithm (reverse lookup)
Given a logarithm (e.g. 3.84957):
- Take only the mantissa .84957
- Look up 84957 in the tables → you land near row 708, column 0 → *70800*
- Characteristic 3 → place decimal point → *708.00*

#pagebreak()

#set page(
  width:  5.5in,
  height: 8.5in,
  margin: (x: 1.4cm, y: 1.8cm),
  numbering: "1",
  number-align: center,
)
#set heading(numbering: "1.")
#show heading: it => block(above: 1.8em, below: 1.2em, text(weight: "bold", size: 11pt, it))

#counter(page).update(1)   // forces the first real content page to be number 1

= Five-Figure Logarithm Tables (1.00000 – 9.99999)

#for base in range(1, 10) {
  let start = base * 1000

  align(center)[
    #text(size: 13pt, weight: "bold")[Mantissas for #start – #(start + 999)]
    #v(0.4cm)
  ]

  table(
    columns: 11,
    stroke: (x,y) => if x == 0 or y == 0 { (thickness: 0.7pt) } else { (thickness: 0.28pt) },
    align: center + horizon,
    table.header(
      [], [0], [1], [2], [3], [4], [5], [6], [7], [8], [9]
    ),

    ..for row0 in range(0, 1000, step: 10) {
      let n = start + row0
      let label = str(n).slice(0, 3)
      let row = ([#label],)

      for col in range(0, 10) {
        let num = n + col
        let mant = log10(num / 1000.0)
        let value = calc.round(mant * 100000)
        let digits = fivedigit(int(value))

        let formatted = digits.clusters().map(d =>
          if d == "0" { text(weight: "regular", d) }
                  else { text(weight: "bold", d) }
        ).join()

        row.push(formatted)
      }
      row
    }
  )
  pagebreak()
}