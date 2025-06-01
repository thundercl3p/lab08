FROM ubuntu:24.04

RUN apt update
RUN apt install -yy  gcc g++ cmake

COPY . test/
WORKDIR test

RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release
RUN cmake --build _build


ENV LOG_PATH=/home/logs/log.txt
VOLUME /home/logs

WORKDIR _build/hello_world_application
ENTRYPOINT ./hello_world
