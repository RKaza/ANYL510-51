
dirty <- read.csv("~/Desktop/Analytics PRO/Analytics_510/assignment 7/dirty_data.csv", header=TRUE, na.strings=c("","NA"))
names(dirty)
install.packages("zoo")
require(zoo)
install.packages("data.table")
library(data.table)
dirty_no_missing = as.data.table(dirty)
setDT(dirty_no_missing)[,Area := na.locf(na.locf(Area, na.rm=FALSE), fromLast=TRUE) , by = Year]
dirty_no_missing


clean_data <- dirty_no_missing
clean_data$Street <- gsub("[^A-Za-z ]", " ", clean_data$Street)
clean_data$Street <- gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", clean_data$Street, perl=TRUE)
clean_data$Street.2 <- gsub("[^A-Za-z ]", " ", clean_data$Street.2)
clean_data$Street.2 <- gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", clean_data$Street.2, perl=TRUE)


clean_data$Street <- gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", clean_data$Street, perl=TRUE)
clean_data$Street.2 <- gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", clean_data$Street.2, perl=TRUE)

install.packages('gsubfn')
library('gsubfn')

patterns     <- c("Lane", "Road", "Avenue", "Green", "Hospital", "Village", "Center", "Drive", "Circle", "Park","Street")
replacements <- c("Lan.",  "Rd.", "Ave.", "Gr.","Hosp.","Vil.","Ctr.", "Dr.", "Cr.","Pk.","Str.")

clean_data$Street <- gsubfn("\\b\\w+\\b", as.list(setNames(replacements, patterns)), clean_data$Street)
clean_data$Street.2 <- gsubfn("\\b\\w+\\b", as.list(setNames(replacements, patterns)), clean_data$Street.2)



i <- 1

while(i < NROW(clean_data)) {if(clean_data$Street[i] == clean_data$Street.2[i]) {clean_data$Street.2[i] = ""}<- i+1}

dirty_no_missing_no_col <-clean_data
dirty_no_missing_no_col$Strange.HTML <- NULL
View(dirty_no_missing_no_col)
