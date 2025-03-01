# Stage 1: Build the app using Gradle
FROM gradle:7.3.3-jdk11 AS build
WORKDIR /app
COPY . .
RUN gradle build
RUN ls -la /app/build/libs/  # List files in the build/libs directory to confirm JAR location

# Stage 2: Create the final image with the JAR
FROM openjdk:8-jre-slim
WORKDIR /usr/app
COPY --from=build /app/build/libs/my-app-1.0-SNAPSHOT.jar /usr/app/  # Ensure path matches
EXPOSE 8080
CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
