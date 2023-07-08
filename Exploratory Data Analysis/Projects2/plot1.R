library("data.table")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

#Source_Classification_Code <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
summarySCC_PM25 <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# Prevents histogram from printing in scientific notation
summarySCC_PM25[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
summarySCC_PM25 <- summarySCC_PM25[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

png("plot1.png", width=480, height=480)
barplot(summarySCC_PM25[, Emissions]
        , names = summarySCC_PM25[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")
dev.off()
