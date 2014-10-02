## Load data in variables NEI, SCC

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## LA County and Baltimore data identified on fips
baltimoreData <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
laData <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# totals
baltimoreDataFrame <- aggregate(baltimoreData[, 'Emissions'], by = list(baltimoreData$year), sum)
colnames(baltimoreDataFrame) <- c('year', 'Emissions')
baltimoreDataFrame$City <- paste(rep('Baltimore City', 4))

laDataFrame <- aggregate(laData[, 'Emissions'], by = list(laData$year), sum)
colnames(laDataFrame) <- c('year', 'Emissions')
laDataFrame$City <- paste(rep('Los Angeles County', 4))

graphData <- as.data.frame(rbind(baltimoreDataFrame, laDataFrame))

png('plot6.png')

library(ggplot2)

ggplot(data = graphData, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year),stat = "identity") + guides(fill = F) + ggtitle('Total vehicle emissions LA County x Baltimore City') + ylab(expression('PM(2.5) total')) + xlab('Year') + theme(legend.position = 'none') + facet_grid(. ~ City) + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))

dev.off()