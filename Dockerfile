# Stage 1: Build the application
FROM openjdk:17-jdk-slim AS build

# Copy Maven Wrapper and Project Object Model (POM)
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Resolve dependencies
RUN ./mvnw dependency:resolve

# Copy the application source code
COPY src src

# Build the application
RUN ./mvnw package -DskipTests

# Stage 2: Create a minimal image with the JAR file
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build target/*.jar app.jar

# Expose the application port (adjust if needed)
EXPOSE 8081

# Specify the default command to run when the container starts
ENTRYPOINT ["java", "-jar", "/app.jar"]
