FROM python:3.10-slim-bullseye

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /app/
WORKDIR /app/

RUN pip3 install --no-cache-dir --upgrade pip
RUN pip3 install --no-cache-dir --requirement requirements.txt
RUN pip3 install --no-cache-dir pytube

ENV COOKIES_FILE_PATH="youtube_cookies.txt"

CMD gunicorn app:app & python3 main.py
