#Read data from file
hsCons <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

#Concatenate [Date] & [Time] fields into a new field DateTime and convert it to Datetime format. 
#Also convert [Date] field to date
hsCons$DateTime <- paste(hsCons$Date, hsCons$Time)
hsCons <- transform(hsCons, DateTime = strptime(hsCons$DateTime , format='%d/%m/%Y %H:%M:%S'), Date = as.Date(Date,'%d/%m/%Y'))

#Filter the required days only
hsCons2 <- subset(hsCons, Date == "2007-02-01" |  Date == "2007-02-02")


par(mfrow = c(2,2), mar = c(4,4.5,2,2), cex.lab = .7)
#Create the first Plot
with(hsCons2,plot(DateTime, Global_active_power, ylab = "Global Active Power", xlab = "", type = "l"))


#Create second graph
with(hsCons2,plot(DateTime, Voltage, ylab = "Voltage", xlab = "datetime", type = "l"))

#Create thrid graph
with(hsCons2,plot(DateTime, Sub_metering_1, ylab = "", xlab = "", type = "l"))

with(hsCons2,points(DateTime, Sub_metering_2, type = "l", col = "red"))

with(hsCons2,points(DateTime, Sub_metering_3, type = "l", col = "blue"))

title(ylab = "Energy Sub metering")

legend(x = "top", lwd = 1, cex = .6, bty = "n", legend = c("sub_metering_1","sub_metering_2", "sub_metering_3"), col = c("black", "red","blue"))


#Create Fourth graph
with(hsCons2,plot(DateTime, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l"))


#Copy the plot to PNG file and close the device
dev.copy(png, "C:/Users/user/Documents/R/Git_Repos/ExData_Plotting1/plot4.png")
dev.off()
