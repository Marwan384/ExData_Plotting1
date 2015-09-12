#Read data from file
hsCons <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

#Concatenate [Date] & [Time] fields into a new field DateTime and convert it to Datetime format. 
#Also convert [Date] field to date
hsCons$DateTime <- paste(hsCons$Date, hsCons$Time)
hsCons <- transform(hsCons, DateTime = strptime(hsCons$DateTime , format='%d/%m/%Y %H:%M:%S'), Date = as.Date(Date,'%d/%m/%Y'))

#Filter the required days only
hsCons2 <- subset(hsCons, Date == "2007-02-01" |  Date == "2007-02-02")

#Create the Plot
with(hsCons2,plot(DateTime, Sub_metering_1, ylab = "", xlab = "", type = "l"))

with(hsCons2,points(DateTime, Sub_metering_2, type = "l", col = "red"))

with(hsCons2,points(DateTime, Sub_metering_3, type = "l", col = "blue"))

title(ylab = "Energy Sub metering")

legend(x = "topright", lwd = 2, cex = .8 ,legend = c("sub_metering_1","sub_metering_2", "sub_metering_3"), col = c("black", "red","blue"))

#Copy the plot to PNG file and close the device
dev.copy(png, "C:/Users/user/Documents/R/Git_Repos/ExData_Plotting1/plot3.png")
dev.off()
