###FROM instruction is the base image . every image is built on some os
FROM maven:3.5-jdk-8 AS build  
	####workdir which dir need to point 
	WORKDIR /usr/src/app
	###to copy files to container
	COPY src ./src
	COPY pom.xml .
	
	RUN mvn -f /usr/src/app/pom.xml clean -Dmaven.test.skip=true package

   FROM dordoka/tomcat
	COPY --from=build /usr/src/app/target/*.war /opt/tomcat/webapps/sample.war
	####port expose
	EXPOSE 8080
	CMD ["/opt/tomcat/bin/catalina.sh", "run"]


	#####if you have more then two FROM instruction then it is multi stage docker build
	###CMD Whenever the container is created this cmd instruction will run
	
     

