library("data.table")
library("ggplot2")

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

#Source_Classification_Code <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
summarySCC_PM25 <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# Prevents histogram from printing in scientific notation
Baltimore <- summarySCC_PM25[fips=='24510',]

png("plot3.png")
ggplot(Baltimore,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("Emissions in Baltimore City 1999-2008 by Type"))

dev.off()
