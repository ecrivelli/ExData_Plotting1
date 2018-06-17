#############################################################################################################################################
## Coursera - Exploratory Data Analysis by Johns Hopkins University                                                                        ##
## https://www.coursera.org/learn/exploratory-data-analysis/home/welcome                                                                   ##
##                                                                                                                                         ##
## Course Project - Week 1 - Course Project - plot4()                                                                                      ##
## ---------------------------------------------                                                                                           ##
##                                                                                                                                         ##
## TODO: Change the directory path to reflect your own directory structure                                                                 ##
##                                                                                                                                         ##
## This function creates a new png plot file in your computer with four different plots regarding Household Power consumption in the USA   ##
## between 2007-02-1 and 2007-02-02.                                                                                                       ##
#############################################################################################################################################

plot4 <- function(){
        ###########################################################################################################################
        MY_WORKING_DIRECTORY <- "./ExploratoryDataAnalysis/course_project/" #TODO: change it to reflect your own directory structure
        ###########################################################################################################################
        
        
        # READING DATA
        ##############
        print("READING POWER CONSUMPTION DATA")
        
        power_consumption <-read.csv(paste0(MY_WORKING_DIRECTORY, "/data/household_power_consumption.txt"),sep = ";", na.strings="?",header=TRUE)
        #converting the date column for filtering
        power_consumption$Date <-as.Date(power_consumption$Date, "%d/%m/%Y")
        #We will only be using data from the dates 2007-02-01 and 2007-02-02.
        power_consumption <- subset(power_consumption, 
                                    power_consumption$Date >= as.Date("2007-02-01", "%Y-%m-%d") & power_consumption$Date <= as.Date("2007-02-02", "%Y-%m-%d"))
        #for this exercise we need a Datetime column for ploting
        power_consumption$DateTime <- strptime(paste(power_consumption$Date, power_consumption$Time), "%Y-%m-%d %H:%M:%S")
        
        # CREATING THE PLOT
        ###################
        print("CREATING THE PLOT")
        
        #So it will print weekdays names in English
        Sys.setlocale("LC_TIME", "en_US.UTF-8")
        
        #formating the file name
        plotFile <- paste0(MY_WORKING_DIRECTORY, "plot4.png")
        #call the plotting function to create a new png file
        png(filename = plotFile, width = 480, height = 480)
        
        #setting the environment to receive 4 plots: 2x2
        par(mfrow=c(2,2)) 
        
        #PLOT #1
        ################################################
        #using the plot function to create base plot
        plot(power_consumption$DateTime,
             power_consumption$Global_active_power,
             type = "n", #so it won't try to print
             main = "", 
             xlab = "",
             ylab = "Global Active Power")
        #adding the line
        lines(power_consumption$DateTime, power_consumption$Global_active_power)
        
        #PLOT #2
        ################################################
        #using the plot function to create base plot
        plot(power_consumption$DateTime,
             power_consumption$Voltage,
             type = "n", #so it won't try to print
             main = "", 
             xlab = "datetime",
             ylab = "Voltage")
        #adding the line
        lines(power_consumption$DateTime, power_consumption$Voltage)
        
        #PLOT #3
        ################################################
        #using the plot function to create base plot
        plot(power_consumption$DateTime,
             power_consumption$Global_active_power,
             type = "n", #so it won't try to print
             main = "", 
             xlab = "",
             ylim = c(0,max(power_consumption$Sub_metering_1, power_consumption$Sub_metering_2, power_consumption$Sub_metering_3)),#so max y-axis will display all lines
             ylab = "Energy sub metering")
        #adding the lines
        lines(power_consumption$DateTime, power_consumption$Sub_metering_1, col = "black")
        lines(power_consumption$DateTime, power_consumption$Sub_metering_2, col = "red")
        lines(power_consumption$DateTime, power_consumption$Sub_metering_3, col = "blue")
        #adding legend
        legend("topright", #position 
               c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               lty=1, 
               lwd=2.5, 
               col=c("black", "red", "blue"), 
               bty ="n" #whithout the box border
               )
        
        #PLOT #4
        ################################################
        #using the plot function to create base plot
        plot(power_consumption$DateTime,
             power_consumption$Global_reactive_power,
             type = "n", #so it won't try to print
             main = "", 
             xlab = "datetime",
             ylab = "Global_reactive_power")
        #adding the line
        lines(power_consumption$DateTime, power_consumption$Global_reactive_power)
    
        
        #closing the R graphics device
        dev.off()
        
        # PLOT DONE
        ###################
        print("DONE!")
        print(paste0("Please check your file inside your R working directory at:", plotFile))
        
}