export APT_LIST_PATH=$WERCKER_CACHE_DIR/wercker/apt-lists
mkdir -p $APT_LIST_PATH
sudo rm -fr /var/lib/apt/lists
sudo ln -s $APT_LIST_PATH/ /var/lib/apt/lists

export APT_OPTS='-o Acquire::Check-Valid-Until=false'

if [ -n "$WERCKER_INSTALL_PACKAGES_DISABLE_SECURITY" ]
then
    sudo sed -i -r "s/^(.+security\..+)$/#\1/i" /etc/apt/sources.list
    sudo apt-get $APT_OPTS update -y
fi

if [ $( find $WERCKER_CACHE_DIR/wercker/aptupdated -mtime -1 | wc -l ) -eq 0 ]
then
    touch $WERCKER_CACHE_DIR/wercker/aptupdated
    sudo apt-get $APT_OPTS update -y
fi

sudo apt-get $APT_OPTS install $WERCKER_INSTALL_PACKAGES_PACKAGES -y --force-yes
