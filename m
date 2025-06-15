Return-Path: <linux-hyperv+bounces-5919-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC33DADA481
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jun 2025 01:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826977A61CA
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Jun 2025 23:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2870194A67;
	Sun, 15 Jun 2025 23:06:03 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8CB149C7B
	for <linux-hyperv@vger.kernel.org>; Sun, 15 Jun 2025 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750028763; cv=none; b=IkA9iTeI79hgLd1EnUSKDAiKYwGg9v8tT0b3q06n5H5gUIMemsYhSh57kurqv/MpzBfqb/KNq7ruYTK246HgOSa3i3ueiLZX2kgJTwEt77EK/HM9/i3GqJhYru+X+Y6cdu0Fs3olFoUYzFUufZeA9K0E1kTZ5P/+GxY8eB+oZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750028763; c=relaxed/simple;
	bh=UOAhcn4hT06j8KeobuB1jhKnMn0Gw/zVwFYcMDTWQUg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXw3NDCH5ASMIpqCOxm91MWgdEApu5yGDnlqZwiJbxYDdb8zs18oa+bp1JNj7v9VFusqo7VFFuOt2Jh3DB6RyjPlwBhm0Tchp8yhvxxkbXBLK90AMhm/5P0fu29bLNn+4ciWLx0N8pETzvC2zr3ZzUIveYAiAtUeeQ84HCIEMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uQwQK-001p3X-1o
	for linux-hyperv@vger.kernel.org;
	Sun, 15 Jun 2025 23:05:59 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uQwQI-000000016Y8-2voT
	for linux-hyperv@vger.kernel.org;
	Mon, 16 Jun 2025 01:05:58 +0200
Date: Mon, 16 Jun 2025 01:05:58 +0200
From: Ben Hutchings <benh@debian.org>
To: linux-hyperv@vger.kernel.org
Subject: [PATCH 1/2] tools/hv: Make the sample hv_get_dhcp_info script more
 useful
Message-ID: <aE9R1tSjATI-ISnw@decadent.org.uk>
References: <aE9Ri42HK2L1YOn3@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iVfoX72qHOh5nA1q"
Content-Disposition: inline
In-Reply-To: <aE9Ri42HK2L1YOn3@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--iVfoX72qHOh5nA1q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently the sample hv_get_dhcp_info script only supports the old Red
Hat network-scripts configuration format and leaves everything else to
downstream distributions.

However, Network Manager and systemd-networkd are available across
many distributions, so it makes more sense to implement support for
them here.

Debian's ifupdown is also used in several distributions that are not
Debian derivatives, so I think it makes sense to implement support for
that here too.

Extend the script to support all of these:

- Add a report function that reports the status based on the result of
  the previous command
- Add a function for each configuration system that checks whether
  that system in use for the given interface, and:
  - If so, checks and reports the DHCP status
  - If not, returns failure
- Call each of those functions, exiting once one of them succeeds,
  with a final fallback to reporting 'Disabled'

The network-scripts check is placed last, because it only checks a
file and not the actual interface state and so is the least reliable
check.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/hv/hv_get_dhcp_info.sh | 87 +++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 12 deletions(-)

diff --git a/tools/hv/hv_get_dhcp_info.sh b/tools/hv/hv_get_dhcp_info.sh
index 2f2a3c7df3de..310b16a2f734 100755
--- a/tools/hv/hv_get_dhcp_info.sh
+++ b/tools/hv/hv_get_dhcp_info.sh
@@ -12,18 +12,81 @@
 #	that DHCP is enabled on the interface. If DHCP is not enabled,
 #	the script prints the string "Disabled" to stdout.
 #
