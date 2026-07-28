cat("\014")

cat("=========================================================\n")
cat("      MARKOV DECISION PROCESS (MDP)\n")
cat("   MODULE 2 : DISPLAY TRANSITION PROBABILITY FOR ACTION\n")
cat("=========================================================\n\n")

states <- c("S1","S2","S3")
actions <- c("Left","Right")

transition_table <- data.frame(
  Current_State = c("S1","S1","S2","S2","S3","S3"),
  Action = c("Left","Right","Left","Right","Left","Right"),
  Next_State = c("S2","S3","S1","S3","S2","S1"),
  Probability = c(0.80,0.20,0.60,0.40,0.50,0.50)
)

cat("COMPLETE TRANSITION PROBABILITY TABLE\n\n")
print(transition_table)

cat("\n=========================================================\n")
cat("TRANSITION PROBABILITY FOR EACH ACTION\n")
cat("=========================================================\n")

for(action in actions)
{
  cat("\nAction :", action, "\n")
  cat("---------------------------------------------\n")
  
  action_data <- subset(transition_table, Action == action)
  
  print(action_data)
  
  cat("\nNumber of Transitions :", nrow(action_data), "\n")
  cat("Total Probability     :", sum(action_data$Probability), "\n")
}

cat("\n=========================================================\n")
cat("ACTION WISE TRANSITION SUMMARY\n")
cat("=========================================================\n")

summary_table <- aggregate(
  Probability ~ Action,
  data = transition_table,
  FUN = sum
)

print(summary_table)

cat("MODULE 2 EXECUTED SUCCESSFULLY\n")