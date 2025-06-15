Return-Path: <linux-hyperv+bounces-5918-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A15ADA47D
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jun 2025 01:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770F816BFBC
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Jun 2025 23:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC081DED5D;
	Sun, 15 Jun 2025 23:04:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD3194A67
	for <linux-hyperv@vger.kernel.org>; Sun, 15 Jun 2025 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750028689; cv=none; b=mUpirJK1380r4LAe0CRaCa8JJw6r9IZSb8TGCOOn4HZTPTlNk4Pw52GIBfwrs3Ny9nvlBxg8WeyGB84HKGaMyNoHo7oKKDl86I7slIxwVkSB+YbnDDlhP2zmYuPAnggHZ/6ipH0U2SD5Lf8lL1+q28fLj9sapDZuRyKRf8Ey2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750028689; c=relaxed/simple;
	bh=1xr681e8ZwQbQdV9t6ultXIwjJoT79zb2m305uN+1fs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IE2JP6cxpx5Dp1F0y1KZkvlvqgwxRyXyAn/UKuLAka/Z3SPmNx4WGXZmACXXkhLW8HFIjxlYk0cS5oQcW2OpBvyHGrrdB69SE707qR0RnivJq/p1nHkSGVBzaR9QNkTqJDEdxoVulrMC4D/NlvLVwrHPvUsF86IspPWGkpILQ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uQwP7-001p3N-1n
	for linux-hyperv@vger.kernel.org;
	Sun, 15 Jun 2025 23:04:44 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uQwP5-000000016Wy-1vp2
	for linux-hyperv@vger.kernel.org;
	Mon, 16 Jun 2025 01:04:43 +0200
Date: Mon, 16 Jun 2025 01:04:43 +0200
From: Ben Hutchings <benh@debian.org>
To: linux-hyperv@vger.kernel.org
Subject: [PATCH 0/2] tools/hv: Improve the sample hv_get_dhcp_info script
Message-ID: <aE9Ri42HK2L1YOn3@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1vjZWrq8g8h6eUt2"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--1vjZWrq8g8h6eUt2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The sample hv_get_dhcp_info script was originally supposed to be
replaced by downstream distributions, but:

- Network Manager and systemd-networkd are used across many
  distributions
- Debian's ifupdown is not only used in Debian derivatives but also
  Alpine and Void Linux

This adds support for all of those.

The check for DHCP in network-scripts configuration files was
also quite lax.  This makes the regex a bit more strict.

Ben.

Ben Hutchings (2):
  tools/hv: Make the sample hv_get_dhcp_info script more useful
  tools/hv: Make network-scripts DHCP status check more specific

 tools/hv/hv_get_dhcp_info.sh | 87 +++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 12 deletions(-)


--1vjZWrq8g8h6eUt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhPUYUACgkQ57/I7JWG
EQlfbw/8CrfSf5XxqvV07FaN+bcNTJEFWsUhIc0G4gw6OJi7n5tRyj0+EZoAmac9
BCtvD7ug+WghNeQkFRCyvjobGRWoCFo9zyFVRvrcYaea8hny8xe7S2AVNepY0N/D
iaTxDHqgDDbGaxdZ423nLHgqJB1FDWJ1UZkEOE+yQTYG97ciXr/PTZo8XBAJb/tL
JPnBmlW0a0+E5Ra+l/VQMj7C+ASYKnHwvhFvxBeLHU3ppSJCahz3KC0BuKrvUTBv
g9o49pN0mrLl0jN3YSdg/aSfpMjbpZqymoEH3KHRKhQKOeF6XB7kAXcUx6QZIvPK
U+DBFICOb2nYa9jmhYEaRtQbyRd7cJeDyDIg6fcCh6cYAmZIrFJSjZO5FrozY9+Y
VcJYelHAyrrF1os3QFgCBVSdnMJZsxfAvvyK+MzJSJQ17dgkibS+FCddK4P/lOfv
IrE7ZT6H2kxRqZz8hO0yZnMbYqFOc7tQmln3YI5/1B2qd9KAjR/f1IfrX5kCfa0u
Sy/4Ap4r1WJ//liKX8Gi5MrV/3qQFEIm/0I2I7e9QYJMaEDjDT2Z7IHxOq5Z610h
dlPnmT+sqBS2ZL5JBoyDdDmaSKpNkHz6Gk9akLztOOqEaLMtPTQxhrCfu9Iqu9ak
TX2e6JJGRDqoWZ4ZZx92RzQ+UZuAwy8RpjXZgr495XY2c1gFEqM=
=klih
-----END PGP SIGNATURE-----

--1vjZWrq8g8h6eUt2--

