FROM maven:3.5-jdk-8 AS build
        ARG  login_id
	WORKDIR /usr/src/app
	COPY src ./src
	COPY pom.xml .
	RUN mvn  -s settings.xml -f /usr/src/app/pom.xml clean -Dmaven.test.skip=true package sonar:sonar -Dsonar.login=$login_id
	

	

	FROM dordoka/tomcat
	COPY --from=build /usr/src/app/target/*.war /opt/tomcat/webapps/sample.war
	EXPOSE 8080
	CMD ["/opt/tomcat/bin/catalina.sh", "run"]

