FROM python:3.8-slim 
RUN apt-get update 
COPY . /app
WORKDIR /app 
RUN pip3 install -r requirements.txt
CMD ["flask", "run", "--host=0.0.0.0"] 
