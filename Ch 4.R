df<- data.frame(face=c("ace", "two", "six"), suit= c("clubs", "clubs", "clubs"), value=c(1,2,3))
df

typeof(df)
class(df)
str(df)

df<= data.frame(face=c("ace", "two", "six"), suit=c("clubs", "clubs", "clubs"), value=c(1,2,3), stringsAsFactors=FALSE)

head(deck)
head(deck,10)

write.csv(deck,file="cards.csv", row.names=FALSE)
getwd()

head(deck)
deck[1,1]
deck[1, c(1,2,3)]
new <- deck[1, c(1,2,3)]

#if you repeat a number in your index R will return it
deck[c(1,1), c(1,2,3)]

vec <- c(6,1,3,6,10,5)
vec[1:3]

deck[1:2, 1:2]
deck[1:2, 1]
deck[1:2, 1, drop=FALSE]

deck[-(2:52), 1:3]
#cannot index positive and negative numbers in same index 
deck[c(-1,1), 1]
deck[0,0]
deck[1, ]

deck[1, c(TRUE, TRUE, FALSE)]
rows<- c(TRUE, F, F, F, F, F, F, F, F, F)
deck[rows, ]

deck[1, c("face", "suit", "value")]
deck[ , "value"]

deal<- function(cards) {cards[1, ]}
deal(deck)
deal(deck)
deal(deck)

deck2<- deck[1:52, ]
head(deck2)

deck3<- deck[c(2, 1, 3:52), ]
head(deck3)

random<- sample(1:52, size=52)
random

deck4<- deck[random, ]
head(deck4)

shuffle<- function(cards) {random<- sample(1:52, size=52); cards[random, ]}
deal(deck)
deal(deck2)

deck$value
mean(deck$value)
median(deck$value)

lst<- list(numbers= c(1,2), logical=TRUE, strings=c("a", "b", "c"))
lst           
lst[1]

#below will result in error 
sum(lst[1])
lst$numbers
sum(lst$numbers)
#subset list with single bracket smaller list is returned
lst["numbers"]
lst[["numbers"]]
