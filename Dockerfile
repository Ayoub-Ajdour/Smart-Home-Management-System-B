# Base image
FROM openjdk:17-jdk-slim

# Update the package list and install Maven
RUN sed -i 's|http://deb.debian.org/debian|http://ftp.us.debian.org/debian|g' /etc/apt/sources.list && \
    apt-get -o Acquire::Retries=3 update && \
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

# Command to run the application
CMD ["java", "-jar", "target/SmartHomeManagementSystemBackend-0.0.1-SNAPSHOT.war"]
