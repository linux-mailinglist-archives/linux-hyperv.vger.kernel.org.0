Return-Path: <linux-hyperv+bounces-5991-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13625AE3DBA
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Jun 2025 13:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4ED618818C1
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Jun 2025 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B9823D284;
	Mon, 23 Jun 2025 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X5pyvNLK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B25119F480;
	Mon, 23 Jun 2025 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750677247; cv=none; b=nJHE8u9Cenjp2mWBKW+n+eO6wg3v7RUYmyFwl3CYnXs4wwTEr0IBzUru82OWeBlNzyvVnQ3CJtquOu671pTyneipvuI3jItiTnL6z+iA4gbp7pm6H4k3+0Ua4jHL+z24vpIdafh9gu7n1mrPNkiREesdE9P66trycVJZzqGsSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750677247; c=relaxed/simple;
	bh=sIf+y3eps6fWxm877h1GGA65xOw8i21b2qA+L/pYwMk=;
	h=From:To:Subject:Date:Message-Id; b=qhUWQiqDTtxy9a9AyAIeMcLJupoNBhrSDM8leygn2Ydw7p9d1b/19aUcEKpqm21hAK8JcEAIoz/O+wUtXnYw1uJYoQRR/fNdt17pnAhlfkmxx5pUNM+Ow4PHiobnaFSpFf+6nAHVHATksSnXUSA8M5cLz1douwnHQ7OSeIgntXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X5pyvNLK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id E8E862117FA8; Mon, 23 Jun 2025 04:14:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E8E862117FA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750677243;
	bh=TcrNOqs7qfoyYxnhBaQ5mBizC/Ht7aSG3QI7fMcH/nI=;
	h=From:To:Subject:Date:From;
	b=X5pyvNLKwM486Hf5mMXl3Urt2vxVgDmqRII2KqoOYOhubYVWd99oybg9M/sMIYu9n
	 uLCKkL9jrOr888gxv/5VsDeWBcglceDSErzDWvarqpCJgmLyyiguvUqEKiMHeYWucJ
	 g/radS4rXH4OxbEo7DgNGIvwQiEk42NHB+rrdMOU=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shradhagupta@linux.microsoft.com,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	lorenzo@kernel.org,
	shirazsaleem@microsoft.com,
	ernis@linux.microsoft.com,
	schakrabarti@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mana: Fix build errors when CONFIG_NET_SHAPER is disabled
Date: Mon, 23 Jun 2025 04:14:01 -0700
Message-Id: <1750677241-1504-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Fix build errors when CONFIG_NET_SHAPER is disabled, including:

drivers/net/ethernet/microsoft/mana/mana_en.c:804:10: error:
'const struct net_device_ops' has no member named 'net_shaper_ops'

     804 |         .net_shaper_ops         = &mana_shaper_ops,

drivers/net/ethernet/microsoft/mana/mana_en.c:804:35: error:
initialization of 'int (*)(struct net_device *, struct neigh_parms *)'
from incompatible pointer type 'const struct net_shaper_ops *'
[-Werror=incompatible-pointer-types]

     804 |         .net_shaper_ops         = &mana_shaper_ops,

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Fixes: 75cabb46935b ("net: mana: Add support for net_shaper_ops")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506230625.bfUlqb8o-lkp@intel.com/
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 10e766c73fca..a4a18eb02558 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -719,6 +719,7 @@ static int mana_change_mtu(struct net_device *ndev, int new_mtu)
 	return err;
 }
 
+#if IS_ENABLED(CONFIG_NET_SHAPER)
 static int mana_shaper_set(struct net_shaper_binding *binding,
 			   const struct net_shaper *shaper,
 			   struct netlink_ext_ack *extack)
@@ -790,6 +791,7 @@ static const struct net_shaper_ops mana_shaper_ops = {
 	.delete = mana_shaper_del,
 	.capabilities = mana_shaper_cap,
 };
+#endif
 
 static const struct net_device_ops mana_devops = {
 	.ndo_open		= mana_open,
@@ -801,7 +803,9 @@ static const struct net_device_ops mana_devops = {
 	.ndo_bpf		= mana_bpf,
 	.ndo_xdp_xmit		= mana_xdp_xmit,
 	.ndo_change_mtu		= mana_change_mtu,
+#if IS_ENABLED(CONFIG_NET_SHAPER)
 	.net_shaper_ops         = &mana_shaper_ops,
+#endif
 };
 
 static void mana_cleanup_port_context(struct mana_port_context *apc)
-- 
2.34.1


