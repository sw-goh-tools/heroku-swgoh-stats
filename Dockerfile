FROM ghcr.io/swgoh-utils/swgoh-stats:latest
ENV TINI_SUBREAPER=true
ENV USE_SEGMENTS=true
ENV USE_UNZIP=false
