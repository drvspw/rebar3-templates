#!/bin/bash

set -e


PROJECT_DIR=$(pwd)
PROJECT={{name}}

function sedeasy {
    sed -i "s/$1/$(echo $2 | sed -e 's/[\/&]/\\&/g')/g" $3
}

branch() {
    # Check if branch name comes for drone
    local BRANCH=${CIRCLE_BRANCH}

    # Get for github env variable
    if [ "X$BRANCH" == X ]; then
	BRANCH=$(echo -n $GITHUB_REF | sed 's/refs\/heads\///g')
    fi

    # Finally take from git
    if [ "X$BRANCH" == X ]; then
	BRANCH=$(git rev-parse --abbrev-ref HEAD)
    fi
    echo -n "${BRANCH}"
}

version() {
    local vsn=$(rebar3 current)
    echo -n "${vsn}"
}

pkg_name() {
    local PKG_VERSION=$(version)
    echo -n "${PROJECT}_${PKG_VERSION}_amd64"
}

debian() {
    local PKG_VERSION=$(version)
    local PKG=$(pkg_name)
    local BRANCH=$(branch)
    local DEB_DIR=${PROJECT_DIR}/_build/deb

    # Clean Build directiory
    echo "Preparing build directory..."
    rm -rf ${DEB_DIR}

    # Create Directory Structure
    echo "Creating debian package directory structure...."

    # Copy DEBIAN control files
    mkdir -p ${DEB_DIR}/${PKG}/DEBIAN
    cp -r ${PROJECT_DIR}/package/deb/* ${DEB_DIR}/${PKG}/DEBIAN/
    sed -i "s/Version:.*/Version: ${PKG_VERSION}/" ${DEB_DIR}/${PKG}/DEBIAN/control
    sedeasy "XBS-Comment:.*" "Comment: This package is built from ${BRANCH} branch" ${DEB_DIR}/${PKG}/DEBIAN/control
    sedeasy "__PKG_VERSION__" "${PKG_VERSION}" ${DEB_DIR}/${PKG}/DEBIAN/postinst

    # Copy {{name}}.service file
    mkdir -p ${DEB_DIR}/${PKG}/usr/lib/systemd/system
    cp ${PROJECT_DIR}/package/systemd/*.service ${DEB_DIR}/${PKG}/usr/lib/systemd/system/

    # Create project directory
    mkdir -p ${DEB_DIR}/${PKG}/opt/${PROJECT}

    # Unpack {{name}} erlang release
    tar -zxvf ${DEB_DIR}/../${PROJECT}.tar.gz -C ${DEB_DIR}/${PKG}/opt/

    # Build debian package
    cd ${DEB_DIR} && dpkg-deb --build ${PKG}

    echo "Created ${PKG}.deb"
}

main() {
    case $1 in
	debian)
	    debian
	    ;;

	pkg)
	    pkg_name
	    ;;
    esac
}

# Call main with all the arguments
main $@
