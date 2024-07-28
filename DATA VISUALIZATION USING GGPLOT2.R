#------------------GGPLOT----------------

#----------------------------DATA-----------------

movies<- read.csv(file.choose())
head(movies)
nrow(movies)
colnames(movies)<-c("Film","Genre","CriticRating","AudienceRating","Budgetmillions","Year")
tail(movies)
str(movies)
summary(movies)

movies$Film<-factor(movies$Film)
movies$Genre<-factor(movies$Genre)
str(movies)
movies$Year<-factor(movies$Year)

#----------------------------aesthetics-----------

??ggplot
library(ggplot2)

ggplot(data=movies,aes(x=CriticRating,y=AudienceRating))+geom_point()

ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre,
                       size=Budgetmillions))+geom_point()

#-------------------------plotting with layers----------

p<-ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre,
                          size=Budgetmillions))
#points
p+geom_point()

#line
p+geom_line()

#multiplelayers
p+geom_point()+geom_line()

p+geom_line()+geom_point()

#--------------Overriding Aesthetics-------------

q<-ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre,
                          size=Budgetmillions))
q

q+geom_point()

#overriding aes
#ex1

q+geom_point(aes(size=CriticRating))

#ex2

q+geom_point(aes(size=Budgetmillions))

q+geom_point()

q+geom_point(aes(x=Budgetmillions))+xlab("Budgetmillions $$$")

q+geom_line(size=1)+geom_point()


#-----------------mapping vs setting------------

r<-ggplot(data=movies,aes(x=CriticRating,y=AudienceRating))

r+geom_point()

#Addcolour
#1.mapping (What we have done so far)

r+geom_point(aes(colour=Genre))

#Error
#r+geom_point(colour="DrakGreen")


#1.mapping
r+geom_point(aes(size=Budgetmillions))

#2.setting
r+geom_point(aes(size=2))


#-------------------Histograms & Density charts--------

s<-ggplot(data=movies,aes(x=Budgetmillions))

#s+geom_histogram(binwidth = 10,fill="Genre")

s+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")


s+geom_density(aes(fill=Genre) , position="stack")

#--------Starting layer tips -------------

t<-ggplot(data=movies,aes(x=AudienceRating))

t+geom_histogram(binwidth=10,fill="white",colour="blue")

#another way

t+geom_histogram(binwidth=10,
                 aes(x=AudienceRating),
                 fill="white",colour="blue")
#overriding

t+geom_histogram(binwidth=10,
                 mapping=aes(x=CriticRating),
                 fill="white",colour="blue")+xlab("CriticRating")
?ggplot


#-----------------Statistical transformations------------

?geom_smooth()

k<-ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre))

k+geom_point()+geom_smooth(fill=NA)


#boxplotting

u<-ggplot(data=movies,aes(x=Genre,y=AudienceRating,colour=Genre))

u+geom_point()

u+geom_boxplot(size=1.2)+geom_point()

#tips 
u+geom_boxplot(size=1.2)+geom_jitter()

u+geom_jitter() +geom_boxplot(size=1.2,alpha=0.5)

u+geom_boxplot(aes(x=CriticRating,colour=Genre))


#------------------Facets-------------

v<-ggplot(data=movies,aes(x=Budgetmillions,colour=Genre))

v+geom_histogram(binwidth=20,
                   aes(fill=Genre),colour="black")

#facet_grid:

v+geom_histogram(binwidth=10,
                 aes(fill=Genre),colour="black")+facet_grid(Genre~.,scales="free")


#facets to scatterplots

w<-ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,
    colour=Genre))      
w+geom_point(size=3)+facet_grid(Year~Genre)

w+geom_point(size=3)+facet_grid(Genre~Year)

w+geom_point(size=3)+
  geom_smooth()+
  facet_grid(Genre~Year)

w+geom_point(aes(size=Budgetmillions))+
  geom_smooth()+
  facet_grid(Genre~Year)


#-------------coordinates------------
#Limits
#Zoom

m<-ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre))

m+geom_point()+xlim(50,100)+ylim(50,75)


#wont work well always

n<-ggplot(data=movies,aes(x=Budgetmillions))
n+geom_histogram(binwidth = 10,colour="Black",aes(fill=Genre))


n+geom_histogram(binwidth = 10,colour="Black",aes(fill=Genre))+ylim(0,50)

n+geom_histogram(binwidth = 10,colour="Black",aes(fill=Genre))+coord_cartesian(ylim=c(0,50))
    
#improve#1

w+geom_point(aes(size=Budgetmillions))+
  geom_smooth()+
  facet_grid(Genre~Year)+coord_cartesian(ylim=c(0,100))

#--------------------Theme-----------------------

o<-ggplot(data=movies,aes(x=Budgetmillions))

h<-o+geom_histogram(binwidth = 10,aes(fill=Genre),colour="black")

#axes labels

h+xlab("Money Axis")+
  ylab("Number of Movies")+
  ggtitle("Movie Budget Distribution")+
  theme(axis.title.x=element_text(colour="DarkGreen",size=30),
        axis.title.y=element_text(colour="Red",size=30),
        axis.text.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        legend.title=element_text(size=30),
        legend.text=element_text(size=30),
        legend.position=c(1,1),
        legend.justification= c(1,1),
        plot.title = element_text(colour="DarkBlue",
                                size=40,
                                family="Courier"))

?theme
