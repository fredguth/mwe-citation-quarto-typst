#import "@preview/drafting:0.2.0": *

#let margincite(key, mode, prefix, suffix, noteNum, hash) = context {
  if query(bibliography).len()>0 {
    let supplement = suffix.split(",").filter(value => not value.contains("dy.")).join(",")
    let dy = if suffix.contains("dy.") {
      eval(suffix.split("dy.").at(1, default: "").split(",").at(0, default: "").trim())
    } else {none}

    cite(key, form: "normal", supplement: supplement)
    if dy!=none {
      set text(size: 8pt)
      [#margin-note(dy:dy, dx:100%+.1em)[#block(width: 7cm, inset:1em)[#cite(key, form:"full", supplement: supplement)]]]
      
    }
  }
}


#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  paper: "a4",
  margin: (left: 1cm,  right: 7cm, top: 2cm, bottom: 2cm),
  
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  bib: none,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  if title != none {
    align(center)[#block(inset: 2em)[
      #text(weight: "bold", size: 1.5em)[#title]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
    ]
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }


 

  show cite.where(form:"prose"): none

  // set-page-properties() // I don't want it to calculate, I want to give my calculations
  set-margin-note-defaults(
    stroke: none,
    side: right,
    margin-right: 1cm, // 1cm is absurd.. just to show that it is being ignored!!!
    margin-left: 1cm,
    page-width: 21cm-8.25cm
  )
  // set-page-properties()

  place(dx: 100%, dy: 3cm, block(width: 7cm, height: 7cm, fill: rgb("#dbdbc5"))[
    #let n = 1
    #set text(fill: gray)
    #while n < 17 {
      [Please do not put your citations here.]
      n = n+1
    }
  ]
  )

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }

  if bib != none {
    heading(level:1,[References])
    bib
  }
}

#set table(
  inset: 6pt,
  stroke: none
)
