library(dplyr)
library(lubridate)
## loading the data
power <- read.table("household_power_consumption.txt",stringsAsFactors = FALSE, sep = ";",header = TRUE)
dim(power)
str(power)
mypower <- subset(power, power$Date =="1/2/2007"|power$Date=="2/2/2007" )
mypower_df <- tbl_df(mypower)

## checking and converting data
mypower_df <- mutate(mypower_df,DateTime = paste(mypower$Date, mypower$Time, sep="-"))
mypower_df$DateTime <- dmy_hms(mypower_df$DateTime,tz="US/Pacific")
str(mypower_df)
which(mypower_df =="?") ## interger(0)
mypower_df$Global_active_power <-as.numeric(mypower_df$Global_active_power)

# plotting
dev.off()
plot(mypower_df$DateTime,mypower_df$Global_active_power,type="l", ylab ="Global Active Power(kilowatts)", xlab = "")
axis(side = 1,labels =  "Thu",at=mypower_df$DateTime[1])
axis(side = 1,labels =  "Fri",at=mypower_df$DateTime[1441])
axis(side = 1,labels =  "Sat",at=mypower_df$DateTime[2880])

# writing a png file
dev.copy(png, file = "Plot2.png",height=480, width=480)
