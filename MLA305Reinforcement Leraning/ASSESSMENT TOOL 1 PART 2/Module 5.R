cat("\014")
cat("MODULE 5 : VISUALIZATION OF BEST ACTION\n\n")

# Transition and Reward Table
transition_table <- data.frame(
  Current_State = c("S1","S1","S2","S2","S3","S3"),
  Action = c("Left","Right","Left","Right","Left","Right"),
  Next_State = c("S2","S3","S1","S3","S2","S1"),
  Probability = c(0.80,0.20,0.60,0.40,0.50,0.50),
  Reward = c(5,10,3,8,6,4)
)

# Calculate Expected Reward
transition_table$Expected_Reward <-
  transition_table$Probability * transition_table$Reward

# Action-wise Expected Reward
action_summary <- aggregate(
  Expected_Reward ~ Action,
  data = transition_table,
  sum
)

# Find Best Action
best_index <- which.max(action_summary$Expected_Reward)
best_action <- action_summary$Action[best_index]
best_reward <- action_summary$Expected_Reward[best_index]

# Colors
bar_colors <- rep("lightblue", nrow(action_summary))
bar_colors[best_index] <- "green"

# Save Graph
png("Best_Action_Visualization.png", width = 800, height = 600)

bp <- barplot(
  action_summary$Expected_Reward,
  names.arg = action_summary$Action,
  col = bar_colors,
  border = "black",
  ylim = c(0, max(action_summary$Expected_Reward)+2),
  main = "Best Action Based on Expected Immediate Reward",
  xlab = "Actions",
  ylab = "Expected Reward"
)

text(
  bp[best_index],
  best_reward + 0.5,
  labels = paste("Best:", best_action),
  col = "red",
  font = 2,
  cex = 1.2
)

dev.off()

# Display Graph
bp <- barplot(
  action_summary$Expected_Reward,
  names.arg = action_summary$Action,
  col = bar_colors,
  border = "black",
  ylim = c(0, max(action_summary$Expected_Reward)+2),
  main = "Best Action Based on Expected Immediate Reward",
  xlab = "Actions",
  ylab = "Expected Reward"
)

text(
  bp[best_index],
  best_reward + 0.5,
  labels = paste("Best:", best_action),
  col = "red",
  font = 2,
  cex = 1.2
)

cat("\nBEST ACTION :", best_action, "\n")
cat("EXPECTED REWARD :", best_reward, "\n")
cat("Graph saved as 'Best_Action_Visualization.png'\n")
cat("\nMODULE 5 EXECUTED SUCCESSFULLY\n")


library(DiagrammeR)

grViz("
digraph {

graph [rankdir=TB]

node [shape=box style=filled fillcolor=lightblue fontsize=16]

A [label='START']
B [label='Transition Table']
C [label='Calculate Expected Rewards']
D [label='Compare Actions']
E [label='Best Action = LEFT']
F [label='Expected Reward = 8.8']
G [label='END']

A -> B
B -> C
C -> D
D -> E
E -> F
F -> G

}
")