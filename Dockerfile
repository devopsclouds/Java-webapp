FROM maven:3.5-jdk-8 AS build
RUN java --version
ARG SONAR_TOKEN=token
        ARG SONAR_PRJ_KEY=key
	ENV SONAR_HOST http://192.168.0.10:9000/
	WORKDIR /usr/src/app
	COPY src ./src
	COPY pom.xml .
	#COPY settings.xml .
	RUN mvn  clean -Dmaven.test.skip=true package sonar:sonar  -Dsonar.projectKey=$SONAR_PRJ_KEY -Dsonar.login=$SONAR_TOKEN  -Dsonar.host.url="$SONAR_HOST" 


	

	

	FROM dordoka/tomcat
	COPY --from=build /usr/src/app/target/*.war /opt/tomcat/webapps/sample.war
	EXPOSE 8080
	CMD ["/opt/tomcat/bin/catalina.sh", "run"]

