FROM openjdk:11-jdk

RUN apt-get update && apt-get install -y fswatch

WORKDIR /usr/app

COPY . .

COPY watch-and-reload.sh /usr/app/watch-and-reload.sh
RUN chmod +x /usr/app/watch-and-reload.sh

CMD ["/usr/app/watch-and-reload.sh"]
