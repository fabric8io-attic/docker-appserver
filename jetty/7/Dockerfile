FROM fabric8/base-sti

MAINTAINER fabric8@googlegroups.com

EXPOSE 8080 8778

ENV JETTY_VERSION 7.6.17.v20150415
ENV DEPLOY_DIR /maven

RUN wget http://download.eclipse.org/jetty/${JETTY_VERSION}/dist/jetty-distribution-${JETTY_VERSION}.zip -O /tmp/jetty.zip

# Unpack
USER root
RUN cd /opt && jar xf /tmp/jetty.zip
RUN ln -s /opt/jetty-distribution-${JETTY_VERSION} /opt/jetty
RUN rm /tmp/jetty.zip
RUN chown -R jboss:jboss /opt/jetty/

# Startup script
ADD deploy-and-run.sh /opt/jetty/bin/
RUN chmod a+x /opt/jetty/bin/deploy-and-run.sh
USER jboss

# jolokia agent
RUN wget http://central.maven.org/maven2/org/jolokia/jolokia-jvm/1.3.1/jolokia-jvm-1.3.1-agent.jar -O /opt/jetty/jolokia-agent.jar

ENV JAVA_OPTIONS -javaagent:/opt/jetty/jolokia-agent.jar=host=0.0.0.0,port=8778,agentId=$HOSTNAME
ENV JETTY_HOME /opt/jetty
ENV PATH $PATH:$JETTY_HOME/bin

CMD /opt/jetty/bin/deploy-and-run.sh