-# Each Distro is expected to implement this script in a distro specific
-# fashion. For instance, on Distros that ship with Network Manager enabled,
-# this script can be based on the Network Manager APIs for retrieving DHCP
-# information.
+# Distributions may need to adapt or replace this script for their
+# preferred network configuration system.
=20
-if_file=3D"/etc/sysconfig/network-scripts/ifcfg-"$1
+# Report status based on result of previous command
+report() {
+    if [ $? -eq 0 ]; then
+	echo "Enabled"
+    else
+	echo "Disabled"
+    fi
+}
=20
-dhcp=3D$(grep "dhcp" $if_file 2>/dev/null)
+check_network_manager() {
+    local conn_name
=20
-if [ "$dhcp" !=3D "" ];
-then
-echo "Enabled"
-else
-echo "Disabled"
-fi
+    # Check that the interface has a configured connection, and get
+    # its name
+    if conn_name=3D"$(nmcli -g GENERAL.CONNECTION device show "$1" 2>/dev/=
null)" &&
+       [ "$conn_name" ]; then
+	# Check whether the connection enables DHCPv4
+	test "$(nmcli -g ipv4.method connection show "$conn_name")" =3D auto
+	report
+    else
+	return 1
+    fi
+}
+
+check_systemd_networkd() {
+    local status
+
+    # Check that the interface is managed by networkd
+    if status=3D"$(networkctl status --json=3Dshort -- "$1" 2>/dev/null)" =
&&
+       ! printf '%s' "$status" |
+	   grep -qE '"AdministrativeState":"unmanaged"'; then
+	# Check for DHCPv4 client state in the interface status
+	printf '%s' "$status" | grep -q '"DHCPv4Client":'
+	report
+    else
+	return 1
+    fi
+}
+
+check_ifupdown() {
+    local conf_name
+
+    # Check that a configuration has been applied to the interface
+    if command -v ifquery >/dev/null &&
+       conf_name=3D"$(ifquery --state -- "$1" | sed 's/[^=3D]*=3D//')" &&
+       [ "$conf_name" ]; then
+	# Check whether that configuration enables DHCPv4.
+	# Unfortunately ifquery does not expose the method name, so we
+	# have to grep through the configuration file(s) and make an
+	# assumption about which are included.
+	find /etc/network/interfaces /etc/network/interfaces.d \
+	     -type f -regex '.*/[a-zA-Z0-9_-]+$' -print |
+	    xargs grep -qE '^\s*iface\s+'"$conf_name"'\s+inet\s+dhcp(\s|$)'
+	report
+    else
+	return 1
+    fi
+}
+
+check_network_scripts() {
+    local if_file=3D"/etc/sysconfig/network-scripts/ifcfg-"$1
+
+    if [ -f "$if_file" ]; then
+	grep -q dhcp "$if_file"
+	report
+    else
+	return 1
+    fi
+}
+
+check_network_manager "$1" ||
+check_systemd_networkd "$1" ||
+check_ifupdown "$1" ||
+check_network_scripts "$1" ||
+report


--iVfoX72qHOh5nA1q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhPUdYACgkQ57/I7JWG
EQlILg/+Pj/THB6lD3lUeTAHoTg1cg1asR7Ulc5M+HRKc9nGtNztL2z8CxevkNz+
gjkpYcvMJK/OMJTovmUT0juzZcsR9W+YYBhgtE1zx3XpmMXLsS8pNEHk4db8IuGt
X2JuPqzqXbTl1bjO9IHvNUm5WxFKYCPBHbJB43ESweAoExvmth4V+YiWfFXkiz6m
i73ZbtATVHXT0UIc9D7u6Y6JPLxXDaKWAjyeujdZrpXdtlebEUbfubSNe53jOaJX
iSnOnH1ScmJ6i7xeZmEy8ETs96geobkToGIN1JJl81PlNvRfsqa3T1qCHsEOqjaM
LrxirvUClkoge6DGfl6N0EbNMoWVXRwmcx+eMiXPo+dWi+7rpIjVIqvmVgd3De+y
/G5idjIhu0Ri0FLyC8N98YaVaPrVa8/lE44RDox/1OgSXHAQVnUjnrUbYQaWDLKv
3kENTC3BrvlFcUjTBj8oitemV3kNQWKXYk/ZtkKI3WR1NQf6EMC/NWAjvCr2DHvO
CUFLzY0K5YqGbpwyxTBmLvP4MoVbp8MIt8/XUmH4uGC5FQT9SWlm+g8km2qyitmr
D059pTFfTIyg8lQuy4+KdLZVAdel/Z4NdJ59FFbqONTvk7LkxWRAkmixxWpf0AxL
WAlLFF+ko0gjv+iWBrPIO3rE5hON8F/yhECl6dXWOTW3pQRhN+8=
=yqG5
-----END PGP SIGNATURE-----

--iVfoX72qHOh5nA1q--

