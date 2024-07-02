# Use OpenJDK 11 as base image
FROM openjdk:11-jdk AS build

# Set working directory
WORKDIR /app

# Copy Maven wrapper and project descriptor files
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Download dependencies and plugins
RUN ./mvnw dependency:go-offline

# Copy the rest of the backend source code
COPY src src

# Build the backend application
RUN ./mvnw package -DskipTests

# Stage 2 - Create the final image
FROM openjdk:11-jre-slim

# Set working directory
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Copy frontend build artifacts into a directory
COPY frontend/build /app/frontend

# Expose port 8080
EXPOSE 8080

# Command to run the Spring Boot application
CMD ["java", "-jar", "app.jar"]