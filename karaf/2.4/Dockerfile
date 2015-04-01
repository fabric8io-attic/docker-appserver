FROM fabric8/base-sti

MAINTAINER fabric8@googlegroups.com

EXPOSE 8181 8101 8778

ENV KARAF_VERSION 2.4.1
ENV DEPLOY_DIR /opt/jboss/deploy
USER jboss

ENV JAVA_HOME /usr/lib/jvm/java


RUN wget http://archive.apache.org/dist/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz -O /tmp/karaf.tar.gz

# Unpack
RUN tar xzf /tmp/karaf.tar.gz -C /opt/jboss
RUN ln -s /opt/jboss/apache-karaf-${KARAF_VERSION} /opt/jboss/karaf
RUN rm /tmp/karaf.tar.gz

# Add roles
ADD users.properties /opt/jboss/apache-karaf-${KARAF_VERSION}/etc/

# Startup and usage cript
ADD ./usage /usr/bin/
ADD ./deploy-and-start /usr/bin/

# jolokia agent
RUN wget http://central.maven.org/maven2/org/jolokia/jolokia-jvm/1.2.3/jolokia-jvm-1.2.3-agent.jar -O /opt/jboss/karaf/jolokia-agent.jar

# Remove unneeded apps
RUN rm -rf /opt/jboss/karaf/deploy/README 

ENV KARAF_OPTS -javaagent:/opt/jboss/karaf/jolokia-agent.jar=host=0.0.0.0,port=8778,authMode=jaas,realm=karaf,user=admin,password=admin,agentId=$HOSTNAME
ENV KARAF_HOME /opt/jboss/karaf
ENV PATH $PATH:$KARAF_HOME/bin

CMD ["/usr/bin/usage"]
