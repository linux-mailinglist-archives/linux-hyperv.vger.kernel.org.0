Return-Path: <linux-hyperv+bounces-7836-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC4C883EF
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 07:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 835874E3B2E
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 06:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7128316193;
	Wed, 26 Nov 2025 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BKPn2jOl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DB92877FC;
	Wed, 26 Nov 2025 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137964; cv=none; b=VyKjxslxOhr2Sqj0x5uTOcggSDNLpO5cnuMS6JujkyNQold0v5KyCTpRbJ/6jA8j47Qyah2e7uGazuOb0laFAhb849xd4rEntLI3UQBO7qPJi495gl5G/RryVRLVJcUoBWwiY2PST+y7ILjs+MeswXjhnbyRoCP8yO/MDVqyGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137964; c=relaxed/simple;
	bh=XCRZGPkt5eGq27kInUuHRnLT0RrOdl1nc+CixkQ6y1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5vup7WNtwp6OAYlc/48if95u50XJBlw1xAWTGYQXUJvCErjLnob8EKxcxT2nIXp1d6sepoC75J077h2Sd+JTV3ECvU9QLd3jN/dcZVD3QUo+A9AlVfCBwyiGhXh6kOXYymwiBAUT9WFPQvSCHsGR8Rp1EOq7CBRkz5WLFisq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BKPn2jOl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.20])
	by linux.microsoft.com (Postfix) with ESMTPSA id ACFA42120EB2;
	Tue, 25 Nov 2025 22:19:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACFA42120EB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764137962;
	bh=GnvKGusb0fsxTKpU3T/9X1Q964Z1EVEhjbq1Av65TSQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BKPn2jOljUmMQgYD4Zv6gajimH35ihV0pbkmxwZvN5iHVJOtIR8xFW2pHclJTFDby
	 BcWSpgUsslTGmVnORIPEqMMj5/tsS6zNS/ktSlK8dr6qs3auKgy4s/cmFaNGoR26pX
	 lKvkRjRSyqeqOyNeNykEj5MqNWeoo35odj/HDCac=
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
Subject: [PATCH 5.4-6.6 v2] uio_hv_generic: Enable user space to manage interrupt_mask for subchannels
Date: Wed, 26 Nov 2025 06:19:14 +0000
Message-ID: <20251126061914.538760-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
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

This is a backport of the upstream
commit d062463edf17 ("uio_hv_generic: Set event for all channels on the device")
with some modifications to resolve merge conflicts and take care of
missing support for slow devices on older kernels.
Original change was not a fix, but it needs to be backported to fix a
NULL pointer crash resulting from missing interrupt mask setting.

Commit b15b7d2a1b09 ("uio_hv_generic: Let userspace take care of interrupt mask")
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
Fixes: b15b7d2a1b09 ("uio_hv_generic: Let userspace take care of interrupt mask")
Closes: https://bugs.debian.org/1120602
Cc: stable@vger.kernel.org # all LTS kernels from 5.4 till 6.6
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
Changes since v1:
https://lore.kernel.org/all/20251115085937.2237-1-namjain@linux.microsoft.com/
* Changed commit being fixed, to reflect upstream commit
* Added stable kernel versions info in Stable tag and email subject.
This needs to be ported to all the stable kernels, where the Fixes patch
went in - 5.4.x, 5.10.x, 5.15.x, 6.1.x, 6.6.x.

Previous notes:
Remove reviewed-by tags since the original code has changed quite a bit
while backporting.
Backported change for 6.12 kernel is sent separately.
---
 drivers/uio/uio_hv_generic.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 137109f5f69b..95c1f08028a3 100644
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
2.43.0


