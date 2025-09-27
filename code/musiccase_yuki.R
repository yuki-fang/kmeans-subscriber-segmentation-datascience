setwd("/Applications/IMC460/")  
library(dplyr)
library(tidyverse)
library(psych)

music_data = read.csv("/Applications/IMC460/music.csv")

#select music questions, ignore time var 
music_questions <- music_data %>%
  select(V28:V54)

music_questions <- music_questions %>%
  filter(complete.cases(.))

head(music_questions)

#scree plot: 
R <- cor(music_questions)
scree(R, factors=FALSE)
round(eigen(R)$values, 1)

fit = principal(music_questions, nfactor=3)
print(fit$loadings, cutoff=0.31, digits=3, sort=TRUE)

# varimax rotation:
fit3 = principal(music_questions, nfactor=3)
fit3
print(fit3$loadings, cutoff=0.3, digits=3, sort=TRUE)

fit3$values

cor(music_questions, fit3$scores)

alpha(music_questions)



# Remove the selected questions
questions_to_drop <- c("V54", "V28", "V29", "V51","V53", "V35", "V48", "V31", "V50","V47", "V33", "V52", "V34","V37", "V36","V40")

# Run PCA without these variables
fit3_updated <- principal(music_questions[, !colnames(music_questions) %in% questions_to_drop], nfactors=3)

# Print updated factor loadings with cutoff 0.3
print(fit3_updated$loadings, cutoff=0.31, digits=3, sort=TRUE)


#cronbach's coefficient alpha:
updated_items <- music_questions[, c("V38", "V39", "V41", "V42", "V30", "V32", "V43", "V46", "V44", "V45", "V49")]

alpha(updated_items)

updated_items

rc1_items <- music_questions[, c("V38", "V39", "V41", "V42")]
alpha(rc1_items)

rc2_items <- music_questions[, c("V30", "V32", "V43", "V46")]
alpha(rc2_items)

rc3_items <- music_questions[, c("V44", "V45", "V49")]
alpha(rc3_items)


# Calculate the average score for each category (Escapism, Cultural Capital, Emotional Resonance)
music_questions$emotional_resonance = (music_questions$V44 + music_questions$V45 + music_questions$V49)/3

music_questions$escapism = (music_questions$V38 + music_questions$V39 + music_questions$V41 + music_questions$V42)/4

music_questions$cultural_capital = (music_questions$V30 + music_questions$V32 + music_questions$V43 + music_questions$V46)/4

# Perform PCA (Principal Component Analysis)
selected_vars <- c( "V38", "V39", "V41", "V42",   # Escapism
                   "V30", "V32", "V43", "V46",  # Cultural Capital
                   "V45", "V49", "V44")  # Emotional Resonance

fit3 = principal(music_questions[, selected_vars], nfactors=3, rotate="promax")

# Correlation between the calculated scores and the PCA factor scores
round(cor(cbind(music_questions[, c("escapism", "cultural_capital", "emotional_resonance")], fit3$scores)), 4)

# Mean of each column (calculated scores and factor scores)
round(apply(cbind(music_questions[, c("escapism", "cultural_capital", "emotional_resonance")], fit3$scores), 2, mean), 4)

# Standard deviation of each column (calculated scores and factor scores)
round(apply(cbind(music_questions[, c("escapism", "cultural_capital", "emotional_resonance")], fit3$scores), 2, sd), 4)

# Minimum value of each column (calculated scores and factor scores)
round(apply(cbind(music_questions[, c("escapism", "cultural_capital", "emotional_resonance")], fit3$scores), 2, min), 4)

# Maximum value of each column (calculated scores and factor scores)
round(apply(cbind(music_questions[, c("escapism", "cultural_capital", "emotional_resonance")], fit3$scores), 2, max), 4)

R = cor(updated_items)
scree(R, factors=F)
round(eigen(R)$values, 1)


music_questions

model <- lm(time1 ~ music_questions$emotional_resonance + music_questions$escapism + music_questions$cultural_capital, data = music_data)
summary(model)

# Compute factor scores by averaging assigned items
music_data$RC1 <- rowMeans(music_questions[, c("V38", "V39", "V41","V42")], na.rm = TRUE)
music_data$RC2 <- rowMeans(music_questions[, c("V30", "V32", "V43", "V46")], na.rm = TRUE)
music_data$RC3 <- rowMeans(music_questions[, c("V44", "V45", "V49")], na.rm = TRUE)

music_data


model <- lm(time1 ~ RC1 + RC2 + RC3, data = music_data)
summary(model)