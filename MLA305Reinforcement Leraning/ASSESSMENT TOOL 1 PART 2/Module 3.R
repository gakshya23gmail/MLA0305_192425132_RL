cat("\014")
cat("      MARKOV DECISION PROCESS (MDP)\n")
cat("      MODULE 3 : DISPLAY REWARD FOR EACH ACTION\n")
states <- c("S1","S2","S3")
actions <- c("Left","Right")

reward_table <- data.frame(
  Current_State = c("S1","S1","S2","S2","S3","S3"),
  Action = c("Left","Right","Left","Right","Left","Right"),
  Next_State = c("S2","S3","S1","S3","S2","S1"),
  Reward = c(5,10,3,8,6,4)
)

cat("COMPLETE REWARD TABLE\n\n")
print(reward_table)
cat("REWARD FOR EACH ACTION\n")
for(action in actions)
{
  cat("\nAction :", action, "\n")
  cat("---------------------------------------------\n")
  
  action_data <- subset(reward_table, Action == action)
  
  print(action_data)
  
  cat("\nNumber of Rewards :", nrow(action_data), "\n")
  cat("Total Reward      :", sum(action_data$Reward), "\n")
  cat("Average Reward    :", mean(action_data$Reward), "\n")
  cat("Maximum Reward    :", max(action_data$Reward), "\n")
  cat("Minimum Reward    :", min(action_data$Reward), "\n")
}
cat("ACTION WISE REWARD SUMMARY\n")
summary_table <- aggregate(
  Reward ~ Action,
  
  data = reward_table,
  FUN = sum
)

print(summary_table)
cat("MODULE 3 EXECUTED SUCCESSFULLY\n")