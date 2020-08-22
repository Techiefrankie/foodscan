# pull official base image
FROM python:3.7-alpine

# set work directory
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DEBUG 0

# install psycopg2
RUN apk update \
    && apk add make automake gcc g++ subversion python3-dev \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add postgresql-dev \
    && pip install psycopg2 \
    && apk del build-deps

# install dependencies
RUN pip install torch==1.6.0+cpu torchvision==0.7.0+cpu -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install fastai
# RUN pip install wheel setuptools cython numpy scipy pandas matplotlib fastai
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . .

RUN ls foodie/foodie