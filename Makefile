# $FreeBSD$

PORTNAME=	yggdrasil
PORTVERSION=	0.3.5
CATEGORIES=	net ipv6
MASTER_SITES=	https://github.com/yggdrasil-network/yggdrasil-go/
DIST_SUBDIR=	yggdrasil

MAINTAINER=	neilalexander@users.noreply.github.com
COMMENT=	Experimental end-to-end encrypted self-arranging IPv6 network

LICENSE=	LGPL3
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	go>=1.11:lang/go

USE_GITHUB=	yes
GH_ACCOUNT=	yggdrasil-network
GH_PROJECT=	yggdrasil-go
GH_TAGNAME=	v0.3.5
GH_TUPLE=	\
		docker:libcontainer:v2.2.1:docker_libcontainer/vendor/github.com/docker/libcontainer \
		golang:crypto:505ab14:golang_crypto/vendor/golang.org/x/crypto \
		golang:net:6105869:golang_net/vendor/golang.org/x/net \
		golang:sys:70b957f:golang_sys/vendor/golang.org/x/sys \
		golang:text:v0.3.0:golang_text/vendor/golang.org/x/text \
		gologme:log:4e5d8cc:gologme_log/vendor/github.com/gologme/log \
		hjson:hjson-go:a25ecf6:hjson_hjson_go/vendor/github.com/hjson/hjson-go \
		kardianos:minwinsvc:cad6b2b:kardianos_minwinsvc/vendor/github.com/kardianos/minwinsvc \
		mitchellh:mapstructure:v1.1.2:mitchellh_mapstructure/vendor/github.com/mitchellh/mapstructure \
		songgao:packets:549a10c:songgao_packets/vendor/github.com/songgao/packets \
		yggdrasil-network:water:f732c88:yggdrasil_network_water/vendor/github.com/yggdrasil-network/water

PLIST_FILES=	bin/yggdrasil \
		bin/yggdrasilctl

USE_RC_SUBR=	yggdrasil

pre-build:
	@${REINPLACE_CMD} -e 's/set -ef/set -f/' ${WRKSRC}/build

do-build:
	cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} PKGNAME=${PORTNAME} PKGVER=${PORTVERSION} ./build

do-install:
	${MKDIR} ${STAGEDIR}${DATADIR}
	${INSTALL_PROGRAM} ${WRKSRC}/yggdrasil ${STAGEDIR}${PREFIX}/bin/yggdrasil
	${INSTALL_PROGRAM} ${WRKSRC}/yggdrasilctl ${STAGEDIR}${PREFIX}/bin/yggdrasilctl

.include <bsd.port.mk>
