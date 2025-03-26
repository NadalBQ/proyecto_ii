install.packages('readxl')
library(readxl)
INE = read_excel('INE.xlsx')
View(INE)
INE_limpio = INE[,1:41]
numNA = apply(INE_limpio, 2, function(x) sum(is.na(x)))
numNA
tablaNA = data.frame("Variable" = colnames(INE_limpio), numNA)
tablaNA
INE_limpio <- na.omit(INE_limpio)
write.table(INE_limpio, "INE_limpio.csv", sep = ",", row.names = FALSE, col.names = TRUE, quote = FALSE)

