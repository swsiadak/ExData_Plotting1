library(data.table)

url <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("power.zip")) {
    download.file(url,"power.zip")
}

if (!file.exists("./household_power_consumption.txt")) {
    unzip("power.zip")
}
dt <- fread("./household_power_consumption.txt")

dt[, Date := as.Date(dt$Date, tryFormats = c("%d/%m/%Y"))]
dt[, DateTime := as.POSIXct(paste(dt$Date, dt$Time), format="%Y-%m-%d %H:%M:%S")]

subdt <- subset(dt, Date==as.Date("2007-02-01") | Date==as.Date("2007-02-02"))
subdt[, Sub_metering_1 := as.numeric(subdt$Sub_metering_1)]
subdt[, Sub_metering_2 := as.numeric(subdt$Sub_metering_2)]
subdt[, Sub_metering_3 := as.numeric(subdt$Sub_metering_3)]

png(file="plot3.png", width=480, height=480, units="px", bg="transparent")
plot(subdt$DateTime, subdt$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(subdt$DateTime, subdt$Sub_metering_2, type="l", col="red")
lines(subdt$DateTime, subdt$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1), bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
