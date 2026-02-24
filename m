Return-Path: <linux-hyperv+bounces-8971-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK7CEPqbnWnwQgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8971-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 13:39:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D018711E
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 13:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 026BB3078142
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 12:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9985839903E;
	Tue, 24 Feb 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e1xgz6l8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFC239A7EE;
	Tue, 24 Feb 2026 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936723; cv=none; b=qPgbnSFLcf60zJ2r2lTFcBc1/jJTS4KTmgtsiNTBIcr5tQgPEpXY91wbiQZVqu/yVrgJcKeJFScWgd1xOpdwTc1qZ7OST9DEg0GtM48C92je+WbMOdiboF4MhQIuySO9pR3XOfbXqKs5nt83vEZFALPU9hyPx59ZOh+l34Upltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936723; c=relaxed/simple;
	bh=+8dfnuPCvheAZoj489Lw7VaqrKEQ66nLtTo4AaRsAxw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PJYuKqBuVwXWcAKVxO3OKFSLNEBKwkCXFp7aTydv136zndE+H90i0tbd0VVAAdvAp/dBvAPbiYDns97cR8Dx5oH/J9+V50wPV5DDnLVpgIJ205LEsjVfQUEFnL4mYIJtyZe5uTu4oC8XJ5cHmdAyzMs+TJZPtqpwaLpw2HogT4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e1xgz6l8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 63B3E20B6F02; Tue, 24 Feb 2026 04:38:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63B3E20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771936716;
	bh=fWYrBpZ0QKK9eLfeDvRYeB6kFeBxTaLv8KWU5s0DQvc=;
	h=Date:From:To:Subject:From;
	b=e1xgz6l8MW+phkYu38JX0G3e4yO51wiYtpZAZUt9bv0qraZ8WRh0iPY5WOsU/b5Cg
	 0uklXhOxgBKiCgFT+7ZT5gHJsZ4Vn9jo1l4bvAKogf72UWfhmGteZ8+eJRavQFVKMN
	 5kbWXRfbKncroWU+DLxLkKDzt5WcZoU4qPOkAxzM=
Date: Tue, 24 Feb 2026 04:38:36 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	dipayanroy@microsoft.com
Subject: [PATCH net] net: mana: Fix double destroy_workqueue on service
 rescan PCI path
Message-ID: <aZ2bzL64NagfyHpg@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8971-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: C88D018711E
X-Rspamd-Action: no action

While testing corner cases in the driver, a use-after-free crash
was found on the service rescan PCI path.

When mana_serv_reset() calls mana_gd_suspend(), mana_gd_cleanup()
destroys gc->service_wq. If the subsequent mana_gd_resume() fails
with -ETIMEDOUT or -EPROTO, the code falls through to
mana_serv_rescan() which triggers pci_stop_and_remove_bus_device().
This invokes the PCI .remove callback (mana_gd_remove), which calls
mana_gd_cleanup() a second time, attempting to destroy the already-
freed workqueue. Fix this by NULL-checking gc->service_wq in
mana_gd_cleanup() and setting it to NULL after destruction.

Call stack of issue for reference:
[Sat Feb 21 18:53:48 2026] Call Trace:
[Sat Feb 21 18:53:48 2026]  <TASK>
[Sat Feb 21 18:53:48 2026]  mana_gd_cleanup+0x33/0x70 [mana]
[Sat Feb 21 18:53:48 2026]  mana_gd_remove+0x3a/0xc0 [mana]
[Sat Feb 21 18:53:48 2026]  pci_device_remove+0x41/0xb0
[Sat Feb 21 18:53:48 2026]  device_remove+0x46/0x70
[Sat Feb 21 18:53:48 2026]  device_release_driver_internal+0x1e3/0x250
[Sat Feb 21 18:53:48 2026]  device_release_driver+0x12/0x20
[Sat Feb 21 18:53:48 2026]  pci_stop_bus_device+0x6a/0x90
[Sat Feb 21 18:53:48 2026]  pci_stop_and_remove_bus_device+0x13/0x30
[Sat Feb 21 18:53:48 2026]  mana_do_service+0x180/0x290 [mana]
[Sat Feb 21 18:53:48 2026]  mana_serv_func+0x24/0x50 [mana]
[Sat Feb 21 18:53:48 2026]  process_one_work+0x190/0x3d0
[Sat Feb 21 18:53:48 2026]  worker_thread+0x16e/0x2e0
[Sat Feb 21 18:53:48 2026]  kthread+0xf7/0x130
[Sat Feb 21 18:53:48 2026]  ? __pfx_worker_thread+0x10/0x10
[Sat Feb 21 18:53:48 2026]  ? __pfx_kthread+0x10/0x10
[Sat Feb 21 18:53:48 2026]  ret_from_fork+0x269/0x350
[Sat Feb 21 18:53:48 2026]  ? __pfx_kthread+0x10/0x10
[Sat Feb 21 18:53:48 2026]  ret_from_fork_asm+0x1a/0x30
[Sat Feb 21 18:53:48 2026]  </TASK>

Fixes: 505cc26bcae0 ("net: mana: Add support for auxiliary device servicing events")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 5 ++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 0055c231acf6..3926d18f1840 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1946,7 +1946,10 @@ static void mana_gd_cleanup(struct pci_dev *pdev)
 
 	mana_gd_remove_irqs(pdev);
 
-	destroy_workqueue(gc->service_wq);
+	if (gc->service_wq) {
+		destroy_workqueue(gc->service_wq);
+		gc->service_wq = NULL;
+	}
 	dev_dbg(&pdev->dev, "mana gdma cleanup successful\n");
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9b5a72ada5c4..f69e42651359 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3762,7 +3762,9 @@ void mana_rdma_remove(struct gdma_dev *gd)
 	}
 
 	WRITE_ONCE(gd->rdma_teardown, true);
-	flush_workqueue(gc->service_wq);
+
+	if (gc->service_wq)
+		flush_workqueue(gc->service_wq);
 
 	if (gd->adev)
 		remove_adev(gd);
-- 
2.43.0


