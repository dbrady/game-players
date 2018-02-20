# Picross

Picross is a kind of 2D bitmap solving puzzle where you are given the sizes, but
not the positions, of the RLE (Run Length Encoding) for each row and column. For
example, this little house:

    ..#######..
    .#.......#.
    #.........#
    #.###.###.#
    #.#.#.#.#.#
    #.#.#.###.#
    #.#.#.....#
    #.#.#.....#
    ###########

Would be given in puzzle form as:

                         1
                     1  111
                   1111 3131
                  71616111117
                +------------
              7 | ...........
            1 1 | ...........
            1 1 | ...........
        1 3 3 1 | ...........
    1 1 1 1 1 1 | ...........
        1 1 3 1 | ...........
        1 1 1 1 | ...........
        1 1 1 1 | ...........
             11 | ...........

Spans are given for the "on" bits, and each span must have at least one "off"
bit between in and any adjacent spans. This means four contiguous "on" bits is
always represented as a 4, never as 2, 2 or 1, 3.

Not all bitmaps have unique span definitions, but all Picross puzzles are
required to have a unique solution; for example you would never see either of
these bitmaps as a Picross puzzle because they both have the same span legend:

        232        232
       ----       ----
    2 | ##.    2 | .##
    3 | ###    3 | ###
    2 | .##    2 | ##.

# Solving Logically

In the house puzzle, line 9 has an obvious solution since all 11 columns must be
turned on. Lines 4-6 also have only one possible solution each, because if you
lay down the spans with spaces in between, you use up all 11 columns. You can
often solve a line partially as well, however. For instance, line 1 has a span
of 7, which means that even if the span is all the way to the left or right or
anywhere in between, the three center cells must be turned on.
