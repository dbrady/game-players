# Galaxies by Nikoli ("Tentai Show")
Galaxies was contributed to Simon Tatham's Portable Puzzle Collection and is one
of the best puzzle games ever conceived. It was invented by Nikoli as "Tentai
Show", commonly translated to English as "Spiral Galaxies".

You are given a rectangular grid containing a number of dots. Your aim is to
draw edges along the gridlines which divide the rectangle into regions in such a
way that every region is 180-degrees rotationally symmetric, and contains
exactly one dot which is located at the centre of its symmetry.

# Sample Board

So... the problem with this game is that the boards are fantastically hard to
represent in text, even though they maybe shouldn't be.

This is board id 10x10du#88529954285710 (on the iPad version of the game, no
idea if the random seeds are portable)

     0123456789ABCDEFGHIJK
    0+-------------------+0
    1| | | | | |O| | | |O|1
    2|-------------------|2
    3| | | | | | |O| | | |3
    4|O--O---------------|4
    5| | | | | | | |O| | |5
    6|-------------------|6
    7| | | | | | |O| | | |7
    8|------O---------O--|8
    9| | | | | | | | | | |9
    A|--------O--O-------|A
    B|O| | | | | | | | | |B
    C|-------------------|C
    D| | | | | O | | | | |D
    E|-----O---------O---|E
    F| | | | | | | | | |O|F
    G|--O-------O--------|G
    H|O| | | | | |O| |O| |H
    I|-------------------|I
    J| O | |O| | | |O| | |J
    K+-------------------+K
     0123456789ABCDEFGHIJK

Some quick solving notes:

* The center in the top-right corner at J1 is a 1x1 cell because it's stuck in
  the corner. Nothing out of bounds can be rotated in, so there must be walls at
  I1 and J2.

* A center that straddles a wall automatically owns the cells on either side, so
  the cell at 2J owns 1J and 3J, and since that puts the shape into the corner,
  the shape is complete and we can construct walls at 1I, 3I, and 4J.

* A center that sits on the intersection of four walls owns all four cells
  surrounding it; The center at 6E owns 5D, 7D, 5F and 7F.

* If adjacent cells cells are owned by the same center there cannot be a wall
  between them; conversely if two cells are known to be owned by different
  centers then there must be a wall between them. In the upper left, for
  example, the center at 14 owns 13 and 15, and the center at 44 owns 33 and 35,
  so there must be walls at 23 and 25 (though from the first rule I'd have put
  walls there already since 14 is against the left-hand wall)

* If a cell is owned by a center, the rotationally symmetric cell around that
  center must also be owned by that center. For example as play progresses
  towards the solutions we will see that 6E stretches diagonally up and left
  until it touches the wall at 19; in order to maintain radial symmetry it must
  then also stretch down and to the right until it owns BJ.

* If a cell is owned by a center and it has a wall on one or more sides, the
  rotationally symmetric cell must have walls on the radially symmetric
  sides. 19 has a wall on the left at 09 so BJ must have a wall on its right at
  CJ. BJ has a wall below it at BK so 19 must have a wall above it at 18.

* It is sometimes possible to exclude all possible owners of a cell but one. For
  example, cell JB on the right-hand wall cannot be owned by EG because EG
  cannot own DH because there's a different center in that cell. H8 has a
  similar problem as F5 also has a center in it. At the start of the game, CA
  could claim it as 59 is unclaimed, but CA cannot form a clear path to 59 and
  is disqualified. Similarly, there is a theoretically possible path from D7
  down to JB and up to 73 but as play progresses, D7 is forced to shrink to a
  1x1 cell. This leaves JB with just one owner: the center directly below it at
  JF. Since that cell's mirror is the corner cell at JJ, we see that JB
  must have a wall above it at JA and that sews up the bottom-right shape as a
  1x5 bar.

Other notes may follow, but for now, here's is the solution to this board:

     0123456789ABCDEFGHIJK
    0+-------------------+0
    1| |   |    O    | |O|1
    2| |   +---------- +-|2
    3| |   |      O      |3
    4|O| O +-+ +-+-------|4
    5| |   | | | |  O  | |5
    6| |   | +-+ +-+---+ |6
    7| |   |   | |O|     |7
    8|-+-+-+O+-+ +-+  O  |8
    9|   |   | |   |     |9
    A|-+ +-+ |O| O + +-+-|A
    B|O|   | | |   | | | |B
    C|-+   +-+-+-+ +-+ | |C
    D| |     | O | |   | |D
    E| +-+ O +-+-+ | O | |E
    F|   |     | | |   |O|F
    G|-+O+-+   |O+-+ +-+ |G
    H|O|   |   | |O| |O| |H
    I|-+-+ +-+ +-+-+-+-+ |I
    J| O | |O|   |  O  | |J
    K+-------------------+K
     0123456789ABCDEFGHIJK

...did I mention it's really hard to represent visually, at least in ascii?
Sigh.
