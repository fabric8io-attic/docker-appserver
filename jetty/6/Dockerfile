FROM fabric8/base-sti

MAINTAINER fabric8@googlegroups.com

EXPOSE 8080 8778

ENV JETTY_VERSION=6.1.18 \
    JAVA=/usr/bin/java \
    DEPLOY_DIR=/maven \
    JAVA_OPTIONS=-javaagent:/opt/jetty/jolokia-agent.jar=host=0.0.0.0,port=8778 \
    JETTY_HOME=/opt/jetty \
    PATH=$PATH:$JETTY_HOME/bin

# Download & Unpack
USER root
RUN wget http://mirrors.ibiblio.org/maven/jetty/jetty-${JETTY_VERSION}/jetty-${JETTY_VERSION}.zip -O /tmp/jetty.zip && \
    cd /opt && jar xf /tmp/jetty.zip && \
    ln -s /opt/jetty-${JETTY_VERSION} /opt/jetty && \
    rm /tmp/jetty.zip && \
    wget http://central.maven.org/maven2/org/jolokia/jolokia-jvm/1.3.1/jolokia-jvm-1.3.1-agent.jar -O /opt/jetty/jolokia-agent.jar && \
    chown -R jboss:jboss /opt/jetty/

# Startup script
ADD deploy-and-run.sh /opt/jetty/bin/
ADD jetty-logging.xml /opt/jetty/etc/
RUN chmod a+x /opt/jetty/bin/deploy-and-run.sh
USER jboss

CMD /opt/jetty/bin/deploy-and-run.sh
