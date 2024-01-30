Return-Path: <linux-hyperv+bounces-1478-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AF68420F6
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 11:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4C51C236A8
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106C26089C;
	Tue, 30 Jan 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EOXJFH0G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C9F605B4;
	Tue, 30 Jan 2024 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609780; cv=none; b=BZeeDWrWw90crDzB/7gkEUxvK3bXsB3oxq3fteLEB7NScpShlbzLZmlAi2gwg6ANDpK/4lHOSE9tjebXIyTe7+lI3hQwg5kQ/tlCL7ttaHaRXXlwxac3mldz7cVLuD7dYOPR7gZW7TSGTCKjAPCfHCkxOcgMtlZPLErP2f3dYO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609780; c=relaxed/simple;
	bh=EKido4cfkiPSNL005kSWWswMbAIta1D446sWSq/aX7s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VvGm7zfonclBXn8maCGhqIrFck2gTm/aubYWuhEJYTXU4PPuk9uCYx/f8ynVeNZ7GUNuw0D1WAn+dX6fwpi4OxuRYOTGsL/GoQ6K0jBHyhSXqcPpQ85T9lVoCb3YcpnhX+vu+3KUg5MkJjHmFhCwyX6PMxmfo15wjj8NvrriFw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EOXJFH0G; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 0489720541E2; Tue, 30 Jan 2024 02:16:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0489720541E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706609778;
	bh=lWjvTitWSXmCVj9tD67yPr16D3fiYZ1z5BKjD2XlLRg=;
	h=From:To:Cc:Subject:Date:From;
	b=EOXJFH0G7tayi52lb6OIV4X8MfQM5rdbWzzN8htV351zOxwFxrJGx4Gh9m0I4lhpz
	 gi33oSm245JV5oWwlD11Eo2pd3O5Dauj5ZPPwRNu5kJ+IaSLeTGjDnsfDlNljn4Il5
	 PUlNQmoTnNJvmpKmPEeeXGIwvdCqEfLvdH5SkqbU=
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
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH net] hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove
Date: Tue, 30 Jan 2024 02:16:12 -0800
Message-Id: <1706609772-5783-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

In commit ac5047671758 ("hv_netvsc: Disable NAPI before closing the
VMBus channel"), napi_disable was getting called for all channels,
including all subchannels without confirming if they are enabled or not.

Which caused hv_netvsc getting hung at napi_disable, when netvsc_probe()
and netvsc_remove() are happening simultaneously and netvsc_remove()
calls cancel_work_sync(&nvdev->subchan_work) before netvsc_sc_open()
calls napi_enable for the sub channels. Which causes NAPIF_STATE_SCHED
bit not getting cleared for the subchannels.

Now during netvsc_device_remove(), when napi_disable is called for those
subchannels, napi_disable gets stuck on infinite msleep.

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

Fixes: ac5047671758 ("hv_netvsc: Disable NAPI before closing the VMBus channel")
Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
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


