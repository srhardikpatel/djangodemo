FROM ubuntu

WORKDIR /app

COPY . /app

RUN apt update

RUN apt install python3 python3-django -y

ENTRYPOINT ["python3"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]
