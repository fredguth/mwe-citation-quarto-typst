
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


  

  let margincite(citation) = context {
    if query(bibliography).len()>0 {
      // let (key, supplement, form, style) = citation.fields()
      citation
      place(dy:-2em, dx:100%+1cm)[#repr(citation)]
    }
  }

  show cite: margincite

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
