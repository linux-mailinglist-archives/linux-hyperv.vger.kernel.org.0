Return-Path: <linux-hyperv+bounces-1487-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301AB8437F5
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 08:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6389F1C255DD
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 07:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0361650A91;
	Wed, 31 Jan 2024 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RglxAPrU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649645677B;
	Wed, 31 Jan 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686584; cv=none; b=GUF//I4gJrHcfiiqUNP52paBVXm/XCqtumN+OQ5/cxUA0zlWgqrOMwLsc3OSbcxs0OIk42/XDE3EXBSYR89DEVZYsHZF7lIBMDM9/fHfb/p2l/2tYLTxsIuDKtrAyTr4aiEOfCLy0NgowJxO6r9y6hkEFBltSSZndU0Bhobcm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686584; c=relaxed/simple;
	bh=5bEHW6ksJ3xqW6jJnxsmV+ldSHTTfxdpUCo76HbOvWs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=n3DFzV8VW0Pq8oFCu4Q5VjxBWOrQoqjj804lcMjtU10e0YWd46uYkMJ5H636b+CYNtrIACRYhm9QM5EqAodnj/ZVFrVfmWd8gpqPMDxx18gRtvJV0+8aokyaWLY+Ysg9wz78kfcR7tXdC9eMPoUlopxUzXzXTDsc/ln+dj384W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RglxAPrU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 4E89B2057C14; Tue, 30 Jan 2024 23:36:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E89B2057C14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706686577;
	bh=A9hod7/WJM4EPvXZpXLKwY7FnhxMOn4SZ60i2PuUqsE=;
	h=From:To:Cc:Subject:Date:From;
	b=RglxAPrUIN7r8YQ3/2n+WHKSPQEQWtIXbM7C0ahipg7d346Hb5+voReAY38R8Ijby
	 Hwc9GhT8yNe+b6mzytI2HJwqAyibvevAQ8ng6Kqa7JS6LoL96u5AQ0t4NHP4s7raKM
	 M6tYRnha0OFzaRpeK8wnrSf4O6n8MnDbWSson16U=
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	yury.norov@gmail.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH V2 net] hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove
Date: Tue, 30 Jan 2024 23:35:51 -0800
Message-Id: <1706686551-28510-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

In commit ac5047671758 ("hv_netvsc: Disable NAPI before closing the
VMBus channel"), napi_disable was getting called for all channels,
including all subchannels without confirming if they are enabled or not.

This caused hv_netvsc getting hung at napi_disable, when netvsc_probe()
has finished running but nvdev->subchan_work has not started yet.
netvsc_subchan_work() -> rndis_set_subchannel() has not created the
sub-channels and because of that netvsc_sc_open() is not running.
netvsc_remove() calls cancel_work_sync(&nvdev->subchan_work), for which
netvsc_subchan_work did not run.

netif_napi_add() sets the bit NAPI_STATE_SCHED because it ensures NAPI
cannot be scheduled. Then netvsc_sc_open() -> napi_enable will clear the
NAPIF_STATE_SCHED bit, so it can be scheduled. napi_disable() does the
opposite.

Now during netvsc_device_remove(), when napi_disable is called for those
subchannels, napi_disable gets stuck on infinite msleep.

This fix addresses this problem by ensuring that napi_disable() is not
getting called for non-enabled NAPI struct.
But netif_napi_del() is still necessary for these non-enabled NAPI struct
for cleanup purpose.

Call trace:
[  654.559417] task:modprobe        state:D stack:    0 pid: 2321 ppid:  1091 flags:0x00004002
[  654.568030] Call Trace:
[  654.571221]  <TASK>
[  654.573790]  __schedule+0x2d6/0x960
[  654.577733]  schedule+0x69/0xf0
[  654.581214]  schedule_timeout+0x87/0x140
[  654.585463]  ? __bpf_trace_tick_stop+0x20/0x20
[  654.590291]  msleep+0x2d/0x40
[  654.593625]  napi_disable+0x2b/0x80
[  654.597437]  netvsc_device_remove+0x8a/0x1f0 [hv_netvsc]
[  654.603935]  rndis_filter_device_remove+0x194/0x1c0 [hv_netvsc]
[  654.611101]  ? do_wait_intr+0xb0/0xb0
[  654.615753]  netvsc_remove+0x7c/0x120 [hv_netvsc]
[  654.621675]  vmbus_remove+0x27/0x40 [hv_vmbus]

Cc: stable@vger.kernel.org
Fixes: ac5047671758 ("hv_netvsc: Disable NAPI before closing the VMBus channel")
Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
V1 -> V2:
Changed commit message, added some more details on
napi NAPIF_STATE_SCHED bit set and reset.
---
 drivers/net/hyperv/netvsc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 1dafa44155d0..a6fcbda64ecc 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -708,7 +708,10 @@ void netvsc_device_remove(struct hv_device *device)
 	/* Disable NAPI and disassociate its context from the device. */
 	for (i = 0; i < net_device->num_chn; i++) {
 		/* See also vmbus_reset_channel_cb(). */
-		napi_disable(&net_device->chan_table[i].napi);
+		/* only disable enabled NAPI channel */
+		if (i < ndev->real_num_rx_queues)
+			napi_disable(&net_device->chan_table[i].napi);
+
 		netif_napi_del(&net_device->chan_table[i].napi);
 	}
 
-- 
2.34.1


