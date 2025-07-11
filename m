Return-Path: <linux-hyperv+bounces-6198-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CA5B02608
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 22:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D17C1CA723D
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC77221FAA;
	Fri, 11 Jul 2025 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H8FGOcZT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B3019995E;
	Fri, 11 Jul 2025 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267456; cv=none; b=tP/JKzD3h9zuyrx1tZbSsREko86fsCUcyeUpyy2aq7pzvennLoYp67AmWL71nhD+2N94hZiyJjjVf0E0s5cFB9euwa6WeBTQAARf/2qsSrNFcUzWazonw8Z7nuXOZZJDhXZ41IeM9BIyIloVf+D4/8EIkWmxrBO6K6Wrcnec5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267456; c=relaxed/simple;
	bh=7oeksbsqlBDbsMLdrS0Ae+ePAmrEawcDiCXcwACxhMo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ruFAvmE7mYETo8cM01pq3Xj8c+1GPQyIFb30I/VgVhcG0NicLWJBiaxRFzFKYU1MXJZhVVvwS2JuOpDiuMviRippt1tm68xQ0/M/eH1gLKTQ++KUQr1kGvxqD9XpyIr86f+wVY1J84qogZ8uJ7P4WsMdVNpIUlt7926FWJkmlyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H8FGOcZT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id B09CB2054690; Fri, 11 Jul 2025 13:57:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B09CB2054690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752267454;
	bh=YK2hlHCdDL9aIF8iZPjno6SLfHSItOAg/HMmpGq7cI4=;
	h=From:To:Cc:Subject:Date:From;
	b=H8FGOcZTmEHW9KxdvYWdoPW3ZPC7yk2wPyvCcf2NB9TifwHY4URnXuZnoNHrR4cUY
	 Stt2BkIIRrnJUWkJE+kgpk904FGKUGGKhE8I4MTWVUg40p94Wu+YxtihQAxw0ydc6b
	 8b8ChiKH9SiMJhrhlwxC/q2Wo3F4PjQDN/chCkL0=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stephen@networkplumber.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] hv_netvsc: Switch VF namespace in netvsc_open instead
Date: Fri, 11 Jul 2025 13:57:10 -0700
Message-Id: <1752267430-28487-1-git-send-email-haiyangz@linux.microsoft.com>
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
Fixes: 4c262801ea60 ("hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event")
Reported-by: Cathy Avery <cavery@redhat.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
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


