## Load data in variables NEI, SCC

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Calculate sum for emission for every year

TotalEmission <- aggregate(Emissions ~ year,NEI, sum)

## Initiate graph device
png(filename = "plot1.png")

barplot( (TotalEmission$Emissions), names.arg=TotalEmission$year,
  xlab="Year", ylab="PM(2.5) Emissions",  main="Total PM(2.5) Emissions")

dev.off()