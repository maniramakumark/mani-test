FROM openjdk:21-jdk-slim AS stage1

WORKDIR /app

COPY pom.xml .

COPY src ./src

RUN mvn clean package

FROM openjdk:21-jdk-slim

WORKDIR /app

## copying demo-0.0.1-SNAPSHOT.jar to working directory as app.jar

COPY --from=stage1 /app/target/*.jar app.jar  

CMD ["java", "-jar", "app.jar"]

