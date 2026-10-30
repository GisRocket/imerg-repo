FROM qgis/qgis:latest

WORKDIR /app

# Копиране на целия bundled проект в контейнера
COPY . /app/

# Задаване на променливите за QGIS Server
ENV QGIS_PROJECT_FILE=/app/atmosphere_2023.qgz
ENV QGIS_SERVER_LOG_LEVEL=0

EXPOSE 8080

# Използване на вградения бинарен файл директно вместо spawn-fcgi
CMD ["/usr/bin/qgis_mapserv.fcgi"]