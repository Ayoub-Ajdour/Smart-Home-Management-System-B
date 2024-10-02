FROM openjdk:17-jdk-slim

RUN apt-get update && \
    apt-get install -y maven && \
    apt-get clean;

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn package -DskipTests

EXPOSE 80

CMD ["java", "-jar", "target/SmartHomeManagementSystemBackend-0.0.1-SNAPSHOT.war"]
