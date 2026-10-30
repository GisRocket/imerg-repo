FROM qgis/qgis:latest

# Инсталиране на lighttpd и необходими инструменти
RUN apt-get update && apt-get install -y \
    lighttpd \
    spawn-fcgi \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копиране на проекта и ресурсите
COPY . /app/

# Задаване на променливи
ENV QGIS_PROJECT_FILE=/app/atmosphere_2023.qgz
ENV QGIS_SERVER_LOG_LEVEL=0

# Създаване на правилен lighttpd.conf с точния път до qgis_mapserv.fcgi
RUN echo 'server.modules = ( "mod_fastcgi", "mod_access", "mod_alias" )' > /etc/lighttpd/lighttpd.conf && \
    echo 'server.document-root = "/app"' >> /etc/lighttpd/lighttpd.conf && \
    echo 'server.port = 8080' >> /etc/lighttpd/lighttpd.conf && \
    echo 'fastcgi.server = ( "" => (( "bin-path" => "/usr/lib/qgis/qgis_mapserv.fcgi", "socket" => "/tmp/qgis-server.sock", "check-local" => "disable", "max-procs" => 1, "bin-environment" => ( "QGIS_PROJECT_FILE" => "/app/atmosphere_2023.qgz" ) )))' >> /etc/lighttpd/lighttpd.conf

EXPOSE 8080

# Стартиране на Lighttpd на преден план
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]