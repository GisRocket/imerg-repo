FROM qgis/qgis:latest

# Инсталиране на необходими пакети за мрежови растри и FCGI
RUN apt-get update && apt-get install -y \
    spawn-fcgi \
    libfcgi-dev \
    gdal-bin

WORKDIR /app

# Копиране на целия ти проект в контейнера (замени atmosphere_2023.qgz с истинското име на твоя файл)
COPY . /app/

# Настройка на променливите за QGIS Server
ENV QGIS_PROJECT_FILE=/app/atmosphere_2023.qgz
ENV QGIS_SERVER_LOG_LEVEL=0

EXPOSE 8080

# Стартиране на QGIS Server през Spawn-FCGI
CMD ["spawn-fcgi", "-n", "-p", "8080", "/usr/bin/qgis_mapserv.fcgi"]