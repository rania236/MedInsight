# Multi-stage build for patient-service
FROM maven:3.9.9-eclipse-temurin-17-alpine AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Copy the JAR file
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8050
ENTRYPOINT ["java", "-jar", "app.jar"]