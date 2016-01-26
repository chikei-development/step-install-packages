export APT_LIST_PATH=$WERCKER_CACHE_DIR/wercker/apt-lists
mkdir -p $APT_LIST_PATH
sudo rm -fr /var/lib/apt/lists
sudo ln -s $APT_LIST_PATH/ /var/lib/apt/lists

#sudo sed -ie 's/httpredir.debian.org/ftp.debian.org/' /etc/apt/sources.list
cat <<EOF | sudo tee /etc/apt/sources.list
deb http://ftp.jp.debian.org/debian/ jessie main
#deb-src http://ftp.jp.debian.org/debian/ jessie main
deb http://security.debian.org/ jessie/updates main
#deb-src http://security.debian.org/ jessie/updates main
deb http://ftp.jp.debian.org/debian/ jessie-updates main
#deb-src http://ftp.jp.debian.org/debian/ jessie-updates main
EOF


sudo apt-get update -y
if [ $( find $WERCKER_CACHE_DIR/wercker/aptupdated -mtime -1 | wc -l ) -eq 0 ]
then
    touch $WERCKER_CACHE_DIR/wercker/aptupdated
fi

sudo apt-get install $WERCKER_INSTALL_PACKAGES_PACKAGES -y --force-yes
