Return-Path: <linux-hyperv+bounces-8218-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4EFD11B0B
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 11:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A09C1300097E
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 10:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC93263F2D;
	Mon, 12 Jan 2026 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g4o0NJDh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A822777F3;
	Mon, 12 Jan 2026 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212130; cv=none; b=SHjHDc37Izi/3HjZL9aGcjwVFcrEZM+ByllnjDXf6LeuaahC/p7pZduGLMe+iBbQ6xb8W7nUY77tDCollU6yEBt6AKR3dWm013RUTjHUKPF1S/0HUkFynvb/w/qiA0IuBR4P8zE2PuxIZp5W+VO2FW2AY1OLU3v5UsIAZLhOcfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212130; c=relaxed/simple;
	bh=UMTY9KjFxaev741KbMJgdfge/IQMIlEn2hCHe3VBIWI=;
	h=From:To:Subject:Date:Message-Id; b=BgurmP81npxmWfPfQR7lM61LBNhjyI2sCl2nBA6bSUicFmk1rPthUJHxq7bMS9e3zsvB3UWoN4TwQPmgUclfQ+E5vs5794tgYY0a0sS9bhro1qoMNH9ZHOfPZqG4HsM5gPC3BVQShQlTUkClITDEJPQyHhLIgKAulXM/VRsYkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g4o0NJDh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id AB42921268B7; Mon, 12 Jan 2026 02:02:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB42921268B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768212123;
	bh=sYbctcXXvuUTz7v2J7ZUmkvQ0xtiDBU5+4KSYNhhJ5w=;
	h=From:To:Subject:Date:From;
	b=g4o0NJDhWUlszaGohPAusynGHX3BwUYCoyuf877mEUaRYKEBYlXhzAu99VaIhVwak
	 qxp1DtM2SAHuTCsDc9Z54gZnbrr3U/Cs1zg1iOEKR6IXHFo+iaCJ+eCawhYPPp93mf
	 OWAz2ibH8H7RgEzh1YKfRskrAaZsVpmJDqxqGSNw=
From: Aditya Garg <gargaditya@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dipayanroy@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	ernis@linux.microsoft.com,
	gargaditya@microsoft.com,
	gargaditya@linux.microsoft.com
Subject: [PATCH net-next] net: hv_netvsc: reject RSS hash key programming without RX indirection table
Date: Mon, 12 Jan 2026 02:01:33 -0800
Message-Id: <1768212093-1594-1-git-send-email-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

RSS configuration requires a valid RX indirection table. When the device
reports a single receive queue, rndis_filter_device_add() does not
allocate an indirection table, accepting RSS hash key updates in this
state leads to a hang.

Fix this by gating netvsc_set_rxfh() on ndc->rx_table_sz and return
-EOPNOTSUPP when the table is absent. This aligns set_rxfh with the device
capabilities and prevents incorrect behavior.

Fixes: 962f3fee83a4 ("netvsc: add ethtool ops to get/set RSS key")
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 3d47d749ef9f..cbd52cb79268 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1750,6 +1750,9 @@ static int netvsc_set_rxfh(struct net_device *dev,
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
+	if (!ndc->rx_table_sz)
+		return -EOPNOTSUPP;
+
 	rndis_dev = ndev->extension;
 	if (rxfh->indir) {
 		for (i = 0; i < ndc->rx_table_sz; i++)
-- 
2.43.0


