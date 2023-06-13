FROM alpine/git:v2.32.0 as git
WORKDIR /opt
RUN git clone https://github.com/spring-projects/spring-petclinic

FROM openjdk:11-jdk-slim as build
WORKDIR /opt
COPY --from=git /opt/spring-petclinic /opt
RUN ./gradlew -Dorg.gradle.daemon=false bootJar

FROM openjdk:11-jre-slim
WORKDIR /opt
COPY --from=build /opt/build/libs/spring-petclinic-2.6.0.jar /opt/petclinic.jar
RUN apt update && apt install mariadb-client -y

USER 10001
EXPOSE 8080
ENTRYPOINT ["java","-jar","petclinic.jar"]