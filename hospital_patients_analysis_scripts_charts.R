# Load libraries 
library(tidyverse)
library(ggplot2)

# Read your dataset
hospital <- read_csv("healthcare_dateset_work.csv", show_col_types = FALSE)
hospital

# Inspect the hospital dataset
glimpse(hospital)

# Create age_group & stay_length in R
hospital <- hospital %>%
  mutate(
    stay_length = as.numeric(`Discharge Date` - `Date of Admission`),
    age_group = case_when(
      Age < 18 ~ "Child",
      Age <= 35 ~ "Yound Adult",
      Age <= 60 ~ "Adult",
      TRUE ~ "Senior"
    )
  )
hospital

# Medical Condition 
hospital %>%
  count(`Medical Condition`, sort = TRUE) %>%
  ggplot(aes(x = reorder(`Medical Condition`, n), y = n, fill = `Medical Condition`)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Most Common Medical Conditions",
    x = "Medical Condition",
    y = "Number of Patients"
  )

# Gender Distribution
hospital %>%
  count(Gender) %>%
  ggplot(aes(x = Gender, y = n, fill = Gender)) +
  geom_col() +
  labs(
    title = "Gender Distribution",
    x = "Gender",
    y = "Number of Patients"
  ) 

# Average Billing by Condition
hospital %>%
  group_by(`Medical Condition`) %>%
  summarise(avg_billing = mean(`Billing Amount`)) %>%
  arrange(desc(avg_billing)) %>%
  ggplot(aes(x = reorder(`Medical Condition`, avg_billing), y = avg_billing, fill = `Medical Condition`)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Average Billing by Condition",
    x = "Medical Condition",
    y = "Average Billing"
  )

# Hospital Load (Top 10)
hospital %>%
  count(Hospital, sort = TRUE) %>%
  slice_head(n = 10) %>%
  ggplot(aes(x = reorder(Hospital, n), y = n, fill = Hospital)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 10 Hospital by Patients Load",
    x = "Hospital",
    y = "Number of Patients"
  )

# Insurance Distribution
hospital %>%
  count(`Insurance Provider`, sort = TRUE) %>%
  ggplot(aes(x = reorder(`Insurance Provider`, n), y = n, fill = `Insurance Provider`)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Insurance Provider Distribution",
    x = "Insurance Provider",
    y = "Patients Covered"
  )

# Admission Type
hospital %>%
  count(`Admission Type`) %>%
  ggplot(aes(x = `Admission Type`, y = n, fill = `Admission Type`)) +
  geom_col() +
  labs(
    title = "Admission Type Distribution",
    x = "Admission Type",
    y = "Number of Patients"
  )

# Avg Stay Length by Condition
hospital %>%
  group_by(`Medical Condition`) %>%
  summarise(avg_stay_length = mean(stay_length)) %>%
  arrange(`Medical Condition`) %>%
  ggplot(aes(x = reorder(`Medical Condition`, avg_stay_length), y = avg_stay_length, fill = `Medical Condition`)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Average Stay Length by Condition",
    x = "Medical Condition",
    y = "Days"
  )

# Age Group Distribution
hospital %>%
  count(age_group) %>%
  ggplot(aes(x = age_group, y = n, fill = age_group)) +
  geom_col() +
  labs(
    title = "Age Group Distribution",
    x = "Age Group",
    y = "Number of Patients"
  )

# Condition + Gender
hospital %>%
  group_by(`Medical Condition`, Gender) %>%
  summarise(total_billing = sum(`Billing Amount`), .groups = "drop") %>%
  ggplot(aes(x = `Medical Condition`, y = total_billing, fill = Gender)) +
  geom_col(position = "stack") +
  coord_flip() +
  labs(
    title = "Billing by Condition and Gender",
    x = "Medical Condition",
    y = "Total Billing"
  )
