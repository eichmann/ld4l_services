FROM tomcat:9-jdk8-openjdk-slim-bullseye

COPY ld4l_services.war webapps/ld4l_services.war

RUN mkdir -p /usr/local/RAID/LD4L

