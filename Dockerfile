FROM registry.gitlab.com/swgoh-tools/swgoh-stats:latest
ENV TINI_SUBREAPER=true
ENV USE_SEGMENTS=true
ENV USE_UNZIP=false
