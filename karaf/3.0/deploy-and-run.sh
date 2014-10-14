#!/bin/sh


DIR=${DEPLOY_DIR:-/maven}
echo "Copying offline repo"
cp -rf $DIR/repository/* /opt/karaf/system/
echo "Checking for kars in $DIR/kars"
if [ -d $DIR ]; then
  for i in $DIR/kars/*; do
     file=$(basename $i)
     echo "Linking $i --> /opt/karaf/deploy/$file"
     ln -s $i /opt/karaf/deploy/$file
  done
fi
# Use faster (though more unsecure) random number generator
export KARAF_OPTS="$KARAF_OPTS -Djava.security.egd=file:/dev/./urandom"
/opt/karaf/bin/karaf server
