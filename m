Return-Path: <linux-hyperv+bounces-5920-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4370FADA482
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jun 2025 01:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D633AF318
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Jun 2025 23:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C5A149C7B;
	Sun, 15 Jun 2025 23:06:14 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B681DED5D
	for <linux-hyperv@vger.kernel.org>; Sun, 15 Jun 2025 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750028774; cv=none; b=Zq4SVTIoDe8DzSgOYD3NB0PWyCxH4MVPh6YJefNM2c5vMr09Psnf1O2IF3yjGBwI0sv0XQVp7+mtbL3ZbE/IcS+stPRGEb0Ye1FcbYRkNLZXpBmv7m4zLHELh+EmouM1ilp6qCFg+7baUHumgdodH4R0H/IZhQ1W/MdCkyM66Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750028774; c=relaxed/simple;
	bh=M6QEtflO3swhML3Q0+iZrUd60nNrBc/MJLMhSeq6Np8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVL4Urwyt524FJ01RN6FQIeiD7ULcOFUBjHAl7msuR1IlkiI2sXtgSsW4q3l82S3oFZVeewRya2UWVChQ1sW5i7zNZh9rTvLpf75uq2VRKtidw3YYSEyBX2irtMTaW4jvjTYs7/Po4ypQFaW2lKeUej6CbxvE7jHfR6MCfJVEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uQwQV-001p3c-1A
	for linux-hyperv@vger.kernel.org;
	Sun, 15 Jun 2025 23:06:10 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uQwQT-000000016Yt-2voK
	for linux-hyperv@vger.kernel.org;
	Mon, 16 Jun 2025 01:06:09 +0200
Date: Mon, 16 Jun 2025 01:06:09 +0200
From: Ben Hutchings <benh@debian.org>
To: linux-hyperv@vger.kernel.org
Subject: [PATCH 2/2] tools/hv: Make network-scripts DHCP status check more
 specific
Message-ID: <aE9R4V2w9cQPhsQK@decadent.org.uk>
References: <aE9Ri42HK2L1YOn3@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GWoBgtk1GdRwshbd"
Content-Disposition: inline
In-Reply-To: <aE9Ri42HK2L1YOn3@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--GWoBgtk1GdRwshbd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We currently look for the string 'dhcp' in a network-scripts
configuration file, but this could potentially be found in a comment
line.  The variable that controls whether DHCPv4 is used is BOOTPROTO,
so check for that variable name as well as the value 'dhcp'.

Also quote the interface name when constructing the configuration
filename, just in case it contains a special character.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/hv/hv_get_dhcp_info.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hv/hv_get_dhcp_info.sh b/tools/hv/hv_get_dhcp_info.sh
index 310b16a2f734..7815d55a9295 100755
--- a/tools/hv/hv_get_dhcp_info.sh
+++ b/tools/hv/hv_get_dhcp_info.sh
@@ -75,10 +75,10 @@ check_ifupdown() {
 }
=20
 check_network_scripts() {
-    local if_file=3D"/etc/sysconfig/network-scripts/ifcfg-"$1
+    local if_file=3D"/etc/sysconfig/network-scripts/ifcfg-$1"
=20
     if [ -f "$if_file" ]; then
-	grep -q dhcp "$if_file"
+	grep -q '^\s*BOOTPROTO=3D.*dhcp' "$if_file"
 	report
     else
 	return 1

--GWoBgtk1GdRwshbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhPUeEACgkQ57/I7JWG
EQlQyQ/3fNy9sXIlmgrWvHKseAN4OndBSSLh5RI/MdyrhQ0OY29ko6JDFqrGJkXe
pmFn4hbCysmh5IDJWXO5slh/VcH0ql5H5rsjcl1JSTqDbo6XjnlBfDwl8cAXAlPy
sKV2ERYF8Xh31Rc7aAya7rSMyCC1F2YZIPg05XXHp2GB2QEQyykHeYqEU0FkUw0I
JdrGgMHXPbtl+Gouh1WRUqV76HUcqsfJy2+ewWon2MrJMza+rfMEIsleTJ0nsP3v
b//7l5RaqUfXi1SWMb+QiWLhbLnLitqMstRH8uVXhujaQV9FOrSjMNPBIVQCeLnC
z/QS4vV//GBBU5lKpuOKYTP8EeZFgmwy11YFatkIfC+94LYe/WU+0F3SqVQL5V0L
UGrW1WhKyMw9BIKF2EhPEuGl53w3hhzG82z6WTOiSGvBeO/JnHWVxtn5vZk/SPWD
w9cUlCHZ+X0FWzRlaWWk6NcoEEVpelj9u1Ww8voKqLyF+eqSK3H0piDYRvYbxsPk
OXL7dDLCsdAk60SJg5Ajl7aBtP8JmbgluiBrXa4Ss7PT1xoQCtkZTNwvRJqzuvtC
omPC39BCYue6AkZI6JpRuaZZ99QErDDs0RbVStnQpVe7+4q2R267knrt9wjsvHeB
888qBh7tA3iGelYsgWU6NjGETSveU1ysVe2eouWEE6L0rqmMpg==
=IWcF
-----END PGP SIGNATURE-----

--GWoBgtk1GdRwshbd--

