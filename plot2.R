# Justin Owens
# Exploratory Data Analysis
# Week 1
# 1/14/2018

# require any necessary packages
require('data.table')

# read in data file if it doesn't exist
if(!exists("powerdata")){
	# calculate estimated memory: rows * columns * bytes / 2^(20) = MB /1024 = GB
	est_mem = round(((2075259 * 9 * 8) / (2^20)) / 1024, 2)
	print(paste('Estimated memory is:', as.character(est_mem), 'GB', sep = ' '))

	powerdata = fread('./household_power_consumption.txt', header = TRUE, sep = ';', na.strings = '?', colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

	# convert time and date to proper classes
	powerdata[, Time := strptime(paste(powerdata[,Date], powerdata[,Time], sep = ' '), '%d/%m/%Y %H:%M:%S')]
	powerdata[, Date := as.Date(powerdata[, Date], '%d/%m/%Y')]

	# get subset of data based on necessary dates 2007-02-01 to 2007-02-02
	powerdata = subset(powerdata, Date >= as.Date('01/02/2007', '%d/%m/%Y') & Date <= as.Date('02/02/2007', '%d/%m/%Y'))
}

# set graphics device
png('plot2.png', width= 480, height = 480, units = 'px')

# plot 2 line graph
title = ''
yaxislab = 'Global Active Power (kilowatts)'
xaxislab = ''
plot(powerdata$Time, powerdata$Global_active_power, type = 'l', ylab = yaxislab, xlab = xaxislab, main = title)

# close device so output saves correctly
dev.off()