library(tidyverse)
library(tidyquant)
library(magrittr)
library(timetk)

# Get all stock symbols in a stock index
# tq_index_options()
# sp500 <- tq_index("SP500")

# Get all stock symbol in 3 stock exchanges
##tq_exchange_options()
amex <- tq_exchange("AMEX")
nasdaq <- tq_exchange("NASDAQ")
nyse <- tq_exchange("NYSE")

## Combine all stocks
stocklist <- rbind(amex, nasdaq, nyse)

## Delete replicates
stocklist %<>% distinct()

# Get stock price
stockprice <- tq_get(x = stocklist$symbol[1], 
                     get = "stock.prices", 
                     from = "2020-07-01", 
                     to = "2020-12-01", 
                     curl.options = list(ssl_verifypeer = 0))


n <- nrow(stocklist)

for (i in 2:n){
  print(i)
  singlestock <- tq_get(x = stocklist$symbol[i], 
                        get = "stock.prices", 
                        from = "2020-07-01", 
                        to = "2020-12-01", 
                        curl.options = list(ssl_verifypeer = 0))
  stockprice = rbind(stockprice, singlestock)
}

#Save file
setwd("/Users/amelia/Documents/mssp/MA615/MA615_FinalProject/MA615_FinalProject")
save(stocklist, file = "stocklist.RData")
save(stockprice, file = "stockprice.RData")







