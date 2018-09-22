#downloading data from yahoo finance thru rfats quantmod

library(quantmod)

getSymbols("HDFCBANK.BO", src="yahoo")
HDFCBANK.BO
getSymbols("IDFC.NS", src="yahoo")
IDFC.NS
#.BO for BSE and .NS for NSE
getSymbols("SBIN.BO", src="yahoo")
head(SBIN.BO[complete.cases(SBIN.BO)])
tail(SBIN.BO[complete.cases(SBIN.BO)])

getSymbols("SBIN.NS", src="yahoo")


#library(quantmod)
getSymbols("^BSESN",src="yahoo" , from ="2016-10-23", to = Sys.Date())
View(BSESN)
chart_Series(BSESN)

#Analyze One Year Data of Bombay Stock Exchange-
getSymbols("^BSESN",src="yahoo" , from ="2016-10-23", to = Sys.Date())
chart_Series(BSESN,type = "candlesticks")

#Complete Data of Bombay Stock Exchange–
#It will provide you all data after 2007.
getSymbols("^BSESN",src="yahoo")
chart_Series(BSESN)

#25-b----

#quantmod
#OHLC http://www.quantmod.com/examples/data/

# OHLC data - the basics
# OHLC - beyond the obvious
# Subsetting by date - characters and '::' notation
# The last 3 days of the first 2 weeks - interested yet?
# Minutes to hours to days to months - fast aggregation.
# Apply by Period - weekly, monthly or arbitrarily


#Op,Hi,Lo,Cl,Vo,Ad - do pretty much what they say - extract the columns Open, High, Low, Close, Volume, and Adjusted (Yahoo)
#is.OHLC, has.OHLC, has.Op,has.Cl,has.Hi,has.Lo,has.Ad, and has.Vo - fairly obvious seriesHi and seriesLo




library(quantmod)
getSymbols("GS") #Goldman OHLC from yahoo 
#[1] "GS" 
is.OHLC(GS) # does the data contain at least OHL and C? 
has.Vo(GS) # how about volume? 
Op(GS) # just the Open column please. 
seriesHi(GS) # where and what was the high point
range(GS)
range(GS$GS.Open)
head(GS)
tail(GS)



#Typically one would like to see what is happening within an observation, or across a period of observations. That may mean some sort of change in price or volume, be it over one period, or over many periods. In the same simplistic fashion as above, one can get price changes for all combinations of columns, across all possible periods

#Simply combine the columns extraction tools from above to arrive at the naming convention to get price changes. Want Open to Close percent change? It is as simple as OpCl.

OpCl(GS) #daily percent change open to close 
OpOp(GS) #one period open to open change 
HiCl(GS) #the percent change from high to close
head(GS)
head(HiCl(GS))
(200.72-203.32)/200.72


#------
#Lag: What was the previous value in the series
#Next: What is the next value in the series
#Delt: Compute the change (delta) from two prices

Lag(Cl(GS)) #One period lag of the close 
head(GS)
head(Lag(Cl(GS)))

Lag(Cl(GS),c(1,3,5)) #One, three, and five period lags 
head(Lag(Cl(GS),c(1,3,5)))
head(GS)

Next(OpCl(GS)) #The next periods open to close - today! 
head(Next(OpCl(GS)))
head(GS)
200.72 - 200.22

# Open to close one-day, two-day and three-day lags 
Delt(Op(GS),Cl(GS),k=1:3)



#Subsetting by Time and Date? -- xts Makes It Easy
#One of the central motivations for creating the xts package was to offer tools that made it easy to work with time-based series. Extending the zoo class, a new method specific to xts series allows for sub-setting via the traditional R bracket mechanism, but with a twist.
library(zoo)

GS['2007'] #returns all Goldman's 2007 OHLC 
GS['2018'] #now just 2018 
GS['2018-08'] #now just January of 2018 
GS['2018-06::2008-01-09'] #
GS['::'] # everything in GS 
GS['2010::'] # everything in GS, from 2010 onward 
non.contiguous <- c('2016-01','2017-02','2018-12') 
GS[non.contiguous]

#general format for the above is CCYY-MM-DD HH:MM:SS, with ranges specified via the '::' operator. The only requirement is that you specify the level of detail from left to right - that is to get January, you need to specify the year first. The coolest part to this construct is that it is now posssible to only specify the level of detail you require in the returned object; no longer is it necessary to worry about the underlying level of resolution to your data. Monthly data, or minute data, can both be resolved with the same construction.


#The Last 3 Days of The First 2 Weeks
#Another common problem when trying to subset time series data often involves looking at a particular time period. Often the last n-periods may be desired when charting the price of a security, or when constructing a model for trading or analysis. [Note: these functions are now in the standalone package xts - which quantmod requires]

#To facilitate this 'time-based' subsetting, one can use the functions first and last. Essentially extending the concept of head and tail, one can now use character strings to describe the part of the data to be returned. As is probably expected by now - an example may help to clarify.

