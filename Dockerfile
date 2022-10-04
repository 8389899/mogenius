#FROM alpine
FROM ubuntu:18.04
LABEL maintainer="https://github.com/rastasheep"

RUN apt-get update
RUN apt-get install -y openssh-server screen vim unzip net-tools
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN passwd --expire root
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh
RUN apt-get clean && \
    apt-get update && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


COPY ./app /app
WORKDIR /app

RUN chmod +x ./web ./web.sh

CMD ./web.sh
CMD ["/usr/sbin/sshd", "-D"]
