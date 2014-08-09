# plot3.R

filename = "./data/household_power_consumption.txt"
             
# read data, use some optimizations 
d0 = read.table(filename,quote="",
                comment.char="",
                colClasses=c("character","character",rep("numeric",7)),  
                na.strings="?",        # recognize as NA 
                nrows=2100000,         # estimate rows -> storage  
                sep=";", header=T)

# get and convert dates for needed selection 
date0 = as.Date(d0$Date,"%d/%m/%Y")    ## convert to yyyy-mm-dd
date0c = as.character(date0)          ## convert to character

# extract relevant data - 2880 records (1 per minute)
ds = d0[date0c >= "2007-02-01" & date0c <= "2007-02-02",]

# create png plots 480x480 

# combine date+time and convert to POSIXlt 
ds$date_time_0 = paste(as.character(ds$Date), as.character(ds$Time))
ds$date_time_1 = as.POSIXlt(strptime(ds$date_time_0, "%d/%m/%Y %H:%M:%S"))

# Plot 3
png(filename="plot3.png",
    width=480,height=480)

par(mar=c(6,4,1,1)+0.1)
plot(x=ds$date_time_1, 
     y=ds$Sub_metering_1,     # determines y-axis 
     type="l",
     sub="Note: Weekday labels are in German due to R configuration",
     cex.sub=0.8,             # reduce font for sub-title 
     col="black",
     xlab=" ",
     ylab="Energy sub metering ")

points(x=ds$date_time_1,
       y=ds$Sub_metering_2,
       type="l",
       col="red")

points(x=ds$date_time_1,
       y=ds$Sub_metering_3,
       type="l",
       col="blue")
 
legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1,lwd=1,
       cex=0.7,
       col=c("black", "red", "blue"))

dev.off()
