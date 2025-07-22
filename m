Return-Path: <linux-hyperv+bounces-6346-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABF5B0E75A
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 01:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE2C5649D9
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 23:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3528C5A5;
	Tue, 22 Jul 2025 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lCikRG/3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE4A288C06;
	Tue, 22 Jul 2025 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753228282; cv=none; b=fTlST4OElnFvnmeezOnG6OSYckMwAiAYTFe71+GO15/DXBT/nV6hc1OGZzy2Ewgwj4FQ41Lmx8y75SrHspE3lSBFxRb6c1XdJAUySfYN+QTePF2BHR+zHHLks/SfSClCIoBZqngLxYs2JtE8BiyWvL4VHbS6sC4YGj+/P9pchrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753228282; c=relaxed/simple;
	bh=s0SPZUlIJrNHrAp3QQbT8heQEIq53pX0dvoodTTNWgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mx++JZvuUjW3EyNCHywGvcKXCok1r1V4kT5Zc/2mTqlg6Z+IfkqJTDQ+mUR4YmRozKObYRJQTIAOWexwIISGGQoBsCCgC0sUEGKA4csfaJddEfhKESKh+/wPyN3Unqg2NzESK/sSVpzPS1Z0J+f+RkCvkFEy231iyb0ikUfX9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lCikRG/3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id D8CD421268BD; Tue, 22 Jul 2025 16:51:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D8CD421268BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753228280;
	bh=fGkskXaadGQwkh+tyKqVMvueO3YLxo/uj7ttzFTaEVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCikRG/3FCeKBN1OAAPJCm3/QiZ7DrtSdi90HYRiyysVIhWNcRE7o3S5eA9p419rI
	 +12XDKcmhvMraXLwa9orWC0kQHW09MvtJmuiUlCOuM9F813Bis6h4d1mPGAJGNY/lW
	 jFSLUhOcBpslafHoK3n3NojoppFvesS64pO/JEyY=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	sd@queasysnail.net,
	viro@zeniv.linux.org.uk,
	chuck.lever@oracle.com,
	neil@brown.name,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	davem@davemloft.net,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net, 2/2] hv_netvsc: Fix panic during namespace deletion with VF
Date: Tue, 22 Jul 2025 16:50:48 -0700
Message-Id: <1753228248-20865-3-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1753228248-20865-1-git-send-email-haiyangz@linux.microsoft.com>
References: <1753228248-20865-1-git-send-email-haiyangz@linux.microsoft.com>
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

To fix it, skip the VF NIC's namespace change with netvsc when the VF
namespace is being cleaned up, because the default_device_exit_net() will
do it later.

Cc: stable@vger.kernel.org
Fixes: 4c262801ea60 ("hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 8be9bce66a4e..8fc05a8c0018 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2788,13 +2788,21 @@ static void netvsc_event_set_vf_ns(struct net_device *ndev)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(ndev);
 	struct net_device *vf_netdev;
+	struct net *vfnet;
 	int ret;
 
 	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
 	if (!vf_netdev)
 		return;
 
-	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
+	vfnet = dev_net(vf_netdev);
+	/* Do not move it now if its net is being cleaned up,
+	 * net_cleanup_work will move it.
+	 */
+	if (llist_on_list(&vfnet->cleanup_list))
+		return;
+
+	if (!net_eq(dev_net(ndev), vfnet)) {
 		ret = dev_change_net_namespace(vf_netdev, dev_net(ndev),
 					       "eth%d");
 		if (ret)
-- 
2.34.1


