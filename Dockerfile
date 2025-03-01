# Stage 1: Build the app using Gradle
FROM gradle:7.3.3-jdk8 AS build
WORKDIR /app
COPY . .
RUN gradle build

# Stage 2: Build the final image
FROM openjdk:8-jre-slim
WORKDIR /usr/app
COPY --from=build /app/build/libs/my-app-1.0-SNAPSHOT.jar /usr/app/
RUN gradle build
RUN ls -la /app/build/libs/  # List files in the build/libs directory to confirm JAR location

EXPOSE 8080
CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]

