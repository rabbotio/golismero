FROM rabbotio/python

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install \
        wget \
        netcat \
        git \
        perl \
        python \
        python-pip \
        sudo \
        nmap \
        sslscan \
        apache2

RUN git clone https://github.com/golismero/golismero /opt/golismero && \
    cd /opt/golismero

RUN ln -s /opt/golismero/golismero.py /usr/bin/golismero
RUN mkdir -p /home/app/.golismero/
ADD golismero.conf /home/app/.golismero/user.conf
RUN mkdir -p /opt/golismero/results
RUN chown -R app /opt/golismero
RUN chown -R app /home/app

WORKDIR /opt/golismero
RUN pip install -r requirements.txt
RUN pip install -r requirements_unix.txt

USER app

ENTRYPOINT ["golismero"]