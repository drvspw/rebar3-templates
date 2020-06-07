#!/bin/bash

set -e

# Build a package only on a clean tree
#if [[ ! -z $(git status -s) ]]; then
#    echo "Please commit changes before running this"
#    exit -1
#fi

PROJECT=$(basename `pwd`)
MAJOR_VERSION=2
GIT_HOST=github.com
PROJECT_GROUP=xaptum
TAG_ORIGIN=$(echo -n "git@${GIT_HOST}:${PROJECT_GROUP}/${PROJECT}.git")

OS=$(cat /etc/*release 2>/dev/null | head -n1 | sed -e 's/.*(\(.*\)).*/\1/')

function sedeasy {
    sed -i "s/$1/$(echo $2 | sed -e 's/[\/&]/\\&/g')/g" $3
}

env_error() {
    echo "${{name}}_ENV is not set. Allowed values are dev|prod"
    exit -1
}

repo() {
    echo -n "${PROJECT}"
}

owner() {
    echo -n "${PROJECT_GROUP}"
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
    local REVISION=$(date +%y.%m)
    local REVISIONCOUNT=$(git log --oneline | wc -l | tr -d ' ')
    local BRANCH=$(branch)
    local HASH=$(git rev-parse --short HEAD)

    case "X$BRANCH" in
	Xmaster)
	    REVISION_PREFIX=m${REVISIONCOUNT}
	    ;;

	XHEAD)
	    REVISION_PREFIX=m${REVISIONCOUNT}
	    ;;

	*)
	    REVISION_PREFIX=rc${REVISIONCOUNT}
	    ;;
    esac

    echo -n "${MAJOR_VERSION}.${REVISION}-${REVISION_PREFIX}-${HASH}"
}

deploy_url() {
    local ENV=${{{name}}_ENV}
    local DIST=''

    case "X$ENV" in
	Xprod)
	    DIST=${OS}
	    ;;

	Xdev)
	    DIST=${OS}-dev
	    ;;

	*)
	    env_error
	    ;;
    esac

    echo -n "https://apt.xaptum.xyz/upload/${DIST}/main"
}

pkg_name() {
    local PKG_VERSION=$(version)
    echo -n "${PROJECT}_${PKG_VERSION}_amd64"
}

tag() {
    local PKG_VERSION=$(version)
    local BRANCH=$(branch)

    # Tag only master branch commits
    if [[ ${CIRCLE_PROJECT_USERNAME} == ${PROJECT_GROUP} ]]; then
	if [ "X$BRANCH" == Xmaster ]; then
	    echo -n "git remote add tag-origin ${TAG_ORIGIN}" | bash -v
	    echo -n "git tag ${PKG_VERSION}" | bash -v
	    echo -n "git push tag-origin ${PKG_VERSION}" | bash -v
	fi
    fi
}

deploy() {
    local PKG=$(pkg_name)
    local URL=$(deploy_url)
    local DEB_DIR=_build/deb

    if [[ ${CIRCLE_PROJECT_USERNAME} == ${PROJECT_GROUP} ]]; then
	cd ${DEB_DIR} && curl -i -F debfile=@${PKG}.deb -H "Authorization: Bearer ${XAPTUM_APT_API_KEY}" ${URL}
    fi
}

debian() {
    local PKG_VERSION=$(version)
    local PKG=$(pkg_name)
    local BRANCH=$(branch)
    local DEB_DIR=_build/deb

    # Clean Build directiory
    echo "Preparing build directory..."
    rm -rf ${DEB_DIR}

    # Create Directory Structure
    echo "Creating debian package directory structure...."

    # Copy DEBIAN control files
    mkdir -p ${DEB_DIR}/${PKG}/DEBIAN
    cp -r ./debian/control/* ${DEB_DIR}/${PKG}/DEBIAN/
    sed -i "s/Version:.*/Version: ${PKG_VERSION}/" ${DEB_DIR}/${PKG}/DEBIAN/control
    sedeasy "XBS-Comment:.*" "Comment: This package is built from ${BRANCH} branch" ${DEB_DIR}/${PKG}/DEBIAN/control
    sedeasy "__PKG_VERSION__" "${PKG_VERSION}" ${DEB_DIR}/${PKG}/DEBIAN/postinst

    # Copy {{name}}.service file
    mkdir -p ${DEB_DIR}/${PKG}/usr/lib/systemd/system
    cp ./debian/service/*.service ${DEB_DIR}/${PKG}/usr/lib/systemd/system/

    # Create project directory
    mkdir -p ${DEB_DIR}/${PKG}/opt/xaptum/${PROJECT}

    # Unpack {{name}} erlang release
    tar -zxvf ${DEB_DIR}/../${PROJECT}.tar.gz -C ${DEB_DIR}/${PKG}/opt/xaptum

    # Build debian package
    cd ${DEB_DIR} && dpkg-deb --build ${PKG}

    echo "Created ${PKG}.deb"
}

main() {
    case $1 in
	debian)
	    debian
	    ;;

	version)
	    version
	    ;;

	branch)
	    branch
	    ;;

	pkg)
	    pkg_name
	    ;;

	deploy)
	    deploy
	    ;;

	repo)
	    repo
	    ;;

	owner)
	    owner
	    ;;

	tag)
	    tag
	    ;;
    esac
}

# Call main with all the arguments
main $@
