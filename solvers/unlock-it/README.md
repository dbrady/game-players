# Unlock It

Silly and stupid program to try to solve puzzles in the game "Unlock It - A fun
logic puzzle" by MetalPop Games. Search for it in your app store; I only know
it's available for Android in the Google Play Store.

I am not affiliated with MetalPop in any way. I enjoy playing the game, but it
also tickles the part of my brain that wants to teach programs to play games for
me.

## Gameplay

The Unlock It board has 4-10 squares (2-5 high, 2 across). The top left square
has a button on it. You must turn it green and press it to win the level. Each
level is filled with blocks except for one empty space. A block can slide into
the empty space, or can be rotated 180degrees. The green button must be
uncovered to press it, i.e. the empty space must be at the top-left to solve the
puzzle. Down the side of the board are little pins; all pins must be extended to
turn the button green. Each block has up to 3 slots on each side to receive
these pins; the slots can go all the way through or just be a short
recess. Inside the slots in some blocks are pins; if a block contains a pin that
is pressed up against the pin on the side, the pin cannot be extended. If a pin
is shorter than its slot it can slide back and forth in that slot.

Short pins can only be slid back and forth inside their block. Long pins can be
slid outside of their block only if there is a block present on the other side
with a slot that can receive the pin. This means a long pin cannot slide out
into the empty space. A block with a pin sticking out of it or into it cannot be
moved or rotated.

## Moves

Each level has a goal to be solved in the minimum number of moves. Sliding a
block counts as a move, as does rotating it in place. Sliding pins, including
extending and retracting the side pins, are free moves.

## Board Representations

I have no idea how I'm going to represent the board, heh. I need to be able to
represent a tile with up to 3 slots on either side, slots that go through the
block, short or long pins inside the block, and long pins reaching outside the
box into a neighboring slot. I don't really want to make a game that can only be
visualized as SVG but I think it might be either that or some unreadable
encoding. E.g. I could represent the presence of the 3 external pins in octal,
then divide each block into three vertical slices and indicate the presence of
the three slots also in octal. Then some representation of the presence of the
pins inside the blocks, and so on.
