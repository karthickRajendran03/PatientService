FROM adoptopenjdk/maven-openjdk11 AS builder

WORKDIR /home/maven
COPY . .
RUN mvn clean install

FROM registry.access.redhat.com/ubi8/ubi

RUN dnf install -y java-11-openjdk.x86_64

COPY --from=builder /home/maven/target/PatientService-0.0.1-SNAPSHOT.jar ./PatientService-0.0.1-SNAPSHOT.jar

EXPOSE 9080/tcp

CMD ["java", "-jar", "./PatientService-0.0.1-SNAPSHOT.jar"]
