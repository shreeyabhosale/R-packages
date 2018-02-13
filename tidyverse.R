install.packages("tidyverse")
library(tidyverse)
tidyverse_logo()

library(datasets)
attach(iris)
str(iris)
#################    dplyr ############################
#Filter : filter() allows you to select a subset of rows in a data frame. 
iris %>%
  filter(Species=="virginica", Sepal.Length>6)

#Arrange : arrange() sorts the observations in a dataset in ascending or descending order
#based on one of its variables.
iris %>%
  arrange(Sepal.Length)
iris %>%
  arrange(desc(Sepal.Length))
#Combine
iris %>%
  filter(Species=="virginica") %>%
  arrange(Sepal.Length)

#Mutate :mutate() allows you to update or create new columns of a data frame.
iris %>%
  mutate(SLMm=Sepal.Length*10)
#Combine
iris %>%
  filter(Species=="virginica") %>%
  arrange(desc(Sepal.Length)) %>%
  mutate(SLMm=Sepal.Length*10)

#Summarize :summarize() allows you to turn many observations into a single data point.
iris %>%
  summarize(medianSL=median(Sepal.Length))
iris %>%
  filter(Species=="virginica") %>%
  summarize(medianSL=median(Sepal.Length))

#Group by :group_by() allows you to summarize within groups instead of summarizing the
#entire dataset:
iris %>% group_by(Species) %>%
  summarize(medianSL=median(Sepal.Length), MaxSL=max(Sepal.Length))

################## ggplot2 ######################
#Scatter plot : Scatter plots allow you to compare two variables within your data. To do this with
#ggplot2, you use geom_point()
iris_small <- iris %>%
  filter(Sepal.Length>5)
#Additional Aesthetics
#Color
ggplot(iris_small, aes(x=Petal.Length, y=Petal.Width, color=Species)) +
  geom_point()
#color and size
ggplot(iris_small, aes(x=Petal.Length, y=Petal.Width, color=Species, size=Sepal.Length)) +
  geom_point()
#faceting
ggplot(iris_small, aes(x=Petal.Length, y=Petal.Width)) +
  geom_point() +
  facet_wrap(~Species)

#Line Plots
install.packages("gapminder")
library(gapminder)
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianGDPperCap=median(gdpPercap))

ggplot(by_year, aes(x=year, y=medianGDPperCap)) +
  geom_line() +
  expand_limits(y=0)

#Bar Plots
by_species <- iris %>%
 filter(Sepal.Length>6) %>%
 group_by(Species) %>%
 summarize(medianPL=median(Petal.Length))

ggplot(by_species, aes(x=Species, y=medianPL)) +
 geom_col()  

#Histograms
ggplot(iris_small, aes(x=Petal.Length))+
 geom_histogram()

#Box Plots
ggplot(iris_small, aes(x=Species, y=Sepal.Width))+
 geom_boxplot()
