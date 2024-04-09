FROM ubuntu:latest AS build

RUN apt-get update && \
    apt-get install -y openjdk-21-jdk && \
    apt-get install -y maven

WORKDIR /app
COPY . .

RUN mvn clean install

FROM openjdk:21-slim

EXPOSE 8080

COPY --from=build /app/target/login-auth-api-0.0.1-SNAPSHOT.jar /app/app.jar

ENTRYPOINT ["java", "-jar", "/app/app.jar"]