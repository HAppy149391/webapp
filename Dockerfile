# Build stage
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory
WORKDIR /build

# Copy files to the working directory
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package

# Runtime stage
FROM eclipse-temurin:17-jre-jammy

# Set the working directory
WORKDIR /app

# Define an argument to accept the JAR file name
ARG JAR_FILE=webapp-0.0.1-SNAPSHOT.jar

# Copy jar from build stage
COPY --from=build /build/target/${JAR_FILE} app.jar

# Expose application port
EXPOSE 8080

# Start Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
