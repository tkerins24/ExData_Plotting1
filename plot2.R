library (data.table)

#Read File into R
power <- read.table("household_power_consumption.txt", header = TRUE, 
	sep = ";",stringsAsFactors = FALSE,na.strings = "?")

#Subset pwr to Feb 1st, 2nd, 2007
power_subset <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

#Change Global_active_power to numeric
power_subset <- transform(power_subset,Global_active_power = as.numeric(Global_active_power))

#Combine Date and Time Columns into one called DateTime
power_subset <- within(power_subset, DateTime <- paste(Date,Time, sep=" "))

#Convert DateTime from Character to POSIXlt date/time:
power_subset <- transform(power_subset, DateTime = strptime(DateTime, "%d/%m/%Y %H:%M:%S"))

#Open png device
png(file = "plot2.png",width = 480,height = 480)

#Plot graph of Global Active Power as a function of DateTime
with(power_subset, plot(DateTime,Global_active_power, type = "l", 
	ylab = "Global Active Power (kilowatts)",xlab = ""))

#close png device
dev.off()