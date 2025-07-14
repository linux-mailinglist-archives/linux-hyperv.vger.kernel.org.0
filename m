Return-Path: <linux-hyperv+bounces-6225-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC2B045A7
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Jul 2025 18:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C541A63348
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Jul 2025 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0245526159D;
	Mon, 14 Jul 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L6iTTA5J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEA025F97F;
	Mon, 14 Jul 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511310; cv=none; b=YDc3EhVn67lvYUCrmC+TrLoN/HQ87+Q/Jy0JefROQNNOaDBxHrmBBOIvb+mtIZaYyyIORjQMMdi5O81LfLcSzzyfUk1caKnw23Hw84P+rMRddVBim4VltNrUTPyT1AYfAaNvvVDJkxZr/c1bL1xarRIJnFmQlKjjfP9ZA/yJudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511310; c=relaxed/simple;
	bh=LHGxNKkPFo/k6boxFl7Q/3wRfLXRmp0votNJ5kvkbBo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=N9HL2gTGK+vrcmptuu7i6l+cBaWTTTe8gyaoP6pM5YQ8dzU6ujUxKzY3qHbh9nUPCPv2IuN8y/qjdkwXGOATBrrWukXVsg5tVUoV455IV0kEGg2FTloNuhiM9CC4LYErwLDClGsHlIQlP5JcLBgO7D9I61JmSaiodMMHuCNCDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L6iTTA5J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id E9B75211CE1A; Mon, 14 Jul 2025 09:41:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E9B75211CE1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752511308;
	bh=9QMFgykrjbbChs7NfmUYFWDLoGQ54scZpKmu2YN1Lfc=;
	h=From:To:Cc:Subject:Date:From;
	b=L6iTTA5Jbf04Sku70ZErFpMBMRww6mhw9GT3gAxesPCCOvk0EfTzHDRAnz7JBP+Ea
	 TKnNd3cZ1/79MTufulnV7MiLdxMqPOCEq3ZQEk+2c+quGHI1hnJUPHKFdoGvwJYcEi
	 +pTK3YVfmiPhB7Hn28znwDSfE7E+F6dkEhPYrizM=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	cavery@redhat.com
Subject: [PATCH net,v2] hv_netvsc: Switch VF namespace in netvsc_open instead
Date: Mon, 14 Jul 2025 09:41:37 -0700
Message-Id: <1752511297-8817-1-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

The existing code move the VF NIC to new namespace when NETDEV_REGISTER is
received on netvsc NIC. During deletion of the namespace,
default_device_exit_batch() >> default_device_exit_net() is called. When
netvsc NIC is moved back and registered to the default namespace, it
automatically brings VF NIC back to the default namespace. This will cause
the default_device_exit_net() >> for_each_netdev_safe loop unable to detect
the list end, and hit NULL ptr:

