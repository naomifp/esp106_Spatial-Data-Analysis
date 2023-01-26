##########################

# ESP 106
# Lab 3 (Monday) - graphing

##########################

#In this lab we will start by reading merging in data on economic development and indoor and outdoor air pollution. Then we will practice making some graphs with it.



#1. First read in the three csv files: gdppercapitaandgini and airpollution

#Both data sets are from Our World in Data: ourworldindata.org
#The GDP data set has GDP per capita and the GINI index (a measure of income inequality: https://en.wikipedia.org/wiki/Gini_coefficient)
#The air pollution data set has death rates from indoor and outdoor air pollution - units are in deaths per 100,000 people
#Indoor air pollution is the Household Air Pollution from Solid Fuels
#Outdoor air pollution is split into particulate matter and ozone

#Hint: The column names are long and cumbersome (because they contain information about units et) - you might want to rename some of the columns to make them easier to work with

colnames(apol) <- c("Country","Code","Year","PM","Fuels","Ozone","Total")
colnames(gdpgini) <- c("Country","Code","Year","Population","Continent","GINI","GDP")


#2. Chose two countries that you are interested in and make a plot showing the death rates from
##indoor air pollution and outdoor air pollution (sum of particulate matter and ozone) over time
#Distinguish the countries using different colored lines and the types of pollution 
##using different line types
#Make sure to add a legend and appropriate titles for the axes and plot 

#Hint: you can see all the different country names using unique(x$Entity) 
##where x is the data frame containing the air pollution data
#Then create two new data frames that contain only the rows corresponding 
##to each of the two countries you want to look at
#Create a new column of total outdoor air pollution deaths by summing death rates 
##from particulate matter and ozone
#Use these to make your plot and add the lines you need

#Hint: you might have to set the y scale manually to make sure your plot is wide enough 
##to show both countries. You can do this using the "ylim" argument in plot

#combining PM and Ozone to Outdoor Pollution
apol$Out <- apol$PM + apol$Ozone

#calling only data from Indonesia and Malaysia
idn<-subset(apol, Code=="IDN")
mys<-subset(apol, Code=="MYS")

#plotting (x=Year, y=Pollution)
plot(Out ~ Year, data=idn, type="l", main="Deaths from Air Pollution in Indonesia and in Malaysia", ylab="Deaths from Air Pollution", ylim=c(0,100), col="red")
lines(Out ~ Year, data=mys, col="blue")
lines(Fuels ~ Year, data=idn, col="red", lty=2)
lines(Fuels ~ Year, data=mys, col="blue", lty=2)
countries <- c('Outdoor Pollution - Indonesia', 'Outdoor Pollution - Malaysia', 'Indoor Pollution - Indonesia', 'Indoor Pollution - Malaysia')
legend('topright', countries, lty=c(1,1,2,2), col=c("red","blue"))


#3. Merge the air pollution data with the GDP data using merge()
# Merge is a function that combines data across two data frames by matching ID rows
#By default merge will identify ID rows as those where column names are the same between datasets, but it is safer to specify the columns you want to merge by yourself using "by"
#In our case, we want to merge both by country (either the "Entity" or "Code" columns) and year columns
#Note that by default, the merge function keeps only the entries that appear in both data frames - that is fine for this lab. If you need for other applications, you can change using the all.x or all.y arguments to the function - check out the documentation at ?merge

polgdp <- merge(apol, gdpgini)


#4. Make a plot with two subplots - one showing a scatter plot between log of per-capita GDP (x axis) 
##and indoor air pollution death rate (y axis) and one showing log of per-capita GDP (x axis) 
##and outdoor air pollution (y axis)
#Make sure to add appropriate titles to the plots and axes
#Use ylim to keep the range of the y axis the same between the two plots - 
##this makes it easier for the reader to compare across the two graphs
#STRECTH GOAL CHALLENGE - color the points based on continent. NOT REQUIRED FOR FULL POINTS - 
##a challenge if you want to push yourself - continent info is included in the GDP dataset, 
##but it is only listed for the year 2015
#If you are trying this and getting stuck ASK FOR HELP - there are some tips and tricks for making it easier 

plot(Out~GDP, data=polgdp, log="x", col="green", ylim=c(0,300), ylab="Deaths from Air Pollution", xlab="GDP in logarithmic scale", main="Relationship between GDP and Deaths caused by Air Pollution")
points(Fuels~GDP, data=polgdp, pch=4, col="orange")
pollution <- c ('Outdoor Pollution', 'Indoor Pollution')
legend('topright', pollution, pch=c(1,4), col=c("green","orange"))
