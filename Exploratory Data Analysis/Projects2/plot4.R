library("data.table")
library("ggplot2")

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")


# Load the NEI & SCC data frames.
summarySCC_PM25 <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
Source_Classification_Code <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

# Subset coal combustion related NEI data
Source_Classification_Code <- Source_Classification_Code[grepl("Combustion", Source_Classification_Code$SCC.Level.One) | 
                                                            grepl("Coal", Source_Classification_Code$SCC.Level.Four), ]

summarySCC_PM25 <- summarySCC_PM25[summarySCC_PM25$SCC %in% unique(Source_Classification_Code$SCC),]

png("plot4.png")

ggplot(summarySCC_PM25,aes(x = factor(year),y = Emissions)) +
  geom_bar(stat="identity", fill ="#FF9999", width=0.75) +
  labs(x="year", y=expression("Total PM2.5 Emission")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

dev.off()
