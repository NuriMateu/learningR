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
