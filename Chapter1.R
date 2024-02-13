100:130
2 * 3
4 - 1 
6 / (4-1)

3+2
5*3
15-6
9/3

1:6
a<- 1
a +2

my_number <- 1
my_number
die-1
die/2
die*die
1:2
1:4
die
die + 1:2
die + 1:4

die%*% die

round(3.1415)
mean(die)
round(mean(die))

sample(x=1:4, size=2)
sample(x=die, size=1)
sample(die, size=1)
round(3.1415, corners=2)
args(round)
round(3.1415, digits=2)
sample(die,1)
sample(size=1, x=die)
sample(die, size=2)
sample(die, size=2, replace=TRUE)
sample(die, size=2, replace=TRUE)
dice<- sample(die, size=2, replace=TRUE)
dice
sum(dice)

die <- 1:6
dice <- sample(die, size = 2, replace = TRUE)
sum(dice)
roll()

my_function <- function() {} 
roll <- function() {
  die <- 1:6;
  dice <- sample(die, size = 2, replace = TRUE); sum(dice)
}

roll2 <- function(bones) {
  dice <- sample(bones, size = 2, replace = TRUE); sum(dice)
} 

roll2()

roll2 <- function(bones = 1:6) {
  dice <- sample(bones, size = 2, replace = TRUE); sum(dice)
}

roll2(bones=1:4)
roll2(bones=1:6)
roll2(1:20)

## to run it, input "roll2()". a random number will result ech time, as if you were rolling a die. 
