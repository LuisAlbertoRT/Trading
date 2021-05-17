#R finance para rockstars

#https://www.x-trader.net/articulos/software-y-tecnologia/r-para-traders-i.html

library(quantmod)
getSymbols("AAPL",src="yahoo")
getSymbols("TSLA",src="yahoo")
getSymbols("GDP",src="FRED")
getSymbols("EUR/GBP",src="oanda")

plot(AAPL)

chartSeries(TSLA, subset='2016::2021-05')

chartSeries(TSLA, subset='last 3 months',type=c("bars")
            ,theme=chartTheme('white'), TA=NULL)

#Vamos a meterle algunos indicadores al gráfico anterior; 
#por ejemplo, unas bandas de Bollinger con media exponencial 
#y parámetros (25, 1.5) y un RSI de período n=30). 
#Para ello utilizamos el siguiente comando:

chartSeries(TSLA, subset='last 3 months',type=c("bars"),theme=chartTheme('white'),
            TA= c(addBBands(n = 21, sd = 1.5, ma = "EMA"),addRSI(n = 30)))
addMACD() 

#----------------------------Nuevo---------------

#install.packages("IntroCompFinR", repos="http://R-Forge.R-project.org")

library(IntroCompFinR)

getSymbols("^GSPC", src = "yahoo", from = "2010-01-01", to = "2010-07-30", periodicity = "daily")
chartSeries(GSPC, TA=NULL)

chartSeries(GSPC, subset = "last 3 months")

chartSeries(GSPC, subset = "last 3 months")

library(ggplot2)
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()

ggplot(mpg, aes(displ, cty, colour = class)) +
  geom_point() 


ggplot(mpg, aes(displ, hwy)) + geom_point(aes(colour = "blue"))

ggplot(mpg, aes(displ, hwy)) + geom_point(colour = "blue")




#aes(displ, hwy, colour = class)
#aes(displ, hwy, shape = drv)
#aes(displ, hwy, size = cyl)


gspc <- as.data.frame(GSPC)

g1 <- ggplot(gspc) + geom_line(mapping = aes(index(gspc),GSPC.Adjusted))
g1 <- g1 + labs(title = "S&P 500", subtitle = "Desde Enero 2010 a 2018") + xlab("Fecha") + ylab("")
g1 <- g1 + theme_bw()
g1


tickers <- c("ORCL","AMD","IBM","NVDA")
getSymbols(tickers, src = "yahoo", from = "2010-01-01", to = "2018-07-30", periodicity = "daily")



list <- lapply(tickers, function(x) Cl(get(x)))
precio.cierre <- do.call(merge,list)



####----No funciona-------------
retornos <- data.frame(apply(precio.cierre, 2, function(x) Delt(x, type = "log")),
                       fecha = index(precio.cierre)) %>%
  rename(orcl = ORCL.Close, amd = AMD.Close, ibm = IBM.Close, nvda = NVDA.Close) %>% 
  na.omit() 
