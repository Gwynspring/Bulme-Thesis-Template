#import "../../metadata.typ": meta

#grid(
  columns: (auto, 1fr, auto),
  align: (left, center, right),

  image("../../img/bulme.png", height: 3.0cm),

  align(center)[
    #text()[Höhere Technische]
    #linebreak()
    #text()[Bundes-Lehranstalt]
    #linebreak()
    #text()[Graz-Gösting (BULME)]
    #linebreak()
    #text()[#meta.department]
  ],

  image("../../img/htl.png", height: 1.5cm),
)

#heading(level: 1, outlined: false)[Anmerkung]

// Describe here what is NOT part of this thesis — e.g. parts handled by a
// partner student that will be submitted separately. Delete this section if
// no such note is needed.
//
// Example:
// The development of the measurement station is carried out by
// [Partner Name], documented separately, and will be submitted at a later date.