first(GS)  
last(GS) #returns the last obs. 
last(GS,8) #returns the last 8 obs. 

# let's try something a bit cooler. 
last(GS, '3 weeks') 
last(GS, '-3 weeks') # all except the last 3 weeks 
last(GS, '3 months') 

#from first 2 weeks, last 3 days
first(GS, '2 weeks')
last(first(GS, '2 weeks'), '3 days')


#Aggregating to a different time scale
#Often, and especially with higher frequency data, it is necessary to aggregate data into lower frequency terms. For example, take daily data - OHLC or a standard time series - and convert it to weekly or monthly OHLC data.

#With xts it is as simple as to.weekly or to.monthly. In fact, it is currently possible to take everything from minute data all the way up to quarterly data and convert it into something lower frequency. Minute data can become 5 or 10 minute data (to.minutes5 and to.minutes10, respectively), which can in turn be turned into hourly or daily data. Daily data can become weekly, monthly, or even yearly. All carried out in compiled code, and all blazingly fast, yes blazingly fast - convert 2 months of 1-minute bars into 3-minute bars in less than 0.1 seconds and anything lower in half that time. A full year of minute bars in less than a second on a moderately fast computer.

#Is your data weekly, daily, or hourly? A call to periodicity will provide the answer; a call to nweeks will tell you the number of weeks as well.

periodicity(GS) 
unclass(periodicity(GS)) 
to.weekly(GS)
#The result will contain the open and close for the given period, as well as the maximum and minimum over the new period, reflected in the new high and low, respectively. If volume for a period was available, the new volume will also be calculated.
?to.weekly

to.monthly(GS) 
periodicity(to.monthly(GS)) 
to.yearly(GS)
to.yearly(GS['2016::2018'])

ndays(GS); nweeks(GS); nyears(GS) 

# Let's try some non-OHLC to start 
getFX("USD/EUR") 
periodicity(USDEUR) 
to.weekly(USDEUR) 
periodicity(to.weekly(USDEUR))


#-----
#Apply by Period
#It may be useful to identify endpoints in your data by date with the function endpoints. You can use those endpoints (or ones generated automatically) with the functions in the period.apply family. Quickly calculate periodic minimums, maximums, sums, and products - as well as general applys (with the periodic slant) with a few simple functions.

endpoints(GS,on="months") 

# find the maximum closing price each week 
apply.weekly(GS,FUN=function(x) { max(Cl(x)) } ) 

# the same thing - only more general 
period.apply(GS,endpoints(GS,on='weeks'),FUN=function(x){max(Cl(x)) } ) 

# same thing - only 50x faster! 
as.numeric(period.max(Cl(GS),endpoints(GS,on='weeks')))

#Of course, additional wrappers exist to quickly apply arbitrary functions over daily, monthly, quarterly and annual time periods as well. There are also Fortran-based routines for period.min, period.sum, and period.prod, in addition to the period.max function.

#Period Returns
#The last set of functions simply provide a fast and reliable way to calculate returns over calendar periods - derived from the function periodReturn. Named for what they return. A note on starting/ending date convention, all periods could be named in a variety of ways - the first of the period, the first trading time of the period, the last trading time of the period, or even the last day of the period. xts has adopted the last observation of a given period as the date to record for the larger period. There may be a point in the future where this is settable as well. This is now user settable through the indexAt argument to the underlying to.period versions to.monthly and to.quarterly. The full details can be found in the related help pages, but a quick explanation is indexAt lets one set the resulting index to the first of each period (firstof), the last of each period (lastof), the starting observation of the period (startof), the ending observation of the period (endof), the month of the period (yearmon) or the quarter of the period (yearqtr). For most classes of time-series data this defaults to yearmon for monthly observations and yearqtr for quarterly requests.

# Quick returns - quantmod style 
getSymbols("SBUX") 

dailyReturn(SBUX) # returns by day 
weeklyReturn(SBUX) # returns by week 
monthlyReturn(SBUX) # returns by month, indexed by yearmon 

# daily,weekly,monthly,quarterly, and yearly 
allReturns(SBUX) # note the plural

#2symbols----


library('quantmod')
#Calling the Quantmod library. 

library(quantmod)
getSymbols(c("SUNPHARMA.BO","CIPLA.BO"))
#Retrieving data for SunPharma and Cipla stocks from Yahoo API.


chartSeries(c(CIPLA.BO, SUNPHARMA.BO), subset='last 3 months')
#Plotting last 3 months data. Change the timeframe to your choice.

addBBands()
addROC()
#plotting Bollinder Bands and Rate of Change here. 

#https://github.com/kedar123pro/R-Quantmod-Demo



# Charting----


#http://www.quantmod.com/examples/charting/
# Financial Charts in quantmod:
# The workhorse: chartSeries
# Meet the friends: barChart, candleChart, and lineChart
# Chart Arguments: what can you do?
# Voodoo: Technical Analysis with TTR and addTA


