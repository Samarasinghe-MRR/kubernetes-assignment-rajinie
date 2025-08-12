# --------- Builder Stage ---------
FROM openjdk:17-slim AS builder

WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Install Maven and build the JAR
RUN apt-get update && apt-get install -y maven \
 && mvn clean package -DskipTests

# --------- Runtime Stage ---------
FROM openjdk:17-slim

WORKDIR /app

# Create a non-root user
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Copy JAR from builder stage
#COPY --from=builder /app/target/java-api-1.0.0.jar app.jar

# Copy the jar file built by Maven
COPY --from=builder /app/target/*SNAPSHOT.jar app.jar

# Change ownership of the JAR file
RUN chown appuser:appgroup app.jar

# Switch to the non-root user
USER appuser

# Expose the application port
EXPOSE 8080

# Healthcheck endpoint
#HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
#  CMD curl -f http://localhost:8080/health || exit 1

# Start the application
ENTRYPOINT ["java", "-jar", "app.jar"]
