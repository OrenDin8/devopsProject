# syntax=docker/dockerfile:1
FROM python:3.8-slim 

RUN apt-get update
RUN apt-get install -y python
RUN pip install flask 

COPY requirements.txt requirements.txt
COPY . .

EXPOSE 5000

ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 
