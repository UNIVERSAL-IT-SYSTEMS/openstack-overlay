# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit git-2 distutils

DESCRIPTION="Nova is a cloud computing fabric controller (the main part of an
IaaS system). It is written in Python."
HOMEPAGE="https://launchpad.net/nova"
EGIT_REPO_URI="https://github.com/openstack/nova.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools
        dev-python/lockfile
		dev-python/netaddr
		dev-python/eventlet
		dev-python/python-gflags
		dev-python/nosexcover
		dev-python/sqlalchemy-migrate
		dev-python/pylint
		dev-python/mox
		dev-python/pep8
		dev-python/cheetah
		dev-python/carrot
		dev-python/lxml
		dev-python/python-daemon
		dev-python/wsgiref
		dev-python/sphinx
		dev-python/suds
		dev-python/paramiko
		dev-python/feedparser"
RDEPEND="${DEPEND}
		 dev-python/m2crypto
		 app-admin/glance
		 dev-python/python-novaclient
		 dev-python/nova-adminclient
		 dev-python/boto"

src_install() {
	distutils_src_install
	newconfd "${FILESDIR}/nova.confd" nova
	newinitd "${FILESDIR}/nova.initd" nova

	for function in api compute network objectstore scheduler volume; do
		dosym /etc/init.d/nova /etc/init.d/nova-${function}
	done

	diropts -m 0750
	dodir /var/run/nova /var/log/nova /var/lock/nova
}