#Introducing chartSeries
#chartSeries is the main function doing all the work in quantmod. Courtesy of as.xts it can handle any object that is time-series like, meaning R objects of class xts, zoo, timeSeries, its, ts, irts, and more!
#  By default any series that is.OHLC is charted as an OHLC series. There is a type argument which allows the user to decide on the style to be rendered: traditional bar-charts, candle-charts, and matchstick-charts -- thin candles ... get it :) -- as well as line charts.

#The default choice ['auto'] lets the software decide, candles where they'd be visible clearly, matchsticks if many points are being charted, and lines if the series isn't of an OHLC nature. If you don't like to always specify the type to override this behavior you are free to use the wrapper functions in the next section, or make use of setDefaults from the wickedly cool and useful Defaults package (available on CRAN). The fact that I wrote it has nothing to do with my endorsement :)

library(quantmod)
getSymbols("GS") #Goldman OHLC from yahoo 
chartSeries(GS) 

#GS matchstick chart 
# notice the automatic matchstick style 
# we'll change this in the next section 
# but for now it is fine. 

#Charting shortcuts - barChart, lineChart, and candleChart.
#While chartSeries is the primary function called when drawing a chart in quantmod - it is by no means the only way to get something done. There are wrapper functions for each of the main types of charts presently available in quantmod.

#Wrapper functions exist to make life a little easier. Bar style charts, both hlc and ohlc varieties are directly available with barChart, candlestick charting comes naturally through the candleChart wrapper function, and lines via the cryptically named - you guessed it - lineChart. There isn't much special about these functions beyond the obvious. In fact they are one liners that simply call chartSeries with suitably changed default args. But they make a nice addition to the stable.


# first some high-low-close style bars, monochromatic theme 
barChart(GS,theme='white.mono',bar.type='hlc') 

#GS hlc barchart chart 
# how about some candles, this time with color 
candleChart(GS,multi.col=TRUE,theme='white') 

#GS candle chart 
# and now a line, with the default color scheme 
lineChart(GS,line.type='h',TA=NULL) 


#Formal Arguments: Colors, subsetting, tick-marks.
#The best place for complete information on what arguments the functions take is in the documentation. But for now we'll take a look at some of the common options you might change.

#Probably the most important from a usability standpoint is the argument subset. This takes an xts/ISO8601 style time-based string and restricts the plot to the date/time range specified. This doesn't restrict the data available to the techinical analysis functions, only restricts the content drawn to the screen. For this reason it is most advantageous to use as much data as you have available, and then provide the chartSeries function with the subset which you would like to view. This subsetting is also avialable via a call to zoomChart.

#An example, or three, should help clarify its usage.


# the whole series 
chartSeries(GS) 

# now - a little but of subsetting 
# (December '07 to the last observation in '08) 
candleChart(GS,subset='2007-12::2008') 

# slightly different syntax - after the fact. 
# also changing the x-axis labeling 
candleChart(GS,theme='white', type='candles') 
reChart(major.ticks='months',subset='first 16 weeks') 


#Technical Analysis and chartSeries
getSymbols("GS") #Goldman OHLC from yahoo 
# The TA argument to chartSeries is one way to specify the 
# indicator calls to be applied to the chart. 
# NULL mean don't draw any. 

chartSeries(GS, TA=NULL) 

# Now with some indicators applied 
chartSeries(GS, theme="white", TA="addVo();addBBands();addCCI()") 

# The same result could be accomplished a 
# bit more interactively: 
# 
chartSeries(GS, theme="white") #draw the chart 
addVo() #add volume 
addBBands() #add Bollinger Bands 
addCCI() #add Commodity Channel Index


#-----
getSymbols("SBIN.BO") # SBIOHLC from yahoo 
# addTA allows you to add basic indicators 
# to your charts - even if they aren't part of quantmod. 
chartSeries(SBIN.BO, TA=NULL) 

#Then add the Open to Close price change 
#using the quantmod OpCl function 
addTA(OpCl(SBIN.BO),col='blue', type='h') 
head(SBIN.BO)

# Using newTA it is possible to create your own 
# generic TA function --- let's call it addOpCl 
# 
addOpCl <- newTA(OpCl,col='green',type='h') 
addOpCl() 

#31b----get symbol

# Quantmod
#https://finance.yahoo.com/

library(quantmod)

# get data for FTSE
my.df <- getSymbols(Symbols = 'SBIN.NS', auto.assign = FALSE)
head(my.df)
?getSymbols
getSymbols(Symbols = 'ICICIBANK.NS')
head(ICICIBANK.NS)
getSymbols(Symbols = 'HDFC.NS', auto.assign = TRUE)
head(HDFC.NS)
getSymbols(Symbols = 'PNB.NS', auto.assign = FALSE)
#no variable created
head(PNB.NS)