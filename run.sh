export APT_LIST_PATH=$WERCKER_CACHE_DIR/wercker/apt-lists
mkdir -p $APT_LIST_PATH
sudo rm -fr /var/lib/apt/lists
sudo ln -s $APT_LIST_PATH/ /var/lib/apt/lists

if [ -n "$WERCKER_INSTALL_PACKAGES_DISABLE_SECURITY" ]
then
    sudo sed -iE "s/^(.+security\..+)$/#\1/i" /etc/apt/sources.list
    sudo apt-get update -y
fi

if [ $( find $WERCKER_CACHE_DIR/wercker/aptupdated -mtime -1 | wc -l ) -eq 0 ]
then
    touch $WERCKER_CACHE_DIR/wercker/aptupdated
    sudo apt-get update -y
fi

sudo apt-get install $WERCKER_INSTALL_PACKAGES_PACKAGES -y --force-yes
