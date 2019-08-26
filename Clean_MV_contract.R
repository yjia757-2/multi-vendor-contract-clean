library(dplyr)

mvs <- read.csv("MV_Contract.csv", stringsAsFactors = FALSE) %>% select(-Solden_To_Number,-Sold_To_Grid,-Contract_Start_Date)
mvs$Contract_End_Date <- as.Date(mvs$Contract_End_Date, format = "%m/%d/%Y")

# find the earliest date of a contract number and sum the value up 
mvs1 <- mvs %>% group_by(Account, Contract_Number) %>% summarise(Contract_End_Date = min(Contract_End_Date))
mvs2 <- mvs %>% group_by(Account, Contract_Number) %>% summarise(Net_Value = sum(Net_Value))
mvs3 <- inner_join(mvs1, mvs2, by = c("Account", "Contract_Number"))
mvs4 <- distinct(mvs[,c(1,5:7)])
mvs5 <- left_join(mvs3,mvs4,by="Account")

write.csv(mvs5, "Clean_MV_Contract.csv", row.names = FALSE)