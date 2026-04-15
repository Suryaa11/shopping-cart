
# ---------- Stage 1: Build ----------
FROM maven:3.9.9-eclipse-temurin-8 AS builder

WORKDIR /app

# Copy project files
COPY . .

# Build WAR file
RUN mvn clean package -DskipTests

# ---------- Stage 2: Run ----------
FROM tomcat:9-jdk8

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from builder stage
COPY --from=builder /app/target/shopping-cart-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]