FROM qgis/qgis-server:4.2.3

# QGIS Server's official image includes Nginx and Xvfb. Put the project and its
# relative raster sources in the directory used by the image's OGC routes.
COPY . /io/data/

ENV QGIS_SERVER_LANDING_PAGE_PREFIX=/ \
    QGIS_SERVER_LANDING_PAGE_PROJECTS_DIRECTORIES=/io/data

# Render routes web services to port 10000 by default.
RUN sed -i 's/listen       80 default_server;/listen       10000 default_server;/' /etc/nginx/nginx.conf \
    && sed -i '/listen       \[::\]:80 default_server;/d' /etc/nginx/nginx.conf

EXPOSE 10000
