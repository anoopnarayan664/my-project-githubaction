# Stage 1: Build the app using Gradle
FROM gradle:7.3.3-jdk11 AS build
WORKDIR /app
COPY . .
RUN gradle build

# Stage 2: Build the final image
FROM openjdk:11-jre-slim
WORKDIR /usr/app
COPY --from=build /app/build/libs/my-app-1.0-SNAPSHOT.jar /usr/app/

EXPOSE 8080
CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]

