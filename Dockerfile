FROM ubuntu:24.04

RUN apt update && apt install -yy gcc g++ cmake

COPY . /app
WORKDIR /app

# Удаляем старый кэш, если он есть
RUN rm -rf _build

RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release && \
    cmake --build _build

ENV LOG_PATH=/home/logs/log.txt
VOLUME /home/logs

WORKDIR _build/hello_world_application
ENTRYPOINT ["./hello"]
