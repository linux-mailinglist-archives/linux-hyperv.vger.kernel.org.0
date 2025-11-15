Return-Path: <linux-hyperv+bounces-7610-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47385C601AF
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 10:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 316484E2FAE
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDA42580E1;
	Sat, 15 Nov 2025 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LcRFXnqO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1285A24503B;
	Sat, 15 Nov 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763197204; cv=none; b=Pfb1sWB0u1S6shIxQ6irvN/bhPBc1WgwId/yYFygJxf094dJ0zS9L/riPPS2o5pziu2p3VhgcBZHNwzIT7buLs4yQCN78AhExeEZDGmYnMnwiXMSx+LRbGbNG05EzSs6jL9sm7KexmcxVcXmkHuzZ81ILGP38Y8kM5awg+s4Oso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763197204; c=relaxed/simple;
	bh=Fn+54cM7t339sKRQ7gF+ZAKVKdk0zzg/V/yrB2Vdu3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uZHgBzz+srfUOmuiLXfWxIGLGn8OK6DZNG2UszacQ8tJbjunnNkewgCmmCilRxWH78XJxhAVVJEV521AJGUrO5NFOBbkBpe+chjUQ4uG4z99F36g0TwwNvguUD2A6n7YQ3u/0L32tSdX0yT3GCycOKXpZrSendkQiJnw3xLYvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LcRFXnqO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.40])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8CB88201AE70;
	Sat, 15 Nov 2025 00:59:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8CB88201AE70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763197202;
	bh=lLZx9JvSQA3blQF6VXFyrcFYBitj0xT3LfhpPh4FTEM=;
	h=From:To:Cc:Subject:Date:From;
	b=LcRFXnqO5ibP9hc7bW+pRudkmNlnGzJatSQxSw+TW6ZMOYRxC5SHHbxjVEQgelcEc
	 sIVOb3NLI53K6uW0iHZC+bHDJXkyIC5cH/F98eCR7I1ADTkrsFCLbJfZsaNCobg9Uc
	 QGi78s9zlIHHMdNE4RSukMMIyuyvNtddXE/Ze0dY=
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
Subject: [PATCH 6.6 and older] uio_hv_generic: Enable user space to manage interrupt_mask for subchannels
Date: Sat, 15 Nov 2025 14:29:37 +0530
Message-Id: <20251115085937.2237-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Long Li <longli@microsoft.com>

Enable the user space to manage interrupt_mask for subchannels through
irqcontrol interface for uio device. Also remove the memory barrier
when monitor bit is enabled as it is not necessary.

This is a backport of the upstream commit
d062463edf17 ("uio_hv_generic: Set event for all channels on the device")
with some modifications to resolve merge conflicts and take care of
missing support for slow devices on older kernels.
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
Fixes: 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")
Closes: https://bugs.debian.org/1120602
Cc: <stable@vger.kernel.org> # 6.6.x and older
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
Remove reviewed-by tags since the original code has changed quite a bit
while backporting.
Backported change for 6.12 kernel is sent separately.
---
 drivers/uio/uio_hv_generic.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 2724656bf634..69e5016ebd46 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -80,9 +80,15 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
 {
 	struct hv_uio_private_data *pdata = info->priv;
 	struct hv_device *dev = pdata->device;
+	struct vmbus_channel *primary, *sc;
 
-	dev->channel->inbound.ring_buffer->interrupt_mask = !irq_state;
-	virt_mb();
+	primary = dev->channel;
+	primary->inbound.ring_buffer->interrupt_mask = !irq_state;
+
+	mutex_lock(&vmbus_connection.channel_mutex);
+	list_for_each_entry(sc, &primary->sc_list, sc_list)
+		sc->inbound.ring_buffer->interrupt_mask = !irq_state;
+	mutex_unlock(&vmbus_connection.channel_mutex);
 
 	return 0;
 }
@@ -93,11 +99,18 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_state)
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


