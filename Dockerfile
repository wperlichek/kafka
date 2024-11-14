# Use the official Gradle image with JDK
FROM gradle:8.3-jdk17

# Set the working directory in the container
WORKDIR /app

# Copy only Gradle files to cache dependencies separately
COPY build.gradle settings.gradle /app/

# Download dependencies without running tests (cacheable layer)
RUN gradle build -x test --no-daemon --stacktrace || true

# Copy the source code into the container
COPY . /app

# Enable the Gradle build cache
RUN echo "org.gradle.caching=true" >> /app/gradle.properties

# Run the specific test method with Gradle
CMD ["gradle", ":connect:runtime:integrationTest", "--tests", "org.apache.kafka.connect.integration.OffsetsApiIntegrationTest.testResetSinkConnectorOffsetsOverriddenConsumerGroupId", "--no-daemon", "--info", "--offline"]

