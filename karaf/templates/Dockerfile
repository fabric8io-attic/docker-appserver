{{
  var base = it.config.base;
  var majorVersion = it.version.replace(/^([^.]+).*$/,"$1");
  var url = it.config.url ||
           "http://archive.apache.org/dist/tomcat/tomcat-" + majorVersion +
           "/v${KARAF_VERSION}/bin/" + base + "-${KARAF_VERSION}.tar.gz";
  var toRemove = it.config.toRemove;
  var roleFile = it.config.roleFile;
}}
FROM {{= it.javaBaseImage }}

MAINTAINER {{= it.maintainer }}

EXPOSE 8181 8101 8778

ENV KARAF_VERSION {{= it.config.version }}
ENV DEPLOY_DIR /opt/jboss/deploy
USER jboss
{{? it.config.useJavaHome}}
ENV JAVA_HOME {{= it.javaHome }}
{{?}}

RUN wget {{= url }} -O /tmp/karaf.tar.gz

# Unpack
RUN tar xzf /tmp/karaf.tar.gz -C /opt/jboss
RUN ln -s /opt/jboss/{{= base }}-${KARAF_VERSION} /opt/jboss/karaf
RUN rm /tmp/karaf.tar.gz

# Add roles
ADD {{= roleFile.file}} /opt/jboss/{{= base}}-${KARAF_VERSION}/{{= roleFile.dir}}

# Startup and usage cript
ADD ./usage /usr/bin/
ADD ./deploy-and-start /usr/bin/

# jolokia agent
RUN wget http://central.maven.org/maven2/org/jolokia/jolokia-jvm/1.2.2/jolokia-jvm-1.2.2-agent.jar -O /opt/jboss/karaf/jolokia-agent.jar

# Remove unneeded apps
RUN rm -rf {{~toRemove :value:index}}/opt/jboss/karaf/deploy/{{=value}} {{~}}

ENV KARAF_OPTS -javaagent:/opt/jboss/karaf/jolokia-agent.jar=host=0.0.0.0,port=8778,authMode=jaas,realm=karaf,user=admin,password=admin,agentId=$HOSTNAME
ENV KARAF_HOME /opt/jboss/karaf
ENV PATH $PATH:$KARAF_HOME/bin

CMD ["/usr/bin/sti-helper"]
