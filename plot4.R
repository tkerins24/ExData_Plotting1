library (data.table)

#Read File into R
power <- read.table("household_power_consumption.txt", header = TRUE, 
	sep = ";",stringsAsFactors = FALSE)

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
power_subset <- transform(power_subset, DateTime = strptime(DateTime, "%d/%m/%Y %H:%M:%S"))



#Open png device
png(file = "plot4.png",width = 480,height = 480)

#Plot Graphs
par(mfrow = c(2,2))
with(power_subset, {
	#Plot (1,1)
	plot(DateTime,Global_active_power, type = "l", 
		ylab = "Global Active Power (kilowatts)",xlab = "")
	#Plot (1,2)
	plot(DateTime,Voltage, type = "l", 
		ylab = "Voltage",xlab = "datetime")
	#Plot (2,1)
	plot(DateTime, Sub_metering_1,typ = "l", col ="black",
		ylab = "Energy sub metering",xlab = "")
	lines(DateTime, Sub_metering_2,typ = "l", col ="red")
	lines(DateTime, Sub_metering_3,typ = "l", col ="blue")
	legend("topright", lty = 1,col = c("black","red","blue"),
 		legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
	#Plot (2,2)
	plot(DateTime,Global_reactive_power, typ = "l", 
		xlab = "datetime")
})	

#close png device
dev.off()
