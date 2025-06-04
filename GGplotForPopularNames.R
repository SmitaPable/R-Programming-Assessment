# Install necessary packages if not already installed
install.packages("tidyverse")
install.packages("babynames")
install.packages("ggplot2")
install.packages("dplyr")

# Load required libraries
library(ggplot2)
library(babynames)
library(dplyr)

# Filter babynames dataset for popular male names born between 1900 and 1999
popular_names <- dplyr::filter(babynames, sex == "M" & year >= 1900 & year <= 1999)
View(popular_names)

# Calculate the total occurrences of each name
name_counts <- popular_names %>%
  group_by(name) %>%
  summarize(total = sum(n)) %>%
  arrange(desc(total)) %>%
  head(3)
View(name_counts)

# Filter babynames dataset for the three most popular male names
filtered_data <- dplyr::filter(babynames, sex == "M" & name %in% name_counts$name & year >= 1900 & year <= 1999)

# Create a line plot to show the popularity of the three most popular male names over time
ggplot(filtered_data, aes(x = year, y = n, color = name)) +
  geom_line() +
  labs(
    title = "Popularity of the Three Most Popular Male Names (1900-1999)",
    x = "Year",
    y = "Number of Births",
    color = "Name"
  ) +
  theme_minimal()
