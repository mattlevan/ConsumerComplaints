library("arules")
library("arulesViz")
library("stats")
library("ggplot2")

# Load the raw data from the .csv file.
complaints <- read.csv("Consumer_Complaints.csv", header = TRUE)
# Load the .csv as transactions using the "basket" format.
transactions <- read.transactions("Consumer_Complaints.csv",
                                  rm.duplicates = TRUE,
                                  format = "basket",
                                  sep = ",")
# Create rules using a call to apriori on the transactions.
rules <- apriori(transactions,
                 parameter = list(support = 0.01, confidence = 0.5))
# Check out a few visualizations of the rules.
plot(rules)
plot(rules, measure = c("support", "lift"), shading = "confidence")
plot(rules, shading = "order", control = list(main ="Two-key Plot"))

# Store a plot of rules in sel.
sel = plot(rules, 
           measure=c("support","lift"), 
           shading="confidence", 
           interactive=TRUE)
 
# Build subrules.
subrules = rules[quality(rules)$confidence > 0.8];
