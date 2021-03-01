library(dplyr)
## loading the data
power <- read.table("household_power_consumption.txt",stringsAsFactors = FALSE, sep = ";",header = TRUE)
dim(power)
str(power)
mypower <- subset(power, power$Date =="1/2/2007"|power$Date=="2/2/2007" )
mypower_df <- tbl_df(mypower)

## checking and converting data
mypower_df <- mutate(mypower_df,DateTime = paste(mypower$Date, mypower$Time, sep="-"))
mypower_df$DateTime <- as.POSIXct(mypower_df$DateTime, "%d/%m/%Y-%H:%M:%S",tz="US/Pacific")
str(mypower_df)
which(mypower_df =="?") ## interger(0)
mypower_df$Global_active_power <-as.numeric(mypower_df$Global_active_power)

# plotting
dev.off()
hist(mypower_df$Global_active_power, col ="red",xlab = "Global Active Power(kilowatts)", main ="Global Active Power")

# writing a png file
dev.copy(png, file = "Plot1.png",height=480, width=480)
