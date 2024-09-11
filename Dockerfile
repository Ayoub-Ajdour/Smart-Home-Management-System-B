# Base image
FROM openjdk:17-jdk-slim

# Install Maven
RUN apt-get update && \
    apt-get install -y maven && \
    apt-get clean;

# Set the working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the source code
COPY src ./src

# Package the application
RUN mvn package -DskipTests

# Expose the port the app runs on
EXPOSE 80
#
## Command to run the application
CMD ["java", "-jar", "target/SmartHomeManagementSystemBackend-0.0.1-SNAPSHOT.war"]
