# pull official base image
FROM python:3.7-alpine

# set work directory
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DEBUG 0

# install psycopg2
RUN pip install --upgrade pip
RUN apk update \
    && apk add --virtual build-essential musl-dev make automake gcc g++ subversion python3-dev \
    # && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add postgresql-dev \
    && pip install psycopg2 \
    && apk del build-essential

# install dependencies
RUN pip install conda
RUN conda install torch==1.6.0+cpu torchvision==0.7.0+cpu -f https://download.pytorch.org/whl/torch_stable.html
RUN conda install fastai
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . .

RUN ls foodie/foodie