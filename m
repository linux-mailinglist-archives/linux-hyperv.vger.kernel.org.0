Return-Path: <linux-hyperv+bounces-6302-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64EAB0AB15
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 22:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B22B3A53C8
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 20:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0673521C19E;
	Fri, 18 Jul 2025 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bOMtyzbH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584211712;
	Fri, 18 Jul 2025 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870061; cv=none; b=oenrdc2pSyseweoUJ5GQDQZkjjayG0ZWbJqTvNCbvbOk2rN0loHxTjUhPGCgeAtTegX5a10pv1OgLrjHJW51Hzyv4jt0BlTJdPEEWveq1+BfZRmXUs/blqKT0lcRJ0fzL/jdDgm/XIFEvhGzSK3yMMdPw4TNJ32OlLTTP9ttWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870061; c=relaxed/simple;
	bh=5GR/+PDx+U+fOuXcL6gTbXd2bjBLmJST2ztzbRykFBY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HtWL/Yv6toQWb58rjINWV7CX3d4XXI/Qb766IDYD4Rmx4wNECgFCzLpuhI6D73ItRPTD2pmYjurr5DGGJvv+5BFtomt/ZLMtuEp3eyPars4ct/R43wPEZmtwyh/CrBL5fFQ/Jt2OFw3PF1Na+KEJ06cKOQnt0f4VlP0C6vv8Zfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bOMtyzbH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id CC7BC211FEC6; Fri, 18 Jul 2025 13:20:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC7BC211FEC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752870059;
	bh=BOXZHV9y8YTfhsgSAEvvRDJh+qMnYv9KD0BqY7VTGdM=;
	h=From:To:Cc:Subject:Date:From;
	b=bOMtyzbHytMrwCOIp2b+xDKjKZAVaMh+hiYhDdO6FX94Z7fZVOXxg1pPanb3lIFNP
	 m41Jy+bfhctezCJElKS1T6W35wg//egwTdKzwAJQVJ9PZ9uUxKLDlh3L2tcZTD28JV
	 nwQVWwMv80sgrDTdTHmo2HeCXrrMqaKb57CHZCD4=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, davem@davemloft.net, sdf@fomichev.me,
	kuniyu@google.com, ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, #@linux.microsoft.com,
	5.4+@linux.microsoft.com
Subject: [PATCH net] net: core: Fix the loop in default_device_exit_net()
Date: Fri, 18 Jul 2025 13:20:14 -0700
Message-Id: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

The loop in default_device_exit_net() won't be able to properly detect the
head then stop, and will hit NULL pointer, when a driver, like hv_netvsc,
automatically moves the slave device together with the master device.

To fix this, add a helper function to return the first migratable netdev
correctly, no matter one or two devices were removed from this net's list
in the last iteration.

Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 net/core/dev.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 621a639aeba1..d83f5f12cf70 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12629,19 +12629,11 @@ static struct pernet_operations __net_initdata netdev_net_ops = {
 	.exit = netdev_exit,
 };
 
-static void __net_exit default_device_exit_net(struct net *net)
+static inline struct net_device *first_migratable_netdev(struct net *net)
 {
-	struct netdev_name_node *name_node, *tmp;
 	struct net_device *dev, *aux;
-	/*
-	 * Push all migratable network devices back to the
-	 * initial network namespace
-	 */
-	ASSERT_RTNL();
-	for_each_netdev_safe(net, dev, aux) {
-		int err;
-		char fb_name[IFNAMSIZ];
 
+	for_each_netdev_safe(net, dev, aux) {
 		/* Ignore unmoveable devices (i.e. loopback) */
 		if (dev->netns_immutable)
 			continue;
@@ -12650,6 +12642,25 @@ static void __net_exit default_device_exit_net(struct net *net)
 		if (dev->rtnl_link_ops && !dev->rtnl_link_ops->netns_refund)
 			continue;
 
+		return dev;
+	}
+
+	return NULL;
+}
+
+static void __net_exit default_device_exit_net(struct net *net)
+{
+	struct netdev_name_node *name_node, *tmp;
+	struct net_device *dev;
+	/*
+	 * Push all migratable network devices back to the
+	 * initial network namespace
+	 */
+	ASSERT_RTNL();
+	while ((dev = first_migratable_netdev(net)) != NULL) {
+		int err;
+		char fb_name[IFNAMSIZ];
+
 		/* Push remaining network devices to init_net */
 		snprintf(fb_name, IFNAMSIZ, "dev%d", dev->ifindex);
 		if (netdev_name_in_use(&init_net, fb_name))
-- 
2.34.1


