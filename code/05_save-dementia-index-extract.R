################################################################################.
# Name of file - 05_save-dementia-index-extract.R
# Original Authors - Lucy Binsted
# Original Date - September 2026
#
# Written/run on - R Posit
# Version of R - 4.4.2
#
# Description - Save PDS data to send to Dementia Index Team.
################################################################################.

################################################################################.
### 0 - Load environment file ----
################################################################################.

source(here::here("code", "00_setup-environment.R"))

################################################################################.
### 1 - Read data and select columns ----
################################################################################.

pds_dementia_index <- read_rds(get_mi_data_path(
  type = "clean_data", 
  ext = "rds", 
  fy = fy,
  qt = qt,
  test_output = test_output)) %>% 
  select(
    chi_number, date_of_birth, sex, ethnic_group, postcode, 
    dementia_diagnosis_confirmed_date, subtype_of_dementia, health_board) %>%
  mutate(health_board = str_sub(health_board, 3, -1))

################################################################################.
### 2 - Save data ----
################################################################################.

year <- paste0(fy, "_", substr(as.character(as.numeric(fy) + 1), 3, 4))
filepath <- "/conf/dementia/A&I/IR-PQ-FOI/IR2025-00094 Dementia Index Extract/output/"
filename <- paste0("pds_dementia_index_extract-", year, "-Q", qt)
write_rds(pds_dementia_index, paste0(filepath, filename, ".rds"))
write.csv(pds_dementia_index, paste0(filepath, filename, ".csv"))
