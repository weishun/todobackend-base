FROM ubuntu:trusty
MAINTAINER Wilson Santos <wilson@xyber.ph>

# Present dpkg errors
ENV TERM=xterm-256color

# set mirrors to ris.ph/ubuntu
RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirror.rise.ph\/ubuntu/g" /etc/apt/sources.list

# Install Python runtime
RUN apt-get update && \
    apt-get install -y \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
    python python-virtualenv libpython2.7 python-mysqldb

# Create virtual environment
# Upgrade PUP in virutal environment to latest version
RUN virtualenv /appenv && \
    . /appenv/bin/activate && \
    pip install pip --upgrade

# Add entrypoint script
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]


