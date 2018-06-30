library(knitr)	
library(tidyverse)	
library(readxl)	
library(readr)	
library(tidyr)	
library(RODBC)
 library(RSQLite)
library(sqldf)	
library(readxl)
X628 <- tbl_df(read_excel("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/628.xlsx"))
names(X628) <- c("date","time","sip","method","uristem","uriquery","sport","csusername","cip","useragent","referer","scstatus","scsubstatus","scwinstatus","timetaken")
# View(X628)
# glimpse(X628) 
anonymousLogins <-sqldf("select distinct cip from X628 where uriquery like'Name=AnonymousStart%'")
loggedinLogins <-(sqldf("select distinct cip from X628 where uristem='/CherwellPortal/AskAidLoggedIn'"))
inner_join(anonymousLogins,loggedinLogins)

#628 version
#184.180.131.214
#150.135.165.110
#150.135.165.80
#184.98.205.18


X628 <- tbl_df(read_excel("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/627.xlsx"))
names(X628) <- c("date","time","sip","method","uristem","uriquery","sport","csusername","cip","useragent","referer","scstatus","scsubstatus","scwinstatus","timetaken")
# View(X628)
# glimpse(X628) 
anonymousLogins <-sqldf("select distinct cip from X628 where uriquery ='Name=AnonymousStart&UserName=AskAid&password=AskAid'")
loggedinLogins <-(sqldf("select distinct cip from X628 where uristem='/CherwellPortal/AskAidLoggedIn'"))
ips <-inner_join(anonymousLogins,loggedinLogins)
troublemakers <-(sqldf("select date,time,X628.cip,uriquery,uristem from X628 inner join ips on X628.cip=ips.cip
      where (uriquery ='Name=AnonymousStart&UserName=AskAid&password=AskAid' ) or 
      (uristem='/CherwellPortal/AskAidLoggedIn'  and uriquery='-')
           order by X628.cip 
           "))
#View(troublemakers)
#150.135.165.91

checkforproblems <-function(troublemakers){
  numberOfRows <-nrow(troublemakers)
i=1
currentip="0.0.0.0"
currenturi =""
currentsequence=0
for (i in  1:numberOfRows){
  loopip <- (troublemakers[i,"cip"])
  currenturi= (troublemakers[i,"uristem"])
 
  
  if (loopip != currentip){
    currentip <- loopip
    currentsequence =0
    #print("new IP")
  }
  else{
    if (currentsequence ==0 && currenturi=="/CherwellPortal/AskAidLoggedIn"){
      currentsequence=1
    }
    if (currentsequence ==1 && currenturi=="/CherwellPortal/askaid/Command/Dashboards.BringUpDashboard"){
      currentsequence=2
    }
    if (currentsequence ==2 && currenturi=="/CherwellPortal/AskAidLoggedIn"){
      currentsequence=3
      #print("DANGER")
      print(loopip)
    }
    
  }
  #print(paste(loopip,currenturi, currentsequence))
}
}
checkforproblems(troublemakers)

X628 <- tbl_df(read_excel("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/604.xlsx"))
names(X628) <- c("date","time","sip","method","uristem","uriquery","sport","csusername","cip","useragent","referer","scstatus","scsubstatus","scwinstatus","timetaken")
# View(X628)
# glimpse(X628) 
anonymousLogins <-sqldf("select distinct cip from X628 where uriquery like'Name=AnonymousStart%'")
loggedinLogins <-(sqldf("select distinct cip from X628 where uristem='/CherwellPortal/AskAidLoggedIn'"))
ips <-inner_join(anonymousLogins,loggedinLogins)
troublemakers <-(sqldf("select date,time,X628.cip,uriquery,uristem from X628 inner join ips on X628.cip=ips.cip
                       where (uriquery ='Name=AnonymousStart&UserName=AskAid&password=AskAid' ) or 
                       (uristem='/CherwellPortal/AskAidLoggedIn'  and uriquery='-')
                       order by X628.cip 
                       "))
checkforproblems(troublemakers)

runfull <- function(filepath){
  #filepath="C:/Repos/ITSummitRExcel/CherwellWebProject/Data/605.xlsx"
  print(filepath)
  X628 <- tbl_df(read_excel(filepath))
  names(X628) <- c("date","time","sip","method","uristem","uriquery","sport","csusername","cip","useragent","referer","scstatus","scsubstatus","scwinstatus","timetaken")
  # View(X628)
  # glimpse(X628) 
  anonymousLogins <-sqldf("select distinct cip from X628 where uriquery like'Name=AnonymousStart%'")
  loggedinLogins <-(sqldf("select distinct cip from X628 where uristem='/CherwellPortal/AskAidLoggedIn'"))
  ips <-inner_join(anonymousLogins,loggedinLogins)
  troublemakers <-(sqldf("select date,time,X628.cip,uriquery,uristem from X628 inner join ips on X628.cip=ips.cip
                         where (uriquery ='Name=AnonymousStart&UserName=AskAid&password=AskAid' ) or 
                         (uristem='/CherwellPortal/AskAidLoggedIn'  and uriquery='-')
                         order by X628.cip 
                         "))
  checkforproblems(troublemakers)
}
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/604.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/605.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/606.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/607.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/608.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/609.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/610.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/611.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/612.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/613.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/614.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/615.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/616.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/617.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/618.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/619.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/620.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/621.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/622.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/623.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/624.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/625.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/621.xlsx")
runfull("C:/Repos/ITSummitRExcel/CherwellWebProject/Data/627.xlsx")

