FROM alpine:edge

RUN apk update && apk add --no-cache build-base cmake ninja zip unzip curl git

ENV VCPKG_ROOT=/vcpkg
ENV VCPKG_FORCE_SYSTEM_BINARIES=1
ENV VCPKG_DISABLE_METRICS=1

ENV VCPKG_REL=2024.08.23
ENV VCPKG_TAR=$VCPKG_REL.tar.gz

RUN curl -L -O https://github.com/microsoft/vcpkg/archive/refs/tags/$VCPKG_TAR && \
    tar xf $VCPKG_TAR && mv vcpkg-$VCPKG_REL vcpkg && rm $VCPKG_TAR

COPY arm64-linux.cmake triplets/
COPY x64-linux.cmake triplets/

RUN .$VCPKG_ROOT/bootstrap-vcpkg.sh
ENV PATH="$VCPKG_ROOT:$PATH"
