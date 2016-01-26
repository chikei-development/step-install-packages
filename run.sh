export APT_LIST_PATH=$WERCKER_CACHE_DIR/wercker/apt-lists
mkdir -p $APT_LIST_PATH
sudo rm -fr /var/lib/apt/lists
sudo ln -s $APT_LIST_PATH/ /var/lib/apt/lists

#sudo apt-get install software-properties-common -y --force-yes
sudo apt-get update -y

if [ $( find $WERCKER_CACHE_DIR/wercker/aptupdated -mtime -1 | wc -l ) -eq 0 ]
then
    touch $WERCKER_CACHE_DIR/wercker/aptupdated
fi

sudo apt-get install $WERCKER_INSTALL_PACKAGES_PACKAGES -y --force-yes
