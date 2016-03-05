# plot2.R

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

power_consumption_subset <- filter(power_consumption, Date == '2007-02-01' | Date == '2007-02-02') %>%
  mutate(datetime = ymd_hms(paste(Date, format(Time, format = '%H:%M:%S'))))

# Create Plot 2 ####
plot(x = power_consumption_subset$datetime, y = power_consumption_subset$Global_active_power, type = 'l',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)')

dev.copy(png,'plot2.png')
dev.off()
