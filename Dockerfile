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
RUN mkdir -p ~/.golismero/
ADD golismero.conf ~/.golismero/user.conf
RUN mkdir -p /opt/golismero/results

WORKDIR /opt/golismero
RUN pip install -r requirements.txt
RUN pip install -r requirements_unix.txt

ENTRYPOINT ["golismero"]