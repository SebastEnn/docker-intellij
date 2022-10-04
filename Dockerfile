FROM alpine:latest

RUN addgroup sshgroup && \
    adduser -D -s /bin/bash -g sshgroup jetbrain && \
    mkdir -p /home/jetbrain/.ssh
COPY key.pub /home/jetbrain/.ssh/authorized_keys

RUN apk update && \
    apk add git && \
    apk add openjdk-18-jdk && \
    apk add maven && \
    apk add openssh-server && \
	apk clean;

RUN chown jetbrain:sshgroup /home/jetbrain/.ssh/authorized_keys && \
    chmod 600 /home/jetbrain/.ssh/authorized_keys && \
	service ssh start;

COPY --chmod=755 start.sh /home/jetbrain

ENV JAVA_HOME=/usr/lib/jvm/java-18-openjdk-amd64
ENV MAVEN_HOME=/usr/share/maven
ENV PATH="$PATH:$JAVA_HOME/bin"
ENV PATH="$PATH:$MAVEN_HOME/bin"
ENV IDEA_VERSION="2022.2.2"
ENV TZ=Europe/Berlin

ADD https://download.jetbrains.com/idea/ideaIU-$IDEA_VERSION.tar.gz /opt/idea.tar.gz
RUN tar --extract --verbose --directory /opt --file /opt/idea.tar.gz && \
    rm -f /opt/idea.tar.gz

EXPOSE 2022

RUN /opt/idea-IU-222.4167.29/bin/remote-dev-server.sh registerBackendLocationForGateway

# ENTRYPOINT ["/opt/intellij-idea-ultimate/current/bin/remote-dev-server.sh", "registerBackendLocationForGateway"]
# CMD /test.sh
# CMD /ide/bin/remote-dev-server.sh run /project --ssh-link-host 0.0.0.0 --ssh-link-user jetbrain --ssh-link-port 2022
# CMD systemctl start sshd.service
# CMD /home/jetbrain/start.sh
CMD ["/usr/sbin/sshd","-D"]