cat("\014")

cat("=========================================================\n")
cat("      MARKOV DECISION PROCESS (MDP)\n")
cat(" MODULE 1 : TRANSITION PROBABILITY AND REWARD TABLE\n")
cat("=========================================================\n\n")

states <- c("S1","S2","S3")
actions <- c("Left","Right")

cat("States:\n")
print(states)

cat("\nActions:\n")
print(actions)

transition_table <- data.frame(
  Current_State = c("S1","S1","S2","S2","S3","S3"),
  Action = c("Left","Right","Left","Right","Left","Right"),
  Next_State = c("S2","S3","S1","S3","S2","S1"),
  Probability = c(0.80,0.20,0.60,0.40,0.50,0.50)
)

cat("\n=========================================================\n")
cat("TRANSITION PROBABILITY TABLE\n")
cat("=========================================================\n")

print(transition_table)

reward_table <- data.frame(
  Current_State = c("S1","S1","S2","S2","S3","S3"),
  Action = c("Left","Right","Left","Right","Left","Right"),
  Next_State = c("S2","S3","S1","S3","S2","S1"),
  Reward = c(5,10,3,8,6,4)
)

cat("\n=========================================================\n")
cat("REWARD TABLE\n")
cat("=========================================================\n")

print(reward_table)

cat("\n=========================================================\n")
cat("SUMMARY\n")
cat("=========================================================\n")

cat("Number of States      :", length(states), "\n")
cat("Number of Actions     :", length(actions), "\n")
cat("Transition Entries    :", nrow(transition_table), "\n")
cat("Reward Entries        :", nrow(reward_table), "\n")

cat("\nModule 1 Executed Successfully.\n")