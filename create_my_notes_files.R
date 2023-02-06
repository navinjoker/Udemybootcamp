# ipak function: install and load multiple R packages.
# Check to see if packages are installed. 
# Install them if they are not, then load them into the R session.
# Forked from: https://gist.github.com/stevenworthington/3178163
ipak <- function(pkg) {
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)){
    install.packages(new.pkg, dependencies = TRUE)
  }
  suppressPackageStartupMessages(sapply(pkg, require, character.only = TRUE))
}

ipak(c("tidyverse", "tidylog", "fs", "pacman"))

pacman::p_load_gh(
"trinker/lexicon",
"trinker/textclean"
)


############################################################
#                                                          #
#                          unzip                           #
#                                                          #
############################################################

if (!file.exists("Refactored_Py_DS_ML_Bootcamp-master/00-Welcome to the Course.ipynb")){
  unzip("Py-DS-ML-Bootcamp-master.zip")
} else {
  print("Files exists!")
}

############################################################
#                                                          #
#                   clean up ipynb names                   #
#                                                          #
############################################################

names_md <- 
  fs::dir_info(
  path = "Refactored_Py_DS_ML_Bootcamp-master/",
  recurse = TRUE,
  regexp = "*.ipynb$"
    ) %>% 
  select(path) %>% 
  pull() %>% 
  str_remove("Refactored_Py_DS_ML_Bootcamp-master/") %>% 
  str_replace_all("/", "_") %>% 
  str_replace_all(" - ", "_") %>% 
  str_replace_all(" ", "_") %>% 
  str_to_lower() %>% 
  str_remove("\\..+") %>% 
  paste0(".md")

############################################################
#                                                          #
#                   create my notes dir                    #
#                                                          #
############################################################

fs::dir_create("my-study-notes")

############################################################
#                                                          #
#                     save notes files                     #
#                                                          #
############################################################

my_dir <- "my-study-notes/"

if (!file.exists(paste0(my_dir, names_md[1]))){
  
  for (i in seq_along(names_md)) {
   
    # open file to save
    sink(paste0(my_dir, names_md[i]))
    # write inside file
    cat(paste("# TODO:", names_md[i] %>% str_remove("\\..+")))
    # close/create file
    sink()
  
  }
  
} else {
  
  print("esses arquivos já existem")
  
}

############################################################
#                                                          #
#            to create a issue with checkboxes             #
#                                                          #
############################################################

# copy and paste in a new issue on github
for (i in seq_along(names_md)) {
  cat(paste("- [ ]", names_md[i] %>% str_remove("\\..+")), "\n")
}
