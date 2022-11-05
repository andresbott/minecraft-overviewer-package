#!/bin/bash
cd app

## Get sources
git clone https://github.com/overviewer/Minecraft-Overviewer.git
#mkdir Minecraft-Overviewer
#mkdir -p Minecraft-Overviewer/build/scripts-3.9
#mkdir -p Minecraft-Overviewer/build/lib.linux-x86_64-3.9
#mkdir -p Minecraft-Overviewer/build/temp.linux-x86_64-3.9

cd Minecraft-Overviewer


### Build source
python3 setup.py build

### move dist packages
mkdir dist
SCRIPTDIR=$(ls build | grep scripts |head -n 1)
LIBDIR=$(ls build | grep lib.linux |head -n 1)
C_OVERVIEWER_SO=$(ls "build/${LIBDIR}/overviewer_core"  | grep c_overviewer |head -n 1)

mv "build/${LIBDIR}/overviewer_core/${C_OVERVIEWER_SO}" "build/${LIBDIR}/overviewer_core/c_overviewer.so"
mv "build/${SCRIPTDIR}" dist/scipts
mv "build/${LIBDIR}" dist/lib

source overviewer_core/overviewer_version.py
#  #VERSION='0.19.9'
#  #HASH='6ffbe0f0beee56288fabce4db8d1838e42bac160'
#  #BUILD_DATE='Sat Nov  5 12:50:11 2022'
#  #BUILD_PLATFORM=''
#  #BUILD_OS='Linux-5.19.0-2-amd64-x86_64-with-glibc2.35'
#
echo "${VERSION}"
export OVERVIEWER_VERSION="${VERSION}"


PYVER_TMP=$(python3 --version  | awk '{ print $2}' |cut -d"." -f2)
export PYVER="3.${PYVER_TMP}"


envsubst < ../nfpm.tpl.yaml > nfpm.yaml
cat nfpm.yaml

nfpm pkg -f nfpm.yaml -p deb

touch minecraft-overviewer_0.19.9_amd64.deb

FILENAME=$(ls  | grep .deb |head -n 1 | rev |  cut -f 2- -d '.' | rev)

chmod 777 "${FILENAME}.deb"
cp "${FILENAME}.deb" /out/"${FILENAME}_buster.deb"


