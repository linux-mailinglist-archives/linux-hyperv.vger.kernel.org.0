Return-Path: <linux-hyperv+bounces-8026-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB7CC2095
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 11:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77FF9302356F
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09030316194;
	Tue, 16 Dec 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lA7HgkV5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51C2BCF6C;
	Tue, 16 Dec 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882509; cv=none; b=JPMtSiU6CtZs5RFtuiQ7WxYxjtgS7RLcjqOQK9F6w/FonVcHSvVIZdah+G5RPGfaVpFRXB032luupha/9NBDc6YkvPyueunnLDPC8WRgmqQ1OSSCTkaK6IYg+O/IFUUBxHL99jaxze5TMxurvog051lcF7WYYCAGBa9mu3YjN3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882509; c=relaxed/simple;
	bh=B+f4zlNzZBPUZPXd/Z+otBEhzXLqmkj0hCenAv9cAlk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fQxTv/72I055TQ0uIM3PCN9zjNnmSqQV1BCs9kiZkciQEnAYntHHVOVU8eiHXl4f6Is0hXYD9VgQEv9eSnV7pFLmEVhIDA98Oa7fTT4W//jDUhkb9TNoHF0889hWvAj2TeYeb7oPWxoo/teneViTPH0Wg9s+a4xPqSiDOkrPa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lA7HgkV5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 12DFF2012428; Tue, 16 Dec 2025 02:55:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12DFF2012428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765882508;
	bh=o3bOnnraKXEZsNJ4ojfTJylt4MC87O/BQeSoi/0QbqQ=;
	h=Date:From:To:Subject:From;
	b=lA7HgkV5xivU+TzKse12cYyk9AIxKkh68l2nIfjWbYPpzxUM/0LrWQxKF7aHl7trW
	 mFtT76ta/vpMlvRUdp04WLcWldNLODntHTbgtRONdwEnL+oSY5rxgG1A3oGFvLqiI7
	 sfrDvMaPiLsSLryH+pMgXQ8y8AvEnp6UBJ8dqO40=
Date: Tue, 16 Dec 2025 02:55:08 -0800
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
Subject: [PATCH net-next] net: mana: Fix use-after-free in reset service
 rescan path
Message-ID: <20251216105508.GA13584@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)

When mana_serv_reset() encounters -ETIMEDOUT or -EPROTO from
mana_gd_resume(), it performs a PCI rescan via mana_serv_rescan().

mana_serv_rescan() calls pci_stop_and_remove_bus_device(), which can
invoke the driver's remove path and free the gdma_context associated
with the device. After returning, mana_serv_reset() currently jumps to
the out label and attempts to clear gc->in_service, dereferencing a
freed gdma_context.

The issue was observed with the following call logs:
[  698.942636] BUG: unable to handle page fault for address: ff6c2b638088508d
[  698.943121] #PF: supervisor write access in kernel mode
[  698.943423] #PF: error_code(0x0002) - not-present page
[S[  698.943793] Pat Dec  6 07:GD5 100000067 P4D 1002f7067 PUD 1002f8067 PMD 101bef067 PTE 0
0:56 2025] hv_[n e 698.944283] Oops: Oops: 0002 [#1] SMP NOPTI
tvsc f8615163-00[  698.944611] CPU: 28 UID: 0 PID: 249 Comm: kworker/28:1
...
[Sat Dec  6 07:50:56 2025] R10: [  699.121594] mana 7870:00:00.0 enP30832s1: Configured vPort 0 PD 18 DB 16
000000000000001b R11: 0000000000000000 R12: ff44cf3f40270000
[Sat Dec  6 07:50:56 2025] R13: 0000000000000001 R14: ff44cf3f402700c8 R15: ff44cf3f4021b405
[Sat Dec  6 07:50:56 2025] FS:  0000000000000000(0000) GS:ff44cf7e9fcf9000(0000) knlGS:0000000000000000
[Sat Dec  6 07:50:56 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Sat Dec  6 07:50:56 2025] CR2: ff6c2b638088508d CR3: 000000011fe43001 CR4: 0000000000b73ef0
[Sat Dec  6 07:50:56 2025] Call Trace:
[Sat Dec  6 07:50:56 2025]  <TASK>
[Sat Dec  6 07:50:56 2025]  mana_serv_func+0x24/0x50 [mana]
[Sat Dec  6 07:50:56 2025]  process_one_work+0x190/0x350
[Sat Dec  6 07:50:56 2025]  worker_thread+0x2b7/0x3d0
[Sat Dec  6 07:50:56 2025]  kthread+0xf3/0x200
[Sat Dec  6 07:50:56 2025]  ? __pfx_worker_thread+0x10/0x10
[Sat Dec  6 07:50:56 2025]  ? __pfx_kthread+0x10/0x10
[Sat Dec  6 07:50:56 2025]  ret_from_fork+0x21a/0x250
[Sat Dec  6 07:50:56 2025]  ? __pfx_kthread+0x10/0x10
[Sat Dec  6 07:50:56 2025]  ret_from_fork_asm+0x1a/0x30
[Sat Dec  6 07:50:56 2025]  </TASK>

Fix this by returning immediately after mana_serv_rescan() to avoid
accessing GC state that may no longer be valid.

Fixes: 9bf66036d686 ("net: mana: Handle hardware recovery events when probing the device")

Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index efb4e412ec7e..0055c231acf6 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -481,7 +481,7 @@ static void mana_serv_reset(struct pci_dev *pdev)
 		/* Perform PCI rescan on device if we failed on HWC */
 		dev_err(&pdev->dev, "MANA service: resume failed, rescanning\n");
 		mana_serv_rescan(pdev);
-		goto out;
+		return;
 	}
 
 	if (ret)
-- 
2.34.1


