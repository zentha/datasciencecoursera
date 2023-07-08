library("data.table")
library("ggplot2")

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")


# Load the NEI & SCC data frames.
summarySCC_PM25 <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
Source_Classification_Code <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

# Gather the subset of the NEI data which corresponds to vehicles
vehicles <- Source_Classification_Code[grepl("Vehicles", Source_Classification_Code$EI.Sector, ignore.case=TRUE), ]
vehicles2 <- summarySCC_PM25[summarySCC_PM25$SCC %in% vehicles$SCC,]
baltimoreVehicles <- vehicles2[fips=="24510",]


png("plot5.png")

ggplot(baltimoreVehicles,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill ="#FF9999" ,width=0.75) +
  labs(x="year", y=expression("Total PM2.5 Emission")) + 
  labs(title=expression("PM2.5 Motor Vehicle in Baltimore from 1999-2008"))

dev.off()

