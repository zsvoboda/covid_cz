#install.packages("RJDBC",dep=TRUE)
library(RJDBC)
sys <- Sys.getenv(c("HOME"))
drv <- JDBC("org.postgresql.Driver",
            paste(sys[1],"/lib/postgresql-42.2.23.jar", sep=""),
            identifier.quote='"')
conn <- dbConnect(drv, "jdbc:postgresql://localhost:2543/gooddata", "gooddata", "demopass")
d <- dbGetQuery(conn, "select covid_event_person_age, infections, coalesce(deaths,0) as deaths from covid_cz.compute where covid_event_person_age_num >= 30")
res <- cor(d[, c(2,3)])
s <- scale(d[, c(2,3)])

#install.packages("ggplot2",dep=TRUE)
#install.packages("factoextra",dep=TRUE)
library("factoextra")
set.seed(123)
km.res <- kmeans(s, 5, nstart = 25)
fviz_cluster(km.res ,data = d[, c(2,3)])
print(d)