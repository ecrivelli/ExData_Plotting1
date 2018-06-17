#############################################################################################################################################
## Coursera - Exploratory Data Analysis by Johns Hopkins University                                                                        ##
## https://www.coursera.org/learn/exploratory-data-analysis/home/welcome                                                                   ##
##                                                                                                                                         ##
## Course Project - Week 1 - Course Project - plot2()                                                                                      ##
## ---------------------------------------------                                                                                           ##
##                                                                                                                                         ##
## TODO: Change the directory path to reflect your own directory structure                                                                 ##
##                                                                                                                                         ##
## This function creates a new png plot file in your computer with Global Active Power regarding Household Power consumption in the USA    ##
## for the period of 2007-02-1 and 2007-02-02.                                                                                             ##
#############################################################################################################################################

plot2 <- function(){
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
        plotFile <- paste0(MY_WORKING_DIRECTORY, "plot2.png")
        #call the plotting function to create a new png file
        png(filename = plotFile, width = 480, height = 480)
        
        
        #using the plot function to create base plot
        plot(power_consumption$DateTime,
             power_consumption$Global_active_power,
             type = "n", #so it won't try to print
             main = "", 
             xlab = "",
             ylab = "Global Active Power (kilowatts)")
        #adding the line
        lines(power_consumption$DateTime, power_consumption$Global_active_power)
        
        
        #closing the R graphics device
        dev.off()
        
        # PLOT DONE
        ###################
        print("DONE!")
        print(paste0("Please check your file inside your R working directory at:", plotFile))
        
}