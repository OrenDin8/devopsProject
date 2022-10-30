# syntax=docker/dockerfile:1
FROM python:3.8-slim 

RUN apt-get update
RUN apt-get install -y python
RUN pip install flask 

ENV FLASK_APP=app.py 
ENV FLASK_RUN_HOST=0.0.0.0

COPY requirements.txt requirements.txt
COPY . .

EXPOSE 5000

CMD python3 app.py 
