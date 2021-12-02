FROM ubuntu:latest

ADD data/cmake-with-flask /src

WORKDIR /src

RUN apt-get update && apt-get install -y tzdata && apt-get install -y cmake g++ python3 python3-pip

RUN cmake .
RUN make

RUN pip install flask


RUN apt-get clean

RUN useradd techproguser

EXPOSE 5000

ENTRYPOINT FLASK_APP=/src/app.py flask run --port=5000 --host=0.0.0.0
