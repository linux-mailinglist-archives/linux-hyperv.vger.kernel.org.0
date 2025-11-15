Return-Path: <linux-hyperv+bounces-7609-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44658C601A5
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 09:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B379E3597EE
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 08:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05FC24503B;
	Sat, 15 Nov 2025 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UZa8fDaO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1B243969;
	Sat, 15 Nov 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763197063; cv=none; b=uMOvk6cegI4uSnHqMcxyZpuz/CKfeR5Zw4EmeoMoofXF8ZEBpCWhLg2DvIqrdBevXa2SjF1p4Zjs+T+m1VQNf8iUvUdalOokyc90q9o/Arj2wot2cW/WwlBhkWZMgB4IgiuVwAULSm5VJ5uDfiqIQBiUk1rFikvUXE0y99Ok8QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763197063; c=relaxed/simple;
	bh=KphnYgHPmsb1lJwMCHvWI76fDjNU0ujfiaNxWkCiuUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BD+EKdknLUx7Y4YYquV4ber6lw6myWBoqtFoDQbn7k58nssPye4Krxzu+K1KtoODk5rQmVhgQm/9yYOq/jkb/jInzvvE5qOh/AF9tZqMHeqqg2sjwmmWxm+NKQS36tpmz6g3FEgIVEBQNfIUMUzh++PJZX820tMrgVf8/GnGclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UZa8fDaO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 72D43201AE70;
	Sat, 15 Nov 2025 00:57:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 72D43201AE70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763197061;
	bh=VuPwbtfn2z+5KMa3OvLSn+Oz4EKWBZfG0OHamIOwWmA=;
	h=From:To:Cc:Subject:Date:From;
	b=UZa8fDaOqSufNDwj/yvK8s5dTZCajotPx+BSKLgIPXeKj18s7w7alEER/D+4JqQEx
	 /idXMj4iDd2bnnU/Lmw/Zsb5RdA8YEGckylpyxoNX3BrKCA3iOzuYY7FCOowUQacz1
	 jJ/arkGt0omfnK+zptg0yh++Lx6Xj+BIQwC+pNGY=
From: Naman Jain <namjain@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>,
	Peter Morrow <pdmorrow@gmail.com>
Subject: [PATCH 6.12] uio_hv_generic: Set event for all channels on the device
Date: Sat, 15 Nov 2025 14:27:30 +0530
Message-Id: <20251115085730.2197-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Long Li <longli@microsoft.com>

Hyper-V may offer a non latency sensitive device with subchannels without
monitor bit enabled. The decision is entirely on the Hyper-V host not
configurable within guest.

When a device has subchannels, also signal events for the subchannel
if its monitor bit is disabled.

This patch also removes the memory barrier when monitor bit is enabled
as it is not necessary. The memory barrier is only needed between
setting up interrupt mask and calling vmbus_set_event() when monitor
bit is disabled.

This is a backport of the upstream commit
d062463edf17 ("uio_hv_generic: Set event for all channels on the device")
with minor modifications to resolve merge conflicts.
Original change was not a fix, but it needs to be backported to fix a
NULL pointer crash resulting from missing interrupt mask setting.

Commit 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")
removed the default setting of interrupt_mask for channels (including
subchannels) in the uio_hv_generic driver, as it relies on the user space
to take care of managing it. This approach works fine when user space
can control this setting using the irqcontrol interface provided for uio
devices. Support for setting the interrupt mask through this interface for
subchannels came only after commit d062463edf17 ("uio_hv_generic: Set event
for all channels on the device"). On older kernels, this change is not
present. With uio_hv_generic no longer setting the interrupt_mask, and
userspace not having the capability to set it, it remains unset,
and interrupts can come for the subchannels, which can result in a crash
in hv_uio_channel_cb. Backport the change to older kernels, where this
change was not present, to allow userspace to set the interrupt mask
properly for subchannels. Additionally, this patch also adds certain
checks for primary vs subchannels in the hv_uio_channel_cb, which can
gracefully handle these two cases and prevent the NULL pointer crashes.

Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Fixes: 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")
Cc: <stable@vger.kernel.org> # 6.12.x
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 0b414d1168dd..aa7593cea2e3 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -65,6 +65,16 @@ struct hv_uio_private_data {
 	char	send_name[32];
 };
 
+static void set_event(struct vmbus_channel *channel, s32 irq_state)
+{
+	channel->inbound.ring_buffer->interrupt_mask = !irq_state;
+	if (!channel->offermsg.monitor_allocated && irq_state) {
+		/* MB is needed for host to see the interrupt mask first */
+		virt_mb();
+		vmbus_set_event(channel);
+	}
+}
+
 /*
  * This is the irqcontrol callback to be registered to uio_info.
  * It can be used to disable/enable interrupt from user space processes.
@@ -79,12 +89,15 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
 {
 	struct hv_uio_private_data *pdata = info->priv;
 	struct hv_device *dev = pdata->device;
+	struct vmbus_channel *primary, *sc;
 
-	dev->channel->inbound.ring_buffer->interrupt_mask = !irq_state;
-	virt_mb();
+	primary = dev->channel;
+	set_event(primary, irq_state);
 
-	if (!dev->channel->offermsg.monitor_allocated && irq_state)
-		vmbus_setevent(dev->channel);
+	mutex_lock(&vmbus_connection.channel_mutex);
+	list_for_each_entry(sc, &primary->sc_list, sc_list)
+		set_event(sc, irq_state);
+	mutex_unlock(&vmbus_connection.channel_mutex);
 
 	return 0;
 }
@@ -95,11 +108,18 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
 static void hv_uio_channel_cb(void *context)
 {
 	struct vmbus_channel *chan = context;
-	struct hv_device *hv_dev = chan->device_obj;
-	struct hv_uio_private_data *pdata = hv_get_drvdata(hv_dev);
+	struct hv_device *hv_dev;
+	struct hv_uio_private_data *pdata;
 
 	virt_mb();
 
+	/*
+	 * The callback may come from a subchannel, in which case look
+	 * for the hv device in the primary channel
+	 */
+	hv_dev = chan->primary_channel ?
+		 chan->primary_channel->device_obj : chan->device_obj;
+	pdata = hv_get_drvdata(hv_dev);
 	uio_event_notify(&pdata->info);
 }
 
-- 
2.34.1


