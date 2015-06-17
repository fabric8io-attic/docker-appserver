FROM {{= it.javaBaseImage }}

MAINTAINER {{= it.maintainer }}

EXPOSE 8080 8778

ENV JETTY_VERSION={{= it.config.version }} \
    JAVA=/usr/bin/java \
    DEPLOY_DIR=/maven \
    JAVA_OPTIONS=-javaagent:/opt/jetty/jolokia-agent.jar=host=0.0.0.0,port=8778 \
    JETTY_HOME=/opt/jetty \
    PATH=$PATH:$JETTY_HOME/bin

# Download & Unpack
USER root
RUN wget {{= it.config.downloadUrl}} -O /tmp/jetty.zip && \
    cd /opt && jar xf /tmp/jetty.zip && \
    ln -s /opt/{{= it.config.baseName }}-${JETTY_VERSION} /opt/jetty && \
    rm /tmp/jetty.zip && \
    wget http://central.maven.org/maven2/org/jolokia/jolokia-jvm/{{= it.jolokiaVersion}}/jolokia-jvm-{{= it.jolokiaVersion}}-agent.jar -O /opt/jetty/jolokia-agent.jar && \
    chown -R jboss:jboss /opt/jetty/

# Startup script
ADD deploy-and-run.sh /opt/jetty/bin/
ADD jetty-logging.xml /opt/jetty/etc/
RUN chmod a+x /opt/jetty/bin/deploy-and-run.sh
USER jboss

CMD /opt/jetty/bin/deploy-and-run.sh
