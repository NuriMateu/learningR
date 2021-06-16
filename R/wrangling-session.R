# load up to packages
source(here::here("R/package-loading.R"))

# briefly glimpse content of dataset
glimpse(NHANES)
select(NHANES, Age, Weight, BMI)

# exclude a column
select(NHANES, -HeadCirc)

#all columns starting with BP
select(NHANES, starts_with("BP"))

#all the columns that ends with Day
select(NHANES,ends_with("Day"))

#all columns that contain "Age
select(NHANES, contains("Age"))

?select_helpers
# save the selected columns as a new data frame
nhanes_small <- select(NHANES, Age, Gender, Height,
                       Weight, BMI, Diabetes, DiabetesAge,
                       PhysActiveDays, PhysActive, TotChol,
                       BPSysAve, BPDiaAve, SmokeNow, Poverty)

#view the name of the data frame
nhanes_small

#renaming
#rename all columns to snake case
nhanes_small <- rename_with(nhanes_small, snakecase::to_snake_case)

nhanes_small

#rename specific columns
rename(nhanes_small, sex = gender)
nhanes_small
#we save it (otherwise it does not change gender for sex)
nhanes_small<- rename(nhanes_small, sex = gender)
nhanes_small

#try pipe operator

#without the pipe operator
colnames(nhanes_small)

nhanes_small %>% colnames()

#using the pipe operator with more functions
nhanes_small %>%
    select(phys_active) %>%
    rename(physically_active = phys_active)
#test

nhanes_small %>%
    select(tot_chol, bp_sys_ave, poverty)
nhanes_small %>%
    rename(diabetes_diagnosis_age = diabetes_age)

nhanes_small %>%
    select(bmi, contains("age"))

##filtering
#filter for all females

nhanes_small %>%
    filter(sex == "female")

#filter participants that are not females
nhanes_small %>%
    filter(sex !="female")

# participants with BMI equal 25
nhanes_small %>%
    filter(bmi == 25)

# particpants with bmi higher and equal to 25
nhanes_small %>%
    filter(bmi >= 25)

# participants with BMI over 25 and females
nhanes_small %>%
    filter(bmi > 25 & sex =="female")

# participants with BMI over 25 or females
nhanes_small %>%
    filter(bmi > 25 | sex =="female")

##arrange data
#arrange age in ascending order
nhanes_small %>%
    arrange(age)

#arrange sex in ascending order
nhanes_small %>%
    arrange(sex)

# Arranging data by age in descending order
nhanes_small %>%
    arrange(desc(age))

# Arranging data by sex then age in ascending order
nhanes_small %>%
    arrange(sex, age)

##transform or add columns
nhanes_small %>%
    mutate(height = height / 100)

#add a new column with logged height values
nhanes_small %>%
    mutate(logged_height = log(height)) %>%
    select(logged_height)

#add more than one column at the samme time
nhanes_small %>%
    mutate(height = height / 100,
           logged_height = log(height))

#add a logic condition
nhanes_small %>%
    mutate(highly_active = if_else(phys_active_days >= 5, "yes", "no")) %>%
    select(highly_active)

## save to the data set
nhanes_update <- nhanes_small %>%
    mutate(height = height / 100,
           logged_height = log(height),
           highly_active = if_else(phys_active_days >= 5, "Yes", "No"))

## summary statistics
nhanes_small %>%
    summarise(max_bmi = max(bmi))
nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE))

#calculating 2 summary statistics
nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE),
              min_bmi = min(bmi, na.rm = TRUE))

# 1.
nhanes_small %>%
    summarise(mean_weight = mean(weight, na.rm = TRUE),
              mean_age = mean(age, na.rm = TRUE)

# 2.
nhanes_small %>%
    summarise(max_height = max(height, na.rm = TRUE),
              min_height = min(height, na.rm = TRUE)

# 3.
nhanes_small %>%
    summarise(median_age = median(age, na.rm = TRUE),
              median_phys_active_days = median(phys_active_days, na.rm = TRUE))

# calculate summary statistics by groups
nhanes_small %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE))


nhanes_small %>%
    # Recall ! means "NOT", so !is.na means "is not missing"
    filter(!is.na(diabetes)) %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE)) %>%
ungroup()

## save data sets as files
#saving data as an .rda file in the data folder
usethis::use_data(nhanes_small, overwrite = TRUE)
