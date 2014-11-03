#!/bin/sh


DIR=${DEPLOY_DIR:-/maven}

if [ -d "$DIR/repository" ]; then
  echo "Copying offline repo"
  cp -rf $DIR/repository/* /opt/karaf/system/
fi

if [ -d "$DIR/kars" ]; then
  for i in $DIR/kars/*; do
     file=$(basename $i)
     echo "Linking $i --> /opt/karaf/deploy/$file"
     ln -s $i /opt/karaf/deploy/$file
  done
fi

KARAF_USERNAME=${KARAF_USERNAME:-admin}
KARAF_PASSWORD=${KARAF_PASSWORD:-admin}

echo ${KARAF_USERNAME}=${KARAF_PASSWORD},_g_\:admingroup > /opt/karaf/etc/users.properties
echo '_g_\:admingroup = group,admin,manager,viewer,webconsole' >> /opt/karaf/etc/users.properties

export KARAF_OPTS="-javaagent:/opt/jolokia/jolokia.jar=host=0.0.0.0,port=8778,authMode=jaas,realm=karaf,user=${KARAF_USERNAME},password=${KARAF_PASSWORD},agentId=$HOSTNAME"

exec /opt/karaf/bin/karaf server
