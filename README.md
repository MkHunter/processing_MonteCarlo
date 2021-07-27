# AproxPi ~ Monte Carlo method

Monte Carlo methods vary, but tend to follow a particular pattern:

1. Define a domain of possible inputs
2. Generate inputs randomly from a probability distribution over the domain
3. Perform a deterministic computation on the inputs
4. Aggregate the results

## [a) Buffon's Needle](https://en.wikipedia.org/wiki/Buffon%27s_needle_problem)

_Suppose we have a floor made of parallel strips of wood, each the same width, and we drop a needle onto the floor. What is the probability that the needle will lie across a line between two strips?_

## Results

![data/Buffon.gif](/data/Buffon.gif)

## [b) Approximating the value of π with a circumference](https://en.wikipedia.org/wiki/Monte_Carlo_method#Overview)

Consider a quadrant (circular sector) inscribed in a unit square. Given that the ratio of their areas is π/4, the value of π can be approximated using a Monte Carlo method:[11]

1. Draw a square, then inscribe a quadrant within it
2. Uniformly scatter a given number of points over the square
3. Count the number of points inside the quadrant, i.e. having a distance from the origin of less than 1
4. The ratio of the inside-count and the total-sample-count is an estimate of the ratio of the two areas, π/4. Multiply the result by 4 to estimate π.

## Results

![data/Pi.gif](/data/Pi.gif)

# CardGame

Rules:

1. Each round, each player takes a card out of the deck until they have 10 in hand.
2. The player that gets the card with the highest number wins and priority(-Golds, Cups, Swords, Clubs+) .

_Note: In case two or more players get the same "best" card they tie and both of them get a point._

## Results

![data/Cards.gif](/data/Cards.gif)
