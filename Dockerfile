FROM openjdk:21

WORKDIR /app

COPY gradlew .
COPY gradle gradle

COPY build.gradle .
COPY settings.gradle .

COPY src src

RUN ./gradlew build --no-daemon

EXPOSE 8080

CMD ["./gradlew", "bootRun"]
