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

PLIST_FILES=	bin/yggdrasil \
		bin/yggdrasilctl

USE_RC_SUBR=	yggdrasil

pre-build:
	@${REINPLACE_CMD} -e 's/set -ef/set -f/' ${WRKSRC}/build

do-build:
	cd ${WRKSRC} && PKGNAME=${PORTNAME} PKGVER=${PORTVERSION} ./build

do-install:
	${MKDIR} ${STAGEDIR}${DATADIR}
	${INSTALL_PROGRAM} ${WRKSRC}/yggdrasil ${STAGEDIR}${PREFIX}/bin/yggdrasil
	${INSTALL_PROGRAM} ${WRKSRC}/yggdrasilctl ${STAGEDIR}${PREFIX}/bin/yggdrasilctl

post-install:
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/bin/yggdrasil
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/bin/yggdrasilctl

.include <bsd.port.mk>
