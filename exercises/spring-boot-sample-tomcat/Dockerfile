FROM openjdk:8

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY target/spring-boot-sample-tomcat-2.0.0.BUILD-SNAPSHOT.jar /usr/src/app

EXPOSE 8080
ENTRYPOINT ["java", "-jar"]
CMD ["spring-boot-sample-tomcat-2.0.0.BUILD-SNAPSHOT.jar"]
