# plot1.R

library(dplyr)
library(readr)
library(lubridate)

# read data ####
power_consuption_path <- '~/Downloads/household_power_consumption.txt'

power_consumption <- read_delim(file = power_consuption_path, delim = ';', col_types = cols(
  col_date('%d/%m/%Y'),
  col_time('%H:%M:%S'),
  col_double(),
  col_double(),
  col_double(),
  col_double(),
  col_double(),
  col_double(),
  col_double()
), na = '?')

power_consumption_subset <- filter(power_consumption, Date == '2007-02-01' | Date == '2007-02-02')

# Create Plot 1 ####
hist(power_consumption_subset$Global_active_power,
     xlab = 'Global Active Power (kilowatts)',
     ylab = 'Frequency',
     col = 'red',
     main = 'Global Active Power')

dev.copy(png,'plot1.png')
dev.off()
