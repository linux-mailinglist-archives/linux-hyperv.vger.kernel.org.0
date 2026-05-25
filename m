Return-Path: <linux-hyperv+bounces-11187-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNFzJNs6FGpDLAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11187-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 14:04:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 896E75CA424
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 14:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96321300370D
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365337F743;
	Mon, 25 May 2026 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="oxT5JLS0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3F37DE9F
	for <linux-hyperv@vger.kernel.org>; Mon, 25 May 2026 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710678; cv=none; b=dthax1WOk4SEK9YBrF8UTofQQUAy8I03zqHSOuSLGyJyfw6c7k549cws59z6BH/rgIgee9xUZ4F/4fpbyOrvH1sz+cEw5UhSWBRoZ2NpEnQIxpzU73SOiHIV328z5zeK1NgorncaLLg0l3prNBa5H31NN9cg/ONF9/lu7KVz3Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710678; c=relaxed/simple;
	bh=tmwruVzFG6Pq/2XoiDv/T22JQE8Li4Uugk6mvbPFKuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XO8l1Av4sPIvNJLubmVA3GCjWbw1YrmyH2/XwlkF0mNdjKR6qKRkpW24Pr3QvRMl4KkDUHrc5by8dfr8ylpnZoUT7lzoZF8pnbT52JCO7jZqcU6vTtvv5Acn6/cu1/jUI0lLRhLLsNo1tpL7dDiR5cajMictVgoqL3jRZCo0VFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=oxT5JLS0; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ONZX2yTc9nYLJ2fyqI6rG6ATLvCKYL7I+rUstwhQ++w=; b=oxT5JLS0G0bdHUkhSEX+YVYDTa
	dV+LocJHSUr/Dr1JXrC1jJRwtvFRw+sH2h0o++RSqDdlDGOXLb58aZ+UlQqvCBJqn1COl6icgSA4s
	8lAAFc59zwiCRK9dF2l9Lk3GVhIyf4l9tF8boCp/f1FIF6Z6fpj++N2owKxMJcH5mmgXL2SUHj9e3
	hNI2xBmaUA/Dunh2ANgg19d0AqKQhehXHn4d09TPWdhVrDX+VvhpVsbQf+clKRxjXv68dYIS57/fh
	VHilpQJdHUuXj4U+sSEQ58SONpssUVyyIcwYxV24+HGm8fXUWD9q+Vy/kUC7xUi+4QQt26vwebkOI
	RpmOfADw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wRU2i-001YvC-36;
	Mon, 25 May 2026 12:04:25 +0000
Date: Mon, 25 May 2026 14:04:22 +0200
From: Ben Hutchings <benh@debian.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org
Subject: [PATCH] uio_hv_generic: Bind to FCopy device by default
Message-ID: <ahQ6xuhSReidmN-3@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IkPp9eu9jZv5OtLK"
Content-Disposition: inline
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11187-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 896E75CA424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--IkPp9eu9jZv5OtLK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The Hyper-V kernel-mode fcopy driver was removed in 6.10 and the new
fcopy daemon requires this uio driver to function.  However, by
default the driver does not bind to any devices, and must be
configured through the sysfs "new_id" file.

Since the FCopy device is now only usable through this driver, add its
ID to the driver's ID table so that the daemon will work "out of the
box".

Signed-off-by: Ben Hutchings <benh@debian.org>
Fixes: ec314f61e4fc ("Drivers: hv: Remove fcopy driver")
---
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -395,9 +395,15 @@ hv_uio_remove(struct hv_device *dev)
 	vmbus_free_ring(dev->channel);
 }
=20
+static const struct hv_vmbus_device_id hv_uio_id_table[] =3D {
+	{ HV_FCOPY_GUID },
+	{}
+};
+MODULE_DEVICE_TABLE(vmbus, hv_uio_id_table);
+
 static struct hv_driver hv_uio_drv =3D {
 	.name =3D "uio_hv_generic",
-	.id_table =3D NULL, /* only dynamic id's */
+	.id_table =3D hv_uio_id_table,
 	.probe =3D hv_uio_probe,
 	.remove =3D hv_uio_remove,
 };

--IkPp9eu9jZv5OtLK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoUOsEACgkQ57/I7JWG
EQmwLA/+KqGzASAjZjtfITrT0b/cdyuEm74o/kHTKvqgTcdmI4kRxdiNziYa/lhk
9hsefBStfGOMRcN3v/nDHmyWOxONTBc4HCBwIKh85MBPQ+2cX0whXpgfuJvwLyup
POvltlPevFlhc4pJrcjur7arz4qq4Xbw4CRHkR7KffE+hawn6TUMs+W/ZI390XFX
PulSTXR5u5VEt3i61tp7XQ28d4rY03BdH7bh9qFAPvG7hmmLwQtBJFF6rENUPwsf
WsHuAMyhIvXDHEoiH/DnB5OF89E8/HEWNEfs1ayeYXi15149mOvwr1udUWhf5kH0
b3va7PjUYAEEnoc37C+PKE8jU9c9jmUcVL45eXythWBB19T6Siuck4WfWPk8kb5y
XH8Hnj4ckjaPR5B7PK3joYe0j5LZZiBJLZAl9BySpjwL1AWBC2v/qn6FurBAv62g
bNJ21rL6MyfKDBCK/vuOOIdU60Mw0iTQJj+5rGkY5Q9ePzx3Z+3W7dL9RQsHeneS
524N2I9f87RV97FaP/Sg21jW2RuV6+jhBZCPkmfwH7YySD873jytjP2wfNKtHqDJ
N102YGP4emjTvRgGz9UqjMrCB0z7sCp4B9OHeC4aVKtFjCRF96INEDGmUg2rijJg
4SP0iTvQQX5u2UvuNn3rzmiPVVbVhsBYPEYeTNc6q/h3mOPkz10=
=roSv
-----END PGP SIGNATURE-----

--IkPp9eu9jZv5OtLK--

