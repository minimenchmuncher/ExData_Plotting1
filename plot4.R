# plot4.R

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

# Create Plot 4 ####
par(mfrow = c(2,2))

plot(x = power_consumption_subset$datetime, y = power_consumption_subset$Global_active_power, type = 'l',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)')
plot(x = power_consumption_subset$datetime, y = power_consumption_subset$Voltage, type = 'l',
     xlab = 'datetime',
     ylab = 'Voltage')

plot(x = power_consumption_subset$datetime, y = power_consumption_subset$Sub_metering_1, type = 'l',
     xlab = NULL,
     ylab = 'Energy Sub Metering')
lines(x = power_consumption_subset$datetime, y = power_consumption_subset$Sub_metering_2, col = 'red')
lines(x = power_consumption_subset$datetime, y = power_consumption_subset$Sub_metering_3, col = 'blue')
legend('top',
       legend = colnames(power_consumption_subset)[7:9],
       lty = 1,
       col = c('black', 'red', 'blue'),
       bty = 'n',
       cex = .8)

plot(x = power_consumption_subset$datetime, y = power_consumption_subset$Global_reactive_power,
     xlab = 'datetime',
     ylab = 'Global_reactive_power', type = 'l')


dev.copy(png,'plot4.png')
dev.off()
