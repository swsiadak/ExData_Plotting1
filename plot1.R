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

png(file="plot1.png", width=480, height=480, units="px", bg="transparent")
hist(as.numeric(subdt$Global_active_power), col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
