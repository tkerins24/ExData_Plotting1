library (data.table)

#Read File into R
power <- read.table("household_power_consumption.txt", header = TRUE, 
	sep = ";",stringsAsFactors = FALSE,na.strings = "?")

#Subset power to Feb 1st, 2nd, 2007)
power_subset <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

#Change Global_active_power to numeric
power_subset <- transform(power_subset,Global_active_power = as.numeric(Global_active_power))

#Open png device
png(file = "plot1.png", width = 480, height = 480)

#Plot histogram
hist(power_subset$Global_active_power, col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")

#close png device
dev.off()