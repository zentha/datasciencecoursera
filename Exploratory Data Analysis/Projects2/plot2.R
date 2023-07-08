library("data.table")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

#Source_Classification_Code <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
summarySCC_PM25 <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# Prevents histogram from printing in scientific notation
summarySCC_PM25[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
summarySCC_PM25 <- summarySCC_PM25[fips=='24510', lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

png("plot2.png", width=480, height=480)
barplot(summarySCC_PM25[, Emissions]
        , names = summarySCC_PM25[, year]
        , xlab = "Years", ylab = "Baltimore City Emissions from PM2.5"
        , main = "Total emissions in the Baltimore City from 1999 to 2008")
dev.off()
