# Game Players

"Cheats are for people who don't like playing video games." -- Unknown


When I find a game I like, I play the heck out of it. When I find a game I love,
I write programs to play it for me.

If there's two things I love, it's programming computers and playing games. Few
things in life make me as happy as when I can combine both loves. This repo is a
gathering place for the scripts, tools and toys I use to solve puzzles, crack
codes, play games, etc.

This repo is organized by game.

## Solvers

This folder contains programs that solve puzzles posed by other games. Most of
the time writing a program to solve a puzzle is quite easy; the hard part is
figuring out how to represent the puzzle to the computer, and how the computer
can represent the solution back to me in such a way that I can then use it in
the game.

A simple example is countdown, a pair of scripts (countdown_maths and
countdown_word), which are programs that solve the anagrams and math problems
proposed on the British TV game show "Countdown". Normally I would write the
program to take a goal number followed by the candidate numbers to be
used. However, this game is played in real time against a 30 second clock, so
you key in the numbers as the hostess is putting them up on the board, and only
when she hits the button to calculate the target number do you enter the goal.

A harder example is Chuzzles, a game I have lost the solver for, but if I find
it I'll get it into this repo. Given the layout of balls on a board, you must
flick balls into each other, knocking a ball off the board with each move, until
1 ball remains. For that game the input was a text file where I would draw the
board with .'s and o's. For example, the board might look like this:

```
........
........
......o.
..o.....
........
........
..o....o
........

```

The solver would assign arbitrary labels to the balls and emit the board with
the balls labeled, like so:

```
........
........
......a.
..b.....
........
........
..c....d
........

```

Finally the game would emit the solution in pairs of ball+direction indicating
which ball to flick which way. In this case the unique solution is 'c> c^ c<'.


MUCH harder examples (currently) including Unlock It and Circuit Scramble, both
of which do not yet have working representations. They are both visual puzzle
games that have pure logic as their core mechanic, but they have rich visual
representations that do not lend themselves well to text.

## Tools

This folder is for tools to help me with a given game, such as calculating
derived stats for a game, such as calculating gold income over time or
determining the optimal adventuring party based on whether the party needed to
do the most damage quickly by spending their special skills, do the most
sustained damage without using mana, or simply survive the longest under harsh
conditions.

## Toys

Random scraps that don't fit anywhere else.
