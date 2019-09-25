# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG TAG="20190925"
ARG IMAGETYPE="application"
ARG MAPSTORE2_VERSION="v2019.02.00"
ARG CATALINA_HOME="/usr/local/tomcat"
ARG BASEIMAGE="huggla/tomcat-alpine:$TAG"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG RUNDEPS="freetype ttf-font-awesome"
ARG BUILDDEPS="openjdk8"
ARG DOWNLOADS="https://github.com/geosolutions-it/MapStore2/releases/download/$MAPSTORE2_VERSION/mapstore.war https://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64.tar.gz https://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-amd64.tar.gz"
ARG DESTDIR="/webapps-nobind/mapstore2"
ARG BUILDCMDS=\
'   cd $DESTDIR '\
'&& /usr/lib/jvm/java-1.8-openjdk/bin/jar xf $DOWNLOADSDIR/mapstore.war '\
'&& cp -a $DOWNLOADSDIR/jai-1_1_3/lib/*.jar $DOWNLOADSDIR/jai_imageio-1_1/lib/*.jar WEB-INF/lib/ '\
'&& cp -a $DOWNLOADSDIR/jai-1_1_3/lib/*.so $DOWNLOADSDIR/jai_imageio-1_1/lib/*.so /usr/lib/jvm/java-1.8-openjdk/jre/lib/amd64/libfontmanager.so /finalfs/usr/local/lib/amd64/'
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-huggla/build:$TAG} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================
ENV VAR_MAPSTORE_CONFIG_DIR="/etc/mapstore2" \
    VAR_WITH_MANAGERS="false" \
    VAR_ROOT_APP="mapstore2"
    
# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
