library (data.table)

#Read File into R
power <- read.table("household_power_consumption.txt", header = TRUE, 
	sep = ";",stringsAsFactors = FALSE,na.strings = "?")

#Subset pwr to Feb 1st, 2nd, 2007
power_subset <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

#Change Columns from character to numeric
power_subset <- transform(power_subset,Global_active_power = as.numeric(Global_active_power))
power_subset <- transform(power_subset,Global_reactive_power = as.numeric(Global_reactive_power))
power_subset <- transform(power_subset,Voltage = as.numeric(Voltage))
power_subset <- transform(power_subset,Global_intensity = as.numeric(Global_intensity))
power_subset <- transform(power_subset, Sub_metering_1 = as.numeric(Sub_metering_1))
power_subset <- transform(power_subset, Sub_metering_2 = as.numeric(Sub_metering_2))
power_subset <- transform(power_subset, Sub_metering_3 = as.numeric(Sub_metering_3))

#Combine Date and Time Columns into one called DateTime
power_subset <- within(power_subset, DateTime <- paste(Date,Time, sep=" "))

#Convert DateTime from Character to POSIXlt date/time:
power_subset <- transform(pwr2, DateTime = strptime(DateTime, "%d/%m/%Y %H:%M:%S"))



#Open png device
png(file = "plot3.png",width = 480,height = 480)

#Plot Sub_metering_1
with(power_subset, plot( DateTime, Sub_metering_1,typ = "l", col ="black",
	ylab = "Energy sub metering",xlab = ""))

#Add Sub_metering_2 to plot
with(power_subset, lines(DateTime, Sub_metering_2,typ = "l", col ="red"))

# Add Sub_metering_3 to plot
with(power_subset, lines(DateTime, Sub_metering_3,typ = "l", col ="blue"))

#Add legend to plot
legend("topright", lty = 1,col = c("black","red","blue"),
 	legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#close png device
dev.off()
