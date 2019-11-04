# $FreeBSD$

PORTNAME=		yggdrasil
PORTVERSION=		0.3.11
DISTVERSIONPREFIX=	v
CATEGORIES=		net
MASTER_SITES=		https://github.com/yggdrasil-network/yggdrasil-go/
DIST_SUBDIR=		yggdrasil

MAINTAINER=		freebsd@neilalexander.dev
COMMENT=		Experimental end-to-end encrypted self-arranging IPv6 network

LICENSE=		LGPL3
LICENSE_FILE=		${WRKSRC}/LICENSE

USES=			go:modules
USE_GITHUB=		yes
GH_ACCOUNT=		yggdrasil-network
GH_PROJECT=		yggdrasil-go
GH_TUPLE=		\
	Arceliar:phony:d0c68492aca0:arceliar_phony/vendor/github.com/Arceliar/phony \
	golang:crypto:87dc89f01550:golang_crypto/vendor/golang.org/x/crypto \
	golang:net:ec77196f6094:golang_net/vendor/golang.org/x/net \
	golang:sys:b4ff53e7a1cb:golang_sys/vendor/golang.org/x/sys \
	golang:text:v0.3.2:golang_text/vendor/golang.org/x/text \
	gologme:log:4e5d8ccb38e8:gologme_log/vendor/github.com/gologme/log \
	hashicorp:go-syslog:v1.0.0:hashicorp_go_syslog/vendor/github.com/hashicorp/go-syslog \
	hjson:hjson-go:9147687966d9:hjson_hjson_go/vendor/github.com/hjson/hjson-go \
	kardianos:minwinsvc:cad6b2b879b0:kardianos_minwinsvc/vendor/github.com/kardianos/minwinsvc \
	mitchellh:mapstructure:v1.1.2:mitchellh_mapstructure/vendor/github.com/mitchellh/mapstructure \
	songgao:packets:549a10cd4091:songgao_packets/vendor/github.com/songgao/packets \
	vishvananda:netlink:v1.0.0:vishvananda_netlink/vendor/github.com/vishvananda/netlink \
	vishvananda:netns:7109fa855b0f:vishvananda_netns/vendor/github.com/vishvananda/netns \
	yggdrasil-network:water:c83fe40250f8:yggdrasil_network_water/vendor/github.com/yggdrasil-network/water

PLIST_FILES=		bin/yggdrasil \
			bin/yggdrasilctl

USE_RC_SUBR=		yggdrasil

pre-build:
	@${REINPLACE_CMD} -e 's/set -ef/set -f/' ${WRKSRC}/build

do-build:
	cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} PKGNAME=${PORTNAME} PKGVER=${PORTVERSION} ./build

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/yggdrasil ${STAGEDIR}${PREFIX}/bin/yggdrasil
	${INSTALL_PROGRAM} ${WRKSRC}/yggdrasilctl ${STAGEDIR}${PREFIX}/bin/yggdrasilctl

.include <bsd.port.mk>