[  231.449420] mana 7870:00:00.0 enP30832s1: Moved VF to namespace with: eth0
[  231.449656] BUG: kernel NULL pointer dereference, address: 0000000000000010
[  231.450246] #PF: supervisor read access in kernel mode
[  231.450579] #PF: error_code(0x0000) - not-present page
[  231.450916] PGD 17b8a8067 P4D 0 
[  231.451163] Oops: Oops: 0000 [#1] SMP NOPTI
[  231.451450] CPU: 82 UID: 0 PID: 1394 Comm: kworker/u768:1 Not tainted 6.16.0-rc4+ #3 VOLUNTARY 
[  231.452042] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/21/2024
[  231.452692] Workqueue: netns cleanup_net
[  231.452947] RIP: 0010:default_device_exit_batch+0x16c/0x3f0
[  231.453326] Code: c0 0c f5 b3 e8 d5 db fe ff 48 85 c0 74 15 48 c7 c2 f8 fd ca b2 be 10 00 00 00 48 8d 7d c0 e8 7b 77 25 00 49 8b 86 28 01 00 00 <48> 8b 50 10 4c 8b 2a 4c 8d 62 f0 49 83 ed 10 4c 39 e0 0f 84 d6 00
[  231.454294] RSP: 0018:ff75fc7c9bf9fd00 EFLAGS: 00010246
[  231.454610] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 61c8864680b583eb
[  231.455094] RDX: ff1fa9f71462d800 RSI: ff75fc7c9bf9fd38 RDI: 0000000030766564
[  231.455686] RBP: ff75fc7c9bf9fd78 R08: 0000000000000000 R09: 0000000000000000
[  231.456126] R10: 0000000000000001 R11: 0000000000000004 R12: ff1fa9f70088e340
[  231.456621] R13: ff1fa9f70088e340 R14: ffffffffb3f50c20 R15: ff1fa9f7103e6340
[  231.457161] FS:  0000000000000000(0000) GS:ff1faa6783a08000(0000) knlGS:0000000000000000
[  231.457707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  231.458031] CR2: 0000000000000010 CR3: 0000000179ab2006 CR4: 0000000000b73ef0
[  231.458434] Call Trace:
[  231.458600]  <TASK>
[  231.458777]  ops_undo_list+0x100/0x220
[  231.459015]  cleanup_net+0x1b8/0x300
[  231.459285]  process_one_work+0x184/0x340

To fix it, move the VF namespace switching code from the NETDEV_REGISTER
event handler to netvsc_open().

Cc: stable@vger.kernel.org
Cc: cavery@redhat.com
Fixes: 4c262801ea60 ("hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v2: verified it's applicable to net, fixed cc list.

---
 drivers/net/hyperv/netvsc_drv.c | 43 ++++++++++-----------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 42d98e99566e..074ecc346108 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -135,6 +135,19 @@ static int netvsc_open(struct net_device *net)
 	}
 
 	if (vf_netdev) {
+		if (!net_eq(dev_net(net), dev_net(vf_netdev))) {
+			ret = dev_change_net_namespace(vf_netdev, dev_net(net),
+						       "eth%d");
+			if (ret)
+				netdev_err(vf_netdev,
+					   "Cannot move to same ns as %s: %d\n",
+					   net->name, ret);
+			else
+				netdev_info(vf_netdev,
+					    "Moved VF to namespace with: %s\n",
+					    net->name);
+		}
+
 		/* Setting synthetic device up transparently sets
 		 * slave as up. If open fails, then slave will be
 		 * still be offline (and not used).
@@ -2772,31 +2785,6 @@ static struct  hv_driver netvsc_drv = {
 	},
 };
 
-/* Set VF's namespace same as the synthetic NIC */
-static void netvsc_event_set_vf_ns(struct net_device *ndev)
-{
-	struct net_device_context *ndev_ctx = netdev_priv(ndev);
-	struct net_device *vf_netdev;
-	int ret;
-
-	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
-	if (!vf_netdev)
-		return;
-
-	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
-		ret = dev_change_net_namespace(vf_netdev, dev_net(ndev),
-					       "eth%d");
-		if (ret)
-			netdev_err(vf_netdev,
-				   "Cannot move to same namespace as %s: %d\n",
-				   ndev->name, ret);
-		else
-			netdev_info(vf_netdev,
-				    "Moved VF to namespace with: %s\n",
-				    ndev->name);
-	}
-}
-
 /*
  * On Hyper-V, every VF interface is matched with a corresponding
  * synthetic interface. The synthetic interface is presented first
@@ -2809,11 +2797,6 @@ static int netvsc_netdev_event(struct notifier_block *this,
 	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
 	int ret = 0;
 
-	if (event_dev->netdev_ops == &device_ops && event == NETDEV_REGISTER) {
-		netvsc_event_set_vf_ns(event_dev);
-		return NOTIFY_DONE;
-	}
-
 	ret = check_dev_is_matching_vf(event_dev);
 	if (ret != 0)
 		return NOTIFY_DONE;
-- 
2.34.1


