FROM python:3.7-alpine

RUN addgroup -S -g 777 django && adduser -D -S -G django -u 777 django

RUN apk -U upgrade && apk -U add ca-certificates alpine-sdk musl-dev gcc python3-dev libmagic \
    gettext openjpeg openjpeg-tools openjpeg-dev libjpeg-turbo \
    libjpeg-turbo-utils libjpeg-turbo-dev musl freetype freetype-dev \
    libwebp lcms2 tiff zlib zlib-dev && \
    update-ca-certificates

RUN mkdir -p /code && chown -R django:django /code
WORKDIR /code

COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY *.sh /
RUN chown django:django /*.sh && chmod +x /*.sh

COPY . .
RUN chown -R django:django /code

EXPOSE 5000
CMD ["/start.sh"]
