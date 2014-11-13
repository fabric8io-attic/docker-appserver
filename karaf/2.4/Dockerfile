FROM jolokia/java-jolokia:8

MAINTAINER fabric8@googlegroups.com

EXPOSE 8181 8101 8778

ENV KARAF_VERSION 2.4.0
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV DEPLOY_DIR /maven

RUN curl -qs https://repo1.maven.org/maven2/org/apache/karaf/apache-karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz | \
    tar xz -C /opt && \
    ln -s /opt/apache-karaf-* /opt/karaf && \
    useradd -d /opt/karaf -s /sbin/nologin -c "karaf user" karaf && \
    chown -R karaf:karaf /opt/karaf /opt/apache-karaf-* && \
    sed -i 's/log4j.rootLogger=INFO, out, osgi:*/log4j.rootLogger=INFO, stdout, osgi:*/' /opt/karaf/etc/org.ops4j.pax.logging.cfg

# Startup script
ADD deploy-and-run.sh /opt/karaf/bin/
ADD onbuild.sh /opt/karaf/bin/

ONBUILD RUN /opt/karaf/bin/onbuild.sh

CMD ["opt/karaf/bin/deploy-and-run.sh"]
